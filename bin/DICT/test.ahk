#include ..\..\
#include .\inc\string.aik

���ҵ����봰��( var_text, var_strList="")
{
    GLOBAL g_bMyInputBox := -1          ;; ����Ƿ���[ȷ��] �� [ȡ��] ��ť�˳�
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
    ;; С������ʾ
   	if ( nRowCount <= 2 && nMaxLen < 55 )
   	{
   		Gui, 7:Add, Text, x6 y10 w310 h30 , %var_text%
		Gui, 7:Add, ComboBox, x11 y50 w310 h25 R20 vg_sMyInputbox g���ҵ����봰��_�����, %var_strList%
		Gui, 7:Add, Button, x56 y95 w80 h30 default  g���ҵ����봰��_ȷ����ť��, ȷ��(&Y)
		Gui, 7:Add, Button, x196 y95 w80 h30  g���ҵ����봰��_ȡ����ť��, ȡ��(&N)
		Gui, 7:Add, GroupBox, x1 y35 w330 h45 , 
		; Generated using SmartGui Creator 4.0
		Gui, 7:Show, h138 w333, �ҵ����봰��
   	}
   	else	;; �󴰿���ʾ
   	{

   		�ƽ��س���ͳһ��Windows���(var_text)
		Gui, 7:Add, ComboBox, x11 y15 w450 h25 R20 vg_sMyInputbox g���ҵ����봰��_�����, %var_strList%
		Gui, 7:Add, Button, x96 y60 w80 h30 default  g���ҵ����봰��_ȷ����ť��, ȷ��(&Y)
		Gui, 7:Add, Button, x276 y60 w80 h30 g���ҵ����봰��_ȡ����ť��, ȡ��(&N)
		Gui, 7:Add, GroupBox, x5 y0 w465 h45, 
		Gui, 7:Add, Edit, x11 y100 w450 h70 ReadOnly, %var_text%
		; Generated using SmartGui Creator 4.0
		Gui, 7:Show, h184 w479, �ҵ����봰��   		
   	}
	
	LOOP 
	{
		if g_bMyInputBox >= 0
			BREAK
		Sleep 250
	}
	RETURN g_sMyInputbox
	
���ҵ����봰��_�����:
	ControlGetText var_temp, Edit1, �ҵ����봰�� ahk_class AutoHotkeyGUI
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
	Control HideDropDown, , ComboBox1, �ҵ����봰�� ahk_class AutoHotkeyGUI
	GuiControl,,g_sMyInputbox, |
	if findList <>
	{	
		GuiControl,,g_sMyInputbox, %findList%
		Control ShowDropDown, , ComboBox1, �ҵ����봰�� ahk_class AutoHotkeyGUI
	;	ControlFocus,  Edit1, �ҵ����봰�� ahk_class AutoHotkeyGUI
	}
	else
	{
		GuiControl,,g_sMyInputbox, %var_strList%
	}
	GuiControl, Text, g_sMyInputbox, %var_temp%
	send {end}
	RETURN	
	
���ҵ����봰��_ȷ����ť��:
	Gui, submit, nohide
	g_bMyInputBox := 1
	Gui, 7:destroy
	RETURN 
		
���ҵ����봰��_ȡ����ť��:
7:GuiClose:
	g_bMyInputBox := 0
	g_sMyInputbox = 
	Gui, 7:destroy
	RETURN 
}

#IfWinActive �ҵ����봰�� ahk_class AutoHotkeyGUI
~up::	
~down::
	g_bMyInputBoxAuto := false
	RETURN
	
#IfWinActive 

