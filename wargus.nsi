!include "MUI.nsh"

!define NAME "Wargus"

Name "${NAME}"
OutFile "Wargus-2.1.exe"

;!define MUI_ICON "stratagus.ico"
;!define MUI_UNICON "stratagus.ico"

InstallDir "$PROGRAMFILES\${NAME}"
InstallDirRegKey HKCU "Software\${NAME}" ""

Var MUI_TEMP
Var STARTMENU_FOLDER

!define MUI_ABORTWARNING


!insertmacro MUI_PAGE_WELCOME

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
  File /r "wargus\*.*"
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
  Delete "$SMPROGRAMS\$MUI_TEMP\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$MUI_TEMP"

  DeleteRegKey /ifempty HKCU "Software\${NAME}"
SectionEnd

