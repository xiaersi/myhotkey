/*
������Ļ����������ʵ�֣� 
1�����Էǿ��У����������̶����жϣ���ʱ��ÿ���루ͨ�������ļ����ã���������ʱ����������201007181950.jpg�����浽ָ���ļ��С� 
2�����Կ���һ���ӣ�ͨ�������ļ��豸�����Զ������ļ����������ļ���FTP�������ķ�ʽ�ϴ���ָ��FTP��������ָ��Ŀ¼��Ŀ¼��Ϊ����IP��ַ���� 

*/

#Persistent


#include ..\..\
#include .\inc\inifile.aik
#include .\inc\capture.aik
#include .\inc\ftp.aik

g_inifile = ��Ļ���.ini		;; �����ļ�
ifnotexist %g_inifile%
{
	write_ini(g_inifile, "setting", "CaptureTime", "5000") 	; �������ʱ��
	write_ini(g_inifile, "setting", "FTPTime", "60000")		; �ϴ����ʱ��
	write_ini(g_inifile, "setting", "PicDir", a_scriptdir)	; ��ʱ��Ž���ͼ���Ŀ¼
	write_ini(g_inifile, "setting", "DelAfterFTP", "0")		; ָ�����ϴ�֮���ͼ��ɾ��(���ƶ�������Ŀ¼)
	write_ini(g_inifile, "FTP", "server", "")				; FTP������
	write_ini(g_inifile, "FTP", "port", "21")				; �˿�
	write_ini(g_inifile, "FTP", "name", "")					; �û��� ( ����û���������Ϊ��, ���ᵯ����¼���� )
	write_ini(g_inifile, "FTP", "password", "")				; ����
	write_ini(g_inifile, "FTP", "remotePath", "")			; Զ��Ŀ¼
	msgbox �������������ļ�,�����б�����!
	run %g_inifile%
	exitapp
}

; ���������ͼ���ļ���
IfNotExist, PrintScreen
{
	FileCreateDir, PrintScreen
}
   
; ����FTPĿ��
IfNotExist, FTP
{
	FileCreateDir, FTP
}

; ������������FTP����Ŀ¼, ��FTPd����־���ϴ���ϵ�ͼƬ�ƶ�����Ŀ¼
g_ftpLog = FTP\%a_yyyy%-%a_mm%-%a_dd%
IfNotExist, %g_ftpLog%
{
	FileCreateDir, %g_ftpLog%
}
   
; �������ļ��ж�ȡ����
g_captureTime 	:= read_ini(g_inifile, "setting", "CaptureTime", "5000")
g_ftpTime 		:= read_ini(g_inifile, "setting", "FTPTime", "60000")
g_bDelAfterFTP 	:= read_ini(g_inifile, "setting", "DelAfterFTP", "0")
g_Server 		:= read_ini(g_inifile, "FTP", "server", "")
g_Port			:= read_ini(g_inifile, "FTP", "port", "21")
g_remotePath 	:= read_ini(g_inifile, "FTP", "remotePath", "")
uName 			:= read_ini(g_inifile, "FTP", "name", "")
pWord 			:= read_ini(g_inifile, "FTP", "password", "")

;; ���������˺���һ��Ϊ��,��ô�����Ի���Ҫ�������˺ź�����
;  ����ᵯ�����������, ��ʵ����Ŀ��, ���д����½��, ���û����õ�����
if ( uName == "" || pWord == "" )
{
	InputBox, uName, Please input your username, Please input your username
	if(ErrorLevel) ; �û����ȡ�����˳�
	{
	   ExitApp
	}
	InputBox, pWord, Please input your password, Please input your password, HIDE
	if(ErrorLevel) ; �û����ȡ�����˳�����
	{
	   ExitApp
	}
}

; ��ʵ����Ҫ���һ�����������Ƿ���ȷ, ���ֻ����ʾ����, �ʶ������������ö���ȷ.

; ���ö�ʱ��
SetTimer ����ʱ������, %g_captureTime%
SetTimer ����ʱ�ϴ�FTP��, %g_ftpTime%

; ��ʱ�����Ķ�ʱ��, ÿ��һ��ʱ��(���/���̿���ʱ), ����һ��, ���浽PrintScreenĿ¼
����ʱ������:
	if ( A_TimeIdlePhysical <= g_captureTime )
	{
		capfile = PrintScreen\%a_yyyy%%a_mm%%a_dd%%A_Hour%%A_Min%%A_Sec%.jpg
		CaptureScreen(0, False, capfile, 100)		; ��ͼ����
	}
	return
	
; ��ʱ��������ͼ���ϴ���FTP������
����ʱ�ϴ�FTP��:
	if ( A_TimeIdlePhysical > g_ftpTime )
	{
		FileList =
		Loop, PrintScreen\*.jpg
		    FileList = %FileList%%A_LoopFileName%`n
		Sort, FileList  ; Sort by date.
		Loop, parse, FileList, `n
		{
		    if A_LoopField =  ; ��Ч���ļ���������
		        continue
		        
		    ; �ϴ�һ��ͼ��
		    file_to_upload = PrintScreen\%A_LoopField%
			hConnect:=FTP_Open( g_Server, g_Port, Username, Password )
			FTP_PutFile( hConnect, file_to_upload, g_remotePath )
			FTP_CloseSocket( hConnect )
			FTP_Close( )
			
			; ɾ�����ƶ��Ѿ��ϴ���ͼ���ļ�
			if g_bDelAfterFTP = 1
		    	FileDelete %file_to_upload%
		    else 
		    	FileMove, %file_to_upload%, %g_ftpLog%\%A_LoopField% , 1
		}	
	}
	return
