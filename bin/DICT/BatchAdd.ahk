#NoTrayIcon
#include ..\..\
#include .\inc\string.aik
#include .\inc\inifile.aik

change_icon()                           ;; 设置图标

AutoTrim, Off

g_dictTitle = %1%                       ;; 我的小字典的标题
g_TITLE = 批量添加单词项
g_WINTITLE = 批量添加单词项 ahk_class AutoHotkeyGUI
g_clip := clipboard
∑删除字符串中所有子串( g_clip, "`r")

g_GuiID =
g_col_list =
g_separate_list =
g_col_count = 0
g_separate_count = 0
g_keycol_count = 0
g_comcol_count = 0
g_rownum = 0                            ;; 剪贴板中有效行数
g_currow = 0
g_LVName = SysListView321

_dict := readtempini("我的字典", "file", "" )
_section := readTempini("我的字典", "section", "" )
_key := readTempini("我的字典", "key", "" )
g_formatList := readTempini("我的字典", "formatList", "" )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ListView右键菜单
;Menu, MyContextMenu, Add, 查看(&V), 【右键查看】
Menu, MyContextMenu, Add, 修改(&E), 【右键修改】
Menu, MyContextMenu, Add, 删除(&D), 【右键删除】
Menu, MyContextMenu, Add, 插入(&I), 【右键插入】

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 创建窗口
Gui +resize ;+AlwaysOnTop
g_GuiID := WinExist()

Gui, Add, ComboBox, x41 y21 w560 h28 R10 +Left v_format g【格式编辑框】, %g_formatList%

Gui, Add, Text, x16 y111 w40 h18 +Right, 字典:
Gui, Add, Edit, x56 y106 w150 h25  v_dict , %_dict%

Gui, Add, Text, x216 y111 w40 h18 +Right, 分类:
Gui, Add, Edit, x256 y106 w150 h25  v_section, %_section%

Gui, Add, Text, x416 y111 w40 h18 +Right , Key:
Gui, Add, Edit, x456 y106 w150 h25 v_key, %_key%

Gui, Add, GroupBox, x1 y2 w642 h90 , 格式
Gui, Add, ListView, x16 y141 w610 h270 Grid v_KeyListView, [单词]|[单词解释项]
Gui, Add, Button, x96 y50 w80 h30 default, 预览
Gui, Add, Button, x276 y50 w80 h30 , 保存
Gui, Add, Button, x366 y50 w80 h30 , 关闭
Gui, Add, Button, x456 y50 w80 h30 , 帮助
Gui, Add, Button, x186 y50 w80 h30 , 打开
; Generated using SmartGui Creator 4.0
Gui, Show, h424 w645, %g_TITLE%

GoTo button预览
RETURN



【格式编辑框】:
	GoSub button预览
	return


button打开:
	Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before RETURNing to the main window.

	FileSelectFile, var_SelectedFile, 3, %A_WorkingDir%, 请选择字典文件, 文本文件 (*.csv; *.ini; *.txt; )

	IfExist %var_SelectedFile%
	{
		g_clip =
		var_fileflag =
		var_trimlist = `"

		LOOP, read, %var_SelectedFile%
		{
			if  A_LOOPReadLine =
				CONTINUE

			if g_clip =
			{	;; 尝试根据文件第一行的内容判断是什么文件
				if ( A_LOOPReadLine == "Name,Type,Nullable,Default,Storage,Comments"  )
				{
					var_fileflag = 数据表导出文件
					CONTINUE
				}
				if A_LOOPReadLine = "Name","Type","Nullable","Default","Storage","Comments"
				{
					var_fileflag = 数据表导出文件
					CONTINUE
				}
			}
			;; 将读取的一行中的","替换成 _逗号_，这是CSV文件中的逗号，避免与分隔符逗号混淆
			var_LOOPline := A_LOOPReadLine


			stringleft var_firstchar, var_field, 1
	        if var_firstchar = `"
	        {
	        	var_pos = 0
	        	var_field =

	        	LOOP
	        	{
	        		StringGetPos, var_pos, var_LOOPline, `" , L, var_pos + 1
	        		if ErrorLevel
	        		{
	        			stringmid var_field, var_LOOPline, 1, strlen(var_LOOPline)
	        			BREAK
	        		}
	        		if ( var_pos >= strlen( var_LOOPline ) )
	        		{
	        			stringmid var_field, var_LOOPline, 1, var_pos + 1
	        			BREAK
	        		}
					stringmid var_onechar, var_LOOPline, var_pos+1, 1
					if var_onechar = `,
					{
						stringmid var_field, var_LOOPline, 1, var_pos + 1
						BREAK
					}
	        	}
	        	if var_field <>
	        	{
	        		var_temp := var_field
	        		StrTrim( var_temp, var_trimlist)
					StringReplace, var_temp, var_temp, `,, _逗号_ , All
					StringReplace, var_LOOPline, var_LOOPline, `"%var_field%`", %var_temp%
	        	}
	        }



			var_left = `,`"
			var_right = `"`,
			LOOP
			{
			;	msgbox StrMid2Sub( %var_LOOPline%, `n[%var_left%], [%var_right%] )
				var_temp := StrMid2Sub( var_LOOPline, var_left, var_right )
				if var_temp =
					BREAK

				StringReplace, var_temp2, var_temp, `,, _逗号_ , All
			;	msgbox %var_LOOPline%`n `"%var_temp%`" >>> %var_temp2%
				StringReplace, var_LOOPline, var_LOOPline, `"%var_temp%`", %var_temp2% , All
			}

			var_curline =
		    LOOP, parse, var_LOOPline, `,
		    {
		    	var_field := a_LOOPField
		    	;; 查看单元格的第一个字符是否为双引号，是则删除单元格前后的双引号
		        stringleft var_firstchar, var_field, 1
		        var_temp := var_field
		        if var_firstchar = `"
		        {
		        	StrTrim( var_field, var_trimlist)
		        }
		        if var_curline=
			       	var_curline = %var_field%
		        else
		        	var_curline = %var_curline%,%var_field%
		    }
		    ;; 将处理后的行，赋值给g_clip，以便预览
		    g_clip = %g_clip%%var_curline%`n
		}
		;; 根据不同的文件，自动设置不同的格式
		if var_fileflag = 数据表导出文件
		{
			var_temp = A1$,$C3$,$C1$,$n1$,$n2$,$C2$,$
			GuiControl, Text, _format, %var_temp%
		}
		GoTo button预览
	}
	RETURN

button保存:
	Gui, submit, nohide
	if _dict =
	{
		msgbox 请先指定字典！
		RETURN
	}
	ifnotexist %_dict%
	{
		msgbox 字典不存在！
		RETURN
	}
	if _section =
	{
		msgbox 请先设置分类！
		RETURN
	}
	RowCount =
	RowNumber = 0  ; This causes the first LOOP iteration to start the search at the top of the list.
	DefaultKeyvalue =
	if ( g_word_count <= 0 && _key != "" )
	{
		DefaultKeyvalue := read_ini( _dict, _section, _key, "" )
		;; 如果使用默认单词名称且该单词已经存在，则询问是追加还是替换!
		if ( g_word_count == 0 && DefaultKeyvalue != "" )
		{
			TrayTip , %_key%, =`n%DefaultKeyvalue%
			msgbox 4, 追加或替换单词, 字典 %_dict% 的[%_section%]节中已经存在单词< %_key% >`n`n是(Y)：追加 到 %_key%`n否(N)：替换
			ifmsgbox No
			{
				write_ini( _dict, _section, _key, "" )
			}
			TrayTip
		}
	}

	LOOP % LV_GetCount()
	{
	    RowNumber := a_Index
	    RowCount++
	    LV_GetText(var_key, RowNumber, 1)
	    LV_GetText(var_value, RowNumber, 2)
	    strTrim( var_key )
	    strTrim( var_value )

	    ;; 格式中指定了单词名称
	    if g_word_count > 0
	    {
		    if ( var_key != "" && var_value != "" )
		    {
		    	var_read := read_ini( _dict, _section, var_key, "" )
		    	StrListAdd( var_read, var_value, "|" )
		    	write_ini( _dict, _section, var_key, var_read )
		    }
	    }
	    else 	;; 格式中没有指定单词名称， 使用默认单词名称
	    {
	    	StrListAdd( DefaultKeyvalue, var_value, "|" )
	    }
	}
	;; 格式中没有指定单词名称， 使用默认单词名称的情况
	if ( g_word_count <= 0 && DefaultKeyvalue != "" && _key != ""  )
	{
;		msgbox g_word_count[%g_word_count%] 添加到[%_key%]	;; test
		write_ini( _dict, _section, _key, DefaultKeyvalue )
	}
	if RowCount =
	{
		msgbox 列表中没有内容！
		RETURN
	}
	else
	{
		tooltip %RowCount% 个单词项！
		Gui hide
		sleep 800
	}
	gosub GuiClose
	return



button关闭:
GuiClose:
ExitApp


button预览:
	GoSub  【解析格式】
	if ( g_separate_count <= 0 )
	{
		GoTo 【没有格式生成预览】
	}
	else
	{
		GoTo 【生成有格式的预览】
	}

	RETURN


【解析格式】:
	Gui, submit, nohide
	;; 释放内存
	if ( g_col_count > 0 )
	{
		LOOP %g_col_count%
		{
			g_row_%a_Index% =
		}
	}
	if ( g_separate_count > 0 )
	{
		LOOP %g_separate_count%
		{
			g_separate_%a_Index% =
		}
	}
	g_col_list =
	g_separate_list =
	g_col_count = 0
	g_separate_count = 0
	g_keycol_count := 0
	g_comcol_count := 0
	g_word_count := 0

	;; 分析格式字符串
	LOOP parse,	_format, $
	{
		var_index := a_Index // 2
        if ( var_index * 2 == a_Index ) ;; a_Index 为偶数
		{
			g_separate_count++
			g_separate_%var_index% := a_LOOPField
		}
        else                            ;; a_Index 为奇数
		{
			var_index++
			g_col_count++
			g_col_%var_index% := a_LOOPField
			get_first_char( a_LOOPField,  var_char)
			if var_char = A
			{
				g_keycol_count++
			}
			else if var_char = C
			{
				g_comcol_count++
			}
			else if var_char = w
			{
				g_word_count++
			}
		}
	}

	;; 将新格式保存到配置文件, 作为历史格式
	readTempini("我的字典", "formatList", "" )
	IfInString _format, $
	{
		if ∑Add字符串队列( g_formatList, _format, "|", true, 20 )
		{
			GuiControl,, _format, |
			GuiControl,, _format, %g_formatList%
			WriteTempIni( "我的字典", "formatList", g_formatList )
		}
		ControlSetText Edit1, %_format%, %g_WINTITLE%
	}
	RETURN


【没有格式生成预览】:
	Gui, submit, nohide
	LV_Delete()
	if _key =
		var_key = 未知
	else
		var_key := _key

	LOOP parse, g_clip, `n
	{
		if a_LOOPField =
		{
			CONTINUE
		}
		stringreplace var_temp, a_LOOPField, _逗号_, `, ,All
		LV_Add("", _key, var_temp )
	}
	LV_ModifyCol(1)
	RETURN


【生成有格式的预览】:
	Gui, submit, nohide
	if _key =
	{
		msgbox 请指定默认key
		RETURN
	}
	else
		var_key := _key

	LV_Delete()
    g_rownum := 0                     ;; 行数
	LOOP parse, g_clip, `n
	{
		if a_LOOPField =
		{
			CONTINUE
		}
		g_rownum++
		var_row := a_Index
		g_w_%var_row% =

		var_right := a_LOOPField
;		msgbox g_separate_count[%g_separate_count%] line[%var_row%]: %a_LOOPField%
		var_LOOPSep := g_separate_count + 1
		LOOP %var_LOOPSep%
		{
			var_col := a_Index
			var_left =
			if ( StrSplit2Sub( var_right, g_separate_%var_col%, var_left, var_right ) )
			{
				var_temp := g_col_%var_col%
				g_%var_temp% := var_left
			}
			else
			{
				var_temp := g_col_%var_col%
				if var_right <>
				{
					g_%var_temp% := var_right
					var_right =
					BREAK
				}
				else
				{
					g_%var_temp% = 未知
				}
			}
		}

		if g_w =
		{
			g_w := _key
		}


;		msgbox var_row = %var_row%
		var_line =
		LOOP %g_keycol_count%
		{
			var_temp := g_a%a_Index%
			var_line = %var_line% %var_temp%
		}

		if g_comcol_count > 0
		{
			var_line = %var_line% `/*
			LOOP %g_comcol_count%
			{
				var_temp := g_c%a_Index%
				var_line = %var_line% %var_temp%
			}
			var_line = %var_line% *`/
		}
		stringreplace var_line, var_line, _逗号_, `, ,All
		LV_Add("", g_w, var_line )

	}
	LV_ModifyCol(1)
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 右键快捷菜单响应函数
GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl = _KeyListView  ;
	{
		;; 保存当前选择的行到 g_iLocalPos
		Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
	}
	return

【右键修改】:
	var_irow := LV_GetNext()
	if var_irow > 0
	{
		var_buf =
		LV_GetText( var_temp, var_irow, 2)
		MsgInputBox( var_buf, "修改", "修改单词项", var_temp )
		if var_buf <>
			LV_Modify( var_irow, "Col2", var_buf )
	}
	return

【右键删除】:
	LV_Delete( LV_GetNext() )
	return

【右键插入】:
	return

#IfWinActive 批量添加单词项 ahk_class AutoHotkeyGUI
F1::
	ComboBox_choose_next("ComboBox1", g_currow)
	Sleep 100
	GoTo button预览
	RETURN


^Enter::
	gosub button保存
	Return

^E::
	gosub 【右键修改】
	return 

^del::
	gosub 【右键删除】
	return

#IfWinActive
