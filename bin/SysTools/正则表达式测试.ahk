#include ..\..\
#Include .\inc\listview\LVA.aik
#Include .\inc\listview\iconlist.aik
#Include .\inc\listview\lvfunc.aik
#include .\inc\inifile.aik
#include .\inc\string.aik


g_inifile=regtool.ini
g_lvSec=ͨ��
g_SelectedFile =


Gui +LastFound 
hGui := WinExist()

Gui, Add, Button, x6 y20 w90 h30  	g��ѡ����ʷ���ʽ��, ��ʷ���ʽ(&O)
Gui, Add, Edit, 	x96 y22 w410 h25  -Multi 	v_search g��������ʽ�����,
Gui, Add, Button, x506 y20 w80 h30 	g��ƥ�䡿, ƥ��
Gui, Add, Edit, 	x616 y22 w390 h25  -Multi 	v_replace g���滻�ַ������,
Gui, Add, Button, x1010 y20 w78 h30 	g���滻��, �滻

Gui, Add, Button, x1090 y20 w120 h30 g������������ʽ��, ����������ʽ(&S)

Gui, Add, Edit, 	x6 y90 w600 h550 	HScroll v_FileContent,
Gui, Add, Edit, 	x616 y90 w600 h550  HScroll v_NewContent, ��ƥ������
Gui, Add, Text, 	x6 y70 w440 h20 , ԭʼ�ı�
Gui, Add, Text, 	x616 y70 w440 h20 , �滻���ı�

Gui, Add, Checkbox, x706 y65 w200 h20 Checked  v_OnlyRepalceMatch, ֻ�滻��ƥ�����
Gui, Add, Checkbox, x96 y65 w200 h20 Checked  v_MatchByLine, ����ƥ��

Gui, Add, Button, x486 y62 w100 h22  	g���򿪡�, ���ļ�(&F)

Gui, Add, Button, x1130 y62 w80 h22 g�����¼��ء�, Reload(&R)




Gui, Add, ListView, x96 y48 w410 h270 +LV0x2 v_KeyListView g��ListView��, ���|����|����Exp|�滻Exp
LV_SetImageList(hLVIL, 1)               ;; ʹ��ImageList��ʹListView�ĸ߶ȸ���
GuiControl, Hide, _KeyListView
LVA_ListViewAdd("_KeyListView", "")


LV_ModifyCol(1, 	60)		;; ����ListView��1�еĿ��
LV_ModifyCol(2, 	150)	;; ����ListView��2�еĿ��
LV_ModifyCol(3,200)	;; ����ListView��3�еĿ��
LVA_SetCell("_KeyListView", 0, 2, "", "0xAAAAAA" )
LVA_SetCell("_KeyListView", 0, 1, "", "Green" )

OnMessage( 0x06, "WM_ACTIVATE" )
OnMessage("0x4E", "LVA_OnNotify")


; Generated using SmartGUI Creator 4.0
Gui, Show,   h650 w1225, ������ʽ����


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

���򿪡�:
	FileSelectFile, g_SelectedFile, 3, , ѡ����Ҫ��������־�ļ�,
	if g_SelectedFile <>
	{
		FileRead var_temp, %g_SelectedFile%
		GuiControl , , _FileContent, %var_temp%
	}

	Return

��������ʽ�����:
	Gosub ��ƥ�䡿
	Return

��ƥ�䡿:
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

���滻�ַ������:
	Return

���滻��:
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

�����¼��ء�:
	Reload
	Return



������������ʽ��:
	Gui, submit, NoHide
	InputBox, var_input , ����Ϊ, ���������ʽ������, ,, 130
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
		��Add�ַ�������(recentList, var_value, ",")
		
		write_ini( g_inifile, ".", "recent", recentList)
		write_ini( g_inifile, var_sec, var_name . "_s", _search)
		write_ini( g_inifile, var_sec, var_name . "_r", _replace)
		tooltip ����ɹ���
		SetTimer, RemoveToolTip, -5000
	}
	return


��ѡ����ʷ���ʽ��:
	Gui, submit, NoHide
	if _search =
	{
		gosub ��չʾ���ʹ�õ�������ʽ��
	}
	else 
	{
		gosub ������չʾ������ʽ��	
	}
	return

��ListView��:
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


��չʾ���ʹ�õ�������ʽ��:
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

			;; ��Listview ���һ������
			var_row := LV_Add( "",  var_sec, var_name,  var_search, var_replace )

			;; Ϊ����ӵ��У������ı���ɫ
			var_FontColor = red
			LVA_SetCell( "_KeyListView", var_row, 2, "", var_FontColor )
		}
		

		;; �Զ�����ListView�ĸ߶ȣ�����Ӧ����
		if ( items > 0 )
		{
			���Զ�����ListView�ĸ߶�( items )
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

������չʾ������ʽ��:

	LV_Delete()
	return




���Զ�����ListView�ĸ߶�( items )
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

