#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������

g_username := read_ini("root.cfg", "users", "lastuser", "" )
change_icon()

ifnotexist Users
	FileCreateDir, Users

FileInstall, Users\AutoHotKey.ini, %A_ScriptDir%\Users\AutoHotKey.ini
FileInstall, Users\ShortcutMenu.ini, %A_ScriptDir%\Users\ShortcutMenu.ini

�����ù���Ŀ¼( g_username )

FileInstall, �����ȼ�.ico,%A_ScriptDir%\�����ȼ�.ico
FileInstall, Suspend.ico, %A_ScriptDir%\Suspend.ico



#include .\lib\AutoHotString.aik

;; ����������ͼ����Ҽ��˵�TrayMenu
gosub �����ԭ�е�TrayMenu��
gosub �����Ĭ�ϵ�TrayMenu�˵��

;; ���������������(Ҫ���õ�������������Ĵ����ִֹͣ��)
if g_GlobalSwitch_xHotString
{
	g_GlobalSwitch_xHotString := false
	�ƴ򿪷����������( )	
}		
return


#include .\SubUI\TrayMenu.aik

;#include .\lib\timer.aik
#include .\lib\common.aik
#include .\inc\inifile.aik
#include .\inc\string.aik
#include .\inc\path.aik
#include .\inc\cmdstring.aik
#include .\inc\mousemoveinfo.aik
#include .\inc\MouseGesture.aik
#include .\inc\XML\xhotstring.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\SubUI\21��Ļ���崰��.aik
#include .\SubUI\22InputListBox.aik
#include .\SubUI\23�༭�������.aik
#include .\SubUI\24��ӻ�����������б�.aik
#include .\SubUI\25�޸ĵ�ǰ��������.aik
#include .\SubUI\26Ϊ�������������Ӷ���.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\lib\insert.aik
#include .\lib\appkey.aik
#include .\lib\AutoLable.aik
#include .\lib\XHotString.aik

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#include .\AWin\IE\IE.ahk
#include .\AWin\Explore\Explore.aik
#include .\AWin\vim.aik
#include .\Awin\MyHotkey\PhiyonKeyboard.ahk


�����ù���Ŀ¼( _userName = "" )
{
	;; ���жϽű�������û��root.cfg��û���򴴽�֮, ���ļ��Ǹ�Ŀ¼�ı�־
	ifnotexist %a_scriptdir%\root.cfg
	{
		;; ���û��root.cfg��˵���ǵ�һ���˶�������
		var_prompt = ��һ�����з����ȼ�������ϸ�Ķ�����ע�����ȷ���Ƿ�Ҫ����ִ�з����ȼ���
		var_text =
(
������һ�����з����ȼ�ʱ���ῴ������ʾ���������Ķ������ע������:

�������ȼ�˵����
------------------------------------------------------------------------
��ǰ�汾 V1.04Alpha�ڲ�棬��Windows XP�ڿ�����
��Windows Vista��Window 7 ��Ҳ�����У�����δ������ֲ��ԡ�


��ע�����
------------------------------------------------------------------------
1�����ڿ�Դ
	�����ȼ�ʹ��AutoHotkey��д���ǿ�Դ��Ŀ�������ҪԴ��������������ϵ��
	��ӭ����Ȥ�����Ѽ���һͬ������

	Ϊ���ò��˽�AutoHotkey���߲�Ը�ⰲװAutoHotkey������Ҳ��ʹ�÷����ȼ���
	���ǽ������ȼ������EXE��ִ���ļ��������ܻ������������:

2������ĳЩɱ�������ľ�������
	AutoHotkey��ͨ������������Դ��ʽ���õ���������ʽ���б���ģ����ֱ��뷽ʽ
	���ܻᱻһЩ������ɱ������������ɽ��ȫ��ʿ��ֱ����Ϊ��ľ����360��ȫ��ʿ
	����Ҳ��ô�����������ȼ��Լ�AutoHotkey���ǿ�Դ��Ŀ��ÿһ�д��붼��¶����Ŀ
	֮�£����Բ�������������û���������顣

3����������ľ����Ϊ
	�����ȼ���һЩ������Ҫ��׽����Ҽ���������Ϣ�ȣ���Щ��Ϊ���ܻᱻһЩ��ȫ
	�������360��ȫ��ʿ������������ľ����Ϊ��������ͨ�������������׽һЩ��Ҫ
	����Ϣ���ܶ๦���޷�ʹ�ã������ȼ��Ͳз��ˡ�


���쳣����
------------------------------------------------------------------------
1�����ʹ�÷����ȼ��Ĺ����������쳣���밴Win+F5���������ȼ���

2����ĳЩϵͳ�У��������ܵ����������Ӱ�죩�����������ʹ���Ҽ�ʧЧ��
��ʱ��ͨ���������� ������������ ���û�������ָ��Ҽ��˵���


����һ����
------------------------------------------------------------------------
������Է����ȼ��������ǣ��밴��ȡ������ť�˳������ȼ���

��������η����ȼ��밴��ȷ������ť��Ȼ���ڵ����Ĵ����û��ĶԻ����������û�����
�����ȼ�����Users�ļ����£��������û������������ļ�����Ϊ����Ŀ¼��������
�˹���Ŀ¼�д�������Ĭ�ϵ������ļ���

���ףԸ��ʹ�÷����ȼ���죡
)		
		
		if not MsgTipBox( "�����ȼ�����", var_prompt, var_text )
		{
			ExitApp
		}
		fileappend 	#root.cfg  �����ȼ���Ŀ¼�ı�־�����ڸ�Ŀ¼�����д��ļ�,  %a_scriptdir%\root.cfg
	}

	;; �����������û����Ƿ���Ч����Ч�û����л�֮
	if _userName <>
	{
		ifexist Users\%_userName%\
		{
			change_user( _userName )		
			return
		}
	}
	;; �����������û�����Чʱ���������е��û��б�
	UserList =
	UserCount = 0
	LastUser =
	Loop, Users\*.*, 2
	{
		if A_LoopFileName <>
		{
			ifnotinstring A_LoopFileName, .
			{
				UserList = %UserList%%A_LoopFileName%|
				LastUser := A_LoopFileName
				UserCount++
			}
		}
	}
	;; ��ǰ��û���û���ѯ���û�����һ��
	if UserCount = 0
	{
		loop
		{
			LastUser := �ƴ����û�()
			if LastUser <>
			{
				change_user( LastUser )		
				reload   ;; �����û�֮�����������ȼ�����Ȼ����������Ч��
				break
			}
		}
	}
	else ;; �Ѿ����û������û�ѡ��һ���û���
	{
		loop 
		{
			LastUser := InputListBox( UserList )
			if LastUser <>
			{
				change_user( LastUser )	
				break
			}
			else
			{
				msgbox ��ѡ��һ���û���
			}
		}
	}
}





^+v::
	CreateMenuByIni( "�˵���չճ��", "A", "", false )
	menu �˵���չճ��, show
	/*
	var_oldclip := ClipBoardAll
	StringUpper, clipboard, clipboard
	sleep 100
	send ^v
	clipboard := var_oldclip
	*/
	return
