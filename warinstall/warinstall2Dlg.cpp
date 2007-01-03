// Warinstall2Dlg.cpp : implementation file
//

#include "stdafx.h"
#include "warinstall.h"
#include "Warinstall2Dlg.h"

#include <assert.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

CWarinstall2Dlg *dlg;
CMutex mutex;

/////////////////////////////////////////////////////////////////////////////
// CWarinstall2Dlg dialog


CWarinstall2Dlg::CWarinstall2Dlg(CWnd* pParent /*=NULL*/)
	: CDialog(CWarinstall2Dlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWarinstall2Dlg)
	m_progress = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_lines = 0;
	m_done = 0;
}

void CWarinstall2Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWarinstall2Dlg)
	DDX_Control(pDX, IDCANCEL, m_button);
	DDX_Control(pDX, IDC_PROGRESS, m_progressctl);
	DDX_Text(pDX, IDC_PROGRESS, m_progress);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CWarinstall2Dlg, CDialog)
	//{{AFX_MSG_MAP(CWarinstall2Dlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_MESSAGE(UWM_ADDPROGRESS, OnAddProgress)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CWarinstall2Dlg message handlers

UINT MyControllingFunction(LPVOID pParam);

BOOL CWarinstall2Dlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	dlg = this;
	AfxBeginThread(MyControllingFunction, this);
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CWarinstall2Dlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CWarinstall2Dlg::OnQueryDragIcon()
{
	return (HCURSOR)m_hIcon;
}

LRESULT CWarinstall2Dlg::OnAddProgress(WPARAM wParam, LPARAM lParam)
{
	if (this->m_done) {
		this->m_button.SetWindowText(_T("Close"));
	}

	CSingleLock sLock(&mutex);
	sLock.Lock();
	UpdateData(FALSE);
	this->m_progressctl.LineScroll(this->m_lines);
	sLock.Unlock();
	return 0;
}

void CWarinstall2Dlg::AddProgress(LPTSTR msg)
{
	if (!msg) {
		this->m_done = 1;
		this->PostMessage(UWM_ADDPROGRESS);
		return;
	}

	CSingleLock sLock(&mutex);
	sLock.Lock();
	if (!this->m_progress.IsEmpty()) {
		this->m_progress += "\r\n";
	}
	this->m_progress += CString(msg);
	this->m_lines++;
	sLock.Unlock();
	this->PostMessage(UWM_ADDPROGRESS);
}

void MakeDir(LPCTSTR path)
{
	SECURITY_ATTRIBUTES sa;
	TCHAR buf[MAX_PATH + 60];

	_stprintf(buf, _T("Creating directory: %s"), path);
	dlg->AddProgress(buf);

	memset(&sa, 0, sizeof(sa));
	CreateDirectory(path, &sa);
}

void Copy(LPTSTR src, LPTSTR dst)
{
	TCHAR buf[4096];

	_stprintf(buf, _T("Copying: %s"), src);
	dlg->AddProgress(buf);

	CopyFile(src, dst, FALSE);
}

void CopyFiles(LPTSTR src, LPTSTR dst)
{
	WIN32_FIND_DATA ffd;
	HANDLE hnd;
	TCHAR srcbuf[MAX_PATH];
	TCHAR dstbuf[MAX_PATH];
	TCHAR dir[MAX_PATH];
	PTCHAR p;

	_tcscpy(dir, src);
	p = dir + _tcslen(dir) - 1;
	while (*p != '\\' && p >= dir) {
		p = CharPrev(dir, p);
	}
	if (*p == '\\') {
		*p = '\0';
	}

	hnd = FindFirstFile(src, &ffd);
	if (hnd == INVALID_HANDLE_VALUE) {
		return;
	}
	do {
		if (!(ffd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)) {
			_stprintf(srcbuf, _T("%s\\%s"), dir, ffd.cFileName);
			_stprintf(dstbuf, _T("%s\\%s"), dst, ffd.cFileName);
			Copy(srcbuf, dstbuf);
		}
	} while (FindNextFile(hnd, &ffd));
	FindClose(hnd);
}

int myprintf(LPCTSTR fmt, ...)
{
	TCHAR buf[4096];
	PTCHAR p;
	va_list va;

	va_start(va, fmt);
	_vsntprintf(buf, sizeof(buf), fmt, va);
	va_end(va);

	p = buf + _tcslen(buf) - 1;
	*p = '\0';
	dlg->AddProgress(buf);

	return 0;
}

void myexit(int err)
{
	MessageBox(theApp.GetMainWnd()->m_hWnd,
		_T("An error was encountered while extracting the data.  Click OK to exit."),
		_T("Error"),
		MB_OK | MB_ICONERROR);
	exit(err);
}


#define printf myprintf
#define exit myexit
#ifndef _DEBUG
#define _DEBUG
#define DEFINED_DEBUG
#endif
#include "../pudconvert.c"
#include "../wartool.c"
#undef printf
#undef exit
#ifdef DEFINED_DEBUG
#undef _DEBUG
#endif

UINT MyControllingFunction(LPVOID pParam)
{
	TCHAR *argv[] = {_T("warinstall"), NULL, NULL};
//	TCHAR buf[MAX_PATH];

	MakeDir(_T("data"));

	// Wartool
	dlg->m_folder += "\\data";
	argv[1] = _tcsdup(dlg->m_folder.GetBuffer(dlg->m_folder.GetLength()));
	main(2, argv);
	free(argv[1]);

	Copy(_T("contrib\\cross.png"), _T("data\\graphics\\ui\\cursors\\cross.png"));
	Copy(_T("contrib\\red_cross.png"), _T("data\\graphics\\missiles\\red_cross.png"));
	Copy(_T("contrib\\mana.png"), _T("data\\graphics\\ui\\mana.png"));
	Copy(_T("contrib\\mana2.png"), _T("data\\graphics\\ui\\mana2.png"));
	Copy(_T("contrib\\health.png"), _T("data\\graphics\\ui\\health.png"));
	Copy(_T("contrib\\health2.png"), _T("data\\graphics\\ui\\health2.png"));
	Copy(_T("contrib\\food.png"), _T("data\\graphics\\ui\\food.png"));
	Copy(_T("contrib\\score.png"), _T("data\\graphics\\ui\\score.png"));
	Copy(_T("contrib\\ore,stone,coal.png"), _T("data\\graphics\\ui\\ore,stone,coal.png"));
	Copy(_T("contrib\\stratagus.png"), _T("data\\graphics\\ui\\stratagus.png"));

	MakeDir(_T("data\\music"));
	Copy(_T("contrib\\toccata.mod.gz"), _T("data\\music\\default.mod.gz"));

//	MakeDir(_T("data\\maps\\other"));
//	sprintf(buf, "maps\\multi\\*", dlg->m_folder);
//	CopyFiles(buf, _T("data\\maps\\other"));

	Copy(_T("data\\maps\\multi\\(2)mysterious-dragon-isle.smp.gz"),
		_T("data\\maps\\default.smp.gz"));
	Copy(_T("data\\maps\\multi\\(2)mysterious-dragon-isle.sms.gz"),
		_T("data\\maps\\default.sms.gz"));

	MakeDir(_T("data\\scripts"));
	MakeDir(_T("data\\scripts\\ai"));
	MakeDir(_T("data\\scripts\\human"));
	MakeDir(_T("data\\scripts\\orc"));
	MakeDir(_T("data\\scripts\\tilesets"));
	CopyFiles(_T("scripts\\*.lua"), _T("data\\scripts"));
	CopyFiles(_T("scripts\\ai\\*.lua"), _T("data\\scripts\\ai"));
	CopyFiles(_T("scripts\\human\\*.lua"), _T("data\\scripts\\human"));
	CopyFiles(_T("scripts\\orc\\*.lua"), _T("data\\scripts\\orc"));
	CopyFiles(_T("scripts\\tilesets\\*.lua"), _T("data\\scripts\\tilesets"));

	dlg->AddProgress(_T("Done."));
	dlg->AddProgress(NULL);

	return 0;
}

