!include "MUI.nsh"

;*** edit these defines to point to their correct locations ***;
!define STRATEXE "stratagus.exe"
!define SDLDLL "..\stratagus\SDL.dll"
!define WARINSTEXE "warinstall\Release\warinstall.exe"
!define PUDCONVERTEXE "pudconvert.exe"

!define NAME "Wargus"
!define WGTMP "wargustemp"

Name "${NAME}"
OutFile "Wargus-2.2.exe"

;!define MUI_ICON "stratagus.ico"
;!define MUI_UNICON "stratagus.ico"

InstallDir "$PROGRAMFILES\${NAME}"
InstallDirRegKey HKCU "Software\${NAME}" ""

Var MUI_TEMP
Var STARTMENU_FOLDER

; pre-compilation tasks
!system "echo CVS>exc.txt"
!system "rmdir /Q /S ${WGTMP}"
!system "mkdir ${WGTMP}"
!system "mkdir ${WGTMP}\scripts"
!system "mkdir ${WGTMP}\contrib"
!system "mkdir ${WGTMP}\campaigns"
!system "xcopy /E scripts ${WGTMP}\scripts /EXCLUDE:exc.txt"
!system "xcopy /E contrib ${WGTMP}\contrib /EXCLUDE:exc.txt"
!system "xcopy /E campaigns ${WGTMP}\campaigns /EXCLUDE:exc.txt"
!system "rmdir /S /Q ${WGTMP}\scripts\.svn"
!system "rmdir /S /Q ${WGTMP}\scripts\ai\.svn"
!system "rmdir /S /Q ${WGTMP}\scripts\human\.svn"
!system "rmdir /S /Q ${WGTMP}\scripts\menus\.svn"
!system "rmdir /S /Q ${WGTMP}\scripts\orc\.svn"
!system "rmdir /S /Q ${WGTMP}\scripts\tilesets\.svn"
!system "rmdir /S /Q ${WGTMP}\contrib\.svn"
!system "rmdir /S /Q ${WGTMP}\campaigns\.svn"
!system "rmdir /S /Q ${WGTMP}\campaigns\human\.svn"
!system "rmdir /S /Q ${WGTMP}\campaigns\human-exp\.svn"
!system "rmdir /S /Q ${WGTMP}\campaigns\orc\.svn"
!system "rmdir /S /Q ${WGTMP}\campaigns\orc-exp\.svn"
!system "erase exc.txt"


!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY

!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\${NAME}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_TEXT "Setup now needs to extract the data from Warcraft 2.\r\n\r\nNote: You will not be able to play Wargus until this is complete."
!define MUI_FINISHPAGE_RUN "$INSTDIR\warinstall.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Extract Warcraft 2 data now"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"


Section "${NAME}" SecDummy
  SectionIn RO
  SetOutPath "$INSTDIR"
  File /r "${WGTMP}\*.*"
  File "${STRATEXE}"
  File "${SDLDLL}"
  File "${WARINSTEXE}"
  File "${PUDCONVERTEXE}"
  WriteRegStr HKCU "Software\${NAME}" "" $INSTDIR
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\${NAME}.lnk" "$INSTDIR\stratagus.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Extract WC2 Data.lnk" "$INSTDIR\warinstall.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd


Section "Uninstall"
  RMDir /r "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP

  Delete "$SMPROGRAMS\$MUI_TEMP\${NAME}.lnk"
  Delete "$SMPROGRAMS\$MUI_TEMP\Extract WC2 Data.lnk"
  Delete "$SMPROGRAMS\$MUI_TEMP\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$MUI_TEMP"

  DeleteRegKey /ifempty HKCU "Software\${NAME}"
SectionEnd

!system "rmdir /Q /S ${WGTMP}"
