;
;    stratagus.nsi - Windows NSIS Installer for Stratragus
;    Copyright (C) 2010  Pali Rohár <pali.rohar@gmail.com>
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program.  If not, see <http://www.gnu.org/licenses/>.
;
;

!include "MUI.nsh"

;--------------------------------

!define NAME "Wargus"
!define VERSION "2.2.5.1"

;--------------------------------

!define ICON "contrib/wargus.ico"
!define WARGUS "wargus.exe"
!define WARTOOL "wartool.exe"
!define PUDCONVERT "pudconvert.exe"
!define FFMPEG2THEORA "ffmpeg2theora.exe"
!define UNINSTALL "uninstall.exe"
!define INSTALLER "${NAME}-${VERSION}.exe"
!define INSTALLDIR "$PROGRAMFILES\${NAME}\"

!ifdef AMD64
!undef INSTALLER
!define INSTALLER "${NAME}-${VERSION}-x86_64.exe"
!undef INSTALLDIR
!define INSTALLDIR "$PROGRAMFILES64\${NAME}\"
!undef NAME
!define NAME "Wargus (64 bit)"
!endif

!define REGKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"
!define LANGUAGE "English"

!ifdef AMD64
!define STRATAGUS_REGKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\Stratagus (64 bit)"
!else
!define STRATAGUS_REGKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\Stratagus"
!endif

;--------------------------------

LangString REMOVEPREVIOUS ${LANG_ENGLISH} "Removing previous installation"
LangString REMOVECONFIGURATION ${LANG_ENGLISH} "Removing configuration files:"
LangString DESC_REMOVEEXE ${LANG_ENGLISH} "Remove ${NAME} executable"
LangString DESC_REMOVECONF ${LANG_ENGLISH} "Remove all other configuration and extracted data files and directories in ${NAME} install directory created by user or ${NAME}"
LangString NO_STRATAGUS ${LANG_ENGLISH} "Stratagus is not installed. You need Stratagus to run Wargus!"

LangString EXTRACTDATA_PAGE_TITLE ${LANG_ENGLISH} "Title"
LangString EXTRACTDATA_PAGE_SUBTITLE ${LANG_ENGLISH} "Subtitle"

!ifdef AMD64
LangString AMD64ONLY ${LANG_ENGLISH} "This version is for 64 bits computers only."
!endif

;--------------------------------

Var STARTMENU_FOLDER

!define MUI_ICON "${ICON}"
!define MUI_UNICON "${ICON}"

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_UNFINISHPAGE_NOAUTOCLOSE
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${REGKEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "StartMenu"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "COPYING"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER
!insertmacro MUI_PAGE_INSTFILES
Page custom PageExtractData PageExtractDataLeave
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "${LANGUAGE}"

;--------------------------------

Name "${NAME}"
Icon "${ICON}"
OutFile "${INSTALLER}"
InstallDir "${INSTALLDIR}"
InstallDirRegKey HKLM "${REGKEY}" "InstallLocation"

BrandingText " "
ShowInstDetails Show
ShowUnInstDetails Show
XPStyle on
RequestExecutionLevel admin

;--------------------------------

Function .onInit

!ifdef AMD64

	System::Call "kernel32::GetCurrentProcess() i .s"
	System::Call "kernel32::IsWow64Process(i s, *i .r0)"
	IntCmp $0 0 0 end

	MessageBox MB_OK|MB_ICONSTOP "$(AMD64ONLY)"
	Abort

end:

!endif

	ReadRegStr $R0 HKLM "${STRATAGUS_REGKEY}" "InstallLocation"
	StrCmp $R0 "" 0 end2

	MessageBox MB_OK|MB_ICONSTOP "$(NO_STRATAGUS)"
	Abort

end2:

FunctionEnd

;--------------------------------

Function PageExtractData

	ReserveFile "extractdata.ini"
	!insertmacro MUI_HEADER_TEXT $(EXTRACTDATA_PAGE_TITLE) $(EXTRACTDATA_PAGE_SUBTITLE)
	!insertmacro MUI_INSTALLOPTIONS_EXTRACT "extractdata.ini"
	!insertmacro MUI_INSTALLOPTIONS_DISPLAY "extractdata.ini"

FunctionEnd

Function PageExtractDataLeave

	!insertmacro MUI_INSTALLOPTIONS_READ $R0 "extractdata.ini" "Field 2" "State"

	IfFileExists "$R0\data\rezdat.war" extract

	MessageBox MB_OK|MB_ICONSTOP "This is not valid Warcraft II directory.\nFile $R0\data\rezdat.war does not exist."
	Abort

extract:

; TODO: extract data

FunctionEnd

;--------------------------------

Section "-${NAME}" UninstallPrevious

        SectionIn RO

	ReadRegStr $R0 HKLM "${REGKEY}" "InstallLocation"
	StrCmp $R0 "" end

	DetailPrint "$(REMOVEPREVIOUS)"
	SetDetailsPrint none
	ExecWait "$R0\${UNINSTALL} /S _?=$R0"
	Delete "$R0\${UNINSTALL}"
	RMDir $R0
	SetDetailsPrint lastused

end:

SectionEnd

Section "${NAME}"

	SectionIn RO

	SetOutPath $INSTDIR
	File "${WARGUS}"
	File "${WARTOOL}"
	File "${PUDCONVERT}"
	File "${FFMPEG2THEORA}"
	File /r "maps"
	File /r "scripts"
	File /r "campaigns"

	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
	CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
	CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\${NAME}.lnk" "$INSTDIR\${WARGUS}"
	CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\${UNINSTALL}"
	!insertmacro MUI_STARTMENU_WRITE_END

	WriteRegStr HKLM "${REGKEY}" "DisplayName" "${NAME}"
	WriteRegStr HKLM "${REGKEY}" "UninstallString" "$\"$INSTDIR\${UNINSTALL}$\""
	WriteRegStr HKLM "${REGKEY}" "QuietUninstallString" "$\"$INSTDIR\${UNINSTALL}$\" /S"
	WriteRegStr HKLM "${REGKEY}" "InstallLocation" "$INSTDIR"
	WriteRegStr HKLM "${REGKEY}" "DisplayIcon" "$\"$INSTDIR\${WARGUS}$\",0"
	WriteRegStr HKLM "${REGKEY}" "DisplayVersion" "${VERSION}"
	WriteRegDWORD HKLM "${REGKEY}" "NoModify" 1
	WriteRegDWORD HKLM "${REGKEY}" "NoRepair" 1

	WriteUninstaller "$INSTDIR\${UNINSTALL}"

SectionEnd

;--------------------------------

Section "un.${NAME}" Executable

	SectionIn RO

	Delete "$INSTDIR\${WARGUS}"
	Delete "$INSTDIR\${WARTOOL}"
	Delete "$INSTDIR\${PUDCONVERT}"
	Delete "$INSTDIR\${FFMPEG2THEORA}"
	Delete "$INSTDIR\${UNINSTALL}"
	RMDir "$INSTDIR"

	!insertmacro MUI_STARTMENU_GETFOLDER Application $STARTMENU_FOLDER
	Delete "$SMPROGRAMS\$STARTMENU_FOLDER\${NAME}.lnk"
	Delete "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk"
	RMDir "$SMPROGRAMS\$STARTMENU_FOLDER"

	DeleteRegKey /ifempty HKLM "${REGKEY}"

SectionEnd

Section /o "un.Configuration" Configuration

	DetailPrint "$(REMOVECONFIGURATION)"
	RMDir /r "$INSTDIR"

SectionEnd

!insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${Executable} $(DESC_REMOVEEXE)
!insertmacro MUI_DESCRIPTION_TEXT ${Configuration} $(DESC_REMOVECONF)
!insertmacro MUI_UNFUNCTION_DESCRIPTION_END

;--------------------------------

;!system "wget http://v2v.cc/~j/ffmpeg2theora/ffmpeg2theora-0.27.exe"

;!define MUI_FINISHPAGE_TEXT "Setup now needs to extract the data from Warcraft 2.\r\n\r\nNote: You will not be able to play Wargus until this is complete."
;!define MUI_FINISHPAGE_RUN "$INSTDIR\warinstall.exe"
;!define MUI_FINISHPAGE_RUN_TEXT "Extract Warcraft 2 data now"
