#Persistent
#SingleInstance force
CoordMode, Mouse, Screen
SetBatchLines, -1
SetMouseDelay -1
��ɫ��=FF0000,FF4000,FF8000,FFC000,FFFF00,C0FF00,80FF00,00FF00,00FF80,00FFFF,00C0FF,0080FF,0040FF,0000FF,4000FF,8000FF,C000FF,FF00FF,FF00C0,FF0080,FFFFFF,CCCCCC,999999,666666,333333,010101
��ɫ=0x0000FF	;0xBBGGRR
�ʿ�=4
Menu, Tray, Icon, Shell32.dll, 142, 1

;��ˢ��
Gui,1: +AlwaysOnTop +Owner -Caption
Gui,1: Show, x0 y0 w%A_ScreenWidth% h-%A_ScreenHeight% NA, AHK��Ļ����1
WinSet, Transparent, 1, AHK��Ļ����1
Gui,1: Show, x0 y0 h%A_ScreenHeight% w%A_ScreenWidth% NA, AHK��Ļ����1

;����
hdc_screen:=DllCall("GetDC", "uint", 0)
hdc_buffer:=DllCall("CreateCompatibleDC", "uint", hdc_screen)
hbm_buffer:=DllCall("CreateCompatibleBitmap", "uint", hdc_screen, "int", A_ScreenWidth, "int", A_ScreenHeight)
DllCall("SelectObject", "uint", hdc_buffer, "uint", hbm_buffer)
DllCall("BitBlt", "uint", hdc_buffer, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_screen, "int", 0, "int", 0, "uint", 0x00CC0020)
hdc_buffer2:=DllCall("CreateCompatibleDC", "uint", hdc_screen)
hbm_buffer2:=DllCall("CreateCompatibleBitmap", "uint", hdc_screen, "int", A_ScreenWidth, "int", A_ScreenHeight)
DllCall("SelectObject", "uint", hdc_buffer2, "uint", hbm_buffer2)
;DllCall("BitBlt", "uint", hdc_buffer2, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_screen, "int", 0, "int", 0, "uint", 0x00CC0020)
Gui,2: -Caption +LastFound +owner1 +ToolWindow +AlwaysOnTop
Gui,2: Show, x0 y0 w%A_ScreenWidth% h-%A_ScreenHeight% NA, AHK��Ļ����2
WinSet, TransColor, 0, AHK��Ļ����2
Gui,2: Show, x0 y0 h%A_ScreenHeight% w%A_ScreenWidth% NA, AHK��Ļ����2

hdc_canvas:=DllCall("GetDC", "uint", WinExist())
DllCall("BitBlt", "uint", hdc_canvas, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_buffer, "int", 0, "int", 0, "uint", 0x00CC0020)

;��ɫ��
Gui,3: Margin, -4, 0
Gui,3: Color, 111511
Gui,3: +AlwaysOnTop +LastFound -0x0CC00000 -Border +ToolWindow +owner1
WinSet, TransColor, 111511
Gui,3: Font, s20, ����
Gui,3: Add, Text, ym w8 h30 c000000,
Loop, Parse, ��ɫ��, CSV
	Gui,3: Add, Text, ym w30 h30 c%A_LoopField% g��ѡɫ��, ��%A_LoopField%
Gui,3: Show, y1 h28 NA, AHK��Ļ����3
Hwnd3:=WinExist()
OnMessage(0x0200,"WM_MOUSEMOVE")
Return

��ѡɫ��:
	��ɫ:="0x" SubStr(A_GuiControl,7,2) SubStr(A_GuiControl,5,2) SubStr(A_GuiControl,3,2)
	Return
;
WM_MOUSEMOVE(wParam, lParam)
{
	Global
	If (i || A_Gui=3)
		Return
	x:=lParam & 0xFFFF
	y:=lParam >> 16
	tooltip wm(%x%`, %y%)
	If (wParam & 1)
		DrawLine(x_, y_, x, y, ��ɫ)
	Else If (wParam & 2)
		DrawLine(x_, y_, x, y, 0)
	Else If (wParam & 16)
		DrawLine(x_, y_, x, y, DllCall("shlwapi.dll\ColorHLSToRGB",Int,Mod(H++,240),Int,120,Int,240))
	x_:=x, y_:=y
	Paint(x_,y_,��ɫ)
}
Paint(x,y,color)
{
	Global hdc_canvas, hdc_buffer2
	DllCall("BitBlt", "uint", hdc_canvas, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_buffer2, "int", 0, "int", 0, "uint", 0x00CC0020)
	cBrush:=DllCall("gdi32.dll\CreateSolidBrush", "uint", color)
	DrawCircle(x,y, cBrush, hdc_canvas)
	DllCall("gdi32.dll\DeleteObject", "uint", cBrush)
}
DrawLine(x0, y0, x1, y1, color=0)
{
	Global hdc_buffer2
	cBrush:=color="ERASE" ? "ERASE" : DllCall("gdi32.dll\CreateSolidBrush", "uint", color)
	dx:=x1 - x0
	dy:=y1 - y0
	dxy:=(Abs(dx)> Abs(dy) ? Abs(dx) : Abs(dy))
	dx:=dx / dxy
	dy:=dy / dxy
	Loop %dxy%
	{
		x0 += dx
		y0 += dy
		DrawCircle(x0,y0, cBrush, hdc_buffer2)
	}
	DllCall("gdi32.dll\DeleteObject", "uint", cBrush)
	WinSet, AlwaysOnTop, On, AHK��Ļ����3
}
DrawCircle(x,y,cBrush,hdc)
{
	Global hdc_buffer, �ʿ�
	cRegion:=DllCall("gdi32.dll\CreateRoundRectRgn", "int", x-�ʿ�, "int", y-�ʿ�, "int", x+�ʿ�, "int", y+�ʿ�, "int", �ʿ�*2, "int", �ʿ�*2)
	If (cBrush="ERASE")
	{
		DllCall("SelectClipRgn", "uint", hdc, "uint", cRegion)
		DllCall("BitBlt", "uint", hdc, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_buffer, "int", 0, "int", 0, "uint", 0x00CC0020)
		DllCall("SelectClipRgn", "uint", hdc, "uint", 0)
	}
	Else
		DllCall("gdi32.dll\FillRgn" , "uint", hdc , "uint", cRegion , "uint", cBrush)
	DllCall("gdi32.dll\DeleteObject", "uint", cRegion)
}
;
~Esc::
	Suspend, Permit
	If i:=!i
	{
		WinSet, ExStyle, +0x20, AHK��Ļ����1
		Paint(0,0,0)
	}
	Else
		WinSet, ExStyle, -0x20, AHK��Ļ����1
	j:=!i
	GoSub, F1
	Suspend
	Return
;������
LCtrl::
	While, GetKeyState("LCtrl", "P")
	{
	}
	Return

;�����ɫ
~MButton::
	Random, H, 0, 239
	��ɫ:=DllCall("shlwapi.dll\ColorHLSToRGB",Int,H,Int,120,Int,240)
	Paint(x_,y_,��ɫ)
	Return
;�����ʿ�
WheelDown::
	If �ʿ�>1
		�ʿ�--
	Paint(x_,y_,��ɫ)
	Return
WheelUp::
	If �ʿ�<100
		�ʿ�++
	Paint(x_,y_,��ɫ)
	Return
;���ص�ɫ��
F1::
	If j:=!j
	{
		Gui,3: Show, y1 NA Hide, AHK��Ļ����3
		Paint(0,0,0)
	}
	Else
		Gui,3: Show, y1 NA, AHK��Ļ����3
	Return

;�������
F2::
	DllCall("BitBlt", "uint", hdc_buffer2, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_buffer, "int", 0, "int", 0, "uint", 0x00CC0020)
	Return
F3::Reload
F4::ExitApp



