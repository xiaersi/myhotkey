#include ..\..\
#include .\inc\string.aik

∑我的输入窗口( var_text, var_strList="")
{
    GLOBAL g_bMyInputBox := -1          ;; 玩家是否按了[确定] 或 [取消] 按钮退出
    GLOBAL g_sMyInputbox = 
    GLOBAL g_bMyInputBoxAuto := true

    nMaxLen = 0
    nRowCount = 0
    LOOP parse, var_text, `n
    {
    	nRowCount ++
    	nTemp := strlen( var_text )
    	if ( nTemp > nMaxLen )
    		nMaxLen := nTemp
    }
    ;; 小窗口显示
   	if ( nRowCount <= 2 && nMaxLen < 55 )
   	{
   		Gui, 7:Add, Text, x6 y10 w310 h30 , %var_text%
		Gui, 7:Add, ComboBox, x11 y50 w310 h25 R20 vg_sMyInputbox g【我的输入窗口_输入框】, %var_strList%
		Gui, 7:Add, Button, x56 y95 w80 h30 default  g【我的输入窗口_确定按钮】, 确定(&Y)
		Gui, 7:Add, Button, x196 y95 w80 h30  g【我的输入窗口_取消按钮】, 取消(&N)
		Gui, 7:Add, GroupBox, x1 y35 w330 h45 , 
		; Generated using SmartGui Creator 4.0
		Gui, 7:Show, h138 w333, 我的输入窗口
   	}
   	else	;; 大窗口显示
   	{

   		∑将回车符统一成Windows风格(var_text)
		Gui, 7:Add, ComboBox, x11 y15 w450 h25 R20 vg_sMyInputbox g【我的输入窗口_输入框】, %var_strList%
		Gui, 7:Add, Button, x96 y60 w80 h30 default  g【我的输入窗口_确定按钮】, 确定(&Y)
		Gui, 7:Add, Button, x276 y60 w80 h30 g【我的输入窗口_取消按钮】, 取消(&N)
		Gui, 7:Add, GroupBox, x5 y0 w465 h45, 
		Gui, 7:Add, Edit, x11 y100 w450 h70 ReadOnly, %var_text%
		; Generated using SmartGui Creator 4.0
		Gui, 7:Show, h184 w479, 我的输入窗口   		
   	}
	
	LOOP 
	{
		if g_bMyInputBox >= 0
			BREAK
		Sleep 250
	}
	RETURN g_sMyInputbox
	
【我的输入窗口_输入框】:
	ControlGetText var_temp, Edit1, 我的输入窗口 ahk_class AutoHotkeyGUI
	if (var_preMyinput == var_temp)
	{
		RETURN
	}
	if not g_bMyInputBoxAuto 
	{
		g_bMyInputBoxAuto := true
		RETURN
	}
	var_preMyinput := var_temp
	findList =
	if var_temp <>
	{
		LOOP parse, var_strList, |
		{
			if a_LOOPField <>
			{
				IfInString a_LOOPField, %var_temp%
				{
					StrListAdd( findList, a_LOOPField, "|" )
				}
			}
		}
	}
	Control HideDropDown, , ComboBox1, 我的输入窗口 ahk_class AutoHotkeyGUI
	GuiControl,,g_sMyInputbox, |
	if findList <>
	{	
		GuiControl,,g_sMyInputbox, %findList%
		Control ShowDropDown, , ComboBox1, 我的输入窗口 ahk_class AutoHotkeyGUI
	;	ControlFocus,  Edit1, 我的输入窗口 ahk_class AutoHotkeyGUI
	}
	else
	{
		GuiControl,,g_sMyInputbox, %var_strList%
	}
	GuiControl, Text, g_sMyInputbox, %var_temp%
	send {end}
	RETURN	
	
【我的输入窗口_确定按钮】:
	Gui, submit, nohide
	g_bMyInputBox := 1
	Gui, 7:destroy
	RETURN 
		
【我的输入窗口_取消按钮】:
7:GuiClose:
	g_bMyInputBox := 0
	g_sMyInputbox = 
	Gui, 7:destroy
	RETURN 
}

#IfWinActive 我的输入窗口 ahk_class AutoHotkeyGUI
~up::	
~down::
	g_bMyInputBoxAuto := false
	RETURN
	
#IfWinActive 

