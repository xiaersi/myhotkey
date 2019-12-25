CoordMode, Mouse, Screen

$»­±ÊÉ«$=0xBBGGRR ;0x0000FF	;0xBBGGRR
$»­±Ê¿í$=4

; Menu, Tray, Icon, Shell32.dll, 142, 1

¡¾´´½¨Ä¬ÈÏÆÁÄ»»­°å¡¿:
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
	Gui,21: Show, x0 y-2000 w%A_ScreenWidth% h-%A_ScreenHeight% NA, AHKÄ¬ÈÏÆÁÄ»»­°å
	WinSet, TransColor, 0, AHKÄ¬ÈÏÆÁÄ»»­°å
	Gui,21: Show, x0 y0 h%A_ScreenHeight% w%A_ScreenWidth% NA, AHKÄ¬ÈÏÆÁÄ»»­°å

	hdc_canvas:=DllCall("GetDC", "uint", WinExist())
	DllCall("BitBlt", "uint", hdc_canvas, "int", 0, "int", 0, "int", A_ScreenWidth, "int", A_ScreenHeight, "uint", hdc_buffer, "int", 0, "int", 0, "uint", 0x00CC0020)

	mousegetpos, x0, y0	

	settimer [¶¨Ê±»­Ïß], 200
	;OnMessage(0x0200,"WM_MOUSEMOVE")
Return


¡¾Ïú»ÙÄ¬ÈÏÆÁÄ»»­°å¡¿:
	Gui, 21:Destroy
return


[¶¨Ê±»­Ïß]:
	mousegetpos, x, y
	if ( x != x0 || y != y0 )
	{
		DrawLine(x0, y0, x, y, DllCall("shlwapi.dll\ColorHLSToRGB",Int,Mod(H++,240),Int,120,Int,240))
		x0 := x
		y0 := y
		Paint(x0,y0,$»­±ÊÉ«$)
	}
	return

;
WM_MOUSEMOVE(wParam, lParam)
{
	Global
	If (i || A_Gui=3)
		Return
		
	;; Èç¹ûÊó±êÓÒ¼üÊÍ·Å£¬ÔòÊó±êÊÖÊÆ½áÊø£¬ÍË³ö³ÌÐò
;	if GetKeyState("RButton","P") = 0  
;		ExitApp
		
	x:=lParam & 0xFFFF
	y:=lParam >> 16

	DrawLine(x_, y_, x, y, DllCall("shlwapi.dll\ColorHLSToRGB",Int,Mod(H++,240),Int,120,Int,240))

	x_:=x, y_:=y
	Paint(x_,y_,$»­±ÊÉ«$)
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
	Global hdc_buffer, $»­±Ê¿í$
	cRegion:=DllCall("gdi32.dll\CreateRoundRectRgn", "int", x-$»­±Ê¿í$, "int", y-$»­±Ê¿í$, "int", x+$»­±Ê¿í$, "int", y+$»­±Ê¿í$, "int", $»­±Ê¿í$*2, "int", $»­±Ê¿í$*2)
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
