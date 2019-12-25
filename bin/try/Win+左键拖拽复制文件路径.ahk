SetBatchLines, -1
SetBatchLines, 1
CoordMode, Mouse, Screen

Gui, +AlwaysOnTop -Caption +Border +ToolWindow
Gui, Show, x0 y0 w9 h9 Hide, AHK.WE2CB.DND.GUI 
Return 

#LButton::
 MouseGetPos, X, Y
 GuiX := X-30
 GuiY := Y-30
 Gui, Show, x%GuiX% y%GuiY%
 MouseClickDrag, Left,,, GuiX+3, GuiY+3, 0
 MouseMove, X, Y
 Gui, Hide
Return

GuiDropFiles: 
 ClipBoard := A_GuiControlEvent
Return




