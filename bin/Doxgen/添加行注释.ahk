#NoTrayIcon
#include ..\..\
#include .\inc\common.aik
#include .\inc\string.aik
#include .\inc\inifile.aik

change_icon()                           ;; ����ͼ��

;;------��ʼ��ȫ�ֱ���------------------------------------------------------
g_inifile = noteline.ini
g_sec := ReadTempIni( "�����ע��", "type", "cpp" )
g_secqueue =
read_sections(g_secqueue, g_inifile)

; ini�ļ��еı����ʽ����
; n1=����,����,����,���λ��,�Ƿ�˫��,˵��
g_count := read_ini(g_inifile, g_sec, "count", "0")
g_preinput := �û���δ��������
if g_sec = ahk
	g_note = `;`;
else
	g_note = //

g_title = ���[%g_sec%]��ע��

g_previewClose := false                 ;; Ԥ����رմ���
g_inClickListView := false              ;; ���ڵ��ListView��Ϊ�����༭������ֵ�У�������������ֵ��ʱ�� goto button����Ԥ��
;;-------��ʾ����------------------------------------

Gui, Add, Edit, x16 y23 w590 h25 v_Comment g�����ݿ�, %clipboard%
Gui, Add, Text, x626 y96 w70 h20 , ע�ͷ��ţ�
Gui, Add, Edit, x696 y90 w80 h21 v_Note g��ע�ͷ��ſ�, %g_note%
Gui, Add, Text, x626 y126 w70 h20 , ע�����ͣ�
Gui, Add, Edit, x696 y120 w80 h21 v_Line g�����Ϳ�, -
Gui, Add, Text, x16 y255 w60 h16 , Ԥ��
Gui, Add, Text, x626 y186 w70 h16 , ע�ͳ��ȣ�
Gui, Add, Edit, x696 y181 w80 h20 v_Length +Left g�����ȿ�, 77
Gui, Add, Button, x626 y211 w80 h25 g����Сע�ͳ��ȡ�, ���ٳ���
Gui, Add, Button, x706 y211 w70 h25 g������ע�ͳ��ȡ�, ���ӳ���
Gui, Add, CheckBox, x626 y61 w80 h20 v_CheckBox g����ѡ��, ˫��ע��           ;; button3
Gui, Add, Button, x16 y80 w100 h30 , ����Ԥ��
Gui, Add, Button, x16 y120 w100 h30 , ����ģ��
Gui, Add, Button, x16 y160 w100 h30 default, ȷ��
Gui, Add, Button, x16 y200 w100 h30 , ȡ��
Gui, Add, ListBox, x156 y70 w450 h190 +AltSubmit v_MyListBox g��ע���б�
Gui, Add, Text, x136 y90 w20 h150 +Center, ��ѡ��ע�ͷ��
Gui, Add, Edit, x16 y270 w770 h100 v_Preview,
Gui, Add, GroupBox, x6 y5 w610 h53 , ע������
Gui, Add, GroupBox, x6 y60 w120 h185 ,
Gui, Add, Text, x626 y156 w70 h20 , ���λ�ã�
Gui, Add, Edit, x696 y151 w80 h21 v_Cursor g�����λ�ÿ�, 5

Gui, Add, ComboBox, x696 y18 w80 h28 r10 vg_sec g��ע�ͷ����ࡿ, %g_secqueue%	;; Edit7
Gui, Add, Text, x626 y20 h16 , �����ࣺ
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


goto button����Ԥ��
Return


��ע�ͷ����ࡿ:
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

;;---�����б༭���ֵ�����仯ʱ��ˢ��Ԥ��------------------------------------
�����ݿ�:
��ע�ͷ��ſ�:
�����Ϳ�:
�����ȿ�:
����ѡ��:
�����λ�ÿ�:
	if not g_inClickListView
	{
		goto button����Ԥ��
	}
	return


;;------����ע�ͳ���--------------------------------------------------------
����Сע�ͳ��ȡ�:
	gui submit, nohide
	var_notelen := strlen( _Note )
	if ( _Length <= (var_notelen + 4))
		return
	_Length -= 4
	controlSetText Edit4, %_Length%, %g_title%
	goto button����Ԥ��
	return
������ע�ͳ��ȡ�:
	gui submit, nohide
	_Length += 4
	controlSetText Edit4, %_Length%, %g_title%
	goto button����Ԥ��
	return

;;------��Ӧ���ListBox, ������ѡ�ķ��-------------------------------------
��ע���б�:
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
            g_inClickListView := true       ;; ����Ҫ���ñ༭���ֵ�� ������������ֵ�Ĺ�����goto button����Ԥ��
			;; ѡ��˫�и�ѡ��
			if ( _CheckBox == 1 )
                Control, Check, , Button3,  %g_title%   ;; Button3 ��˫�и�ѡ��
			else
				Control, UnCheck, , Button3,  %g_title%

			ControlSetText Edit2, %_Note%, %g_title%
			ControlSetText Edit3, %_Line%, %g_title%
			ControlSetText Edit4, %_Length%, %g_title%
			ControlSetText Edit6, %_Cursor%, %g_title%

			if A_GuiEvent = DoubleClick
			{
				;; �û�˫�����б�����Ԥ���󽫽��Send��ȥ���رմ���
				g_previewClose := true
			}
			goto button����Ԥ��
		}
	}

	return


;;------����ǰע�ͷ�񱣴浽�����ļ���--------------------------------------
button����ģ��:
	gui submit, nohide
	ifinstring _Note, `,
	{
		msgbox ע�ͷ����в��ܰ���`,��, ģ�屣��ʧ��!
		return
	}
	ifinstring _Line, `,
	{
		msgbox ע�������в��ܰ���`,��, ģ�屣��ʧ��!
		return
	}
	; n1=����,����,����,���λ��,�Ƿ�˫��,˵��
	;; ��鵱ǰע�ͷ���Ƿ��Ѿ������,��������˳�
	var_count := read_ini( g_inifile, g_sec, "count", "0")
	var_new = %_Note%,%_Line%,%_Length%,%_Cursor%,%_CheckBox%
	loop %var_count%
	{
		var_key = n%a_index%
		var_temp := read_ini(g_inifile, g_sec, var_key, "" )
		ifinstring var_temp, %var_new%
		{
			msgbox 4, �滻ע�ͷ��?, ע�ͷ���Ѿ�����!`n[%g_sec%] %var_key% = %var_temp%`n`nȷ���滻?
			ifmsgbox No
				return
		}
	}
	;; �Լ�����ע��ģ��˵������, �������޸�
	var_default := ������Ĭ�ϵ�ע�ͷ��˵��(_note, _line, _length, _cursor, _CheckBox )

	var_text = ��Ϊ�����ע��ģ�����˵������!`n%var_new%
	var_itemshow := myinput("ע��ģ��˵��", var_text, var_default, 360, 150 )
	var_text =
	if var_itemshow =
	{
		msgbox ��û������˵������,ģ�����ʧ��!
		return
	}

	;; ���µ�ע��ģ�鱣�浽�����ļ���g_inifile
	var_count++
	var_key = n%var_count%
	var_new = %var_new%,%var_itemshow%
	write_ini(g_inifile, g_sec, var_key, var_new)
	write_ini(g_inifile, g_sec, "count", var_count)

	; ˢ��Listbox�б�
	g_count++
	var_temp = %g_count%) %var_itemshow%
	GuiControl,, _MyListBox, %var_temp%
	return

;;------��Ӧ"ȷ��","ȡ��"��ť, ���ҹرմ����˳�����-------------------------
buttonȷ��:
	gui submit, hide
	ControlGetText var_temp, Edit5, %g_titleT%
	clipboard := var_temp
	sleep 200
	send ^v

buttonȡ��:
GuiClose:
ExitApp


;;------����ע�ͷ��ʱ,����Ĭ�ϵ�ʾ��˵��-----------------------------------
������Ĭ�ϵ�ע�ͷ��˵��(_note, _line, _length, _cursor, _check )
{
	var_ret=
	var_len = 25
	var_notelen := strlen( _Note )
	var_linelen := strlen( _line )

	if _check = 1
	{
		if ( _Line = "" || _Length <= var_notelen || var_linelen <= 0 )
		{
			var_ret = %_Note% ˫�� ע������
		}
		else
		{
			var_ret = %_Note%
			var_loops := var_len // var_linelen
			loop %var_loops%
			{
				var_ret = %var_ret%%_Line%
			}
			var_ret = %var_ret% [%_length%]`t%_note% ע������
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
			var_ret = %_Note% ���� ע������
		}
		else if ( var_linelen == 1 )
		{
			var_ret = %_Note%
			var_loops := _Cursor - var_notelen
			Loop %var_loops%
			{
				var_ret = %var_ret%%_Line%
			}
			var_ret = %var_ret%ע��

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
			var_ret = %var_ret%ע��

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


;;------����ע��Ԥ��--------------------------------------------------------
button����Ԥ��:
	gui submit, nohide
    g_inClickListView := false          ;; �����޸ı༭��ʱ��ʵʱ����Ԥ��
	if _CheckBox
		goto ������˫��ע�͡�
	else
		goto �����ɵ���ע�͡�

	return

�����ɵ���ע�͡�:
	var_notelen := strlen( _Note )
	var_commentLen := strlen( _Comment )
	if ( var_commentLen >= (_Length - var_notelen) )
	{
		goto ������˫��ע�͡�
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

	;; ����Ԥ����,�Զ����"ȷ��"��ť,���رմ���
	if g_previewClose
	{
		g_previewClose := false
		goto buttonȷ��
	}
	return

������˫��ע�͡�:
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

	;; ����Ԥ����,�Զ����"ȷ��"��ť,���رմ���
	if g_previewClose
	{
		g_previewClose := false
		goto buttonȷ��
	}
	return


