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

    rip_music_win32.c - rip audio CD on Windows with cdda2wav.exe
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

#include <windows.h>
#include <process.h>
#include <errno.h>
#include <stdio.h>

#include "rip_music.h"

#if _MSC_VER
#define snprintf _snprintf
#endif


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
} SCSI_BUS_DATA, *PSCSI_BUS_DATA;

typedef struct _SCSI_ADAPTER_BUS_INFO {
	UCHAR NumberOfBuses;
	SCSI_BUS_DATA BusData[1];
} SCSI_ADAPTER_BUS_INFO, *PSCSI_ADAPTER_BUS_INFO;
#endif

#define SCSI_INFO_BUFFER_SIZE 2048	// just throw a huge buffer at it

int GetSCSIAddressFromDriveLetter(const char drive_letter, PSCSI_ADDRESS scsi_address) {

	char file_name[8];
	int result = 0;
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
				result = 1;

		} else {

			if ( GetLastError() == 50 ) { // USB/FIREWIRE devices?

				// as per cdda2wav
				int temp = (int)(toupper(drive_letter) - 'A');
				scsi_address->PortNumber = temp+64;
				scsi_address->PathId = temp;
				result = 1;

			}

		}

		CloseHandle(device_handle);

	}

	return result;
}


int GetSPTIAddressFromDriveLetter(const char drive_letter, char * spti_address) {

	SCSI_ADDRESS target_scsi_address;

	if ( ! GetSCSIAddressFromDriveLetter(drive_letter, &target_scsi_address) ) {

		printf("Error: Cannot get SCSI address of drive %c\n", drive_letter);
		return 1;

	}

	const int max_list = 128; // hopefully enough
	short list[max_list];
	int num_list = 0;
	int i;

	// add drives to the list
	for ( i = 0; i < 26; i++ ) {

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
	for ( i = 0; ; i++ ) {

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
	int found = 0;

	for ( i = 0; i < num_list; i++ ) {

		if ( list[i] < value )
			count++;
		else if ( list[i] == value )
			found = 1;

	}

	if ( ! found || count >= 26 ) { // cdda2wav caps at 26

		fprintf(stderr, "Unknown Error\n");
		return 1;

	}

	sprintf(spti_address, "SPTI:%u,%u,%u", count, target_scsi_address.TargetId, target_scsi_address.Lun);
	return 0;

}

char GetDriveLetterFromPath(const char * path) {

	char save_cwd[_MAX_PATH];
	char cwd[_MAX_PATH];
	int res;

	if ( ! GetCurrentDirectory(sizeof(save_cwd), save_cwd) ) {

		fprintf(stderr, "Error: Cannot store working directory: %s\n", strerror(errno));
		return 0;

	}

	if ( ! SetCurrentDirectory(path) ) {

		fprintf(stderr, "Error: Cannot change directory to %s: %s\n", path, strerror(errno));
		return 0;

	}

	res = GetCurrentDirectory(sizeof(cwd), cwd);

	if ( ! res )
		fprintf(stderr, "Error: Cannot get working directory: %s\n", strerror(errno));

	if ( ! SetCurrentDirectory(save_cwd) )
		fprintf(stderr, "Error: Cannot restore working directory: %s\n", strerror(errno));

	if ( ! res )
		return 0;
	else
		return cwd[0];

}

int RipMusic(int expansion_cd, const char * data_dir, const char * dest_dir) {

	const char cdda2wav[] = "cdda2wav.exe";
	const char * args[7] = { cdda2wav, "-D", "", "-J", NULL, NULL, NULL };
	char drive;
	char spti[20];
	int count = 0;
	int i;

	if ( ! ( drive = GetDriveLetterFromPath(data_dir) ) ) {

		fprintf(stderr, "Error: Cannot get drive letter of path %s\n", data_dir);
		return 1;

	}

	if ( GetSPTIAddressFromDriveLetter(drive, spti) != 0 ) {

		fprintf(stderr, "Error: Cannot get SPTI address of drive %c\n", drive);
		return 1;

	}

	printf("Found CD-ROM device: %s\n", spti);
	fflush(stdout);

	args[2] = spti;

	if ( _spawnvp(_P_WAIT, cdda2wav, args) != 0 )
		return 1;

	for ( i = 0; MusicNames[i]; ++i ) {

		char num[3];
		char file[_MAX_PATH];

		if ( ! expansion_cd && ! MusicNames[i+1] )
			break;

		snprintf(num, sizeof(num), "%d", i+2);
		snprintf(file, sizeof(file), "\"%s/%s.wav\"", dest_dir, MusicNames[i]);

		args[3] = "-t";
		args[4] = num;
		args[5] = file;

		if ( _spawnvp(_P_WAIT, cdda2wav, args) == 0 )
			++count;

	}

	if ( count == 0 )
		return 1;
	else
		return 0;

}
