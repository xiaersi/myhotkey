#include ..\..\
#Include .\inc\listview\LVA.aik
#Include .\inc\listview\iconlist.aik
#Include .\inc\listview\lvfunc.aik
#include .\inc\inifile.aik
#include .\inc\string.aik


g_inifile=regtool.ini
g_lvSec=通用
g_SelectedFile =


Gui +LastFound 
hGui := WinExist()

Gui, Add, Button, x6 y20 w90 h30  	g【选择历史表达式】, 历史表达式(&O)
Gui, Add, Edit, 	x96 y22 w410 h25  -Multi 	v_search g【正则表达式输入框】,
Gui, Add, Button, x506 y20 w80 h30 	g【匹配】, 匹配
Gui, Add, Edit, 	x616 y22 w390 h25  -Multi 	v_replace g【替换字符输入框】,
Gui, Add, Button, x1010 y20 w78 h30 	g【替换】, 替换

Gui, Add, Button, x1090 y20 w120 h30 g【保存正则表达式】, 保存正则表达式(&S)

Gui, Add, Edit, 	x6 y90 w600 h550 	HScroll v_FileContent,
Gui, Add, Edit, 	x616 y90 w600 h550  HScroll v_NewContent, 无匹配内容
Gui, Add, Text, 	x6 y70 w440 h20 , 原始文本
Gui, Add, Text, 	x616 y70 w440 h20 , 替换后文本

Gui, Add, Checkbox, x706 y65 w200 h20 Checked  v_OnlyRepalceMatch, 只替换有匹配的行
Gui, Add, Checkbox, x96 y65 w200 h20 Checked  v_MatchByLine, 逐行匹配

Gui, Add, Button, x486 y62 w100 h22  	g【打开】, 打开文件(&F)

Gui, Add, Button, x1130 y62 w80 h22 g【重新加载】, Reload(&R)




Gui, Add, ListView, x96 y48 w410 h270 +LV0x2 v_KeyListView g【ListView】, 类别|名称|搜索Exp|替换Exp
LV_SetImageList(hLVIL, 1)               ;; 使用ImageList将使ListView的高度更高
GuiControl, Hide, _KeyListView
LVA_ListViewAdd("_KeyListView", "")


LV_ModifyCol(1, 	60)		;; 设置ListView第1列的宽度
LV_ModifyCol(2, 	150)	;; 设置ListView第2列的宽度
LV_ModifyCol(3,200)	;; 设置ListView第3列的宽度
LVA_SetCell("_KeyListView", 0, 2, "", "0xAAAAAA" )
LVA_SetCell("_KeyListView", 0, 1, "", "Green" )

OnMessage( 0x06, "WM_ACTIVATE" )
OnMessage("0x4E", "LVA_OnNotify")


; Generated using SmartGUI Creator 4.0
Gui, Show,   h650 w1225, 正则表达式测试


Return


GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl <> _KeyListView  ; Display the menu only for clicks inside the ListView.
	{
		GuiControl, Hide, _KeyListView
	}
	RETURN

LButton::
	if A_GuiControl <> _KeyListView  ; Display the menu only for clicks inside the ListView.
	{
		GuiControl, Hide, _KeyListView
	}
	click
	RETURN


GuiClose:
ExitApp

【打开】:
	FileSelectFile, g_SelectedFile, 3, , 选择需要分析的日志文件,
	if g_SelectedFile <>
	{
		FileRead var_temp, %g_SelectedFile%
		GuiControl , , _FileContent, %var_temp%
	}

	Return

【正则表达式输入框】:
	Gosub 【匹配】
	Return

【匹配】:
	Gui, submit, NoHide
	if _search <>
	{
		MatchBuf =
		if _MatchByLine
		{
			Loop parse, _FileContent, `n
			{
				if ( RegExMatch( A_LoopField, _search, var_match ) > 0 )
				{
					MatchBuf = %MatchBuf%%var_match%`n

				}
			}
		}
		else
		{
			if ( RegExMatch( _FileContent, _search, var_match ) > 0 )
			{
				MatchBuf := var_match
			}
		}
		GuiControl , , _NewContent, %MatchBuf%
	}
	Else
		GuiControl , , _NewContent,
	Return

【替换字符输入框】:
	Return

【替换】:
	Gui, submit, NoHide
	if _search <>
	{
		MatchBuf =
		if _MatchByLine
		{
			Loop parse, _FileContent, `n
			{
				if ( !_OnlyRepalceMatch || RegExMatch( A_LoopField, _search ) > 0 )
				{
					var_match := RegExReplace( A_LoopField, _search, _replace )
					{
						MatchBuf = %MatchBuf%%var_match%`n
					}
				}
			}
		}
		else
		{
			if ( !_OnlyRepalceMatch || RegExMatch( _FileContent, _search ) > 0 )
			{
				var_match := RegExReplace( _FileContent, _search, _replace )
				{
			;	msgbox  RegExReplace( _FileContent`, %_search%`, %_replace% )`n`n%var_match%
					MatchBuf := var_match
				}
			}
		}
		GuiControl , , _NewContent, %MatchBuf%
	}
	Else
		GuiControl , , _NewContent,
	Return

【重新加载】:
	Reload
	Return



【保存正则表达式】:
	Gui, submit, NoHide
	InputBox, var_input , 保存为, 请给正则表达式命名：, ,, 130
	if var_input <>
	{
		ifinstring var_input, ::
		{
			var_value = %var_input%
			StrSplit2Sub(var_input, "::", var_sec, var_name)
		}
		else
		{
			var_value = %g_lvSec%::%var_input%
			var_sec = %g_lvSec%
			var_name = %var_input%
		}

		recentList := read_ini(g_inifile, ".", "recent", "")
		∑Add字符串队列(recentList, var_value, ",")
		
		write_ini( g_inifile, ".", "recent", recentList)
		write_ini( g_inifile, var_sec, var_name . "_s", _search)
		write_ini( g_inifile, var_sec, var_name . "_r", _replace)
		tooltip 保存成功！
		SetTimer, RemoveToolTip, -5000
	}
	return


【选择历史表达式】:
	Gui, submit, NoHide
	if _search =
	{
		gosub 【展示最近使用的正则表达式】
	}
	else 
	{
		gosub 【搜索展示正则表达式】	
	}
	return

【ListView】:
	if ( A_GuiEvent == "DoubleClick"  )
	{
		GetLVCellUnderMouse( hGui, g_LVName, var_CurRow, var_CurCol, var_CellX, var_CellY, var_CellW, var_CellH )
		LV_GetText( g_lvSearch, var_CurRow, 3 )
		LV_GetText( g_lvSec, var_CurRow, 1 )
		LV_GetText( g_lvName, var_CurRow, 2 )
		LV_GetText( g_lvReplace, var_CurRow, 4 )

		msgbox  _search = %g_lvSearch%, _replace = %g_lvReplace%
		GuiControl , , _search, %g_lvSearch%
		GuiControl , , _replace, %g_lvReplace%
	}
	return



RemoveToolTip:
ToolTip
return	


【展示最近使用的正则表达式】:
	var_content := IniFileRead(g_inifile)
	var_recent := FindFromIniMem(var_content, ".", "recent", "")

	if var_recent <>
	{
		LV_Delete()
		items := 0

		StringSplit, recentArray, var_recent, `,
		
		Loop, %recentArray0%
		{
			items ++
			recent := recentArray%A_Index%
			StrSplit2Sub(recent, "::", var_sec, var_name)
			var_search :=  FindFromIniMem(var_content, var_sec, var_name . "_s", "")
			var_replace := FindFromIniMem(var_content, var_sec, var_name . "_r", "")


			;msgbox %var_sec% | %var_name% | %var_search% | %var_replace%	

			;; 向Listview 添加一行数据
			var_row := LV_Add( "",  var_sec, var_name,  var_search, var_replace )

			;; 为新添加的行，设置文本颜色
			var_FontColor = red
			LVA_SetCell( "_KeyListView", var_row, 2, "", var_FontColor )
		}
		

		;; 自动调整ListView的高度，以适应行数
		if ( items > 0 )
		{
			∑自动调整ListView的高度( items )
			GuiControl, Focus, _KeyListView
			GuiControl, Show, _KeyListView
		}
		else
		{
			GuiControl, Hide, _KeyListView
		}
		GuiControl, +Redraw, _KeyListView
	}
	return

【搜索展示正则表达式】:

	LV_Delete()
	return




∑自动调整ListView的高度( items )
{
	Local lv_header_h, lv_row_h, lv_h, y1, y2
	; LVM_GETHEADER
	SendMessage, 0x1000+31, 0, 0, SysListView321, ahk_id %hGui%
	WinGetPos,,,, lv_header_h, ahk_id %ErrorLevel%

	VarSetCapacity( rect, 16, 0 )

	; LVM_GETITEMRECT
	;   LVIR_BOUNDS
	SendMessage, 0x1000+14, 0, &rect, SysListView321, ahk_id %hGui%

	y1 := DecodeInteger( "int4", &rect, 4 )
	y2 := DecodeInteger( "int4", &rect, 12 )
	lv_row_h := y2 - y1
	lv_h := 2 + lv_header_h + ( lv_row_h * items ) + 30

	if ( lv_h > 270 )
		lv_h = 270

	GuiControl, Move, SysListView321, h%lv_h%
	LV_ModifyCol(1)
	LV_ModifyCol(2)
	LV_ModifyCol(3)
	LV_ModifyCol(4)	
}	



DecodeInteger( p_type, p_address, p_offset, p_hex=true )
{
   old_FormatInteger := A_FormatInteger

   if ( p_hex )
      SetFormat, Integer, hex
   else
      SetFormat, Integer, dec

   sign := InStr( p_type, "u", false )^1

   StringRight, size, p_type, 1

   loop, %size%
      value += ( *( ( p_address+p_offset )+( A_Index-1 ) ) << ( 8*( A_Index-1 ) ) )

   if ( sign and size <= 4 and *( p_address+p_offset+( size-1 ) ) & 0x80 )
      value := -( ( ~value+1 ) & ( ( 2**( 8*size ) )-1 ) )

   SetFormat, Integer, %old_FormatInteger%

   return, value
}

