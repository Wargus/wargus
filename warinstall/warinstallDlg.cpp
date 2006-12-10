// warinstallDlg.cpp : implementation file
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

static CString FindCDRomDrive(void)
{
	TCHAR buf[512];
	PTCHAR name;

	if (GetLogicalDriveStrings(sizeof(buf), buf) <= sizeof(buf)) {
		name = buf;
		while (*name) {
			if (GetDriveType(name) == DRIVE_CDROM) {
				return CString(name);
			}
			name += _tcslen(name) + 1;
		}
	}
	return CString("C:\\");
}

/////////////////////////////////////////////////////////////////////////////
// CWarinstallDlg dialog

CWarinstallDlg::CWarinstallDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CWarinstallDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWarinstallDlg)
	m_folder = FindCDRomDrive();
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CWarinstallDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWarinstallDlg)
	DDX_Text(pDX, IDC_FOLDER, m_folder);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CWarinstallDlg, CDialog)
	//{{AFX_MSG_MAP(CWarinstallDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BROWSE, OnBrowse)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CWarinstallDlg message handlers

BOOL CWarinstallDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CWarinstallDlg::OnPaint() 
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
HCURSOR CWarinstallDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

CString startFolder;

int CALLBACK BrowseCallbackProc(HWND hwnd, UINT uMsg, LPARAM lParam, LPARAM lpData)
{
	TCHAR szDir[MAX_PATH];

	if (uMsg == BFFM_INITIALIZED) {
		_tcscpy(szDir, startFolder.GetBuffer(startFolder.GetLength()));
		SendMessage(hwnd, BFFM_SETSELECTION, TRUE, (LPARAM)szDir);
	}
	return 0;
}

void CWarinstallDlg::OnBrowse() 
{
	BROWSEINFO bi;
	LPITEMIDLIST id;
	TCHAR path[MAX_PATH];

	startFolder = this->m_folder;

	memset(&bi, 0, sizeof(bi));
	bi.pszDisplayName = path;
	bi.hwndOwner = this->m_hWnd;
	bi.lpszTitle = _T("Browse for Warcraft 2 folder");
	bi.ulFlags = BIF_RETURNONLYFSDIRS;
	bi.lpfn = BrowseCallbackProc;
	id = SHBrowseForFolder(&bi);
	if (id) {
		if (SHGetPathFromIDList(id, path)) {
			m_folder.Format(_T("%s"), path);
			UpdateData(FALSE);
		}
	}
}

void CWarinstallDlg::OnOK() 
{
	char path[MAX_PATH];
	FILE *fd;

	sprintf(path, "%s\\%s", this->m_folder, "data\\rezdat.war");
	fd = fopen(path, "r");
	if (fd) {
		fclose(fd);
		CDialog::OnCancel();
		CWarinstall2Dlg dlg2;
		dlg2.m_folder = this->m_folder;
		theApp.m_pMainWnd = &dlg2;
		if (dlg2.DoModal() == IDOK) {
		} 
	} else {
		TCHAR caption[512];
		this->GetWindowText(caption, sizeof(caption));
		MessageBox(_T("Could not find Warcraft 2 in this folder"), caption, MB_OK);
	}
}
