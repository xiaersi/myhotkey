;; ͨ�����������ļ� autohotstring.ini ������ȫ���ȼ�
#SingleInstance ignore 						;; ֻ����һ��ʵ������
change_icon()

#include ../../
g_title = ����ȫ���ȼ�
g_GlobalHotkey_Section = ȫ���ȼ�
g_inifile = autoHotString.ini
g_inimem := IniFileRead( g_inifile )
if g_inimem =
{
	MsgBox �����ļ� %g_inifile% �����ڣ�
	ExitApp
}

;; �ؼ���Ĭ��λ��
g_xCB := 26
g_xKN := 66
g_xHK := 376
g_xSK := 586
g_xBT := 690
g_xAD := 745
g_wCB := 15
g_wKN := 300
g_wHK := 200
g_wSK := 100
g_wBT := 50
g_wBT := 50

g_y0 := 60
g_dy := 30

g_pageline := 12

;; ��ȡTabList
g_CurSec =
g_SecNum := 0
g_tabList =
Loop parse, g_inimem, `n
{
	var_line := A_LoopField
	;; �����[�ֽ�]
	if ( RegExMatch( var_line, "^\[.+\]", var_match ) > 0 )
	{
		g_CurSec := RegExReplace(var_match,"[\[\]]","")

		;; add 2011.10.30�� ֻ����ȫ���ȼ�������̫���޷���ʾ
		if ( g_CurSec <> g_GlobalHotkey_Section )
			continue		

		g_SecNum := SecArrayFromIniMem( g_inimem, g_CurSec, "Arr" )
		var_tabNum := g_SecNum // g_pageline
		if Mod( g_SecNum, g_pageline ) > 0
			var_tabNum++
		g_tabList = %g_tabList%%g_CurSec%|
		if var_tabNum > 1
		{
			loops := var_tabNum -1
			loop %loops%
			{
				g_tabList = %g_tabList%%g_CurSec%(%a_index%)|
			}
		}
	}
}


Gui, Add, Button, x150 y450 w100 h30 g����Ч��, ��  Ч
Gui, Add, Button, x500 y450 w110 h30 g���رա�, ��  ��
Gui, Add, Tab2,  x6 y10 w795 h430, %g_tabList%

;; ���д���
g_CurSec =
g_iSec := 0
Loop parse, g_inimem, `n
{
	var_line := A_LoopField
	;; �����[�ֽ�]
	if ( RegExMatch( var_line, "^\[.+\]", var_match ) > 0 )
	{
		g_CurSec := RegExReplace(var_match,"[\[\]]","")
		
		;; add 2011.10.30�� ֻ����ȫ���ȼ�������̫���޷���ʾ
		if ( g_CurSec <> g_GlobalHotkey_Section )
			continue

		if SecArrayFromIniMem( g_inimem, g_CurSec, "Arr" ) > 0
		{
			Gui, Tab, %g_CurSec%,
			g_iSec++
			_y := g_y0 - 20
			Gui, Add, Text, x%g_xCB% w30	   y%_y% h20 , ��Ч
			Gui, Add, Text, x%g_xKN% w%g_wKN%  y%_y% h20 , ��������
			Gui, Add, Text, x%g_xHK% w%g_wHK%  y%_y% h20 , �ȼ���ǰֵ
			Gui, Add, Text, x%g_xSK% w%g_wSK%  y%_y% h20 , �Զ����ȼ�

			loops := Arr0
			loop %loops%
			{
				i := a_index
				line := Arr%i%

				;; ������ǰ�����ڵڼ�����ҳ
				i_tab := ( i - 1 ) // g_pageline
				i_mod := mod( i -1 , g_pageline )
				if i_mod = 0
					if i_tab > 0
					{
						Gui, Tab, %g_CurSec%(%i_tab%)
						g_iSec++

						_y := g_y0 - 20
						Gui, Add, Text, x%g_xCB% w30		  y%_y% h20 , ��Ч
						Gui, Add, Text, x%g_xKN% w%g_wKN%  y%_y% h20 , ��������
						Gui, Add, Text, x%g_xHK% w%g_wHK%  y%_y% h20 , �ȼ���ǰֵ
						Gui, Add, Text, x%g_xSK% w%g_wSK%  y%_y% h20 , �Զ����ȼ�
					}

				_y := g_y0 + 30*( i_mod )
				StrSplit2Sub( line, "=", keyName, keyValue )
				if keyName =
					Continue
				IfInString keyvalue, )
				{
					StrSplit2Sub( keyValue, ")", var_checked, var_hotkey )
				}
				Else
				{
					var_checked := 1
					var_hotkey := keyValue
				}
				if var_checked = 1
					var_checked = Checked
				Else
					var_checked =

				if ( g_CurSec == g_GlobalHotkey_Section )
					KeyNameDisalbed = Disabled
				else
					KeyNameDisalbed =

				Gui, Add, CheckBox,   x%g_xCB% w%g_wCB%  y%_y%  h25 v_CB_%g_iSec%_%i%  %var_checked%, %g_CurSec%      ;; CheckBox��ֵ����ָ���ȼ��Ƿ���Ч����Text�򱣴�Setion�ֽ��Ա���������ȼ�
				Gui, Add, Edit, 	    x%g_xKN% w%g_wKN%  y%_y%  h25 v_KN_%g_iSec%_%i% %KeyNameDisalbed%, %keyName%
				Gui, Add, Edit,    	x%g_xHK% w%g_wHK%  y%_y%  h25 v_HK_%g_iSec%_%i% , %var_hotkey%
				Gui, Add, Hotkey,    	x%g_xSK% w%g_wSK%  y%_y%  h25 v_SK_%g_iSec%_%i% g���ȼ�ֵ�༭��, %var_hotkey%
				Gui, Add, Button,    	x%g_xBT% w%g_wBT%  y%_y%  h23 v_BT_%g_iSec%_%i% g�������Զ����ȼ���, �� ��
				Gui, Add, Button,    	x%g_xAD% w%g_wAD%  y%_y%  h23 v_AD_%g_iSec%_%i% g��׷���Զ����ȼ���, ׷ ��
			}
		}

	}
}
Gui, Show, x377 y280 h506 w808, %g_title%


Return


#include ./inc/inifile.aik
#Include ./inc/string.aik


���رա�:
GuiClose:
ExitApp

���ȼ�ֵ�༭��:

	Return

�������Զ����ȼ���:
	Gui submit, nohide
	var_CtrlName := A_GuiControl
	if RegExMatch( var_CtrlName, "\d+$", iCtrl ) > 0
	{
		if RegExMatch( var_CtrlName, "_\d+_\d+$", iSec ) <= 0
			return

		if RegExMatch( iSec, "_\d+_", iSec ) <= 0
			return

		if RegExMatch( iSec, "\d+", iSec ) <= 0
			return				
		var_keyName := _KN_%iSec%_%iCtrl%
		var_NewKey  := _SK_%iSec%_%iCtrl%
		var_HotKey  := _HK_%iSec%_%iCtrl%
		var_Valid   := _CB_%iSec%_%iCtrl%
		GuiControlGet, var_sec, , _CB_%iSec%_%iCtrl%, Text
		if var_NewKey <>
		{
			var_keyValue := var_NewKey
			GuiControl , , _HK_%iSec%_%iCtrl%, %var_NewKey%
		}
		else
		{
			var_keyValue := var_HotKey
		}
		bSaved := false
		if IsValidHotkey( var_sec, var_keyName, var_keyValue )
		{
			var_keyValue = %var_Valid%)%var_keyValue%
			var_read := read_ini( g_inifile, var_sec, var_keyName, "" )
			if ( var_read == var_keyValue )
				bSaved := true
			else
			{
				MsgBox, 1, �����ȼ�, [%var_sec%] <%var_keyName%> ���ȼ�ֵ��`n`n�� ��%var_read%�� ����Ϊ ��%var_keyValue%��`n`nȷ��Ҫ���ø��ȼ���
				IfMsgBox OK
				{
					write_ini( g_inifile, var_sec, var_keyName, var_keyValue )
					g_inimem := IniFileRead( g_inifile )    ;; ���¼���INI�ļ�����
					bSaved := true
				}
				Else
				{
					bSaved := false
				}
			}
		}
		;; ���û�гɹ������ȼ������ȼ����ֵ���û�ԭ����ֵ
		if not bSaved
			GuiControl , , _HK_%iSec%_%iCtrl%, %var_HotKey%
	}
	Return

��׷���Զ����ȼ���:
	Gui submit, nohide
	var_CtrlName := A_GuiControl
	if RegExMatch( var_CtrlName, "\d+$", iCtrl ) > 0
	{
		if RegExMatch( var_CtrlName, "_\d+_\d+$", iSec ) <= 0
			return

		if RegExMatch( iSec, "_\d+_", iSec ) <= 0
			return

		if RegExMatch( iSec, "\d+", iSec ) <= 0
			return			

		var_keyName := _KN_%iSec%_%iCtrl%
		var_NewKey  := _SK_%iSec%_%iCtrl%
		var_HotKey  := _HK_%iSec%_%iCtrl%
		var_Valid   := _CB_%iSec%_%iCtrl%
		GuiControlGet, var_sec, , _CB_%iSec%_%iCtrl%, Text
		if var_NewKey <>
		{
			NeedleRegEx := "\|?" . var_NewKey . "\|?"
			if RegExMatch( var_Hotkey, NeedleRegEx ) > 0
			{
				MsgBox ��ǰ�ȼ�ֵ�Ѿ������ȼ�%var_NewKey%�������ظ���ӣ�
				Return
			}
			if var_HotKey =
				var_keyValue := var_NewKey
			Else
				var_keyValue = %var_HotKey%|%var_NewKey%
			GuiControl , , _HK_%iSec%_%iCtrl%, %var_keyValue%
		}
		else
		{
			MsgBox Ҫ׷�ӵ��Զ����ȼ���δ���ã�
			Return
		}
		bSaved := false
		if IsValidHotkey( var_sec, var_keyName, var_keyValue )
		{
			var_keyValue = %var_Valid%)%var_keyValue%   ;; Ϊ�Զ����HotKeys���ѡ��� 1)
			NeedleRegEx := var_Valid . "\s*\)\s*" . var_keyValue
			var_read := read_ini( g_inifile, var_sec, var_keyName, "" )

			;; ��ǰ��KeyValue�Ѿ����ڣ���ֱ�ӷ���True
			if ( var_read <> "" && RegExMatch( var_read, NeedleRegEx ) > 0  )
			{
				bSaved := true
			}
			else
			{
				MsgBox, 1, �����ȼ�, [%var_sec%] <%var_keyName%> ���ȼ�ֵ��`n`n�� ��%var_read%�� ����Ϊ ��%var_keyValue%��`n`nȷ��Ҫ���ø��ȼ���
				IfMsgBox OK
				{
					write_ini( g_inifile, var_sec, var_keyName, var_keyValue )
					g_inimem := IniFileRead( g_inifile )    ;; ���¼���INI�ļ�����
					bSaved := true
				}
				Else
				{
					bSaved := false
				}
			}
		}
		;; ���û�гɹ������ȼ������ȼ����ֵ���û�ԭ����ֵ
		if not bSaved
			GuiControl , , _HK_%iSec%_%iCtrl%, %var_HotKey%
	}
	Return

;;---------------------------------------------------------------------------
;; ���_HotkeyList�ܷ����ø�_keyName�����_HotkeyList�е�ĳ���ȼ��Ѿ�
;; ����������ռ�ã������Ѳ�����False
IsValidHotkey( _Section, _keyName, _hotkeyList )
{
	Local var_line, keyName, keyValue, var_pos, var_hotkey, var_temp
	if _hotkeyList =
		Return true

	if _Section =
		Return false

	if _keyName =
		Return false


	StringSplit, arrHK, _hotkeyList, |

	if ( arrHK0 > 0 && SecArrayFromIniMem( g_inimem, _Section, "arrSec" ) > 0 )
	{
		loop %arrSec0%
		{
			var_line := arrSec%a_index%

			IfInString var_line, =
			{
				StrSplit2Sub( var_line, "=", keyName, keyValue )
				if keyName <> %_keyName%
				{
					;; ���keyValue����ѡ�� 1) ����ȥ��ѡ�ֻ����HotKeys
					var_pos := InStr( keyValue, ")" )
					if var_pos > 0
						StringTrimLeft, keyValue, keyValue, var_pos
					loop parse, keyValue, |
					{
						var_hotkey := A_LoopField
						loop %arrHK0%
						{
							var_temp := arrHK%a_index%
							if var_hotkey = %var_temp%
							{
								MsgBox [%_Section%] ���Ѿ�������Ĺؼ���ʹ�����ȼ� `"%var_temp%`"`n`n%var_line%`n`n�޷������ȼ� `"%_keyName% = %var_temp%`" ��
								Return false
							}
						}
					}
				}
			}
		}
	}
	Return true
}


����Ч��:
	SendEvent ^!+{F5}
	Return
