#NoTrayIcon
#include ..\..\
#include .\inc\common.aik
#include .\inc\string.aik
#include .\inc\inifile.aik

change_icon()                           ;; 设置图标

;;------初始化全局变量------------------------------------------------------
g_inifile = noteline.ini
g_sec := ReadTempIni( "添加行注释", "type", "cpp" )
g_secqueue =
read_sections(g_secqueue, g_inifile)

; ini文件中的保存格式如下
; n1=符号,线形,长度,光标位置,是否双行,说明
g_count := read_ini(g_inifile, g_sec, "count", "0")
g_preinput := 用户尚未输入内容
if g_sec = ahk
	g_note = `;`;
else
	g_note = //

g_title = 添加[%g_sec%]行注释

g_previewClose := false                 ;; 预览后关闭窗口
g_inClickListView := false              ;; 正在点击ListView，为各个编辑框设置值中，不允许在设置值的时候 goto button生成预览
;;-------显示窗口------------------------------------

Gui, Add, Edit, x16 y23 w590 h25 v_Comment g【内容框】, %clipboard%
Gui, Add, Text, x626 y96 w70 h20 , 注释符号：
Gui, Add, Edit, x696 y90 w80 h21 v_Note g【注释符号框】, %g_note%
Gui, Add, Text, x626 y126 w70 h20 , 注释线型：
Gui, Add, Edit, x696 y120 w80 h21 v_Line g【线型框】, -
Gui, Add, Text, x16 y255 w60 h16 , 预览
Gui, Add, Text, x626 y186 w70 h16 , 注释长度：
Gui, Add, Edit, x696 y181 w80 h20 v_Length +Left g【长度框】, 77
Gui, Add, Button, x626 y211 w80 h25 g【减小注释长度】, 减少长度
Gui, Add, Button, x706 y211 w70 h25 g【增加注释长度】, 增加长度
Gui, Add, CheckBox, x626 y61 w80 h20 v_CheckBox g【复选框】, 双行注释           ;; button3
Gui, Add, Button, x16 y80 w100 h30 , 生成预览
Gui, Add, Button, x16 y120 w100 h30 , 保存模板
Gui, Add, Button, x16 y160 w100 h30 default, 确定
Gui, Add, Button, x16 y200 w100 h30 , 取消
Gui, Add, ListBox, x156 y70 w450 h190 +AltSubmit v_MyListBox g【注释列表】
Gui, Add, Text, x136 y90 w20 h150 +Center, 请选择注释风格
Gui, Add, Edit, x16 y270 w770 h100 v_Preview,
Gui, Add, GroupBox, x6 y5 w610 h53 , 注释内容
Gui, Add, GroupBox, x6 y60 w120 h185 ,
Gui, Add, Text, x626 y156 w70 h20 , 光标位置：
Gui, Add, Edit, x696 y151 w80 h21 v_Cursor g【光标位置框】, 5

Gui, Add, ComboBox, x696 y18 w80 h28 r10 vg_sec g【注释风格分类】, %g_secqueue%	;; Edit7
Gui, Add, Text, x626 y20 h16 , 风格分类：
; Generated using SmartGUI Creator 4.0
Loop %g_count%
{
	var_key = n%a_index%
	var_temp := read_ini(g_inifile, g_sec, var_key, "" )
	StringGetPos, var_pos, var_temp, `, , R
	if ErrorLevel
		continue
	stringmid var_tip, var_temp, var_pos+2
	GuiControl,, _MyListBox, %a_index%) %var_tip%
}
;;
Gui, Show, center h383 w801, %g_title%
controlSetText Edit7, %g_sec%, %g_title%


goto button生成预览
Return


【注释风格分类】:
	GuiControl,, _MyListBox, |
	gui submit, nohide
	g_count := read_ini(g_inifile, g_sec, "count", "0")
	Loop %g_count%
	{
		var_key = n%a_index%
		var_temp := read_ini(g_inifile, g_sec, var_key, "" )
		StringGetPos, var_pos, var_temp, `, , R
		if ErrorLevel
			continue
		stringmid var_tip, var_temp, var_pos+2
		GuiControl,, _MyListBox, %a_index%) %var_tip%
	}
	return

;;---当下列编辑框的值发生变化时，刷新预览------------------------------------
【内容框】:
【注释符号框】:
【线型框】:
【长度框】:
【复选框】:
【光标位置框】:
	if not g_inClickListView
	{
		goto button生成预览
	}
	return


;;------调整注释长度--------------------------------------------------------
【减小注释长度】:
	gui submit, nohide
	var_notelen := strlen( _Note )
	if ( _Length <= (var_notelen + 4))
		return
	_Length -= 4
	controlSetText Edit4, %_Length%, %g_title%
	goto button生成预览
	return
【增加注释长度】:
	gui submit, nohide
	_Length += 4
	controlSetText Edit4, %_Length%, %g_title%
	goto button生成预览
	return

;;------响应点击ListBox, 采用所选的风格-------------------------------------
【注释列表】:
	GuiControlGet, _MyListBox
	if ( A_GuiEvent == "Normal" || A_GuiEvent == "DoubleClick" )
	{
		var_key = n%_MyListBox%
		var_temp := read_ini(g_inifile, g_sec, var_key, "")
		if var_temp=
		{
			return
		}
		ifinstring var_temp, `,
		{
			Loop parse, var_temp, `,
			{
				if a_index = 1
					_Note := a_loopfield
				else if a_index = 2
					_Line := a_loopfield
				else if a_index = 3
					_Length := a_loopfield
				else if a_index = 4
					_Cursor := a_loopfield
				else if a_index = 5
				{
					_CheckBox := a_loopfield
				}
			}
            g_inClickListView := true       ;; 马上要设置编辑框的值， 不允许在设置值的过程中goto button生成预览
			;; 选择双行复选框
			if ( _CheckBox == 1 )
                Control, Check, , Button3,  %g_title%   ;; Button3 是双行复选框
			else
				Control, UnCheck, , Button3,  %g_title%

			ControlSetText Edit2, %_Note%, %g_title%
			ControlSetText Edit3, %_Line%, %g_title%
			ControlSetText Edit4, %_Length%, %g_title%
			ControlSetText Edit6, %_Cursor%, %g_title%

			if A_GuiEvent = DoubleClick
			{
				;; 用户双击了列表，生成预览后将结果Send出去并关闭窗口
				g_previewClose := true
			}
			goto button生成预览
		}
	}

	return


;;------将当前注释风格保存到配置文件中--------------------------------------
button保存模板:
	gui submit, nohide
	ifinstring _Note, `,
	{
		msgbox 注释符号中不能包含`,号, 模板保存失败!
		return
	}
	ifinstring _Line, `,
	{
		msgbox 注释线形中不能包含`,号, 模板保存失败!
		return
	}
	; n1=符号,线形,长度,光标位置,是否双行,说明
	;; 检查当前注释风格是否已经保存过,保存过则退出
	var_count := read_ini( g_inifile, g_sec, "count", "0")
	var_new = %_Note%,%_Line%,%_Length%,%_Cursor%,%_CheckBox%
	loop %var_count%
	{
		var_key = n%a_index%
		var_temp := read_ini(g_inifile, g_sec, var_key, "" )
		ifinstring var_temp, %var_new%
		{
			msgbox 4, 替换注释风格?, 注释风格已经存在!`n[%g_sec%] %var_key% = %var_temp%`n`n确定替换?
			ifmsgbox No
				return
		}
	}
	;; 自己生成注释模块说明内容, 并允许修改
	var_default := ∑生成默认的注释风格说明(_note, _line, _length, _cursor, _CheckBox )

	var_text = 请为下面的注释模板添加说明文字!`n%var_new%
	var_itemshow := myinput("注释模块说明", var_text, var_default, 360, 150 )
	var_text =
	if var_itemshow =
	{
		msgbox 你没有输入说明文字,模板添加失败!
		return
	}

	;; 将新的注释模块保存到配置文件中g_inifile
	var_count++
	var_key = n%var_count%
	var_new = %var_new%,%var_itemshow%
	write_ini(g_inifile, g_sec, var_key, var_new)
	write_ini(g_inifile, g_sec, "count", var_count)

	; 刷新Listbox列表
	g_count++
	var_temp = %g_count%) %var_itemshow%
	GuiControl,, _MyListBox, %var_temp%
	return

;;------响应"确定","取消"按钮, 并且关闭窗口退出程序-------------------------
button确定:
	gui submit, hide
	ControlGetText var_temp, Edit5, %g_titleT%
	clipboard := var_temp
	sleep 200
	send ^v

button取消:
GuiClose:
ExitApp


;;------保存注释风格时,生成默认的示例说明-----------------------------------
∑生成默认的注释风格说明(_note, _line, _length, _cursor, _check )
{
	var_ret=
	var_len = 25
	var_notelen := strlen( _Note )
	var_linelen := strlen( _line )

	if _check = 1
	{
		if ( _Line = "" || _Length <= var_notelen || var_linelen <= 0 )
		{
			var_ret = %_Note% 双行 注释内容
		}
		else
		{
			var_ret = %_Note%
			var_loops := var_len // var_linelen
			loop %var_loops%
			{
				var_ret = %var_ret%%_Line%
			}
			var_ret = %var_ret% [%_length%]`t%_note% 注释内容
		}

	}
	else
	{
		if ( _Cursor < var_notelen )
			_Cursor := var_notelen
		if ( var_commentLen + _Cursor >= _Length )
		{
			_Cursor := var_notelen + ( _Length - var_commentLen - var_notelen ) // 2
		}
		if ( _Cursor < var_notelen )
			_Cursor := var_notelen

		if ( var_linelen < 1 )
		{
			var_ret = %_Note% 单行 注释内容
		}
		else if ( var_linelen == 1 )
		{
			var_ret = %_Note%
			var_loops := _Cursor - var_notelen
			Loop %var_loops%
			{
				var_ret = %var_ret%%_Line%
			}
			var_ret = %var_ret%注释

			Loop 12
			{
				var_ret = %var_ret%%_Line%
			}
		}
		else
		{
			Loop %var_linelen%
			{
				stringmid var_temp, _Line, %a_index%, 1
				lineArray%a_index% := var_temp
			}
			var_index := 0

			var_ret = %_Note%
			var_loops := _Cursor - var_notelen
			Loop %var_loops%
			{
				var_index++
				var_idx := ( var_index -1 ) // var_linelen
				var_idx := var_index - var_idx * var_linelen
				var_temp := lineArray%var_idx%
				var_ret = %var_ret%%var_temp%
			}
			var_ret = %var_ret%注释

			Loop 12
			{
				var_index++
				var_idx := ( var_index -1 ) // var_linelen
				var_idx := var_index - var_idx * var_linelen
				var_temp := lineArray%var_idx%
				var_ret = %var_ret%%var_temp%
			}

		}
		var_ret = %var_ret% [%_length%]
	}
	return var_ret
}


;;------生成注释预览--------------------------------------------------------
button生成预览:
	gui submit, nohide
    g_inClickListView := false          ;; 允许修改编辑框时，实时生成预览
	if _CheckBox
		goto 【生成双行注释】
	else
		goto 【生成单行注释】

	return

【生成单行注释】:
	var_notelen := strlen( _Note )
	var_commentLen := strlen( _Comment )
	if ( var_commentLen >= (_Length - var_notelen) )
	{
		goto 【生成双行注释】
		return
	}
	if ( _Cursor < var_notelen )
		_Cursor := var_notelen
	if ( var_commentLen + _Cursor >= _Length )
	{
		_Cursor := var_notelen + ( _Length - var_commentLen - var_notelen ) // 2
	}
	if ( _Cursor < var_notelen )
		_Cursor := var_notelen

	var_linelen := strlen( _Line )
	if ( var_linelen < 1 )
	{
		var_preview = %_Note% %_Comment%
	}
	else if ( var_linelen == 1 )
	{
		var_preview = %_Note%
		var_loops := _Cursor - var_notelen
		Loop %var_loops%
		{
			var_preview = %var_preview%%_Line%
		}
		var_preview = %var_preview%%_comment%

		var_loops := _Length - _cursor - var_commentLen
		Loop %var_loops%
		{
			var_preview = %var_preview%%_Line%
		}
	}
	else
	{
		Loop %var_linelen%
		{
			stringmid var_temp, _Line, %a_index%, 1
			lineArray%a_index% := var_temp
		}
		var_index := 0

		var_preview = %_Note%
		var_loops := _Cursor - var_notelen
		Loop %var_loops%
		{
			var_index++
			var_idx := ( var_index -1 ) // var_linelen
			var_idx := var_index - var_idx * var_linelen
			var_temp := lineArray%var_idx%
			var_preview = %var_preview%%var_temp%
		}
		var_preview = %var_preview%%_comment%

		var_loops := _Length - _cursor - var_commentLen
		Loop %var_loops%
		{
			var_index++
			var_idx := ( var_index -1 ) // var_linelen
			var_idx := var_index - var_idx * var_linelen
			var_temp := lineArray%var_idx%
			var_preview = %var_preview%%var_temp%
		}

	}
	controlsettext Edit5, %var_preview%, %g_title%

	;; 生成预览后,自动点击"确定"按钮,并关闭窗口
	if g_previewClose
	{
		g_previewClose := false
		goto button确定
	}
	return

【生成双行注释】:
	var_notelen := strlen( _Note )
	var_linelen := strlen( _line )
	if ( _Line = "" || _Length <= var_notelen || var_linelen <= 0 )
	{
		var_preview = %_Note% %_Comment%
	}
	else
	{
		var_preview = %_Note%
		var_loops := _Length - var_notelen
		var_loops := var_loops // var_linelen
		loop %var_loops%
		{
			var_preview = %var_preview%%_Line%
		}
		var_preview = %var_preview%`r`n%_Note% %_Comment%
	}
	controlsettext Edit5, %var_preview%, %g_title%

	;; 生成预览后,自动点击"确定"按钮,并关闭窗口
	if g_previewClose
	{
		g_previewClose := false
		goto button确定
	}
	return


