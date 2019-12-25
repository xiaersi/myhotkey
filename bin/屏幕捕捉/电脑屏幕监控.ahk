/*
电脑屏幕监控软件功能实现： 
1、电脑非空闲（根据鼠标键盘动作判断？）时，每五秒（通过配置文件设置）截屏并按时间命名（如201007181950.jpg）保存到指定文件夹。 
2、电脑空闲一分钟（通过配置文件设备）后，自动将该文件夹内所有文件用FTP以续传的方式上传到指定FTP服务器的指定目录（目录名为本机IP地址）。 

*/

#Persistent


#include ..\..\
#include .\inc\inifile.aik
#include .\inc\capture.aik
#include .\inc\ftp.aik

g_inifile = 屏幕监控.ini		;; 配置文件
ifnotexist %g_inifile%
{
	write_ini(g_inifile, "setting", "CaptureTime", "5000") 	; 截屏间隔时间
	write_ini(g_inifile, "setting", "FTPTime", "60000")		; 上传间隔时间
	write_ini(g_inifile, "setting", "PicDir", a_scriptdir)	; 临时存放截屏图像的目录
	write_ini(g_inifile, "setting", "DelAfterFTP", "0")		; 指定将上传之后的图像删除(或移动到其他目录)
	write_ini(g_inifile, "FTP", "server", "")				; FTP服务器
	write_ini(g_inifile, "FTP", "port", "21")				; 端口
	write_ini(g_inifile, "FTP", "name", "")					; 用户名 ( 如果用户名和密码为空, 将会弹出登录窗口 )
	write_ini(g_inifile, "FTP", "password", "")				; 密码
	write_ini(g_inifile, "FTP", "remotePath", "")			; 远程目录
	msgbox 请先设置配置文件,再运行本程序!
	run %g_inifile%
	exitapp
}

; 创建保存截图的文件夹
IfNotExist, PrintScreen
{
	FileCreateDir, PrintScreen
}
   
; 创建FTP目标
IfNotExist, FTP
{
	FileCreateDir, FTP
}

; 按日期命名的FTP的子目录, 将FTPd的日志和上传完毕的图片移动到此目录
g_ftpLog = FTP\%a_yyyy%-%a_mm%-%a_dd%
IfNotExist, %g_ftpLog%
{
	FileCreateDir, %g_ftpLog%
}
   
; 从配置文件中读取配置
g_captureTime 	:= read_ini(g_inifile, "setting", "CaptureTime", "5000")
g_ftpTime 		:= read_ini(g_inifile, "setting", "FTPTime", "60000")
g_bDelAfterFTP 	:= read_ini(g_inifile, "setting", "DelAfterFTP", "0")
g_Server 		:= read_ini(g_inifile, "FTP", "server", "")
g_Port			:= read_ini(g_inifile, "FTP", "port", "21")
g_remotePath 	:= read_ini(g_inifile, "FTP", "remotePath", "")
uName 			:= read_ini(g_inifile, "FTP", "name", "")
pWord 			:= read_ini(g_inifile, "FTP", "password", "")

;; 如果密码或账号有一项为空,那么弹出对话框要求输入账号和密码
;  这里会弹出两次输入框, 在实际项目中, 最好写个登陆框, 给用户更好的体验
if ( uName == "" || pWord == "" )
{
	InputBox, uName, Please input your username, Please input your username
	if(ErrorLevel) ; 用户点击取消则退出
	{
	   ExitApp
	}
	InputBox, pWord, Please input your password, Please input your password, HIDE
	if(ErrorLevel) ; 用户点击取消则退出程序
	{
	   ExitApp
	}
}

; 其实还需要检查一下其他配置是否正确, 这个只是演示程序, 故而假设其他配置都正确.

; 设置定时器
SetTimer 【定时截屏】, %g_captureTime%
SetTimer 【定时上传FTP】, %g_ftpTime%

; 定时截屏的定时器, 每隔一段时间(鼠标/键盘空闲时), 截屏一次, 保存到PrintScreen目录
【定时截屏】:
	if ( A_TimeIdlePhysical <= g_captureTime )
	{
		capfile = PrintScreen\%a_yyyy%%a_mm%%a_dd%%A_Hour%%A_Min%%A_Sec%.jpg
		CaptureScreen(0, False, capfile, 100)		; 截图函数
	}
	return
	
; 定时将截屏的图像上传到FTP服务器
【定时上传FTP】:
	if ( A_TimeIdlePhysical > g_ftpTime )
	{
		FileList =
		Loop, PrintScreen\*.jpg
		    FileList = %FileList%%A_LoopFileName%`n
		Sort, FileList  ; Sort by date.
		Loop, parse, FileList, `n
		{
		    if A_LoopField =  ; 无效的文件名则跳过
		        continue
		        
		    ; 上传一张图像
		    file_to_upload = PrintScreen\%A_LoopField%
			hConnect:=FTP_Open( g_Server, g_Port, Username, Password )
			FTP_PutFile( hConnect, file_to_upload, g_remotePath )
			FTP_CloseSocket( hConnect )
			FTP_Close( )
			
			; 删除或移动已经上传的图像文件
			if g_bDelAfterFTP = 1
		    	FileDelete %file_to_upload%
		    else 
		    	FileMove, %file_to_upload%, %g_ftpLog%\%A_LoopField% , 1
		}	
	}
	return
