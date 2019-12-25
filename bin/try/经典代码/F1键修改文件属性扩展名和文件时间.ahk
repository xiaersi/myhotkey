#SingleInstance,force
SetBatchLines, -1
#IfWinActive,,FolderView
F1::    ;;用ALT和F1修改文件属性
clipold = %Clipboard%
clipboard=
Send,^c
ClipWait, 0.5
if ErrorLevel
{
    clipboard=%clipold%
    Return
}
files=%clipboard%
Clipboard=%clipold%
StringSplit,ary, files ,`n,`r
curpath = %ary1%
If ary0=1
{
      FileGetAttrib,attributes,%ary1%
      If ErrorLevel
      {
        MsgBox 文件不存在或没有访问权限
        Return
      }
      IfNotInString, attributes ,D
      {
        Gosub,GuiSingleFile
        Return
      }
}
Gosub,GuiMultiFile
Return
#IfWinActive

GuiSingleFile:
Gui,+Submit +AlwaysOnTop   +Owner +LastFound -MinimizeBox
WinSetTitle,,,文件属性修改
Gui,Add,CheckBox,xm vReadOnly,只读（&R）
Gui,Add,CheckBox,xp+100 yp vHidden,隐藏（&H）
Gui,Add,CheckBox,xm vSystem vSystem,系统（&S）
Gui,Add,CheckBox,xp+100 yp vArchive,存档（&A）
Gui,Add,Text,xm yp+30,文件名：
Gui,Add,Edit,xp+50 H20 W120 vName
Gui,Add,Text,xm yp+30,扩展名：
Gui,Add,Edit,xp+50 yp H20 W120 vExt
Gui,Add,Button,xm yp+30 W80 gRegOpenFile,打开注册表
Gui,Add,Button,xp+100 yp W80 gFileChangeDate,修改日期
Gui,Add,Button,xm yp+30 W80 gSingleInit,撤销修改
Gui,Add,Button,xp+100 yp W80 gSingleApply Default,执行修改
Gosub,SingleInit
Gui,Show,W200 H180
Return

RegOpenFile:
Gui,Submit,NoHide
RegRead,var,HKCR,.%ext%
If ErrorLevel
    Return
RegWrite,REG_SZ,HKCU,Software\Microsoft\Windows\CurrentVersion\Applets\Regedit,Lastkey,HKEY_CLASSES_ROOT\.%ext%
run,regedit.exe
Return

SingleInit:
FileGetAttrib,attributes,%curpath%
IfInString, attributes, H
GuiControl, ,Hidden,1
Else
GuiControl, ,Hidden,0
IfInString, attributes, R
GuiControl, ,ReadOnly,1
Else
GuiControl, ,ReadOnly,0
IfInString, attributes, S
GuiControl, ,System,1
Else
GuiControl, ,System,0
IfInString, attributes, A
GuiControl, ,Archive,1
Else
GuiControl, ,Archive,0
StringGetPos, i, curpath, \ ,R
StringLen,n,curpath
StringRight,fullname,curpath,n-i-1
StringGetPos, i, fullname, . ,R
StringLen,n,fullname
StringLeft,name,fullname,i
StringRight,ext,fullname,n-i-1
GuiControl,,name,%name%
GuiControl,,ext,%ext%
Return

SingleApply:
Gui,Submit
Gosub,GetAttributes
FileSetAttrib,%pattern%,%curpath%,1,1
StringGetPos, i, curpath, \ ,R
StringLeft,newpath,curpath,i
newpath = %newpath%\%name%.%ext%
If newpath != curpath
   FileMove,%curpath%,%newpath%,0
Return

GetAttributes:
GuiControlGet,bool,,Hidden
If bool
pattern =%pattern%+H
Else
pattern =%pattern%-H
GuiControlGet,bool,,ReadOnly
If bool
pattern =%pattern%+R
Else
pattern =%pattern%-R
GuiControlGet,bool,,System
If bool
pattern =%pattern%+S
Else
pattern =%pattern%-S
GuiControlGet,bool,,Archive
If bool
pattern =%pattern%+A
Else
pattern =%pattern%-A
Return

FileChangeDate:
Gui,Destroy
Gui,+Submit +AlwaysOnTop   +Owner +LastFound -MinimizeBox
WinSetTitle,,,文件时间修改
Gui,Add,Radio,group xm+20 checked H20 Section vOrder gGetTime,修改时间
Gui,Add,Radio,xp+80 yp H20 gGetTime,创建时间
Gui,Add,Radio,xp+80 yp H20 gGetTime,访问时间
Gui, Add, DateTime, vMyDateTime xm+10 yp+30,'Date:' yyyy-MM-dd   'Time:' HH:mm:ss
Gui,Add,Button,xm+30 yp+30 gGetTime,撤销修改
Gui,Add,Button,xp+80 yp gCurTime,当前时间
Gui,Add,Button,xp+80 yp gFileSetTime Default,执行修改
GoSub,GetTime
Gui,Show,W300 H100
Return

GetTime:
Gui,Submit,NoHide
if order=1
    timetype=M
else if order=2
    timetype=C
else
    timetype=A
FileGetTime,temptime,%curpath%,%timetype%
GuiControl,,MyDateTime,%temptime%
Return

CurTime:
GuiControl,,MyDateTime,%A_Now%
Return

FileSetTime:
Gui,Submit
if order=1
    timetype=M
else if order=2
    timetype=C
else
    timetype=A
FileSetTime,%MyDateTime%,%curpath%,%timetype%
If recurse = 1
{
FileGetAttrib,attributes,%curpath%
{
    IfInString, attributes ,D
      {
         Loop,%curpath%\*.*,1,1
          {
            FileSetTime,%MyDateTime%,%A_LoopFileFullPath%,%timetype%
          }
      }
}
}
Return

GuiMultiFile:
Gui,+Submit +AlwaysOnTop   +Owner +LastFound -MinimizeBox
WinSetTitle,,,文件属性修改
Gui,Add,CheckBox,xm vReadOnly,只读（&R）
Gui,Add,CheckBox,xp+100 yp vHidden,隐藏（&H）
Gui,Add,CheckBox,xm vSystem vSystem,系统（&S）
Gui,Add,CheckBox,xp+100 yp vArchive,存档（&A）
Gui,Add,CheckBox,xm yp+30 vRecurse Checked,是否将修改应用到子文件
Gui,Add,Button,xm yp+20 W80 gShowFile,查看文件
Gui,Add,Button,xp+100 yp W80 gMultiDate,修改日期
Gui,Add,Button,xm yp+30 W80 gMultiInit,撤销修改
Gui,Add,Button,xp+100 yp W80 gMultiApply Default,执行修改
Gosub,MultiInit
Gui,Show
Return

MultiInit:
FileGetAttrib,attributes,%ary1%
IfInString, attributes, H
GuiControl, ,Hidden,1
Else
GuiControl, ,Hidden,0
IfInString, attributes, R
GuiControl, ,ReadOnly,1
Else
GuiControl, ,ReadOnly,0
IfInString, attributes, S
GuiControl, ,System,1
Else
GuiControl, ,System,0
IfInString, attributes, A
GuiControl, ,Archive,1
Else
GuiControl, ,Archive,0
Return

ShowFile:
ToolTip,%files%
SetTimer,RemoveToolTip,1000
Return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

MultiDate:
Gui,Destroy
Gui,+Submit +AlwaysOnTop   +Owner +LastFound -MinimizeBox
WinSetTitle,,,文件时间修改
Gui,Add,Radio,group xm+20 checked H20 Section vOrder gGetTime,修改时间
Gui,Add,Radio,xp+80 yp H20 gGetTime,创建时间
Gui,Add,Radio,xp+80 yp H20 gGetTime,访问时间
Gui,Add,CheckBox,xm+20 H20 vRecurse Checked,是否将修改应用到子文件
Gui, Add, DateTime, vMyDateTime xm+10 yp+30,'Date:' yyyy-MM-dd   'Time:' HH:mm:ss
Gui,Add,Button,xm+30 yp+30 gGetTime,撤销修改
Gui,Add,Button,xp+80 yp gCurTime,当前时间
Gui,Add,Button,xp+80 yp gMultiSetTime Default,执行修改
Gosub,GetTime
Gui,Show,W300 H120
Return

MultiSetTime:
Loop,%ary0%
{
curpath := ary%A_Index%
Gosub,FileSetTime
}
Return

MultiApply:
Gui,Submit
Gosub,GetAttributes
Loop,%ary0%
{
curpath := ary%A_Index%
FileSetAttrib,%pattern%,%curpath%
If Recurse = 1
{
    FileGetAttrib,attributes,%curpath%
    IfInString, attributes ,D
    {
      FileSetAttrib,%pattern%,%curpath%\*.*,1,1
    }
}
}
Return

GuiClose:
GuiEscape:
Gui,Destroy

