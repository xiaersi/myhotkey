#Include ..\..\inc\listview\LTVCustomColors.aik
;#include LTVCustomColors.ahk

;This listview shows a background color linked to rows
gui, 1:add, listview, , 1|2|3

;This listview shows a fixed background color (i.e. which won't follow rows when reordering) and a text color linked to rows.
gui, 1:add, listview, vLV2, 1|2|3

;This listview shows a background color linked to rows, the same index is used several times: lines with same indexes share same color properties.
gui, 2:add, listview, , 1|2|3

;This listview shows a background color linked to rows, indexes are in 3rd column.
gui, 2:add, listview, HWNDhLV4, 1|2|3

gui, 3:add, Button, gAddItems, Add items to listviews
gui, 3:add, Button, gChangeColors, Change items color
gui, 3:add, Button, gReset, Reset colors
gui, 3:add, Button, gGetColors, get colors in 2nd LV
gui, 3:add, Button, gDestroy, Destroy 4th LV

gui, 1:show, x0 y0, gui1
gui, 2:show, x300 y0, gui2
gui, 3:show, x0 y300, commands

;Adding items in all LV
gosub AddItems

;Adding colors on items of first (hidden) LV
LV_Change()      ;Defaults to Gui1 and SysListView321
p = 0
Loop, % LV_GetCount()/2
{
   p++
   LV_SetColor(p, "", 0x0080FF)
   p++
   LV_SetColor(p, "", 0x0000FF)
}
return


AddItems:

LV_Change()      ;Defaults to Gui1 and SysListView321

If !j
   j=1
Else
   j++
LV_Add("", j, "e")
j++
LV_Add("", j, "f")

LV_Change("", "lv2")      ;Defaults to Gui1 and selects the control which associated variable is lv2 (SysListView322 works too)

If !i
   i=1
Else
   i++
LV_Add("", i, "b")
i++
LV_Add("", i, "c")
LV_SetColor(-i, "", 0x555555)      ;-i fixes color change on line number i

LV_Change(2, 1)      ;Selects Gui2 and ListView1

If !k
   k=1
Else
   k++
LV_Add("", k, "k")
k++
LV_Add("", k, "m")
LV_Add("", k, "m")

LV_Change(hLV4, "", "", 3)      ;Selects the control which hWnd is hLV4

If !l
   l=1
Else
   l++
LV_Add("", "z", "n", l)
l++
LV_Add("", "y", "p", l)
;*/
Return



ChangeColors:
LV_Change()      ;Defaults to Gui1 and SysListView321

p = 0

Loop, % LV_GetCount()/2
{
   p++
   LV_SetColor(p, "", 0x0080FF)
   p++
   LV_SetColor(p, "", 0x0000FF)
}

LV_Change("", "lv2")      ;Defaults to Gui1 and selects the control which associated variable is lv2 (SysListView321 works too)

p = 0
Loop, % LV_GetCount()/2
{
   p+=2
   LV_SetColor(p, 0x9965F0)
}

LV_Change(2, 1)      ;Selects Gui2 and ListView1

p = 0
Loop, % LV_GetCount()/2
{
   p++
   LV_SetColor(p, 0, 0xA3F003)      ;Here, 0 means 0x000000 (black)
   p++
   LV_SetColor(p, 0xFFFFFF, 0xA01F08)
}

LV_Change(hLV4, "", "", 3)      ;Selects the control which hWnd is hLV4

p = 0
Loop, % LV_GetCount()/2
{
   p++
   LV_SetColor(p, "", 0xFF4000)
   p++
   LV_SetColor(p, "", 0xFFF000)
}

Return

Destroy:
LV_Destroy(hLV4)
Return


GetColors:
LV_Change("", "lv2")      ;Defaults to Gui1 and selects the control which associated variable is lv2 (SysListView321 works too)
CL :=  "Static bgd colors:"
Loop, % LV_GetCount()
CL .= "`n'" LV_GetColor(-A_Index, "bAcK") "'"
CL .=  "`n`nDynamic text colors:"
Loop, % LV_GetCount()
CL .= "`n'" LV_GetColor(A_Index, "teXT") "'"
MsgBox %CL%
Return



Reset:

LV_Destroy()      ;= LV_Destroy(1,1)      Resets all and cleans memory. You will need to reinitialize the control to further cistomize its colors
LV_Destroy(2,2)      ;Resets all and cleans memory. Same remark as above.

LV_Change(1,2)
LV_SetColor("",-1,-1)   ;Resets all colors moving with rows
LV_SetColor(-0,-1,-1)   ;Resets all colors fixed to lines

LV_Change(2,1)
LV_SetColor("",0x808080,-1)   ;Changes text color to 808080 and resets background in all rows

Return



GuiClose:
2GuiClose:
3GuiClose:
4GuiClose:
GuiEscape:
2GuiEscape:
3GuiEscape:
4GuiEscape:
ExitApp
Return
