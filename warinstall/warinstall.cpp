// warinstall.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "warinstall.h"
#include "warinstallDlg.h"
#include "warinstall2Dlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CWarinstallApp

BEGIN_MESSAGE_MAP(CWarinstallApp, CWinApp)
	//{{AFX_MSG_MAP(CWarinstallApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CWarinstallApp construction

CWarinstallApp::CWarinstallApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CWarinstallApp object

CWarinstallApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CWarinstallApp initialization

BOOL CWarinstallApp::InitInstance()
{
	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	CWarinstallDlg dlg;
	m_pMainWnd = &dlg;
	dlg.DoModal();

	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}
