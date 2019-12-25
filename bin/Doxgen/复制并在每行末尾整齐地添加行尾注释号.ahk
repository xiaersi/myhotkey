#NoTrayIcon
#include ../../
#include .\inc\string.aik
#include .\inc\inifile.aik

AutoTrim, Off


;; ����ͼ��
change_icon( )

g_text =
g_param = %1%
StringSplit paramArray, g_param, |
if paramArray0 > 1
{
	g_comment 	:= paramArray1
	g_test		:= paramArra2
}
else
{
	if paramArray0 = 1
		g_comment 	:= paramArray1
}

if g_comment =
	g_comment := read_ini( "temp.ini", "���Ʋ���ÿ��ĩβ����������βע�ͷ�", "lastComment", "/**<  */" )

;; �����������ѡ�е��ı����ݣ�����֮
if g_text =
{
	g_oldclip := clipboardall
	clipboard =
	sleep 20
	send ^c
	sleep 100
	g_text = %clipboard%
	clipboard := g_oldclip
	if clipboard =
	{
		tooltip û��ѡ��Ҫע�͵�����
		clipboard := g_oldclip
		sleep 800
		tooltip
		exitapp
	}

}

g_defaultOff := 40
g_tablen := 4
g_minlen := 4	 ; ��βע������Ҫ��һ��Tab
g_lineArr =
g_lineCount := 0
g_space = ``
g_tab = ````````
g_help =
(
����˵����`r
	�ڼ������е��ı����ݵ�ÿһ�к��棬��������ָ���ַ�����ע�ͷ��š�`r
	`r
ʹ��˵����`r
	1��ѡ��Ҫ������ı����ݡ�`r
	2��ͨ����ݼ������磺//e�� `;`;e�� AppsKey+/ --> 1 ) �򿪱�����`r
	3�������ڻ��Զ�����ѡ�е����ݣ���ʾ��Ԥ�����ڡ�`r
	4������������ѡ����Ҫĩβ��ӵķ��ţ�Ҳ����ֱ�����룩��`r
	5������ˢ�¡���ťԤ��Ч������ʵ���ð������������ѡ��ĩβ����ʱ���Զ�ˢ�£���`r
	6����Ԥ��Ч������ʱ������ȷ������ť����Ԥ�����ݷ��͵�ԭ�����ƵĴ��ڣ��滻��ԭ�������ݡ�`r
`r
��ݼ�˵����`r
    F1	-> ������������`r
    F2	-> ������������`r
    F3	-> ������Ĭ������ֵ��`r
    F4	->  �л�ע�ͷ���`r
    F5	-> ��ˢ�°�ť��`r
    F6	->  չ���ͷ���������`r
    F7	->  �����ͷ���������`r
    ESC	->  �˳�����
)


g_commentList = //|///<|/**<  */|`;`;|--

var_clip := g_text

; ���������е�Tab�ÿո��滻�������з�ͳһ��`n
stringreplace var_clip, var_clip, ``, \~, All
StringReplaceAll(var_clip, "`t", g_tab )
;stringreplace var_clip, var_oldclip, `t, %var_tab%, All
stringreplace var_clip, var_clip, `r`n, `n, All
stringreplace var_clip, var_clip, `r, `n, All

; ���зֽ���������ݣ�ÿ�б��浽g_lineArr������
loop parse, var_clip, `n
{
	var_loopfield := a_loopfield
	StrTrimRight( var_loopfield )
	if var_loopfield <>
	{
		g_lineCount ++
		var_len := strlen( var_loopfield )
		if ( var_len > g_minlen )
			g_minlen := var_len
		g_lineArr%g_lineCount% := var_loopfield
	}
}

if g_lineCount <= 0
{
	tooltip ѡ��Ҫע�͵�����Ϊ��
	sleep 800
	tooltip
	exitapp
}

; �������ڣ�������βע�ͺ���λ��
g_curoff := read_ini("temp.ini", "���Ʋ���ÿ��ĩβ����������βע�ͷ�", "LastOffset", g_minlen )

if (g_curoff < g_defaultOff )
	g_curoff := g_defaultOff
else
	�ƽ����ֵ�������С����һ�����ֵ�������( g_curoff, g_tablen )

g_title = ���Ʋ���ÿ��ĩβ����������βע��
g_wintitle = ���Ʋ���ÿ��ĩβ����������βע�� ahk_class AutoHotkeyGUI

g_output =

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��ʾ����

Gui, Add, Text, x16 y21 h20 , ����������
Gui, Add, ComboBox, x296 y16 w70 h20 +Center vg_curoff R8 g����ǰ����ֵ��, 16|28|40|60|80

Gui, Add, Edit, x80 y16 w30 h20  +Center +ReadOnly , %g_minlen%

Gui, Add, Button, x210 y16 w40 h20 g������Ĭ������ֵ��, Ĭ��
Gui, Add, Button, x256 y16 w40 h20 g������������, <&<
Gui, Add, Button, x366 y16 w40 h20 g������������, >&>
Gui, Add, Button, x410 y16 w40 h20 g��ˢ�°�ť��, ˢ��

Gui, Add, Edit, x6 y51 w790 h320 +ReadOnly vg_output, Ԥ��
Gui, Add, ComboBox, x465 y16 w70 h20 R5 vg_comment g��ע�ͷ��ſ�, %g_commentList%

Gui, Add, Text, x120 y21 h20 , Ĭ��ֵ
Gui, Add, Edit, x160 y16 w30 h20  +Center +ReadOnly , %g_defaultOff%

Gui, Add, Button, x550 y11 w80 h30 default g��ȷ����ť��, ȷ��(&Y)
Gui, Add, Button, x635 y11 w80 h30 g��ȡ����ť��, ȡ��(&N)
Gui, Add, Button, x720 y11 w70 h30 g��������ť��, ����(&H)

; Generated using SmartGUI Creator 4.0
Gui, Show, center h377 w800 , %g_title%

ControlSetText Edit4, %g_comment%, %g_wintitle%	; ����ע�ͷ��ſ�Ĭ��ֵ
ControlSetText Edit1, %g_curoff%, %g_wintitle%	; �����������Ĭ��ֵ

goto ������g_lineArr������ʾ��Ϣ��
Return

����ǰ����ֵ��:
	goto ������g_lineArr������ʾ��Ϣ��
	return
��ע�ͷ��ſ�:
	goto ������g_lineArr������ʾ��Ϣ��
	return

������Ĭ������ֵ��:
	if ( g_defaultOff >= g_minlen )
	{
		g_curoff := g_defaultOff
	}
	else
	{
		g_curoff := g_minlen
		�ƽ����ֵ�������С����һ�����ֵ�������( g_curoff, g_tablen )
	}
	controlsettext Edit1, %g_curoff%, %g_wintitle%
	goto ������g_lineArr������ʾ��Ϣ��
	return

������������:
	if ( g_curoff > ( g_minlen + g_tablen ) )
	{
		g_curoff -= g_tablen
		controlsettext Edit1, %g_curoff%, %g_wintitle%
		goto ������g_lineArr������ʾ��Ϣ��
	}
	return

������������:
	g_curoff += g_tablen
	controlsettext Edit1, %g_curoff%, %g_wintitle%
	goto ������g_lineArr������ʾ��Ϣ��
	return

��ˢ�°�ť��:
	goto ������g_lineArr������ʾ��Ϣ��
	return


��ȷ����ť��:
	ControlGetText var_comment, Edit4, %g_wintitle%
	ControlGetText var_lastoff, Edit1, %g_wintitle%
	Gui, Submit, hide
	stringreplace clipboard, g_output, %g_space%, %a_space%, All
	stringreplace clipboard, clipboard, `r`n, `n, All
	stringreplace clipboard, clipboard, `r, `n, All
	stringreplace clipboard, clipboard, `n, `r`n, All
	stringreplace clipboard, clipboard, \~,``, All
	tooltip ���Ƶ�������`n%clipboard%
	sleep 300
	send ^v
	clipboard := g_oldclip

	write_ini( "temp.ini", "���Ʋ���ÿ��ĩβ����������βע�ͷ�", "lastComment",  var_comment )
	write_ini( "temp.ini", "���Ʋ���ÿ��ĩβ����������βע�ͷ�", "LastOffset",   var_lastoff )

��ȡ����ť��:
GuiClose:
ExitApp


��������ť��:
	controlsettext Edit3, %g_help%, %g_wintitle%
	return

������g_lineArr������ʾ��Ϣ��:
	Gui, Submit, nohide
	g_output =

	loop %g_lineCount%
	{
		var_line := g_lineArr%a_index%
		var_len := strlen( var_line  )
		if ( var_len > 0 )
		{
			if ( var_len > g_curoff )
			{
				g_curoff := var_len
				�ƽ����ֵ�������С����һ�����ֵ�������( g_curoff, g_tablen )
				controlsettext edit1, %g_curoff%, %g_wintitle%
			}
			if ( var_len < g_curoff )
			{
				var_loopnum := g_curoff - var_len


				loop %var_loopnum%
				{
				;	AddString( var_line, " ", false )
					var_line = %var_line%%g_space%
				}
			}
			var_line = %var_line%%g_comment%%g_space%
			g_output = %g_output%`r`n%var_line%
		}
	}
	stringleft var_temp, g_output, 2
	if ( var_temp == "`r`n" )
	{
		stringmid g_output, g_output, 3
	}
	controlsettext Edit3, %g_output%, %g_wintitle%
	return


�ƽ����ֵ�������С����һ�����ֵ�������( byref num, len )
{
	var_temp := num // len
	var_temp *= len
	if ( var_temp < num )
		num := var_temp + 4
	else
		num := var_temp
}


#IfWinActive ���Ʋ���ÿ��ĩβ����������βע�� ahk_class AutoHotkeyGUI
F1::
	goto ������������
	return

F2::
	goto ������������
	return

F3::
	goto ������Ĭ������ֵ��
	return


F4::
	;; �õ���ע�ͷ��ſ� ComboBox �������б������
	CB_GETCOUNT:=326 ;0x0146
	SendMessage, CB_GETCOUNT, 0, 0, ComboBox2
	nRowCount:=ErrorLevel

	nNextRow++
	if (nNextRow > nRowCount )
		nNextRow = 1

	;; ѡ�������б�ĵ� nNextRow ��
;	GuiControl, Choose, g_comment, %nNextRow%
	Control, Choose, %nNextRow%, ComboBox2
	goto ��ˢ�°�ť��
	return

F5::
	goto ��ˢ�°�ť��
	return

F6::
	if g_ShowDropDown
	{
		Control HideDropDown, , ComboBox2
		g_ShowDropDown := false
	}
	else
	{
		Control ShowDropDown, , ComboBox2
		g_ShowDropDown := true
	}
	return

esc::
	exitapp
#ifWinActive


