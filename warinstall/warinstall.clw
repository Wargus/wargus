; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CWarinstall2Dlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "warinstall.h"

ClassCount=3
Class1=CWarinstallApp
Class2=CWarinstallDlg

ResourceCount=3
Resource2=IDD_WARINSTALL_DIALOG
Resource1=IDR_MAINFRAME
Class3=CWarinstall2Dlg
Resource3=IDD_WARINSTALL_DIALOG2

[CLS:CWarinstallApp]
Type=0
HeaderFile=warinstall.h
ImplementationFile=warinstall.cpp
Filter=N

[CLS:CWarinstallDlg]
Type=0
HeaderFile=warinstallDlg.h
ImplementationFile=warinstallDlg.cpp
Filter=D
LastObject=IDC_FOLDER
BaseClass=CDialog
VirtualFilter=dWC



[DLG:IDD_WARINSTALL_DIALOG]
Type=1
Class=CWarinstallDlg
ControlCount=5
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_BROWSE,button,1342242816
Control4=IDC_STATIC,static,1342308353
Control5=IDC_FOLDER,edit,1350568064

[DLG:IDD_WARINSTALL_DIALOG2]
Type=1
Class=CWarinstall2Dlg
ControlCount=3
Control1=IDCANCEL,button,1342242816
Control2=IDC_PROGRESS,edit,1353779396
Control3=IDC_STATIC,static,1342308352

[CLS:CWarinstall2Dlg]
Type=0
HeaderFile=Warinstall2Dlg.h
ImplementationFile=Warinstall2Dlg.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=IDC_PROGRESS

