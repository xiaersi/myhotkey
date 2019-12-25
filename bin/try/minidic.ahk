 ;ÃÔÄã´Êµä
 ; Ïñ½ðÉ½´Ê°ÔÆÁÄ»È¡´ÊÒ»Ñù
 ; http://ahk.5d6d.com/thread-3063-1-1.html

#NoEnv
CoordMode,mouse,screen
FileRead,WordList,Ó¢ºº´ÊµäTXT¸ñÊ½.txt
If errorlevel
{
    MsgBox  Load Dictionary error!
    ExitApp
}
CapEnabled:=-1
Gui,-Caption +AlwaysOnTop +Owner
Gui,font,s11 cwhite italic bold
Gui,add,text,x6 y4 vWord hwndWordhwnd,NNNNNNNNNNNNNNNNNNNN
Gui,font,s14 cD5AAD5 normal
Gui,add,text,xp0 yp26 vMean hwndMeanhwnd,NNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
Gui,color,3f3f3f
Gui,+lastfound
FrameID:=WinExist()
Gui,show,Hide w180 h60
DetectHiddenWindows,On
WinSet,region, w180 h60 0-0 0-180 180-60 0-60 0-0 R2-2,ahk_id %FrameID%
WinSet,TransColor,black 225,ahk_id %FrameID%
DetectHiddenWindows,Off
Return

^q::
CapEnabled:=-CapEnabled
If ( CapEnabled=-1 )
{
    SetTimer,MouseCheck,Off
    Gui,Hide
}
Else
    SetTimer,MouseCheck,50
Return

MouseCheck:
MouseGetPos,Mx,My
If ( Mx=Mx_old && My=My_old )
    MouseCount++
Else
    MouseCount:=0
If ( MouseCount>=8 )
    Gosub Interpret
Else
    Gui,Hide
Mx_old:=Mx
My_old:=My
Return


Interpret:
 MouseGetPos,Mx,My,hwnd,c_hwnd,3
 If c_hwnd
    hwnd:=c_hwnd
WordCaptured:=GetText2(hwnd, Mx, My)
If !WordCaptured
{
    Gui,Hide
    Return
}   
If ( WordCaptured=WordOld )
    Return
WordOld:=WordCaptured
StringGetPos,WordPos,WordList,%WordCaptured%
If ( WordPos=-1 )
{
    Gui,Hide
    Return
}
Else
    WordPos++
Meaning:=SubStr(WordList,InStr(WordList,"$","false",WordPos)+1,InStr(WordList,"%","false",WordPos)-InStr(WordList,"$","false",WordPos)-1)
ShowText:=WordCaptured . "`n`n" . Meaning
Gosub GuiUpdate
Return

GuiUpdate:
GuiControl,,Word, %WordCaptured%
GuiControl,,Mean, %Meaning%
FrameX:=Mx+20
Gui,Show,NA x%FrameX% y%My%
Return

GetText2(hwnd,x,y){
	COM_CoInitialize() 
	Com_error()
    suuid := "{13FE2FA1-EE8B-45B9-BBB4-08E5F2F43AC3}" 
    pTcx := COM_CreateObject(suuid) 
    text:=COM_Invoke(pTcx,"GetTextFromPoint",hwnd, x, y) 
    COM_Release(pTcx) 
    COM_CoUninitialize() 
    Return text
}   

