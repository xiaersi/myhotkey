Gui, -Caption +ToolWindow +0x400000
Gui, Font, S14 Bold, Verdana
Gui, Add, Text, w200 h27 Border Center GuiMove, Click Here `&& Drag
Gui, Show, AutoSize
Return

uiMove:
PostMessage, 0xA1, 2,,, A 
Return

GuiEscape:
Exitapp


