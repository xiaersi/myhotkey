;;#include OracleLogin.aik
#include ..\..\lib\MButton.aik


g_user =  ;; �û���¼���ݿ������
g_days = ;; Ĭ�ϵ��������ڵ�����
g_ext =  ;; �����ļ���Ĭ����չ��
iniread g_user, PLSQL.ini, . , login
iniread g_days, PLSQL.ini, . , days

if g_user =
{
	inputbox g_user, ��½�˺�, ��ָ����¼�˺ţ����Բ�ָ��
	iniwrite g_user, PLSQL.ini, . , login
}

if g_days =
{
	g_days := myinput( "ָ�����������������", "��ָ����������������ݣ�" , "100" )
	iniwrite g_days, PLSQL.ini, . , days
}
;;---Include��������---------------------------------------------------------
#include ..\..\
#include .\inc\common.aik
#include .\inc\inifile.aik
#include .\inc\string.aik
#include .\awin\sql\plsql.aik

;;---���ñ���----------------------------------------------------------------
::setday;::
	g_days := myinput("����Ĭ������", "ָ��Ҫ�����Ĭ��������", g_days )
	iniwrite g_days, PLSQL.ini, . , days
	return
	
::setext;::
	g_ext := myinput("���õ�����չ��", "�����õ����ļ���Ĭ����չ����", "pde" )
	return
	
	
;;---���ƴ���----------------------------------------------------------------
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