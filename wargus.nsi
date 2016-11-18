;       _________ __                 __
;      /   _____//  |_____________ _/  |______     ____  __ __  ______
;      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
;      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
;     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
;             \/                  \/          \//_____/            \/
;  ______________________                           ______________________
;                        T H E   W A R   B E G I N S
;         Stratagus - A free fantasy real time strategy game engine
;
;    wargus.nsi - Windows NSIS Installer for Wargus
;    Copyright (C) 2010-2014  Pali Rohar <pali.rohar@gmail.com>, cybermind <cybermindid@gmail.com>
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 2 of the License, or
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

;--------------------------------

!ifdef QUIET
!verbose 2
!endif

!define redefine "!insertmacro redefine"
!macro redefine symbol value
!undef ${symbol}
!define ${symbol} "${value}"
!macroend

!include "MUI2.nsh"
!include "Sections.nsh"

;--------------------------------

; General variables
!define NAME "Wargus"
!define TALES_NAME "Wargus - Aleonas Tales"
!define VERSION "2.4.1"
!define VIVERSION "${VERSION}.0"
!define HOMEPAGE "https://wargus.github.io"
!define LICENSE "GPL v2+"
!define COPYRIGHT "Copyright (c) 1998-2016 by The Stratagus Project"
!define STRATAGUS_NAME "Stratagus"
!define STRATAGUS_HOMEPAGE "https://github.com/Wargus/stratagus"

;--------------------------------

!define ICON "wargus.ico"
!define EXE "wargus.exe"
!define TALES "aleonas_tales.exe"
!define WARTOOL "wartool.exe"
!define PUDCONVERT "pudconvert.exe"

; -- have to try and copy these, VS might have put them under (Release|Debug)
!system "powershell -Command $\"& {cp **\${WARTOOL} ${WARTOOL}}$\""
!system "powershell -Command $\"& {cp **\${EXE} ${EXE}}$\""
!system "powershell -Command $\"& {cp **\${TALES} ${TALES}}$\""
!system "powershell -Command $\"& {cp **\${PUDCONVERT} ${PUDCONVERT}}$\""

!define CDDA2WAV "cdda2wav.exe"
!define FFMPEG2THEORA "ffmpeg2theora.exe"
!define SF2BANK "TimGM6mb.sf2"
!define VCREDIST "vc_redist.x86.exe"
!define VCREDISTREGKEY "SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x86"
!define UNINSTALL "uninstall.exe"
!define INSTALLER "${NAME}-${VERSION}.exe"
!define INSTALLDIR "$PROGRAMFILES\${NAME}\"

; Installer for x86-64 systems
!ifdef x86_64
${redefine} INSTALLER "${NAME}-${VERSION}-x86_64.exe"
${redefine} INSTALLDIR "$PROGRAMFILES64\${NAME}\"
${redefine} NAME "Wargus (64 bit)"
${redefine} STRATAGUS_NAME "Stratagus (64 bit)"
${redefine} VCREDIST "vc_redist.x64.exe"
${redefine} VCREDISTREGKEY "SOFTWARE\WOW6432Node\Microsoft\VisualStudio\14.0\VC\Runtimes\x64"
!endif

; Registry paths
!define REGKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"
!define STRATAGUS_REGKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${STRATAGUS_NAME}"

;--------------------------------

; Download and extract nessesary 3rd party programs
!ifndef NO_DOWNLOAD
!system 'powershell -Command "& {wget http://v2v.cc/~j/ffmpeg2theora/ffmpeg2theora-0.28.exe -OutFile ffmpeg2theora.exe}"'
!system 'powershell -Command "& {wget http://smithii.com/files/cdrtools-2.01-bootcd.ru-w32.zip -OutFile cdrtools.zip}"'
!system 'powershell -Command "& {unzip -o cdrtools.zip cdda2wav.exe}"'
!system 'powershell -Command "& {wget http://ocmnet.com/saxguru/TimGM6mb.sf2 -OutFile TimGM6mb.sf2}"'
!system "powershell -Command $\"& {wget https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/${VCREDIST} -OutFile ${VCREDIST}}$\""
!endif

!addplugindir .

;--------------------------------

Var STARTMENUDIR
Var DATADIR
Var DATADIR2
Var EXTRACTNEEDED
Var EXTRACTNEEDED2

Var OptDataset
Var OptMusic
Var DataDirectory

!define MUI_ICON "${ICON}"
!define MUI_UNICON "${ICON}"

; Installer pages

!define MUI_ABORTWARNING
!define MUI_LANGDLL_ALLLANGUAGES
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!define MUI_FINISHPAGE_RUN "$INSTDIR\${EXE}"
!define MUI_UNFINISHPAGE_NOAUTOCLOSE
!define MUI_UNFINISHPAGE_NOREBOOTSUPPORT
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${REGKEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "StartMenu"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "COPYING"
!insertmacro MUI_PAGE_LICENSE "COPYING-3rd"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY

!define MUI_PAGE_HEADER_TEXT "$(EXTRACTDATA_PAGE_HEADER_TEXT)"
!define MUI_PAGE_HEADER_SUBTEXT "$(EXTRACTDATA_PAGE_HEADER_SUBTEXT)"
!define MUI_DIRECTORYPAGE_TEXT_TOP "$(EXTRACTDATA_PAGE_TEXT_TOP)"
!define MUI_DIRECTORYPAGE_TEXT_DESTINATION "$(EXTRACTDATA_PAGE_TEXT_DESTINATION)"
!define MUI_DIRECTORYPAGE_VARIABLE $DATADIR
!define MUI_DIRECTORYPAGE_VERIFYONLEAVE
!define MUI_PAGE_CUSTOMFUNCTION_PRE PageExtractDataPre
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageExtractDataLeave
!insertmacro MUI_PAGE_DIRECTORY

!define MUI_PAGE_HEADER_TEXT "$(EXTRACTDATA_PAGE_HEADER_TEXT2)"
!define MUI_PAGE_HEADER_SUBTEXT "$(EXTRACTDATA_PAGE_HEADER_SUBTEXT2)"
!define MUI_DIRECTORYPAGE_TEXT_TOP "$(EXTRACTDATA_PAGE_TEXT_TOP2)"
!define MUI_DIRECTORYPAGE_TEXT_DESTINATION "$(EXTRACTDATA_PAGE_TEXT_DESTINATION2)"
!define MUI_DIRECTORYPAGE_VARIABLE $DATADIR2
!define MUI_DIRECTORYPAGE_VERIFYONLEAVE
!define MUI_PAGE_CUSTOMFUNCTION_PRE PageExtractDataPre
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageExtractDataLeave2
!insertmacro MUI_PAGE_DIRECTORY

!insertmacro MUI_PAGE_STARTMENU Application $STARTMENUDIR
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
; Available languages
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Russian"

!insertmacro MUI_RESERVEFILE_LANGDLL

; Language-dependent strings
LangString INSTALLER_RUNNING ${LANG_ENGLISH} "${NAME} Installer is already running"
LangString INSTALLER_RUNNING ${LANG_RUSSIAN} "Установщик ${NAME} уже запущен"
LangString NO_STRATAGUS ${LANG_ENGLISH} "${STRATAGUS_NAME} ${VERSION} is not installed.$\nYou need ${STRATAGUS_NAME} ${VERSION} to run ${NAME}!$\nFirst install ${STRATAGUS_NAME} ${VERSION} from ${STRATAGUS_HOMEPAGE}"
LangString NO_STRATAGUS ${LANG_RUSSIAN} "${STRATAGUS_NAME} ${VERSION} is not installed.$\nYou need ${STRATAGUS_NAME} ${VERSION} to run ${NAME}!$\nFirst install ${STRATAGUS_NAME} ${VERSION} from ${STRATAGUS_HOMEPAGE}"
LangString REMOVEPREVIOUS ${LANG_ENGLISH} "Removing previous installation"
LangString REMOVEPREVIOUS ${LANG_RUSSIAN} "Удаляются файлы из предыдущей установки"
LangString REMOVECONFIGURATION ${LANG_ENGLISH} "Removing configuration and data files:"
LangString REMOVECONFIGURATION ${LANG_RUSSIAN} "Удаляются данные и файлы конфигураций:"
LangString DESC_REMOVEEXE ${LANG_ENGLISH} "Remove ${NAME} binary executables"
LangString DESC_REMOVEEXE ${LANG_RUSSIAN} "Удаляются исполняемые файлы ${NAME}"
LangString DESC_REMOVECONF ${LANG_ENGLISH} "Remove all other configuration and extracted data files and directories in ${NAME} install directory created by user or ${NAME}"
LangString DESC_REMOVECONF ${LANG_RUSSIAN} "Удалить все прочие файлы и директории в установочной папке ${NAME}, созданные пользователем ${NAME}"

LangString EXTRACTDATA_FILES ${LANG_ENGLISH} "Extracting Warcraft II data files..."
LangString EXTRACTDATA_FILES ${LANG_RUSSIAN} "Извлекаются файлы Warcraft II..."
LangString EXTRACTDATA_RIP_AUDIO ${LANG_ENGLISH} "Ripping Warcraft II audio tracks..."
LangString EXTRACTDATA_RIP_AUDIO ${LANG_RUSSIAN} "Копируется CD-музыка Warcraft II..."
LangString EXTRACTDATA_COPY_AUDIO ${LANG_ENGLISH} "Coping Warcraft II audio tracks..."
LangString EXTRACTDATA_COPY_AUDIO ${LANG_RUSSIAN} "Копируется музыка Warcraft II..."
LangString EXTRACTDATA_CONVERT_AUDIO ${LANG_ENGLISH} "Converting Warcraft II audio tracks..."
LangString EXTRACTDATA_CONVERT_AUDIO ${LANG_RUSSIAN} "Конвертируется музыка Warcraft II..."

LangString EXTRACTDATA_FILES_FAILED ${LANG_ENGLISH} "Extracting Warcraft II data files failed."
LangString EXTRACTDATA_FILES_FAILED ${LANG_RUSSIAN} "Не удалось извлечь файлы Warcraft II."
LangString EXTRACTDATA_FILES_FAILED2 ${LANG_ENGLISH} "Extracting Warcraft II Expansion data files failed. The game will still be playable without expansion, so not aborting."
LangString EXTRACTDATA_FILES_FAILED2 ${LANG_RUSSIAN} "Не удалось извлечь файлы Warcraft II Expansion. Игра по-прежнему будет играть без расширения."
LangString EXTRACTDATA_RIP_AUDIO_FAILED ${LANG_ENGLISH} "Ripping Warcraft II audio tracks failed."
LangString EXTRACTDATA_RIP_AUDIO_FAILED ${LANG_RUSSIAN} "Не удалось скопировать CD-музыку Warcraft II."
LangString EXTRACTDATA_COPY_AUDIO_FAILED ${LANG_ENGLISH} "Coping Warcraft II audio tracks failed."
LangString EXTRACTDATA_COPY_AUDIO_FAILED ${LANG_RUSSIAN} "Не удалось скопировать музыку Warcraft II."
LangString EXTRACTDATA_CONVERT_AUDIO_FAILED ${LANG_ENGLISH} "Converting Warcraft II audio tracks failed."
LangString EXTRACTDATA_CONVERT_AUDIO_FAILED ${LANG_RUSSIAN} "Не удалось сконвертировать музыку Warcraft II."

LangString EXTRACTDATA_PAGE_HEADER_TEXT ${LANG_ENGLISH} "Choose Warcraft II Location"
LangString EXTRACTDATA_PAGE_HEADER_TEXT ${LANG_RUSSIAN} "Укажите местоположение Warcraft II"
LangString EXTRACTDATA_PAGE_HEADER_SUBTEXT ${LANG_ENGLISH} "Choose the folder in which are Warcraft II data files."
LangString EXTRACTDATA_PAGE_HEADER_SUBTEXT ${LANG_RUSSIAN} "Укажите папку, в которой содержатся файлы Warcraft II."
LangString EXTRACTDATA_PAGE_TEXT_TOP ${LANG_ENGLISH} "Setup will extract Warcraft II data files from the following folder. You can specify location of CD or install location of Warcraft II data files (doesn't work for Battle.net edition)."
LangString EXTRACTDATA_PAGE_TEXT_TOP ${LANG_RUSSIAN} "Программа установки извлечет файлы Warcraft II из указанной папки. Вы можете указать либо CD-диск с игрой, либо указать папку с установленным Warcraft II (не подходит для версии Battle.net)."
LangString EXTRACTDATA_PAGE_TEXT_DESTINATION ${LANG_ENGLISH} "Source Folder"
LangString EXTRACTDATA_PAGE_TEXT_DESTINATION ${LANG_RUSSIAN} "Папка с файлами Warcraft II"
LangString EXTRACTDATA_PAGE_NOT_VALID ${LANG_ENGLISH} "This is not valid Warcraft II data directory."
LangString EXTRACTDATA_PAGE_NOT_VALID ${LANG_RUSSIAN} "Программа установки не обнаружила Warcraft II в указанной папке."

LangString EXTRACTDATA_PAGE_HEADER_TEXT2 ${LANG_ENGLISH} "Choose Warcraft II Expansion Location (optional)"
LangString EXTRACTDATA_PAGE_HEADER_TEXT2 ${LANG_RUSSIAN} "Укажите местоположение Warcraft II Expansion"
LangString EXTRACTDATA_PAGE_HEADER_SUBTEXT2 ${LANG_ENGLISH} "Choose the folder in which are Warcraft II Expansion data files (optional)."
LangString EXTRACTDATA_PAGE_HEADER_SUBTEXT2 ${LANG_RUSSIAN} "Укажите папку, в которой содержатся файлы Warcraft II Expansion."
LangString EXTRACTDATA_PAGE_TEXT_TOP2 ${LANG_ENGLISH} "Setup will extract Warcraft II Expansion data files from the following folder. You can specify location of CD or install location of Warcraft II data files (doesn't work for Battle.net edition)."
LangString EXTRACTDATA_PAGE_TEXT_TOP2 ${LANG_RUSSIAN} "Программа установки извлечет файлы Warcraft II Expansion   из указанной папки. Вы можете указать либо CD-диск с игрой, либо указать папку с установленным Warcraft II (не подходит для версии Battle.net)."
LangString EXTRACTDATA_PAGE_TEXT_DESTINATION2 ${LANG_ENGLISH} "Source Folder"
LangString EXTRACTDATA_PAGE_TEXT_DESTINATION2 ${LANG_RUSSIAN} "Папка с файлами Warcraft II Expansion"
LangString EXTRACTDATA_PAGE_NOT_VALID2 ${LANG_ENGLISH} "This is not valid Warcraft II Expansion data directory. Skipping Expansion extraction."
LangString EXTRACTDATA_PAGE_NOT_VALID2 ${LANG_RUSSIAN} "Программа установки не обнаружила Warcraft II Expansion в указанной папке."

LangString STR_VERSION ${LANG_ENGLISH} "version"
LangString STR_VERSION ${LANG_RUSSIAN} "версия"

!ifdef x86_64
LangString x86_64_ONLY ${LANG_ENGLISH} "This version is for 64 bits computers only"
LangString x86_64_ONLY ${LANG_RUSSIAN} "Эта версия предназначена для 64-битных систем"
!endif

;--------------------------------

Name "${NAME}"
Icon "${ICON}"
OutFile "${INSTALLER}"
InstallDir "${INSTALLDIR}"
InstallDirRegKey HKLM "${REGKEY}" "InstallLocation"

VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "${NAME} Installer"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "InternalName" "${NAME} Installer"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "${COPYRIGHT}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "License" "${LICENSE}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "Homepage" "${HOMEPAGE}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "OriginalFilename" "${INSTALLER}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${NAME} Installer"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductVersion" "${VERSION}"
VIProductVersion "${VIVERSION}"

BrandingText "${NAME}, $(STR_VERSION) ${VERSION}  ${HOMEPAGE}"
ShowInstDetails Show
ShowUnInstDetails Show
XPStyle on
RequestExecutionLevel admin

ReserveFile "${WARTOOL}"

;--------------------------------

Section "${NAME}"
	SectionIn RO
SectionEnd

SectionGroup "Data set" dataset
	Section "Warcraft 2" opt1Warcraft
	SectionEnd

	Section /o "Aleona Tales" opt1AT
	SectionEnd
SectionGroupEnd

SectionGroup "Music" music
	Section  "MIDI music" opt2MIDI
	SectionEnd

	Section /o "CD Music" opt2CD
	SectionEnd
SectionGroupEnd

Section "-${NAME}" UninstallPrevious

	SectionIn RO

	ReadRegStr $0 HKLM "${REGKEY}" "InstallLocation"
	StrCmp $0 "" +7

	DetailPrint "$(REMOVEPREVIOUS)"
	SetDetailsPrint none
	ExecWait "$0\${UNINSTALL} /S _?=$0"
	Delete "$0\${UNINSTALL}"
	RMDir $0
	SetDetailsPrint lastused

SectionEnd

Section "-${NAME}"

	SectionIn RO

	SetOutPath "$INSTDIR"
	File "${EXE}"
	File "${ALEONAS_TALES}"
	File "${WARTOOL}"
	File "${PUDCONVERT}"
	File "${CDDA2WAV}"
	File "${FFMPEG2THEORA}"

	; -- XXX TODO: include Stratagus and dependencies some better way
	File "stratagus.exe"
	File "libfluidsynth.dll"
	File "libglib-2.0-0.dll"
	File "libgthread-2.0-0.dll"
	File "lua51.dll"
	File "SDL.dll"

	SetOutPath "$INSTDIR\music"
	File "${SF2BANK}"

        SetOutPath "$INSTDIR"

	ClearErrors

	ReadRegDword $R0 HKLM "${VCREDISTREGKEY}" "Installed"
	IfErrors 0 NoErrors
	StrCpy $R0 0
	NoErrors:
	${If} $R0 == 0
	  File "${VCREDIST}"
	  ExecWait "$\"$INSTDIR\${VCREDIST}$\"  /passive /norestart"
	  Delete "$\"$INSTDIR\${VCREDIST}$\""
    ${EndIf}

	ClearErrors

	!cd ${CMAKE_CURRENT_SOURCE_DIR}

	SetOutPath "$INSTDIR\maps"
	File /r /x *.pud* "maps\"
	SetOutPath "$INSTDIR\scripts"
	File /r "scripts\"
	SetOutPath "$INSTDIR\campaigns"
	File /r "campaigns\"
	StrCmp $OptDataset  ${opt1Warcraft} optwar2
	SetOutPath "$INSTDIR\graphics"
	File /r "graphics\"
	SetOutPath "$INSTDIR\music"
	File /r "music\"
	SetOutPath "$INSTDIR\sounds"
	File /r "sounds\"
	CreateShortCut "$SMPROGRAMS\$STARTMENUDIR\${TALES_NAME}.lnk" "$INSTDIR\${TALES}"
	CreateShortcut "$DESKTOP\${TALES_NAME}.lnk" "$INSTDIR\${TALES}"
optwar2:
	SetOutPath "$INSTDIR"

	CreateDirectory "$INSTDIR\music"
	CreateDirectory "$INSTDIR\graphics"
	CreateDirectory "$INSTDIR\graphics\ui"
	CreateDirectory "$INSTDIR\graphics\ui\cursors"
	CreateDirectory "$INSTDIR\graphics\missiles"

	File "/oname=graphics\ui\cursors\cross.png" "contrib\cross.png"
	File "/oname=graphics\missiles\red_cross.png" "contrib\red_cross.png"
	File "/oname=graphics\ui\mana.png" "contrib\mana.png"
	File "/oname=graphics\ui\mana2.png" "contrib\mana2.png"
	File "/oname=graphics\ui\health.png" "contrib\health.png"
	File "/oname=graphics\ui\health2.png" "contrib\health2.png"
	File "/oname=graphics\ui\food.png" "contrib\food.png"
	File "/oname=graphics\ui\score.png" "contrib\score.png"
	File "/oname=graphics\ui\ore,stone,coal.png" "contrib\ore,stone,coal.png"

	!cd ${CMAKE_CURRENT_BINARY_DIR}

	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
	CreateDirectory "$SMPROGRAMS\$STARTMENUDIR"
	CreateShortCut "$SMPROGRAMS\$STARTMENUDIR\${NAME}.lnk" "$INSTDIR\${EXE}"
	CreateShortCut "$SMPROGRAMS\$STARTMENUDIR\Uninstall.lnk" "$INSTDIR\${UNINSTALL}"
	CreateShortcut "$DESKTOP\${NAME}.lnk" "$INSTDIR\${EXE}"
	!insertmacro MUI_STARTMENU_WRITE_END

	WriteRegStr HKLM "${REGKEY}" "DisplayName" "${NAME}"
	WriteRegStr HKLM "${REGKEY}" "UninstallString" "$\"$INSTDIR\${UNINSTALL}$\""
	WriteRegStr HKLM "${REGKEY}" "QuietUninstallString" "$\"$INSTDIR\${UNINSTALL}$\" /S"
	WriteRegStr HKLM "${REGKEY}" "InstallLocation" "$INSTDIR"
	WriteRegStr HKLM "${REGKEY}" "DisplayIcon" "$\"$INSTDIR\${EXE}$\",0"
	WriteRegStr HKLM "${REGKEY}" "DisplayVersion" "${VERSION}"
	WriteRegStr HKLM "${REGKEY}" "HelpLink" "${HOMEPAGE}"
	WriteRegStr HKLM "${REGKEY}" "URLUpdateInfo" "${HOMEPAGE}"
	WriteRegStr HKLM "${REGKEY}" "URLInfoAbout" "${HOMEPAGE}"
	WriteRegDWORD HKLM "${REGKEY}" "NoModify" 1
	WriteRegDWORD HKLM "${REGKEY}" "NoRepair" 1
	WriteRegStr HKLM "${REGKEY}" "DataDir" "$DATADIR"
	WriteRegStr HKLM "${STRATAGUS_REGKEY}\Games" "${NAME}" "${VERSION}"

	WriteUninstaller "$INSTDIR\${UNINSTALL}"

SectionEnd

;--------------------------------

Function PageExtractDataPre
    ; Skips the extraction stage if not needed
	StrCmp $OptDataset  ${opt1AT} noextract
	File "/oname=$TEMP\${WARTOOL}" "${WARTOOL}"
	Goto extract

noextract:

	StrCpy $EXTRACTNEEDED "no"
	Abort

extract:

	StrCpy $EXTRACTNEEDED "yes"

FunctionEnd

Function PageExtractDataLeave

	IfFileExists "$DATADIR\data\rezdat.war" +4
	IfFileExists "$DATADIR\SUPPORT\TOMES\TOME.1" +3

	MessageBox MB_OK|MB_ICONSTOP "$(EXTRACTDATA_PAGE_NOT_VALID)"
	Abort

FunctionEnd

Function PageExtractDataLeave2
    StrCpy $EXTRACTNEEDED2 "yes"
	IfFileExists "$DATADIR2\data\rezdat.war" +4
	IfFileExists "$DATADIR2\SUPPORT\TOMES\TOME.1" +3
	MessageBox MB_OK|MB_ICONINFORMATION "$(EXTRACTDATA_PAGE_NOT_VALID2)"
	StrCpy $EXTRACTNEEDED2 "no"
FunctionEnd

Var KeyStr
Section "-${NAME}" ExtractData

	StrCmp "$EXTRACTNEEDED" "no" end

	AddSize 110348

	DetailPrint ""
	DetailPrint "$(EXTRACTDATA_FILES)"
	StrCpy $DataDirectory "$DATADIR"
	IfFileExists "$DATADIR\SUPPORT\TOMES\TOME.1" +2
	StrCpy $DataDirectory "$\"$DATADIR\data$\""

	DetailPrint "$DataDirectory"
	StrCmp $OptMusic "${opt2CD}" 0 +2
	StrCpy $KeyStr "$KeyStr -r"
	ExecWait "$\"$INSTDIR\${WARTOOL}$\" $KeyStr -v $\"$DataDirectory$\" $\"$INSTDIR$\""
	Pop $0
	IntCmp $0 0 +3

	MessageBox MB_OK|MB_ICONSTOP "$(EXTRACTDATA_FILES_FAILED)"
	Abort

	StrCmp "$EXTRACTNEEDED2" "no" end
	StrCpy $DataDirectory "$DATADIR2"
	IfFileExists "$DATADIR2\SUPPORT\TOMES\TOME.1" +2
	StrCpy $DataDirectory "$\"$DATADIR2\data$\""
	DetailPrint "$DataDirectory"
	ExecWait "$\"$INSTDIR\${WARTOOL}$\" $KeyStr -v $\"$DataDirectory$\" $\"$INSTDIR$\""
	Pop $0
	IntCmp $0 0 +3
	MessageBox MB_OK|MB_ICONSTOP "$(EXTRACTDATA_FILES_FAILED2)"
	Abort
end:

SectionEnd

;--------------------------------

Section "un.${NAME}" Executable

	SectionIn RO

	Delete "$INSTDIR\${EXE}"
	Delete "$INSTDIR\${WARTOOL}"
	Delete "$INSTDIR\${PUDCONVERT}"
	Delete "$INSTDIR\${CDDA2WAV}"
	Delete "$INSTDIR\${FFMPEG2THEORA}"
	Delete "$INSTDIR\${UNINSTALL}"

	IfFileExists "$INSTDIR\scripts\wc2-config.lua" 0 +2
	Rename "$INSTDIR\scripts\wc2-config.lua" "$INSTDIR\wc2-config.lua"

	RMDir /r "$INSTDIR\scripts"

	IfFileExists "$INSTDIR\wc2-config.lua" 0 +3
	CreateDirectory "$INSTDIR\scripts"
	Rename "$INSTDIR\wc2-config.lua" "$INSTDIR\scripts\wc2-config.lua"

	Delete "$INSTDIR\campaigns\human\level*h_c.sms"
	Delete "$INSTDIR\campaigns\orc\level*o_c.sms"
	Delete "$INSTDIR\campaigns\human-exp\levelx*h_c.sms"
	Delete "$INSTDIR\campaigns\orc-exp\levelx*o_c.sms"
	RMDir "$INSTDIR\campaigns\human"
	RMDir "$INSTDIR\campaigns\orc"
	RMDir "$INSTDIR\campaigns\human-exp"
	RMDir "$INSTDIR\campaigns\orc-exp"
	RMDir "$INSTDIR\campaigns"
	RMDir "$INSTDIR"

	!insertmacro MUI_STARTMENU_GETFOLDER Application $STARTMENUDIR
	Delete "$SMPROGRAMS\$STARTMENUDIR\${NAME}.lnk"
	Delete "$SMPROGRAMS\$STARTMENUDIR\${TALES_NAME}.lnk"
	Delete "$SMPROGRAMS\$STARTMENUDIR\Uninstall.lnk"
	RMDir "$SMPROGRAMS\$STARTMENUDIR"
	Delete "$DESKTOP\${NAME}.lnk"

	DeleteRegKey HKLM "${REGKEY}"
	DeleteRegValue HKLM "${STRATAGUS_REGKEY}\Games" "${NAME}"

	ClearErrors
	EnumRegValue $0 HKLM "${REGKEY}\Games" 0
	IfErrors +2

	DeleteRegKey /ifempty HKLM "${STRATAGUS_REGKEY}\Games"

SectionEnd

Section /o "un.Configuration" Configuration

	DetailPrint "$(REMOVECONFIGURATION)"
	RMDir /r "$INSTDIR"

SectionEnd

!insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT "${Executable}" "$(DESC_REMOVEEXE)"
!insertmacro MUI_DESCRIPTION_TEXT "${Configuration}" "$(DESC_REMOVECONF)"
!insertmacro MUI_UNFUNCTION_DESCRIPTION_END

;--------------------------------

Function .onInit
	; Set default components options
	StrCpy $OptDataset ${opt1Warcraft}
	StrCpy $OptMusic ${opt2MIDI}

	; Check if Wargus installer is already running
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${NAME}") i .r1 ?e'
	Pop $0
	StrCmp $0 0 +3

	MessageBox MB_OK|MB_ICONEXCLAMATION "$(INSTALLER_RUNNING)"
	Abort

!ifdef x86_64

	System::Call "kernel32::GetCurrentProcess() i .s"
	System::Call "kernel32::IsWow64Process(i s, *i .r0)"
	IntCmp $0 0 0 0 +3

	MessageBox MB_OK|MB_ICONSTOP "$(x86_64_ONLY)"
	Abort

!endif

	ReadRegStr $DATADIR HKLM "${REGKEY}" "DataDir"
	StrCmp $DATADIR "" 0 +2

	StrCpy $DATADIR "D:"
	!insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Function .onSelChange

  !insertmacro StartRadioButtons $OptDataset
    !insertmacro RadioButton ${opt1Warcraft}
    !insertmacro RadioButton ${opt1AT}
  !insertmacro EndRadioButtons

  !insertmacro StartRadioButtons $OptMusic
    !insertmacro RadioButton ${opt2CD}
    !insertmacro RadioButton ${opt2MIDI}
  !insertmacro EndRadioButtons

FunctionEnd

;--------------------------------

!ifdef UPX

!ifndef UPX_FLAGS
!define UPX_FLAGS "-9"
!else
${redefine} UPX_FLAGS "${UPX_FLAGS} -9"
!endif

!ifdef QUIET
${redefine} UPX_FLAGS "${UPX_FLAGS} -q"
!endif

!packhdr "exehead.tmp" "${UPX} ${UPX_FLAGS} exehead.tmp"

!endif

;!finalize "gpg --armor --sign --detach-sig %1"

;--------------------------------

!ifndef NO_DOWNLOAD
!delfile "ffmpeg2theora.exe"
!delfile "cdda2wav.exe"
!delfile "cdrtools.zip"
!delfile "TimGM6mb.sf2"
!endif

;--------------------------------
