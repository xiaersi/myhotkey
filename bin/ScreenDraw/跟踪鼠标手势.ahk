CoordMode, Mouse, Screen

$����ɫ$=0xBBGGRR ;0x0000FF	;0xBBGGRR
$���ʿ�$=4

; Menu, Tray, Icon, Shell32.dll, 142, 1

������Ĭ����Ļ���塿:
	hdc_screen:=DllCall("GetDC", "uint", 0)
	hdc_buffer:=DllCall("CreateCompatibleDC", "uint", hdc_screen)
	hbm_buffer:=DllCall("CreateCompatibleBitmap", "uint", hdc_screen, "int", A_ScreenWidth, "int", A_ScreenHeight)
	DllCall("SelectObject", "uint", hdc_buffer, "uint", hbm_buffer)
	DllCall("BitBlt", "uint", hdc_buffer, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_screen, "int", 0, "int", 0, "uint", 0x00CC0020)
	hdc_buffer2:=DllCall("CreateCompatibleDC", "uint", hdc_screen)
	hbm_buffer2:=DllCall("CreateCompatibleBitmap", "uint", hdc_screen, "int", A_ScreenWidth, "int", A_ScreenHeight)
	DllCall("SelectObject", "uint", hdc_buffer2, "uint", hbm_buffer2)
	;DllCall("BitBlt", "uint", hdc_buffer2, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_screen, "int", 0, "int", 0, "uint", 0x00CC0020)
	;Gui,2: -Caption +LastFound +owner1 +ToolWindow +AlwaysOnTop
	Gui,21: -Caption +LastFound  +ToolWindow +AlwaysOnTop
	Gui,21: Show, x0 y-2000 w%A_ScreenWidth% h-%A_ScreenHeight% NA, AHKĬ����Ļ����
	WinSet, TransColor, 0, AHKĬ����Ļ����
	Gui,21: Show, x0 y0 h%A_ScreenHeight% w%A_ScreenWidth% NA, AHKĬ����Ļ����

	hdc_canvas:=DllCall("GetDC", "uint", WinExist())
	DllCall("BitBlt", "uint", hdc_canvas, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_buffer, "int", 0, "int", 0, "uint", 0x00CC0020)

	mousegetpos, x0, y0	

	settimer [��ʱ����], 200
	;OnMessage(0x0200,"WM_MOUSEMOVE")
Return


������Ĭ����Ļ���塿:
	Gui, 21:Destroy
return


[��ʱ����]:
	mousegetpos, x, y
	if ( x != x0 || y != y0 )
	{
		DrawLine(x0, y0, x, y, DllCall("shlwapi.dll\ColorHLSToRGB",Int,Mod(H++,240),Int,120,Int,240))
		x0 := x
		y0 := y
		Paint(x0,y0,$����ɫ$)
	}
	return

;
WM_MOUSEMOVE(wParam, lParam)
{
	Global
	If (i || A_Gui=3)
		Return
		
	;; �������Ҽ��ͷţ���������ƽ������˳�����
;	if GetKeyState("RButton","P") = 0  
;		ExitApp
		
	x:=lParam & 0xFFFF
	y:=lParam >> 16

	DrawLine(x_, y_, x, y, DllCall("shlwapi.dll\ColorHLSToRGB",Int,Mod(H++,240),Int,120,Int,240))

	x_:=x, y_:=y
	Paint(x_,y_,$����ɫ$)
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
}
DrawCircle(x,y,cBrush,hdc)
{
	Global hdc_buffer, $���ʿ�$
	cRegion:=DllCall("gdi32.dll\CreateRoundRectRgn", "int", x-$���ʿ�$, "int", y-$���ʿ�$, "int", x+$���ʿ�$, "int", y+$���ʿ�$, "int", $���ʿ�$*2, "int", $���ʿ�$*2)
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


esc::
	exitapp
