allowedMinutes := 15
endTime := A_Now
endTime += %allowedMinutes%, Minutes

Gui Font, s48 w800 c8000FF, Bookman Old Style
Gui Add, Text, w320 h72 x10 y10 center vtime
Gui Show, w340 h100, Time is running out!
SetTimer TicTac, 1000
; Fallthrough

TicTac:
   remainingTime := endTime
   EnvSub remainingTime, %A_Now%, Seconds
   h := remainingTime // 60 // 60
   m := remainingTime // 60
   s := Mod(remainingTime, 60)
   displayedTime := Format2Digits(h) ":" Format2Digits(m) ":" Format2Digits(s)
   GuiControl, , time, %displayedTime%
Return

GuiClose:
GuiEscape:
ExitApp

Format2Digits(_val)
{
   _val += 100
   StringRight _val, _val, 2
   Return _val
}