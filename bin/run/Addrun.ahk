;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��ӿ����еĳ��������ļ�, ʹ�ÿ���ʹ�����д���������
change_icon()                           ;; ����ͼ��

#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������

g_Param = %1%

; msgbox param1 = %g_Param%

;; ���û�д����������ԴӼ������л�ȡ
if g_Param =
{
	Sleep 100
	g_Param := clipboard
}



g_inifile = launchy.ini
g_title = ���������������ļ�
g_wintitle = %g_title% ahk_class AutoHotkeyGUI
g_ForbinChar = `;,`#,=,`%,`&
g_ForbinCharTip = `n `; `# = `% `& `@

EDITWIDTH = 320

_Hotkey =
_HotString =
_WorkPath =
_RadioFile =
_RadioSend =
_radioVar =

;; ��ƽ���

Gui, +AlwaysOnTop
Gui, Add, Text
Gui, Add, Text, , ����:
Gui, Add, Text, , ִ������:
Gui, Add, Text, , ����Ŀ¼:

Gui, Add, Text, ym
Gui, Add, Edit, w%EDITWIDTH% v_Hotkey  g������༭��
Gui, Add, Edit, w%EDITWIDTH% v_Hotstring, %g_Param%
Gui, Add, Edit, w%EDITWIDTH% Disabled v_WorkPath

Gui, Add, Text, ym
Gui, Add, Radio, y+10 v_RadioFile checked g��ClickRadioFile��, Run file     ;; button1
Gui, Add, Radio, y+15 v_RadioSend g��ClickRadioSend��, �������           ;; button2
Gui, Add, Radio, y+12 v_radioVar g���������������, ����::����            ;; button3

Gui, Add, Button, x135 y120 w100 h30 default g��ȷ�������û���������, ȷ��
Gui, Add, Button, x285 y120 w100 h30 g��ȡ�������û���������, ȡ��

Gui, Add, Checkbox, x15 y120 w100 h30  v_bSaveWorkPath g������·����ѡ��, ���湤��·��
Gui, Show, h170, %g_title%

;;---�жϼ��������Ƿ��������, �б���$var$����"����::����"�ĵ�ѡ��---------
if g_Param <>
{
	if IsCmdString( g_Param )
		ControlClick Button2, %g_wintitle%
	else IfInString g_Param, $var$
		ControlClick Button3, %g_wintitle%
	else
	{
		ControlClick Button1, %g_wintitle%
	}
}
ControlFocus , Edit1, %g_wintitle%
RETURN

GuiDropFiles:
	Loop, parse, A_GuiEvent, `n
	{
		if A_LoopField=
			continue

		guicontrol, , _Hotstring, %A_LoopField%
		break
	}
	Return


������༭��:
	Gui, Submit, nohide
	if ( CheckKeyName( _Hotkey ) == "ERROR_CHAR" )
	{
		Send {backspace}
	}
	RETURN


������·����ѡ��:
	Gui, Submit, nohide
	if _bSaveWorkPath
		GuiControl, Enable, Edit3
	else
		GuiControl, Disable, Edit3
	RETURN

��ClickRadioSend��:
���������������:
	ControlSetText  Edit3, ,  %g_wintitle%
	Control UnCheck, , button6, %g_wintitle% 	;; ȡ��ѡ�񱣴湤��·����ѡ��
	GuiControl, Disable, Edit3
	RETURN

��ClickRadioFile��:

	ControlGetText var_temp, Edit2,  %g_wintitle%
	SplitPath, var_temp , , OutDir
	StringReplace, OutDir, OutDir, `", , All

	var_ext := get_file_ext( var_temp)

	;; ������ļ��У���ȡ��������·�����ĸ�ѡ��
	if var_ext = $Web$
	{
		OutDir =	;; ��ַ������·��
	}

	;; ������е��ļ���Ŀ¼���и�·��ʱ����ѡ������·������ѡ��
	if OutDir <>
	{
		if var_ext <> $dir$
		{
			Control Check, , button6, %g_wintitle% 		;; ѡ�񱣴湤��·����ѡ��
			GuiControl, Enable, Edit3
		}
		ControlSetText  Edit3, %OutDir%,  %g_wintitle% ahk_class AutoHotkeyGUI
	}
	else  ;; ·��Ϊ��ʱ�� ����ѡ������·������ѡ��
	{
		Control UnCheck, , button6, %g_wintitle% 	;; ѡ�񱣴湤��·����ѡ��
		GuiControl, Disable, Edit3
	}
	RETURN

��ȷ�������û���������:
	Gui, Submit, nohide
	if  ( CheckKeyName( _Hotkey ) != "OK" )
	{
		MsgBox �����а����Ƿ��ַ���
		RETURN
	}
	;; ����������Ͳ��Ƿ����������[ִ������]�༭�����зָ���
	if not _radiosend
	{
		IfInString _Hotstring, |
		{
			MsgBox [ִ������]�༭�����зָ���`" | `"
			RETURN
		}
	}
	if _bSaveWorkPath
	{
		IfInString _WorkPath, |
		{
			MsgBox [����Ŀ¼]�༭�����зָ���`" | `"
			RETURN
		}
	}
	;; ׼����Section
	if _radiosend = 1
		var_sec = cmd
	else if _radioVar = 1
		var_sec = variable
	else
		var_sec = file

	if ( _Hotkey != "" && _Hotstring != ""  )
	{
		iniread,var_read,%g_inifile%,%var_sec%,%_HotKey%
		if not (var_read="" or var_read="ERROR")
		{
			MsgBox, 4,, %g_inifile%�ļ���%var_sec%���У�`n%_HotKey%�Ѿ����ڣ�Ҫ�滻�� ��`n%_HotKey%��%var_read%`n���滻Ϊ`n%_HotKey%��%_Hotstring%
			IfMsgBox No
			{
				EXITAPP
				RETURN
			}
		}
		var_value := _Hotstring

		;; ����Ǳ����ļ�����������չ���͹���·��, ������ͼ��
		if  var_sec = file
		{
			var_ext := get_file_ext( _Hotstring )
			var_value = %var_value%|%var_ext%
			if var_ext <>
			{
				if var_ext not in $Dir$,$NoExt$,$Web$
				{
					if ( _bSaveWorkPath && get_first_char( _HotKey, var_char) > 0 && var_char != "\" && var_char != "/" )
					{
						var_value = %var_value%|%_WorkPath%
					}
					;; ����ͼ��
					if var_ext not in exe,com,dll,ico,cur,cpl,scr,bmp,jpg,gif,png,tif,bak,tmp
					{

					}
				}
			}

		}
		write_ini( g_inifile, var_sec, _HotKey, var_value )
		EXITAPP
	}
	else
	{
		if _Hotstring =
			ToolTip ������Ҫִ�е�����
		else if _HotKey =
			ToolTip ����������
		Sleep 800
		ToolTip
	}
	RETURN

��ȡ�������û���������:
GuiClose:
	EXITAPP
	RETURN



#include ..\..\
#include .\inc\common.aik
#include .\inc\string.aik
#include .\inc\inifile.aik
#include .\inc\tip.aik
#include .\inc\cmdstring.aik

CheckKeyName( keyName )
{
	if keyName contains ``,~,!,`#,=,-,*,$,?,`%,`&,|, ,@,[,],`:,`',`",`,,`;
	{
		tooltip7("�����в��ܰ��������κ��ַ�֮һ��`n `` ~ `! @ `# $ `% `&  *  - = | . [ �� ] ? `' �� `, `: `;  ")
		RETURN "ERROR_CHAR"
	}
	if keyName in vim,calc,run
	{
		tooltip7("�������������⺬�壬������Ϊ�Զ������`n vim,calc,run")
		RETURN "ERROR_CMD"
	}
	RETURN "OK"
}


#IfWinActive ���������������ļ� ahk_class AutoHotkeyGUI

RAlt::
	Gui, Submit, nohide
	if _bSaveWorkPath
		Control UnCheck, , button6, %g_wintitle% 	;; ȡ��ѡ�񱣴湤��·����ѡ��
	else
		Control Check, , button6, %g_wintitle%
	RETURN
#IfWinActive


