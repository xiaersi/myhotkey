#NoTrayIcon
#include ..\..\
#include .\inc\string.aik
#include .\inc\inifile.aik

change_icon()                           ;; ����ͼ��

AutoTrim, Off

g_dictTitle = %1%                       ;; �ҵ�С�ֵ�ı���
g_TITLE = ������ӵ�����
g_WINTITLE = ������ӵ����� ahk_class AutoHotkeyGUI
g_clip := clipboard
��ɾ���ַ����������Ӵ�( g_clip, "`r")

g_GuiID =
g_col_list =
g_separate_list =
g_col_count = 0
g_separate_count = 0
g_keycol_count = 0
g_comcol_count = 0
g_rownum = 0                            ;; ����������Ч����
g_currow = 0
g_LVName = SysListView321

_dict := readtempini("�ҵ��ֵ�", "file", "" )
_section := readTempini("�ҵ��ֵ�", "section", "" )
_key := readTempini("�ҵ��ֵ�", "key", "" )
g_formatList := readTempini("�ҵ��ֵ�", "formatList", "" )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ListView�Ҽ��˵�
;Menu, MyContextMenu, Add, �鿴(&V), ���Ҽ��鿴��
Menu, MyContextMenu, Add, �޸�(&E), ���Ҽ��޸ġ�
Menu, MyContextMenu, Add, ɾ��(&D), ���Ҽ�ɾ����
Menu, MyContextMenu, Add, ����(&I), ���Ҽ����롿

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��������
Gui +resize ;+AlwaysOnTop
g_GuiID := WinExist()

Gui, Add, ComboBox, x41 y21 w560 h28 R10 +Left v_format g����ʽ�༭��, %g_formatList%

Gui, Add, Text, x16 y111 w40 h18 +Right, �ֵ�:
Gui, Add, Edit, x56 y106 w150 h25  v_dict , %_dict%

Gui, Add, Text, x216 y111 w40 h18 +Right, ����:
Gui, Add, Edit, x256 y106 w150 h25  v_section, %_section%

Gui, Add, Text, x416 y111 w40 h18 +Right , Key:
Gui, Add, Edit, x456 y106 w150 h25 v_key, %_key%

Gui, Add, GroupBox, x1 y2 w642 h90 , ��ʽ
Gui, Add, ListView, x16 y141 w610 h270 Grid v_KeyListView, [����]|[���ʽ�����]
Gui, Add, Button, x96 y50 w80 h30 default, Ԥ��
Gui, Add, Button, x276 y50 w80 h30 , ����
Gui, Add, Button, x366 y50 w80 h30 , �ر�
Gui, Add, Button, x456 y50 w80 h30 , ����
Gui, Add, Button, x186 y50 w80 h30 , ��
; Generated using SmartGui Creator 4.0
Gui, Show, h424 w645, %g_TITLE%

GoTo buttonԤ��
RETURN



����ʽ�༭��:
	GoSub buttonԤ��
	return


button��:
	Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before RETURNing to the main window.

	FileSelectFile, var_SelectedFile, 3, %A_WorkingDir%, ��ѡ���ֵ��ļ�, �ı��ļ� (*.csv; *.ini; *.txt; )

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
			{	;; ���Ը����ļ���һ�е������ж���ʲô�ļ�
				if ( A_LOOPReadLine == "Name,Type,Nullable,Default,Storage,Comments"  )
				{
					var_fileflag = ���ݱ����ļ�
					CONTINUE
				}
				if A_LOOPReadLine = "Name","Type","Nullable","Default","Storage","Comments"
				{
					var_fileflag = ���ݱ����ļ�
					CONTINUE
				}
			}
			;; ����ȡ��һ���е�","�滻�� _����_������CSV�ļ��еĶ��ţ�������ָ������Ż���
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
					StringReplace, var_temp, var_temp, `,, _����_ , All
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

				StringReplace, var_temp2, var_temp, `,, _����_ , All
			;	msgbox %var_LOOPline%`n `"%var_temp%`" >>> %var_temp2%
				StringReplace, var_LOOPline, var_LOOPline, `"%var_temp%`", %var_temp2% , All
			}

			var_curline =
		    LOOP, parse, var_LOOPline, `,
		    {
		    	var_field := a_LOOPField
		    	;; �鿴��Ԫ��ĵ�һ���ַ��Ƿ�Ϊ˫���ţ�����ɾ����Ԫ��ǰ���˫����
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
		    ;; ���������У���ֵ��g_clip���Ա�Ԥ��
		    g_clip = %g_clip%%var_curline%`n
		}
		;; ���ݲ�ͬ���ļ����Զ����ò�ͬ�ĸ�ʽ
		if var_fileflag = ���ݱ����ļ�
		{
			var_temp = A1$,$C3$,$C1$,$n1$,$n2$,$C2$,$
			GuiControl, Text, _format, %var_temp%
		}
		GoTo buttonԤ��
	}
	RETURN

button����:
	Gui, submit, nohide
	if _dict =
	{
		msgbox ����ָ���ֵ䣡
		RETURN
	}
	ifnotexist %_dict%
	{
		msgbox �ֵ䲻���ڣ�
		RETURN
	}
	if _section =
	{
		msgbox �������÷��࣡
		RETURN
	}
	RowCount =
	RowNumber = 0  ; This causes the first LOOP iteration to start the search at the top of the list.
	DefaultKeyvalue =
	if ( g_word_count <= 0 && _key != "" )
	{
		DefaultKeyvalue := read_ini( _dict, _section, _key, "" )
		;; ���ʹ��Ĭ�ϵ��������Ҹõ����Ѿ����ڣ���ѯ����׷�ӻ����滻!
		if ( g_word_count == 0 && DefaultKeyvalue != "" )
		{
			TrayTip , %_key%, =`n%DefaultKeyvalue%
			msgbox 4, ׷�ӻ��滻����, �ֵ� %_dict% ��[%_section%]�����Ѿ����ڵ���< %_key% >`n`n��(Y)��׷�� �� %_key%`n��(N)���滻
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

	    ;; ��ʽ��ָ���˵�������
	    if g_word_count > 0
	    {
		    if ( var_key != "" && var_value != "" )
		    {
		    	var_read := read_ini( _dict, _section, var_key, "" )
		    	StrListAdd( var_read, var_value, "|" )
		    	write_ini( _dict, _section, var_key, var_read )
		    }
	    }
	    else 	;; ��ʽ��û��ָ���������ƣ� ʹ��Ĭ�ϵ�������
	    {
	    	StrListAdd( DefaultKeyvalue, var_value, "|" )
	    }
	}
	;; ��ʽ��û��ָ���������ƣ� ʹ��Ĭ�ϵ������Ƶ����
	if ( g_word_count <= 0 && DefaultKeyvalue != "" && _key != ""  )
	{
;		msgbox g_word_count[%g_word_count%] ��ӵ�[%_key%]	;; test
		write_ini( _dict, _section, _key, DefaultKeyvalue )
	}
	if RowCount =
	{
		msgbox �б���û�����ݣ�
		RETURN
	}
	else
	{
		tooltip %RowCount% �������
		Gui hide
		sleep 800
	}
	gosub GuiClose
	return



button�ر�:
GuiClose:
ExitApp


buttonԤ��:
	GoSub  ��������ʽ��
	if ( g_separate_count <= 0 )
	{
		GoTo ��û�и�ʽ����Ԥ����
	}
	else
	{
		GoTo �������и�ʽ��Ԥ����
	}

	RETURN


��������ʽ��:
	Gui, submit, nohide
	;; �ͷ��ڴ�
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

	;; ������ʽ�ַ���
	LOOP parse,	_format, $
	{
		var_index := a_Index // 2
        if ( var_index * 2 == a_Index ) ;; a_Index Ϊż��
		{
			g_separate_count++
			g_separate_%var_index% := a_LOOPField
		}
        else                            ;; a_Index Ϊ����
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

	;; ���¸�ʽ���浽�����ļ�, ��Ϊ��ʷ��ʽ
	readTempini("�ҵ��ֵ�", "formatList", "" )
	IfInString _format, $
	{
		if ��Add�ַ�������( g_formatList, _format, "|", true, 20 )
		{
			GuiControl,, _format, |
			GuiControl,, _format, %g_formatList%
			WriteTempIni( "�ҵ��ֵ�", "formatList", g_formatList )
		}
		ControlSetText Edit1, %_format%, %g_WINTITLE%
	}
	RETURN


��û�и�ʽ����Ԥ����:
	Gui, submit, nohide
	LV_Delete()
	if _key =
		var_key = δ֪
	else
		var_key := _key

	LOOP parse, g_clip, `n
	{
		if a_LOOPField =
		{
			CONTINUE
		}
		stringreplace var_temp, a_LOOPField, _����_, `, ,All
		LV_Add("", _key, var_temp )
	}
	LV_ModifyCol(1)
	RETURN


�������и�ʽ��Ԥ����:
	Gui, submit, nohide
	if _key =
	{
		msgbox ��ָ��Ĭ��key
		RETURN
	}
	else
		var_key := _key

	LV_Delete()
    g_rownum := 0                     ;; ����
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
					g_%var_temp% = δ֪
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
		stringreplace var_line, var_line, _����_, `, ,All
		LV_Add("", g_w, var_line )

	}
	LV_ModifyCol(1)
	RETURN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �Ҽ���ݲ˵���Ӧ����
GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl = _KeyListView  ;
	{
		;; ���浱ǰѡ����е� g_iLocalPos
		Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
	}
	return

���Ҽ��޸ġ�:
	var_irow := LV_GetNext()
	if var_irow > 0
	{
		var_buf =
		LV_GetText( var_temp, var_irow, 2)
		MsgInputBox( var_buf, "�޸�", "�޸ĵ�����", var_temp )
		if var_buf <>
			LV_Modify( var_irow, "Col2", var_buf )
	}
	return

���Ҽ�ɾ����:
	LV_Delete( LV_GetNext() )
	return

���Ҽ����롿:
	return

#IfWinActive ������ӵ����� ahk_class AutoHotkeyGUI
F1::
	ComboBox_choose_next("ComboBox1", g_currow)
	Sleep 100
	GoTo buttonԤ��
	RETURN


^Enter::
	gosub button����
	Return

^E::
	gosub ���Ҽ��޸ġ�
	return 

^del::
	gosub ���Ҽ�ɾ����
	return

#IfWinActive
