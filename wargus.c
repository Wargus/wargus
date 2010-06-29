/*
    wargus.c - Start game engine Stratagus with Wargus data
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

#if defined (MAEMO_GTK) || defined (MAEMO_CHANGES)
#define MAEMO
#endif

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include <unistd.h>
#include <sys/stat.h>

#ifdef WIN32
#include <windows.h>
#endif

#ifndef WIN32
#include <gtk/gtk.h>
#endif

#ifdef MAEMO
#include <hildon/hildon.h>
#endif

#ifdef _WIN64
#define REGKEY "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Stratagus (64 bit)"
#elif defined (WIN32)
#define REGKEY "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Stratagus"
#endif

#if ! defined(WIN32) && ! defined(WARGUS_PATH)
#define WARGUS_PATH "/usr/share/games/stratagus/wargus"
#endif

#if ! defined(WIN32) && ! defined(STRATAGUS_BIN)
#define STRATAGUS_BIN "/usr/games/stratagus"
#endif

#define TITLE "Wargus"
#define STRATAGUS_NOT_FOUND "Stratagus is not installed.\nYou need Stratagus to run Wargus!"
#define DATA_NOT_EXTRACTED "Wargus data was not extracted yet.\nYou need extract data from original Warcraft II CD first!"

inline void error(char * title, char * text) {

#ifdef WIN32
	MessageBox(NULL, text, title, MB_OK | MB_ICONERROR);
#endif

#ifdef MAEMO
	GtkWidget * dialog, * label;
	dialog = gtk_dialog_new_with_buttons(title, NULL, GTK_DIALOG_MODAL | GTK_DIALOG_DESTROY_WITH_PARENT, GTK_STOCK_OK, GTK_RESPONSE_ACCEPT, GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT, NULL);
	label = gtk_label_new(text);

	gtk_container_add(GTK_CONTAINER (GTK_DIALOG(dialog)->vbox), label);
	gtk_widget_show_all(GTK_WIDGET (dialog));

	gtk_dialog_run(GTK_DIALOG (dialog));
	gtk_widget_destroy(dialog);
#endif

#if ! defined(WIN32) && ! defined(MAEMO)
	GtkWidget * dialog;
	dialog = gtk_message_dialog_new(NULL, GTK_DIALOG_MODAL | GTK_DIALOG_DESTROY_WITH_PARENT, GTK_MESSAGE_ERROR, GTK_BUTTONS_OK, text, NULL);
	gtk_window_set_title(GTK_WINDOW(dialog), title);
	gtk_dialog_run(GTK_DIALOG (dialog));
	gtk_widget_destroy(dialog);
#endif

/*
	execlp("kdialog", "kdialog", "--title", title, "--error", text, NULL);
	execlp("zenity", "zenity", "--error", "--title", title, "--text", text, "--no-wrap", NULL);
	execlp("xmessage", "xmessage", "-title", title, "-center", "  Error: ", text, "  ", NULL);
	execlp("dialog", "dialog", "--title", title, "--backtitle", title, "--msgbox", text, "9", "50", NULL);
	printf("---------%s----------\nError: %s\n", title, text);
*/

	exit(-1);

}

int main(int argc, char * argv[]) {

#ifdef MAEMO
	hildon_gtk_init(&argc, &argv);
#endif

#if ! defined(WIN32) && ! defined(MAEMO)
	gtk_init(&argc, &argv);
#endif

	struct stat st;
	int i;
	char wargus_path[1024];
	char stratagus_bin[1024];
	char title_path[1024];

#ifdef WIN32
	size_t wargus_path_size = sizeof(wargus_path);
	memset(wargus_path, 0, wargus_path_size);
	getcwd(wargus_path, wargus_path_size);

	char stratagus_path[1024];
	DWORD stratagus_path_size = sizeof(stratagus_path);
	memset(stratagus_path, 0, stratagus_path_size);
	HKEY key;

	if ( RegOpenKeyEx(HKEY_LOCAL_MACHINE, REGKEY, 0, KEY_QUERY_VALUE, &key) == ERROR_SUCCESS ) {
                        
		if ( RegQueryValueEx(key, "InstallLocation", NULL, NULL, (LPBYTE) stratagus_path, &stratagus_path_size) == ERROR_SUCCESS )
			if ( stratagus_path_size == 0 || strlen(stratagus_path) == 0 )
				error(TITLE, STRATAGUS_NOT_FOUND);

		RegCloseKey(key);

	}

	if ( chdir(stratagus_path) != 0 )
		error(TITLE, STRATAGUS_NOT_FOUND);

	sprintf(stratagus_bin, "%s\\stratagus.exe", stratagus_path);
#else
	strcpy(wargus_path, WARGUS_PATH);
	strcpy(stratagus_bin, STRATAGUS_BIN);
#endif

	if ( stat(stratagus_bin, &st) != 0 )
		error(TITLE, STRATAGUS_NOT_FOUND);

	if ( stat(wargus_path, &st) != 0 )
		error(TITLE, DATA_NOT_EXTRACTED);

#ifdef WIN32
	sprintf(title_path, "%s\\graphics\\ui\\title.png", wargus_path);
	char wargus_path_esc[1024];
	strcpy(wargus_path_esc+1, wargus_path);
	wargus_path_esc[0] = '"';
	wargus_path_esc[strlen(wargus_path)+1] = '"';
	wargus_path_esc[strlen(wargus_path)+2] = 0;
	strcpy(wargus_path, wargus_path_esc);
#else
	sprintf(title_path, "%s/graphics/ui/title.png", wargus_path);
#endif

	if ( stat(title_path, &st) !=0 )
		error(TITLE, DATA_NOT_EXTRACTED);

	char * stratagus_argv[argc + 3];

#ifdef WIN32
	stratagus_argv[0] = "stratagus.exe";
#else
	stratagus_argv[0] = "stratagus";
#endif

	stratagus_argv[1] = "-d";
	stratagus_argv[2] = wargus_path;

	for ( i = 3; i < argc + 2; ++i )
		stratagus_argv[i] = argv[i - 2];

	stratagus_argv[argc + 2] = NULL;

	execvp(stratagus_bin, stratagus_argv);
	error(TITLE, STRATAGUS_NOT_FOUND);

	return 0;

}
