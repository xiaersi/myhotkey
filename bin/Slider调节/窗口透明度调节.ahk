change_icon()                           ;; �޸�ͼ��

g_title = ����͸���ȵ��ڹ���
g_wintitle = %g_title% ahk_class AutoHotkeyGUI
g_min := 0
g_default := 0
g_max := 255
g_text = ͸����
g_checkbox = ͸��&A
g_bChecked := false

WinGetActiveTitle, g_ATitle
g_default := GetWinAlpha(  g_ATitle )
if g_default < 255
{
	g_bChecked := True
}

Hotkey, IfWinActive, %g_wintitle%
Hotkey, 1, ������͸����1��
Hotkey, 2, ������͸����2��
Hotkey, 3, ������͸����3��
Hotkey, 4, ������͸����4��
Hotkey, 0, ������͸����0��
Hotkey, r, ������͸����0��


#include ../../
#Include ./bin/Slider����/GuiSlider.aik
#include .\inc\window.aik
#include .\inc\common.aik
#include ./inc/string.aik
#include ./inc/tip.aik


���ҵĹ��ܴ���:
	if ( _checkbox = 0 and _MySlider = 255 )
	{
		Return                                  ;; �����ǰ��ѡ��͸������ʵ��ֵΪ255Ҳ��͸���������������ô��ڵ�͸����
	}

	WinSet, Transparent,  %_MySlider%,  %g_ATitle%
	if _MySlider = 255
		GuiControl, , _checkbox, 0
	Else
		GuiControl, , _checkbox, 1
	Return

���ҵ�CheckBox����:
	if _checkbox
	{
		if _MySlider = 255
			Goto ������͸����2��
		WinSet, Transparent,  %_MySlider%,  %g_ATitle%
	}
	else
		WinSet, Transparent,  off,  %g_ATitle%
	Return

������͸����1��:
	;WinSet, Transparent,  210,  %g_ATitle%
	GuiControl Text, _MySlider, 210
	GuiControl, , _checkbox, 1
	Return


������͸����2��:
	;WinSet, Transparent,  160,  %g_ATitle%
	GuiControl Text, _MySlider, 160
	GuiControl, , _checkbox, 1
	Return


������͸����3��:
	;WinSet, Transparent,  110,  %g_ATitle%
	GuiControl Text, _MySlider, 110
	GuiControl, , _checkbox, 1
	Return


������͸����4��:
	WinSet, Transparent,  60,  %g_ATitle%
	GuiControl, , _checkbox, 1
	Return


������͸����0��:
	WinSet, Transparent,  off,  %g_ATitle%
	GuiControl, , _checkbox, 0
	Return


