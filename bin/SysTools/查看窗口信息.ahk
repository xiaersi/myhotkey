#NoTrayIcon
#include ../../
change_Icon()

g_title = AHK ������Ϣ����

Gui, Add, GroupBox, x2 y2 w200 h60 , ������Ϣ
Gui, Add, Text, x5 y19 w32 h14 , ����:
Gui, Add, Edit, x38 y17 w159 h18 ved1,
Gui, Add, Text, x5 y39 w32 h14 , ��:
Gui, Add, Edit, x38 y37 w159 h18 ved2,
Gui, Add, GroupBox, x2 y62 w200 h78 , ���ָ������Ϣ
Gui, Add, Text, x7 y80 w45 h14 , �����:
Gui, Add, Edit, x51 y78 w146 h17 ved3,
Gui, Add, Text, x6 y98 w45 h14 , �ı�:
Gui, Add, Edit, x51 y97 w146 h17 ved4,
Gui, Add, Text, x6 y117 w44 h15 , ��ɫ:
Gui, Add, Edit, x51 y116 w146 h17 ved5,
Gui, Add, GroupBox, x2 y140 w200 h57 , �������( X Y)
Gui, Add, Text, x9 y158 w55 h15 , ������Ļ:
Gui, Add, Edit, x74 y156 w123 h18 ved6,
Gui, Add, Text, x9 y177 w67 h15 , �������:
Gui, Add, Edit, x74 y176 w123 h18 ved7,
Gui, Add, GroupBox, x2 y197 w200 h57 , λ��[���x,����y,���w,�߶�h]
Gui, Add, Text, x7 y214 w78 h15 , �����:
Gui, Add, Edit, x85 y212 w113 h18 ved8,
Gui, Add, Text, x7 y233 w78 h15 , ����¿ؼ�:
Gui, Add, Edit, x85 y231 w113 h18 ved9,
Gui, Add, GroupBox, x2 y254 w200 h110 , �����ı�[���������ı�]
Gui, Add, Edit, x4 y267 w195 h93 ved10,
Gui, Add, Text, x7 y367 w198 h25 c0339E5 gUkl,�ȼ�:Ctrl+Win / �м� (by���곯ϼ)
OnMessage(0x202,"WM_LBUTTONUP")
; Generated using SmartGUI Creator 4.0
Gui,+AlwaysOnTop
Gui, Show, x0 y28 h393 w205, %g_title%
Return

ukl:
run,tencent://message/?uin=458926486&Site=knmb.cn&Menu=yes
Return
~MButton::
	Goto winpos
	Return

~^LWin::
	Goto winpos
	Return


~^rWin::
	Goto winpos
	Return

winpos:
	CoordMode,mouse,Screen ;��������ģʽΪȫ��
	DetectHiddenText, On ;̽�����ص��ı�
	MouseGetPos,sx,sy,win,class ;ȡ�������Ϣ
	;ȡ����
	WinGetTitle,title,ahk_id %win%
	GuiControl,,ed1,%title%
	;������
	WinGetClass,winclass,ahk_id %win%
	GuiControl,,ed2,ahk_class %winclass%
	if class <>
	{
		;�ؼ������
	GuiControl,,ed3,%class%
	;�ؼ��ı�
	ControlGetText,text,%class%,ahk_id %win%
	GuiControl,,ed4,%text%
	;�ؼ���С
	ControlGetPos,ctrlx,ctrly,ctrlw,ctrlh,%class%,ahk_id %win%
	GuiControl,,ed9,%ctrlx%,%ctrly%,%ctrlw%,%ctrlh%
	}
	Else
	{
	;�ÿ�
	GuiControl,,ed3,
	GuiControl,,ed4,
	GuiControl,,ed9,
	}
	;��ɫ
	PixelGetColor,mousecolor,%sx%,%sy%,RGB
	SplitRGB( mousecolor, red, green, blue )
	mousecolor = %mousecolor% (%red%,%green%,%blue%)
	GuiControl,,ed5,%mousecolor%
	;ȫ������
	GuiControl,,ed6,%sx%,%sy%
	;��ǰ������ڵ��������
	CoordMode,mouse,relative ;������ģʽΪ��ǰ����
	MouseGetPos,wx,wy
	GuiControl,,ed7,%wx%,%wy%
	;��ǰ���ڴ�С
	WinGetPos,winx,winy,winw,winh,A
	GuiControl,,ed8,%winx%,%winy%,%winw%,%winh%
	;�����ı�,
	WinGetText,wintext,ahk_id %win%
	GuiControl,,ed10,%wintext%
	Return

GuiClose:
	ExitApp

WM_LBUTTONUP(wParam,lParam,uMsg,hWnd)
{
	
	if A_GuiControl in ed1,ed2,ed3,ed4,ed5,ed6,ed7,ed8,ed9
	{
		GuiControlGet,EditText,,%A_GuiControl%
		if (EditText!=""){
			Clipboard=%EditText%
			ToolTip,�Ѹ���:	%EditText%
			SetTimer,RemoveToolTip,1000
		}
		
	}
	
}

RemoveToolTip:
{
	SetTimer, RemoveToolTip, off
	ToolTip
	return
}

#include ./inc/common.aik
