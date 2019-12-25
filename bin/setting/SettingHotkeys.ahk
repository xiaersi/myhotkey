;; 通过设置配置文件 autohotstring.ini 来设置全局热键
#SingleInstance ignore 						;; 只允许一个实例运行
change_icon()

#include ../../
g_title = 设置全局热键
g_GlobalHotkey_Section = 全局热键
g_inifile = autoHotString.ini
g_inimem := IniFileRead( g_inifile )
if g_inimem =
{
	MsgBox 配置文件 %g_inifile% 不存在！
	ExitApp
}

;; 控件的默认位置
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

;; 获取TabList
g_CurSec =
g_SecNum := 0
g_tabList =
Loop parse, g_inimem, `n
{
	var_line := A_LoopField
	;; 如果是[分节]
	if ( RegExMatch( var_line, "^\[.+\]", var_match ) > 0 )
	{
		g_CurSec := RegExReplace(var_match,"[\[\]]","")

		;; add 2011.10.30， 只设置全局热键，设置太多无法显示
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


Gui, Add, Button, x150 y450 w100 h30 g【生效】, 生  效
Gui, Add, Button, x500 y450 w110 h30 g【关闭】, 关  闭
Gui, Add, Tab2,  x6 y10 w795 h430, %g_tabList%

;; 逐行处理
g_CurSec =
g_iSec := 0
Loop parse, g_inimem, `n
{
	var_line := A_LoopField
	;; 如果是[分节]
	if ( RegExMatch( var_line, "^\[.+\]", var_match ) > 0 )
	{
		g_CurSec := RegExReplace(var_match,"[\[\]]","")
		
		;; add 2011.10.30， 只设置全局热键，设置太多无法显示
		if ( g_CurSec <> g_GlobalHotkey_Section )
			continue

		if SecArrayFromIniMem( g_inimem, g_CurSec, "Arr" ) > 0
		{
			Gui, Tab, %g_CurSec%,
			g_iSec++
			_y := g_y0 - 20
			Gui, Add, Text, x%g_xCB% w30	   y%_y% h20 , 有效
			Gui, Add, Text, x%g_xKN% w%g_wKN%  y%_y% h20 , 功能名称
			Gui, Add, Text, x%g_xHK% w%g_wHK%  y%_y% h20 , 热键当前值
			Gui, Add, Text, x%g_xSK% w%g_wSK%  y%_y% h20 , 自定义热键

			loops := Arr0
			loop %loops%
			{
				i := a_index
				line := Arr%i%

				;; 分析当前行属于第几个分页
				i_tab := ( i - 1 ) // g_pageline
				i_mod := mod( i -1 , g_pageline )
				if i_mod = 0
					if i_tab > 0
					{
						Gui, Tab, %g_CurSec%(%i_tab%)
						g_iSec++

						_y := g_y0 - 20
						Gui, Add, Text, x%g_xCB% w30		  y%_y% h20 , 有效
						Gui, Add, Text, x%g_xKN% w%g_wKN%  y%_y% h20 , 功能名称
						Gui, Add, Text, x%g_xHK% w%g_wHK%  y%_y% h20 , 热键当前值
						Gui, Add, Text, x%g_xSK% w%g_wSK%  y%_y% h20 , 自定义热键
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

				Gui, Add, CheckBox,   x%g_xCB% w%g_wCB%  y%_y%  h25 v_CB_%g_iSec%_%i%  %var_checked%, %g_CurSec%      ;; CheckBox的值用于指定热键是否有效，其Text则保存Setion分节以便后面设置热键
				Gui, Add, Edit, 	    x%g_xKN% w%g_wKN%  y%_y%  h25 v_KN_%g_iSec%_%i% %KeyNameDisalbed%, %keyName%
				Gui, Add, Edit,    	x%g_xHK% w%g_wHK%  y%_y%  h25 v_HK_%g_iSec%_%i% , %var_hotkey%
				Gui, Add, Hotkey,    	x%g_xSK% w%g_wSK%  y%_y%  h25 v_SK_%g_iSec%_%i% g【热键值编辑框】, %var_hotkey%
				Gui, Add, Button,    	x%g_xBT% w%g_wBT%  y%_y%  h23 v_BT_%g_iSec%_%i% g【设置自定义热键】, 设 置
				Gui, Add, Button,    	x%g_xAD% w%g_wAD%  y%_y%  h23 v_AD_%g_iSec%_%i% g【追加自定义热键】, 追 加
			}
		}

	}
}
Gui, Show, x377 y280 h506 w808, %g_title%


Return


#include ./inc/inifile.aik
#Include ./inc/string.aik


【关闭】:
GuiClose:
ExitApp

【热键值编辑框】:

	Return

【设置自定义热键】:
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
				MsgBox, 1, 设置热键, [%var_sec%] <%var_keyName%> 的热键值将`n`n从 “%var_read%” 设置为 “%var_keyValue%”`n`n确定要设置该热键吗？
				IfMsgBox OK
				{
					write_ini( g_inifile, var_sec, var_keyName, var_keyValue )
					g_inimem := IniFileRead( g_inifile )    ;; 重新加载INI文件内容
					bSaved := true
				}
				Else
				{
					bSaved := false
				}
			}
		}
		;; 如果没有成功设置热键，则将热键框的值设置回原来的值
		if not bSaved
			GuiControl , , _HK_%iSec%_%iCtrl%, %var_HotKey%
	}
	Return

【追加自定义热键】:
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
				MsgBox 当前热键值已经包含热键%var_NewKey%，无需重复添加！
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
			MsgBox 要追加的自定义热键尚未设置！
			Return
		}
		bSaved := false
		if IsValidHotkey( var_sec, var_keyName, var_keyValue )
		{
			var_keyValue = %var_Valid%)%var_keyValue%   ;; 为自定义的HotKeys添加选项，如 1)
			NeedleRegEx := var_Valid . "\s*\)\s*" . var_keyValue
			var_read := read_ini( g_inifile, var_sec, var_keyName, "" )

			;; 当前的KeyValue已经存在，则直接返回True
			if ( var_read <> "" && RegExMatch( var_read, NeedleRegEx ) > 0  )
			{
				bSaved := true
			}
			else
			{
				MsgBox, 1, 设置热键, [%var_sec%] <%var_keyName%> 的热键值将`n`n从 “%var_read%” 设置为 “%var_keyValue%”`n`n确定要设置该热键吗？
				IfMsgBox OK
				{
					write_ini( g_inifile, var_sec, var_keyName, var_keyValue )
					g_inimem := IniFileRead( g_inifile )    ;; 重新加载INI文件内容
					bSaved := true
				}
				Else
				{
					bSaved := false
				}
			}
		}
		;; 如果没有成功设置热键，则将热键框的值设置回原来的值
		if not bSaved
			GuiControl , , _HK_%iSec%_%iCtrl%, %var_HotKey%
	}
	Return

;;---------------------------------------------------------------------------
;; 检查_HotkeyList能否设置给_keyName，如果_HotkeyList中的某个热键已经
;; 被其他功能占用，则提醒并返回False
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
					;; 如果keyValue包含选项 1) ，则去掉选项，只留下HotKeys
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
								MsgBox [%_Section%] 中已经有下面的关键字使用了热键 `"%var_temp%`"`n`n%var_line%`n`n无法设置热键 `"%_keyName% = %var_temp%`" ！
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


【生效】:
	SendEvent ^!+{F5}
	Return
