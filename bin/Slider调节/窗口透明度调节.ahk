change_icon()                           ;; 修改图标

g_title = 窗口透明度调节工具
g_wintitle = %g_title% ahk_class AutoHotkeyGUI
g_min := 0
g_default := 0
g_max := 255
g_text = 透明度
g_checkbox = 透明&A
g_bChecked := false

WinGetActiveTitle, g_ATitle
g_default := GetWinAlpha(  g_ATitle )
if g_default < 255
{
	g_bChecked := True
}

Hotkey, IfWinActive, %g_wintitle%
Hotkey, 1, 【设置透明度1】
Hotkey, 2, 【设置透明度2】
Hotkey, 3, 【设置透明度3】
Hotkey, 4, 【设置透明度4】
Hotkey, 0, 【设置透明度0】
Hotkey, r, 【设置透明度0】


#include ../../
#Include ./bin/Slider调节/GuiSlider.aik
#include .\inc\window.aik
#include .\inc\common.aik
#include ./inc/string.aik
#include ./inc/tip.aik


【我的功能处理】:
	if ( _checkbox = 0 and _MySlider = 255 )
	{
		Return                                  ;; 如果当前所选不透明，且实际值为255也不透明，则无需再设置窗口的透明度
	}

	WinSet, Transparent,  %_MySlider%,  %g_ATitle%
	if _MySlider = 255
		GuiControl, , _checkbox, 0
	Else
		GuiControl, , _checkbox, 1
	Return

【我的CheckBox处理】:
	if _checkbox
	{
		if _MySlider = 255
			Goto 【设置透明度2】
		WinSet, Transparent,  %_MySlider%,  %g_ATitle%
	}
	else
		WinSet, Transparent,  off,  %g_ATitle%
	Return

【设置透明度1】:
	;WinSet, Transparent,  210,  %g_ATitle%
	GuiControl Text, _MySlider, 210
	GuiControl, , _checkbox, 1
	Return


【设置透明度2】:
	;WinSet, Transparent,  160,  %g_ATitle%
	GuiControl Text, _MySlider, 160
	GuiControl, , _checkbox, 1
	Return


【设置透明度3】:
	;WinSet, Transparent,  110,  %g_ATitle%
	GuiControl Text, _MySlider, 110
	GuiControl, , _checkbox, 1
	Return


【设置透明度4】:
	WinSet, Transparent,  60,  %g_ATitle%
	GuiControl, , _checkbox, 1
	Return


【设置透明度0】:
	WinSet, Transparent,  off,  %g_ATitle%
	GuiControl, , _checkbox, 0
	Return


