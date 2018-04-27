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
!define VERSION "2.4.2"
!define VIVERSION "${VERSION}.0"
!define HOMEPAGE "https://wargus.github.io"
!define LICENSE "GPL v2+"
!define COPYRIGHT "Copyright (c) 1998-2017 by The Stratagus Project"
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
!define FFMPEG "ffmpeg.exe"
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
!system 'powershell -Command "& {wget http://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-3.3.3-win32-static.zip -OutFile ffmpeg.zip}"'
!system 'powershell -Command "& {unzip -o -j ffmpeg.zip "ffmpeg-3.3.3-win32-static/bin/ffmpeg.exe"}"'
!system 'powershell -Command "& {wget http://smithii.com/files/cdrtools-2.01-bootcd.ru-w32.zip -OutFile cdrtools.zip}"'
!system 'powershell -Command "& {unzip -o cdrtools.zip cdda2wav.exe}"'
!system 'powershell -Command "& {wget http://github.com/craffel/pretty-midi/blob/master/pretty_midi/TimGM6mb.sf2?raw=true -OutFile TimGM6mb.sf2}"'
!system "powershell -Command $\"& {wget https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/${VCREDIST} -OutFile ${VCREDIST}}$\""
!endif

!addplugindir .

;--------------------------------

Var STARTMENUDIR

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
	File "${TALES}"
	File "${WARTOOL}"
	File "${PUDCONVERT}"
	File "${CDDA2WAV}"
	File "${FFMPEG}"

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
	SetOutPath "$INSTDIR\contrib"
	File /r "contrib\"
	SetOutPath "$INSTDIR\shaders"
	File /r "shaders\"
	SetOutPath "$INSTDIR\scripts"
	File /r "scripts\"
	SetOutPath "$INSTDIR\campaigns"
	File /r "campaigns\"
	SetOutPath "$INSTDIR\graphics"
	File /r "graphics\"
	SetOutPath "$INSTDIR\music"
	File /r "music\"
	SetOutPath "$INSTDIR\sounds"
	File /r "sounds\"
	CreateShortCut "$SMPROGRAMS\$STARTMENUDIR\${TALES_NAME}.lnk" "$INSTDIR\${TALES}"
	CreateShortcut "$DESKTOP\${TALES_NAME}.lnk" "$INSTDIR\${TALES}"

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
	WriteRegStr HKLM "${STRATAGUS_REGKEY}\Games" "${NAME}" "${VERSION}"

	WriteUninstaller "$INSTDIR\${UNINSTALL}"

SectionEnd

;--------------------------------

Section "un.${NAME}" Executable

	SectionIn RO

	Delete "$INSTDIR\${EXE}"
	Delete "$INSTDIR\${WARTOOL}"
	Delete "$INSTDIR\${PUDCONVERT}"
	Delete "$INSTDIR\${CDDA2WAV}"
	Delete "$INSTDIR\${FFMPEG}"
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
	Delete "$DESKTOP\${TALES_NAME}.lnk"

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

	!insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Function .onSelChange

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
!delfile "ffmpeg.exe"
!delfile "ffmpeg.zip"
!delfile "cdda2wav.exe"
!delfile "cdrtools.zip"
!delfile "TimGM6mb.sf2"
!endif

;--------------------------------
