#include ..\..\


;; ���Ӱ�����LWin������ʾ��ʼ�˵������ΰ�һ��LWIN�͵�����ʼ�˵�
LWin::
	If is_same_key()
	{
		send ^{esc}
	}
	return
	
	
;; ���Ӱ�����Ctrl�������ҵ����д��ڡ�
Ctrl::
	If is_same_key()
	{
		ifwinexist �ҵ����д��� ahk_class AutoHotkeyGUI
		{
			winclose
		}
		else
		{
			WriteTempIni("run", "googleType", "1")
			var_run := �ƻ�ȡ��Ŀ¼()
			var_run = %var_run%\bin\run\run3.ahk
			run_ahk( var_run )			
			var_run =
		}
	}
	return

;;------ ��Alt+�ո� ����"����"���� ----------------------------------
	

:://file:: 
	var_root := �ƻ�ȡ��Ŀ¼()
	var_file = %var_root%\bin\Doxgen\�����ļ�ע��.ahk
	run_ahk(var_file )
	return

:://brief::
	sendinput /** @brief  */{left 2}
	return

:://w::             ;; ���һ��ע��
	SelectLine()
:://line::
	WriteTempIni( "�����ע��", "type", "cpp" )
	var_root := �ƻ�ȡ��Ŀ¼()
	var_file = %var_root%\bin\Doxgen\�����ע��.ahk
	run_ahk(var_file )
	return

::;;w::
	SelectLine() 
::;;line::
	WriteTempIni( "�����ע��", "type", "ahk" )
	var_root := �ƻ�ȡ��Ŀ¼()
	var_file = %var_root%\bin\Doxgen\�����ע��.ahk
	run_ahk(var_file )
	return

:://e::         	;; �������ڵ�����ĩ��ע�ͷ���λ��
	sleep 100
	write_ini( "temp.ini", "���Ʋ���ÿ��ĩβ����������βע�ͷ�", "lastComment", "//" )
	var_root := �ƻ�ȡ��Ŀ¼()
	send {shift down}{home}{shift up}
	var_file = %var_root%\bin\Doxgen\���Ʋ���ÿ��ĩβ����������βע�ͺ�.ahk
	run_ahk( var_file )
	return

::;;e::         	;; �������ڵ�����ĩ��ע�ͷ���λ��
	sleep 100
	write_ini( "temp.ini", "���Ʋ���ÿ��ĩβ����������βע�ͷ�", "lastComment", ";;" )
	var_root := �ƻ�ȡ��Ŀ¼()
	send {shift down}{home}{shift up}
	var_file = %var_root%\bin\Doxgen\���Ʋ���ÿ��ĩβ����������βע�ͺ�.ahk
	run_ahk( var_file )
	return

