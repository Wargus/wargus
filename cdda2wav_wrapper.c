/*
       _________ __                 __
      /   _____//  |_____________ _/  |______     ____  __ __  ______
      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
             \/                  \/          \//_____/            \/
  ______________________                           ______________________
                        T H E   W A R   B E G I N S
         Stratagus - A free fantasy real time strategy game engine

    cdda2wav_wrapper.cpp - WinAPI wrapper for cdda2wav.exe
    Copyright (C) 2011  aqrit and Pali Rohár <pali.rohar@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

/*
 This program tries to independently find the bus ID cdda2wav is using for a given CD-rom drive.
 Needed because cdda2wav (v2.01 - 3.0) uses a internal numbering scheme to refer to SCSI devices on Windows.
*/

#include <windows.h>
#include <process.h>
#include <errno.h>
#include <stdio.h>
#include <stdbool.h>

#ifndef _NTDDSCSIH_
#define IOCTL_SCSI_GET_ADDRESS		0x00041018
#define IOCTL_SCSI_GET_INQUIRY_DATA	0x0004100C

typedef struct _SCSI_ADDRESS {
	ULONG Length;
	UCHAR PortNumber;
	UCHAR PathId;
	UCHAR TargetId;
	UCHAR Lun;
} SCSI_ADDRESS, *PSCSI_ADDRESS;

typedef struct _SCSI_BUS_DATA {
    UCHAR NumberOfLogicalUnits;
    UCHAR InitiatorBusId;
    ULONG InquiryDataOffset;
}SCSI_BUS_DATA, *PSCSI_BUS_DATA;

typedef struct _SCSI_ADAPTER_BUS_INFO {
    UCHAR NumberOfBuses;
    SCSI_BUS_DATA BusData[1];
} SCSI_ADAPTER_BUS_INFO, *PSCSI_ADAPTER_BUS_INFO;
#endif

#define SCSI_INFO_BUFFER_SIZE 2048	// just throw a huge buffer at it

bool GetSCSIAddressFromDriveLetter(const char drive_letter, PSCSI_ADDRESS scsi_address) {

	char file_name[8];
	bool result = false;
	HANDLE device_handle;

	wsprintf(file_name, "\\\\.\\%c:", drive_letter);
	device_handle = CreateFile(file_name, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);

	if ( device_handle != INVALID_HANDLE_VALUE ) {

		scsi_address->Length = sizeof(SCSI_ADDRESS);
		scsi_address->PortNumber = 0;
		scsi_address->PathId = 0;
		scsi_address->TargetId = 0;
		scsi_address->Lun = 0;
		long bytes_returned;

		if ( DeviceIoControl(device_handle, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_address, sizeof(SCSI_ADDRESS), (LPDWORD)&bytes_returned, FALSE) ) {

			if ( bytes_returned == sizeof(SCSI_ADDRESS) )
				result = true;

		} else {

			if ( GetLastError() == 50 ) { // USB/FIREWIRE devices?

				// as per cdda2wav
				int temp = (int)(toupper(drive_letter) - 'A');
				scsi_address->PortNumber = temp+64;
				scsi_address->PathId = temp;
				result = true;

			}

		}

		CloseHandle(device_handle);

	}

	return result;
}


int main(int argc, char * argv[]) {

	if ( argc != 4 || !argv[1] || argv[1][1] != 0 ) {

		printf("Usage: %s DRIVE_LETTER TRACK_NUMBER OUTPUT_FILE\n", argv[0]);
		return 1;

	}

	const char target_cdrom_driveletter = argv[1][0];

	SCSI_ADDRESS target_scsi_address;

	if ( GetSCSIAddressFromDriveLetter( target_cdrom_driveletter, &target_scsi_address ) ) {

		const int max_list = 128; // hopefully enough
		short list[max_list];
		int num_list = 0;
		int i;

		// add drives to the list
		for ( i = 0; i<26; i++ ) {

			SCSI_ADDRESS scsi_address;

			if ( GetSCSIAddressFromDriveLetter((char)('A'+i), &scsi_address) ) {

				int list_index;
				short value = ( scsi_address.PortNumber << 8 ) | scsi_address.PathId;

				if ( num_list >= max_list )
					break; // list is full

				for ( list_index = 0; list_index < num_list; list_index++)
					if ( list[list_index] == value )
						break; // no duplicates

				if ( list_index >= num_list )
					list[num_list++] = value; // append to list

			}

		}

		// add scsi devices to the list
		for ( i = 0; true; i++ ) {

			static char inquiry_buffer[SCSI_INFO_BUFFER_SIZE];
			long bytes_returned;
			char file_name[24];
			HANDLE device_handle;
			int bus;

			wsprintf(file_name, "\\\\.\\SCSI%u:", i);
			device_handle = CreateFile(file_name, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);

			if ( device_handle == INVALID_HANDLE_VALUE )
				break;

			if ( DeviceIoControl(device_handle, IOCTL_SCSI_GET_INQUIRY_DATA, NULL, 0, inquiry_buffer, SCSI_INFO_BUFFER_SIZE, (LPDWORD)&bytes_returned, NULL) ) {

				for ( bus = 0; bus < ((PSCSI_ADAPTER_BUS_INFO)inquiry_buffer)->NumberOfBuses; bus++ ) {

					int list_index;
					short value = ( i << 8 ) | bus;

					if ( num_list >= max_list )
						break; // list is full

					for ( list_index = 0; list_index < num_list; list_index++ )
						if ( list[list_index] == value )
							break; // no duplicates

					if ( list_index >= num_list )
						list[num_list++] = value; // append to list

				}

			}

			CloseHandle(device_handle);

		}

		// find what would be the cdda2wav "bus"
		short value = ( target_scsi_address.PortNumber << 8 ) | target_scsi_address.PathId;
		int count = 0;
		bool found = false;

		for ( i = 0; i < num_list; i++ )
			if ( list[i] < value )
				count++;
			else if ( list[i] == value )
				found = true;
		
		if ( ( count < 26 ) && ( found != false ) ) { // cdda2wav caps at 26

			char cdda2wav_drive[_MAX_DRIVE];
			char cdda2wav_dir[_MAX_DIR];
			char cdda2wav[_MAX_PATH];
			char file[_MAX_PATH];
			char spti[20];
			int ret;
			errno = 0;

			sprintf(spti, "SPTI:%u,%u,%u", count, target_scsi_address.TargetId, target_scsi_address.Lun);

			_splitpath(argv[0], cdda2wav_drive, cdda2wav_dir, NULL, NULL);
			sprintf(cdda2wav, "\"%s%scdda2wav.exe\"", cdda2wav_drive, cdda2wav_dir);

			sprintf(file, "\"%s\"", argv[3]);

			printf("Spawning process cdda2wav: %s -D %s -t %s %s\n", cdda2wav, spti, argv[2], file);
			ret = _spawnlp(_P_WAIT, cdda2wav, cdda2wav, "-D", spti, "-t", argv[2], file, NULL);

			if ( ret == -1 )
				perror("Error could not spawn process cdda2wav");
			else
				return ret;

		} else {

			printf("Unknown Error\n");

		}

	} else {

		printf("Error couldn't get SCSI address of Drive \'%c\'\n", target_cdrom_driveletter);

	}

	return 1;

}
