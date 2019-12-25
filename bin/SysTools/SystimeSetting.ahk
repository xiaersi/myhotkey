#include ../../
#include ./inc/inifile.aik
#include ./inc/systime.aik


change_icon()                           ;; 设置图标

g_Title = 系统时间设置
g_WINTITLE = %g_Title% ahk_class AutoHotkeyGUI
g_bTimeMod := false                      ;; 是否修改过系统时间
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
;; 窗口显示

Gui, Add, Text, x6 y140 w70 h20 +Right, 启动日期：
Gui, Add, Text, x76 y140 w80 h20 , %a_yyyy%-%a_mm%-%a_dd%
Gui, Add, Text, x166 y140 w70 h20 v_ShowTime, %a_hour%:%a_min%:%a_sec%
Gui, Add, Button, x266 y130 w70 h28 g【还原日期】, 还原日期

Gui, Add, DateTime, x36 y20 w90 h20 v_SelectDate g【选择时间】,
Gui, Add, ComboBox, x136 y20 w95 h20 R10 v_HistoryDate g【历史时间】, %g_InitDate% ;; 历史时间
;Gui, Add, Button, x316 y60 w100 h30 , 选择日期

Gui, Add, GroupBox, x6 y0 w250 h130 ,
Gui, Add, Text, x20 y52 w15 h15 , 年
Gui, Add, ComboBox, x36 y50 w60 h20 R10 v_year, 2011|2010|2009|2008|2007|2006|0225|2004|2003|2002|2001
Gui, Add, Text, x100 y50 w15 h15 , 月
Gui, Add, ComboBox, x116 y50 w45 h20 R10 v_mon, 01|02|03|04|05|06|07|08|09|10|11|12
Gui, Add, Text, x170 y50 w15 h15 , 日
Gui, Add, ComboBox, x186 y50 w45 h20 R10 v_day, 01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31
Gui, Add, Button, x266 y42 w70 h28 g【设置日期】, 设置日期

Gui, Add, Text, x20 y95 w15 h15 , 时
Gui, Add, ComboBox, x36 y90 w60 h20 R10 v_hour, 00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23
Gui, Add, Text, x100 y95 w15 h15 , 分
Gui, Add, ComboBox, x116 y90 w45 h20  R10 v_min, 00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59
Gui, Add, Text, x170 y95 w15 h15 , 秒
Gui, Add, ComboBox, x186 y90 w45 h20 R10 v_sec, 00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59
Gui, Add, Button, x266 y85 w70 h28 g【设置时间】, 设置时间
;Gui, Add, Button, x316 y215 w100 h30 g【关闭按钮】, 退    出
Gui, Add, CheckBox, x266 y10 w70 h20 v_SetWinTop g【窗口置顶】, 窗口置顶
; Generated using SmartGUI Creator 4.0
Gui, Show, x%g_winX% y%g_winY% w%g_winWidth% h%g_winHeight%, %g_Title%

GuiControl,Text, _year,%g_InitYYYY%
GuiControl,Text, _mon,%g_InitMM%
GuiControl,Text, _day,%g_InitDD%

Control Check, , button5, %g_wintitle%  ;; 窗口初始化时，自动选择窗口置顶

settimer 【更新显示时间】, 400

Return



【关闭按钮】:
GuiEscape:
GuiClose:
	if g_bTimeMod
	{
		msgbox 4, 还原日期, 系统时间已经修改过，是否需要还原回 [ %g_InitYYYY% - %g_InitMM% - %g_InitDD% ] ?
		ifMsgBox Yes
		{
			gosub 【还原日期】
		}
	}
ExitApp


【窗口置顶】:
	Gui submit, nohide
	if _SetWinTop
		WinSet AlwaysOnTop, On, %g_WINTITLE%
	else
		WinSet AlwaysOnTop, off, %g_WINTITLE%
	RETURN

【选择时间】:
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

【历史时间】:
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


【还原日期】:
	SetSysDate( g_InitYYYY, g_InitMM, g_InitDD )
	g_bTimeMod := false
	Return

【设置日期】:
	Gui submit, nohide
	if ( _year == "" && _mon == "" && _day == "" )
	{
		msgbox 请选择要设置的日期!
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
		var_temp = 成功设置系统日期[ %_year% - %_mon% - %_day% ]
		tooltip7( var_temp, 800 )
		GuiControl, Text, _year, %_year%
		GuiControl, Text, _mon, %_mon%
		GuiControl, Text, _day, %_day%
		var_temp = %_year%%_mon%%_day%

		ControlGet, var_DateList, List, , ComboBox1    ; 获得整个ListBox, windows spy 检测的控件名称为 Edit1
		Loop, Parse, var_DateList, `n
		{
			if ( var_temp == a_LoopField )
			{
				return ;; 如果设置的系统日期已经在历史日期中存在，则不再添加
			}
		}
		;; 如果尚未添加到历史日期中，则添加之
		GuiControl, , _HistoryDate, %var_temp%
	}
	else
	{
		msgbox 设置系统日期 [ %_year% - %_mon% - %_day% ] 失败！
	}
	Return

【设置时间】:
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
			var_temp = 成功设置系统时间[ %_hour% : %_min% : %_sec% ]
			tooltip7( var_temp, 800 )
		}
		else
			msgbox 设置系统时间( %_hour% : %_min% : %_sec% )失败！
	}
	else
		msgbox 请选择小时！

	Return

【更新显示时间】:
	GuiControl Text, _ShowTime, %a_hour%:%a_min%:%a_sec%
	Return


#include ./inc/tip.aik