/*
    warextract.c - Extract game data on Maemo
    Copyright (C) 2010  Pali Rohár <pali.rohar@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <sys/stat.h>

#include <gtk/gtk.h>
#include <hildon/hildon.h>

#define TITLE "Wargus"
#define DATA_NEED_COPY "Note: You need the original Warcraft II CD\n(Battle.net edition doesn't work)\nto extract the game data files.\nData files are needed to run Wargus.\n\nFirst copy Warcraft II CD to folder MyDocs/WAR2\nin phone, then press OK. If you want to add\nmusic support, extract audio tracks from\nWarcraft II CD to folder MyDocs/WAR2/music"
#define DATA_FOUND "Warcraft II data files was found in folder MyDocs/WAR2\nPlease be patient, the data may take\na couple of minutes to extract...\n\nPress OK to start extracting data now."
#define DATA_NOT_FOUND "Error: Warcraft II data files was not found.\n\nCheck if you have in phone file\nMyDocs/WAR2/DATA/REZDAT.WAR"
#define EXTRACT_OK "Warcraft II data files was successfull extracted."
#define EXTRACT_FAILED "Error: Cannot extract Warcraft II data files,\nextract program crashed."

#define EXTRACT_BIN "/opt/stratagus/share/wargus/build.sh"
#define DATADIR "/home/user/MyDocs/WAR2"
#define EXTRACTDIR "/opt/stratagus/share/wargus"
#define BINPATH "/opt/stratagus/bin"
#define EXTRACT_VIDEOS "" // "-v" TODO: uncomment, when package ffmpeg2theora will be in maemo repository
#define EXTRACT_MUSIC "-m"

#define EXTRACT_COMMAND EXTRACT_BIN " -p " DATADIR " -b " BINPATH " -o " EXTRACTDIR " -s -c " EXTRACT_VIDEOS " " EXTRACT_MUSIC

inline void message(char * title, char * text) {

	GtkWidget * dialog, * label;
	dialog = gtk_dialog_new_with_buttons(title, NULL, GTK_DIALOG_MODAL | GTK_DIALOG_DESTROY_WITH_PARENT, GTK_STOCK_OK, GTK_RESPONSE_ACCEPT, GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT, NULL);
	label = gtk_label_new(text);

	gtk_container_add(GTK_CONTAINER (GTK_DIALOG(dialog)->vbox), label);
	gtk_widget_show_all(GTK_WIDGET (dialog));

	gtk_dialog_run(GTK_DIALOG (dialog));
	gtk_widget_destroy(dialog);

}

int main(int argc, char * argv[]) {

	char buf[1024];
	char version[20];
	char VERSION[20];
	struct stat st;
	FILE * f;

	hildon_gtk_init(&argc, &argv);

	sprintf(buf, "%s/extracted", Dir);
	f = fopen(buf, "r");
	if (f) {
		fgets(f, version, 20);
		fclose(f);
		f = popen(BINPATH "/wartool -V", "r");
		if (f) {
			fgets(f, VERSION, 20);
			pclose(f);
			if (strcmp(version, VERSION) == 0)
				return 0;
		}
	}

	message(TITLE, DATA_NEED_COPY);

	if ( stat("/home/user/MyDocs/WAR2/DATA/REZDAT.WAR", &st) != 0 && stat("/home/user/MyDocs/WAR2/data/rezdat.war", &st) != 0 ) {

		message(TITLE, DATA_NOT_FOUND);
		return -1;

	}

	message(TITLE, DATA_FOUND);
	int ret = system(EXTRACT_COMMAND);

	if ( ret != 0 ) {

		message(TITLE, EXTRACT_FAILED);
		return -1;

	}

	message(TITLE, EXTRACT_OK);
	return 0;

}
