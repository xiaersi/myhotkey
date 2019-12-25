#include ../../
#include ./inc/inifile.aik
#include ./inc/systime.aik


change_icon()                           ;; ����ͼ��

g_Title = ϵͳʱ������
g_WINTITLE = %g_Title% ahk_class AutoHotkeyGUI
g_bTimeMod := false                      ;; �Ƿ��޸Ĺ�ϵͳʱ��
g_InitDate = %a_yyyy%%a_mm%%a_dd%
g_InitTime = %a_hour%%a_min%%a_sec%
g_InitYYYY := a_yyyy
g_InitMM   := a_mm
g_InitDD   := a_dd

g_winWidth := 358
g_winHeight := 180
g_winX		:= a_screenwidth - g_winWidth - 20
g_winY		:= a_screenheight - g_winHeight - 100



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ������ʾ

Gui, Add, Text, x6 y140 w70 h20 +Right, �������ڣ�
Gui, Add, Text, x76 y140 w80 h20 , %a_yyyy%-%a_mm%-%a_dd%
Gui, Add, Text, x166 y140 w70 h20 v_ShowTime, %a_hour%:%a_min%:%a_sec%
Gui, Add, Button, x266 y130 w70 h28 g����ԭ���ڡ�, ��ԭ����

Gui, Add, DateTime, x36 y20 w90 h20 v_SelectDate g��ѡ��ʱ�䡿,
Gui, Add, ComboBox, x136 y20 w95 h20 R10 v_HistoryDate g����ʷʱ�䡿, %g_InitDate% ;; ��ʷʱ��
;Gui, Add, Button, x316 y60 w100 h30 , ѡ������

Gui, Add, GroupBox, x6 y0 w250 h130 ,
Gui, Add, Text, x20 y52 w15 h15 , ��
Gui, Add, ComboBox, x36 y50 w60 h20 R10 v_year, 2011|2010|2009|2008|2007|2006|0225|2004|2003|2002|2001
Gui, Add, Text, x100 y50 w15 h15 , ��
Gui, Add, ComboBox, x116 y50 w45 h20 R10 v_mon, 01|02|03|04|05|06|07|08|09|10|11|12
Gui, Add, Text, x170 y50 w15 h15 , ��
Gui, Add, ComboBox, x186 y50 w45 h20 R10 v_day, 01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31
Gui, Add, Button, x266 y42 w70 h28 g���������ڡ�, ��������

Gui, Add, Text, x20 y95 w15 h15 , ʱ
Gui, Add, ComboBox, x36 y90 w60 h20 R10 v_hour, 00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23
Gui, Add, Text, x100 y95 w15 h15 , ��
Gui, Add, ComboBox, x116 y90 w45 h20  R10 v_min, 00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59
Gui, Add, Text, x170 y95 w15 h15 , ��
Gui, Add, ComboBox, x186 y90 w45 h20 R10 v_sec, 00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59
Gui, Add, Button, x266 y85 w70 h28 g������ʱ�䡿, ����ʱ��
;Gui, Add, Button, x316 y215 w100 h30 g���رհ�ť��, ��    ��
Gui, Add, CheckBox, x266 y10 w70 h20 v_SetWinTop g�������ö���, �����ö�
; Generated using SmartGUI Creator 4.0
Gui, Show, x%g_winX% y%g_winY% w%g_winWidth% h%g_winHeight%, %g_Title%

GuiControl,Text, _year,%g_InitYYYY%
GuiControl,Text, _mon,%g_InitMM%
GuiControl,Text, _day,%g_InitDD%

Control Check, , button5, %g_wintitle%  ;; ���ڳ�ʼ��ʱ���Զ�ѡ�񴰿��ö�

settimer ��������ʾʱ�䡿, 400

Return



���رհ�ť��:
GuiEscape:
GuiClose:
	if g_bTimeMod
	{
		msgbox 4, ��ԭ����, ϵͳʱ���Ѿ��޸Ĺ����Ƿ���Ҫ��ԭ�� [ %g_InitYYYY% - %g_InitMM% - %g_InitDD% ] ?
		ifMsgBox Yes
		{
			gosub ����ԭ���ڡ�
		}
	}
ExitApp


�������ö���:
	Gui submit, nohide
	if _SetWinTop
		WinSet AlwaysOnTop, On, %g_WINTITLE%
	else
		WinSet AlwaysOnTop, off, %g_WINTITLE%
	RETURN

��ѡ��ʱ�䡿:
	Gui submit, nohide
	if _SelectDate is time
	{
		StringLeft, var_yyyy, _SelectDate, 4    ; YYYY (year)
		StringMid, var_mm, _SelectDate, 5, 2  ; MM (month of year, 1-12)
		StringMid, var_dd, _SelectDate, 7, 2  ; DD (day of month)
		GuiControl,Text, _year,%var_yyyy%
		GuiControl,Text, _mon,%var_mm%
		GuiControl,Text, _day,%var_dd%
	}
	Return

����ʷʱ�䡿:
	Gui submit, nohide
	if _HistoryDate is time
	{
		StringLeft, var_yyyy, _HistoryDate, 4    ; YYYY (year)
		StringMid, var_mm, _HistoryDate, 5, 2  ; MM (month of year, 1-12)
		StringMid, var_dd, _HistoryDate, 7, 2  ; DD (day of month)
		GuiControl,Text, _year,%var_yyyy%
		GuiControl,Text, _mon,%var_mm%
		GuiControl,Text, _day,%var_dd%
	}
	Return


����ԭ���ڡ�:
	SetSysDate( g_InitYYYY, g_InitMM, g_InitDD )
	g_bTimeMod := false
	Return

���������ڡ�:
	Gui submit, nohide
	if ( _year == "" && _mon == "" && _day == "" )
	{
		msgbox ��ѡ��Ҫ���õ�����!
		return
	}
	if _year =
		_year 	:= a_yyyy
	if _mon =
		_mon 	:= a_mm
	if _day =
		_day 	:= a_dd

	if ( SetSysDate( _year, _mon, _day ) )
	{
		g_bTimeMod := true
		var_temp = �ɹ�����ϵͳ����[ %_year% - %_mon% - %_day% ]
		tooltip7( var_temp, 800 )
		GuiControl, Text, _year, %_year%
		GuiControl, Text, _mon, %_mon%
		GuiControl, Text, _day, %_day%
		var_temp = %_year%%_mon%%_day%

		ControlGet, var_DateList, List, , ComboBox1    ; �������ListBox, windows spy ���Ŀؼ�����Ϊ Edit1
		Loop, Parse, var_DateList, `n
		{
			if ( var_temp == a_LoopField )
			{
				return ;; ������õ�ϵͳ�����Ѿ�����ʷ�����д��ڣ��������
			}
		}
		;; �����δ��ӵ���ʷ�����У������֮
		GuiControl, , _HistoryDate, %var_temp%
	}
	else
	{
		msgbox ����ϵͳ���� [ %_year% - %_mon% - %_day% ] ʧ�ܣ�
	}
	Return

������ʱ�䡿:
	Gui submit, nohide
	if _hour <>
	{
		if _min =
			_min := a_min
		if _sec =
			_sec := a_sec
		if ( SetSysTime( _hour, _min, _sec ) )
		{
			GuiControl,Text, _min,%_min%
			GuiControl,Text, _sec,%_sec%
			var_temp = �ɹ�����ϵͳʱ��[ %_hour% : %_min% : %_sec% ]
			tooltip7( var_temp, 800 )
		}
		else
			msgbox ����ϵͳʱ��( %_hour% : %_min% : %_sec% )ʧ�ܣ�
	}
	else
		msgbox ��ѡ��Сʱ��

	Return

��������ʾʱ�䡿:
	GuiControl Text, _ShowTime, %a_hour%:%a_min%:%a_sec%
	Return


#include ./inc/tip.aik