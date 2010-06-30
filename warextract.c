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
#define DATA_NEED_COPY "Note: You need the original Warcraft II CD\n(Battle.net edition doesn't work) to extract the game data files.\nData files are needed to run Wargus.\nFirst copy Warcraft II CD to folder MyDocs/WAR2 in phone,\nthen press OK."
#define DATA_FOUND "Warcraft II data files was found in folder MyDocs/WAR2\nPress OK to extract data now.\nPlease be patient, the data may take a couple of minutes to extract..."
#define DATA_NOT_FOUND "Error: Warcraft II data files was not found.\nCheck if you have in phone file MyDocs/WAR2/DATA/RESDAT.WAR"
#define EXTRACT_OK "Warcraft II data files was successfull extracted."
#define EXTRACT_FAILED "Error: Cannot extract Warcraft II data files,\n extract program crashed."

#define EXTRACT_BIN "/opt/stratagus/share/wargus/build.sh"
#define DATADIR "/home/user/MyDocs/WAR2"
#define EXTRACTDIR "/opt/stratagus/share/wargus"
#define BINPATH "/opt/stratagus/bin"
#define EXTRACT_VIDEOS "-v"
#define EXTRACT_MUSIC "-m"

#define EXTRACT_COMMAND = EXTRACT_BIN " -p " DATADIR " -b " BINPATH " -o " EXTRACTDIR " -s -c " EXTRACT_VIDEOS " " EXTRACT_MUSIC

inline void message(char * title, char * text) {

	GtkWidget * dialog, * label;
	dialog = gtk_dialog_new_with_buttons(title, NULL, GTK_DIALOG_MODAL | GTK_DIALOG_DESTROY_WITH_PARENT, GTK_STOCK_OK, GTK_RESPONSE_ACCEPT, GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT, NULL);
	label = gtk_label_new(text);

	gtk_container_add(GTK_CONTAINER (GTK_DIALOG(dialog)->vbox), label);
	gtk_widget_show_all(GTK_WIDGET (dialog));

	gtk_dialog_run(GTK_DIALOG (dialog));
	gtk_widget_destroy(dialog);

}

int main() {

	hildon_gtk_init(&argc, &argv);

	message(TITLE, DATA_NEED_COPY);

	struct stat st;

	if ( stat("/home/user/MyDocs/WAR2/DATA/RESDAT.WAR", &st) != 0 && stat("/home/user/MyDocs/WAR2/data/resdat.war", &st) != 0 ) {

		message(TITLE, DATA_NOT_FOUND);
		return -1;

	}

	message(TITLE, DATA_FOUND);
	char extract_command[] = EXTRACT_COMMAND;
	int ret = system(extract_command, extract_argv);

	if ( ret != 0 ) {

		error(TITLE, EXTRACT_FAILED);
		return -1;

	}

	message(TITLE, EXTRACT_OK);
	return 0;

}
