#SingleInstance, Force

IfNotExist, tile.bmp,  UrlDownloadToFile, http://goo.gl/F9KIf,          tile.bmp
IfNotExist, lens.png,  UrlDownloadToFile, http://i.imgur.com/pGL6k.png, lens.png

Gui +Resize
; Gui, Color, FFFFFF ; <- NEVER USE THIS along with WM_CTLCOLORDLG

OnMessage( 0x136, "WM_CTLCOLORDLG" )

Gui, Font, S30 Bold, Arial Black
Gui, Add, Text, w450 y90 c880000 Border 0x201, WM_CTLCOLORDLG
Gui, Add, Picture, xm+25 ym BackgroundTrans, lens.png
Gui, Show,, GUI with 'Tiled background' ( Maximize/Resize this window )
Sleep 1
Return

WM_CTLCOLORDLG() {
Static wBrush
  If ! wBrush
    hBM := DllCall( "LoadImage", Int,0, Str,"tile.bmp", Int,0, Int,0, Int,0, UInt,0x2010 )
  , wBrush := DllCall( "CreatePatternBrush", UInt,hBM )
Return wBrush
}


