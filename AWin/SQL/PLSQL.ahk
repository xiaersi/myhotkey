;;#include OracleLogin.aik
#include ..\..\lib\MButton.aik


g_user =  ;; 用户登录数据库的名称
g_days = ;; 默认导出几天内的数据
g_ext =  ;; 导出文件的默认扩展名
iniread g_user, PLSQL.ini, . , login
iniread g_days, PLSQL.ini, . , days

if g_user =
{
	inputbox g_user, 登陆账号, 请指定登录账号，可以不指定
	iniwrite g_user, PLSQL.ini, . , login
}

if g_days =
{
	g_days := myinput( "指定导出最近几日数据", "请指定导出最近几日数据：" , "100" )
	iniwrite g_days, PLSQL.ini, . , days
}
;;---Include基础函数---------------------------------------------------------
#include ..\..\
#include .\inc\common.aik
#include .\inc\inifile.aik
#include .\inc\string.aik
#include .\awin\sql\plsql.aik

;;---设置变量----------------------------------------------------------------
::setday;::
	g_days := myinput("设置默认天数", "指定要导入的默认天数：", g_days )
	iniwrite g_days, PLSQL.ini, . , days
	return
	
::setext;::
	g_ext := myinput("设置导出扩展名", "请设置导出文件的默认扩展名：", "pde" )
	return
	
	
;;---控制窗口----------------------------------------------------------------
<#Numpad0::
	WinSet, Transparent, off, A
	return
<#Numpad4::
	WinSet, Transparent, 60, A
	return
<#Numpad3::
	WinSet, Transparent, 110, A
	return

<#Numpad2::
	WinSet, Transparent, 160, A
	return
<#Numpad1::
	WinSet, Transparent, 210, A
	return
	
#Lbutton::
	click
	sleep 100
	winset, AlwaysOnTop,,A
	return	