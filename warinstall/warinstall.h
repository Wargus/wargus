// warinstall.h : main header file for the WARINSTALL application
//

#if !defined(AFX_WARINSTALL_H__493CD6B6_6038_4044_A9B8_AF4D275FD04D__INCLUDED_)
#define AFX_WARINSTALL_H__493CD6B6_6038_4044_A9B8_AF4D275FD04D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CWarinstallApp:
// See warinstall.cpp for the implementation of this class
//

class CWarinstallApp : public CWinApp
{
public:
	CWarinstallApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWarinstallApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CWarinstallApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

extern CWarinstallApp theApp;

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_WARINSTALL_H__493CD6B6_6038_4044_A9B8_AF4D275FD04D__INCLUDED_)
