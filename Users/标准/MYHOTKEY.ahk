
#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������

#include ..\..\
#include .\lib\AutoHotString.aik


;; ����������Ŀ�ݷ�ʽ��ϵͳWindowsĿ¼�£�ʹ����WIN+R���������д����п�������ahk����������
ifnotexist %a_windir%\ahk.lnk
{
	msgbox 4, ������ݷ�ʽ, ��WindowĿ¼�´���������Ŀ�ݷ�ʽ��?
	ifmsgbox, YES
	{
		FileCreateShortcut , %a_ScriptFullPath%, %a_windir%\ahk.lnk, %a_scriptdir%
	}
}


;; ����������ͼ����Ҽ��˵�TrayMenu
gosub �����ԭ�е�TrayMenu��
gosub �����Ĭ�ϵ�TrayMenu�˵��
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\SubUI\21��Ļ���崰��.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\lib\insert.aik
#include .\lib\appkey.aik
#include .\lib\AutoLable.aik

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#include .\AWin\IE\IE.ahk
#include .\AWin\Explore\Explore.aik
#include .\AWin\vim.aik


#include .\SubUI\TrayMenu.aik
#include .\SubUI\22InputListBox.aik
#include .\SubUI\23�༭�������.aik
#include .\SubUI\24��ӻ�����������б�.aik
#include .\SubUI\25�޸ĵ�ǰ��������.aik


:?:;c::	; �л���QQ���
	switchime("QQ���")
	return


:?:;e::	; �� Alt+shift+0 �л���Ӣ��
	switchime("���� (����) - ��ʽ����")
	return	


^+c::
	clipboard =
	send ^c
	sleep 100
	var_temp := clipboard
	clipboard := var_temp
	return

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



