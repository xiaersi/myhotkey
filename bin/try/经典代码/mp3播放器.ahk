; AHk Version: 1.x
; Platform:    Win9x/NT/2000/XP/Vista
;Author: gosber
#SingleInstance Force
FileInstall, SoundFunctions.ahk, SoundFunctions.ahk, 0
FileInstall, Filter.ini, Filter.ini, 0
SetBatchLines -1
#NoEnv
SetTimer, UpdateSound,5000
SetTimer, UpdateTime,100
SetTimer,UpdateProgress,1000
SetTimer,CheckStatus,100
SoundGet, MV
RSound := Round(MV)
playing = 0
IniRead, Filter, Filter.ini, Config, F
SetTitleMatchMode, 3
Gui, Add, Tab, x-4 y0 w480 h130 , 媒体|音量控制
Gui, Add, Button, x6 y30 w90 h20 gOpenMF, 选择音乐文件
Gui, Add, Button, x116 y30 w50 h20 gStopF, 停止
Gui, Add, Button, x116 y60 w50 h20 gPauseF, 暂停
Gui, Tab, 音量控制
Gui, Add, Slider, x6 y30 w460 h40 vVSlider Range0-100 gVolumeC AltSubmit, %MV%
Gui, Add, Text, x6 y80 w130 h20 vVText, 音量`: %RSound%
Gui, Tab, 媒体
Gui, Add, Button, x116 y90 w50 h20 gResumeF, 继续
Gui, Tab, 媒体
Gui, Add, Progress, x176 y30 w290 h30 cGreen vProgress Range1-100 vProgress, 0
Gui, Add, Text, x176 y70 w290 h30 vSongTime, 0:0:0 / 0:0:0
Gui, Add, StatusBar, x176 y70 w290 h30 , 未播放文件
Gui, Tab, 媒体
Gui, Add, ListView, x1 y161 w476 h151 gPlayLV vLV, 曲名|类型|位置
Gui, Tab, 媒体
Gui, Add, Button, x1 y131 w169 h29 gAddC, 添加文件到播放列表
Gui, Add, Text, x171 y135 w250 h20 , 点击播放列表中的文件开始播放
Gui, Tab, 媒体
Gui, Add, Button, x382 y131 w78 h29 gEC, 清空播放列表
; Generated using SmartGUI Creator 4.0
Gui, Show, x357 y382 h347 w488, Taoism PMP
return

GuiClose:
exitapp
return


;Sound Controls
UpdateSound:
Gui, Submit, NoHide
SoundGet, MVU
RSound := Round(MVU)
Guicontrol,,VSlider,%MVU%
GuiControl,,VText,Volume`:%RSound%
return

VolumeC:
Gui, Submit, NoHide
SoundSet,%VSlider%,master
GuiControl,, VText,Volume`:%VSlider%
Return
;Sound Controls

OpenMF:
CheckSong := Sound_Status(hSound)
If CheckSong = playing
    {
    Sound_Stop(hSound)
    playing = 0
    }
Gui, +OwnDialogs
FileSelectFile, Filetoplay, 3, , 选择音乐文件,音乐 %Filter%
If Filetoplay =
    msgbox,未选择文件

filename=
sleep 100
SplitPath, Filetoplay, filename
sleep 100

hSound := Sound_Open(Filetoplay)
If Not hSound
   return
playing = 1
Sound_Play(hSound)
Guicontrol,,Progress,0
Guicontrol,% "+Range1-" Sound_Length(hSound) / 1000,Progress
SplitPath, Filetoplay, filename
SB_SetText("正在播放 " filename)
return

StopF:
Sound_Stop(hSound)
playing = 0
Guicontrol,,Progress,0
GuiControl,,SongTime,0:0:0 / 0:0:0
SB_SetText("未播放")
return

PauseF:
Sound_Pause(hSound)
return

ResumeF:
Sound_Resume(hSound)
return

UpdateTime:
If playing = 0
      return
If(Sound_Pos(hSound) = Sound_Length(hSound))
      return
GuiControl,,SongTime,% Tohhmmss(Sound_Pos(hSound)) . " / " . Tohhmmss(Sound_Length(hSound))
return


UpdateProgress:
If playing = 0
      return
If(Sound_Pos(hSound) = Sound_Length(hSound))
      return
Guicontrol,,Progress,% (Sound_Pos(hSound) / 1000)
Return

CheckStatus:
Status := Sound_Status(hSound)
If Status = stopped
    {
    sleep 1500
    Guicontrol,,Progress,0
    Guicontrol,,SongTime,0:0:0 / 0:0:0
    SB_SetText("未播放")
    }
return


PlayLV:
LV_GetText(name, A_EventInfo, 1)
LV_GetText(dir, A_EventInfo, 3)
ToPlay = %dir%\%name%
CheckSong := Sound_Status(hSound)
If CheckSong = playing
    {
    Sound_Stop(hSound)
    playing = 0
    }
hSound := Sound_Open(ToPlay)
If Not hSound
   return
playing = 1
Sound_Play(hSound)
Guicontrol,,Progress,0
Guicontrol,% "+Range1-" Sound_Length(hSound) / 1000,Progress
SB_SetText("正在播放 " name)
return

UpdateLV:
Gui, Submit, NoHide
LV_Delete()
Loop, %Directory%\*.*
    LV_Add("", A_LoopFileName, A_LoopFileSizeMB, A_LoopFileExt,A_LoopFileFullPath)
LV_ModifyCol()
LV_ModifyCol(2,"Integer")
return

AddC:
If hSound = 
    gosub CAM
Else
{
CheckSong := Sound_Status(hSound)
If CheckSong = playing
    {
    Sound_Pause(hSound)
    playing = 0
    gosub CAM
    }
}
return
CAM:
Critical 
Gui, +OwnDialogs 
Thread,NoTimers 
Sleep,200 ; Ensure No timers start 
FileSelectFile,FilesToAdd,M3,,Select Media File,Audio %Filter% 
Thread,Notimers,False 
If (!FilesToAdd){ 
Return 
} 
Loop, parse, FilestoAdd, `n 
{ 
    if (a_index != 1){ 
      SplitPath,A_loopField,,,FileExt 
      LV_Add("",a_loopfield,FileExt,dir) 
    } 
    Else { 
      Dir:=a_loopField 
    } 

} 
If hSound = 
    return
LV_ModifyCol()
Sound_Resume(hSound)

return


EC:
LV_Delete()
return



;#Include SoundFunctions.ahk
^h::
IfWinExist, Taoism PMP
WinHide, Taoism PMP
else
WinShow, Taoism PMP
return





;代码2：

Sound_Open(File, Alias=""){ 
   IfNotExist, %File% 
   { 
      ErrorLevel = 2 
      Return 0 
   } 
   If Alias = 
   { 
      Random, rand, 10, 10000000000000000000000000000000000000 
      Random, randd, 10, 10000000000000000000000000000000000000 
      Alias = AutoHotkey%rand%%randd% 
   } 
   Loop, %File% 
      File_Short = %A_LoopFileShortPath% 
   r := Sound_SendString("open " File_Short " alias " Alias) 
   If r 
   { 
      ErrorLevel = 1 
      Return 0 
   }Else{ 
      ErrorLevel = 0 
      Return %Alias% 
   } 
}

Sound_Close(SoundHandle){ 
   r := Sound_SendString("close " SoundHandle) 
   Return NOT r 
}

Sound_Play(SoundHandle, Wait=0){ 
   If(Wait <> 0 AND Wait <> 1) 
      Return 0 
   If Wait 
      r := Sound_SendString("play " SoundHandle " wait") 
   Else 
      r := Sound_SendString("play " SoundHandle) 
   Return NOT r 
}

Sound_Stop(SoundHandle){ 
   r := Sound_SendString("seek " SoundHandle " to start") 
   r2 := Sound_SendString("stop " SoundHandle) 
   If(r AND r2) 
   { 
      Return 0 
   }Else{ 
      Return 1 
   } 
}

Sound_Pause(SoundHandle){ 
   r := Sound_SendString("pause " SoundHandle) 
   Return NOT r 
}

Sound_Resume(SoundHandle){ 
   r := Sound_SendString("resume " SoundHandle) 
   Return NOT r 
}

Sound_Length(SoundHandle){ 
   r := Sound_SendString("set time format miliseconds", 1) 
   If r 
      Return 0 
   r := Sound_SendString("status " SoundHandle " length", 1, 1) 
   Return %r% 
}

Sound_Seek(SoundHandle, Hour, Min, Sec){ 
   milli := 0 
   r := Sound_SendString("set time format milliseconds", 1) 
   If r 
      Return 0 
   milli += Sec * 1000 
   milli += Min * 1000 * 60 
   milli += Hour * 1000 * 60 * 60 
   r := Sound_SendString("seek " SoundHandle " to " milli) 
   Return NOT r 
}

Sound_Status(SoundHandle){ 
   Return Sound_SendString("status " SoundHandle " mode", 1, 1) 
}

Sound_Pos(SoundHandle){ 
   r := Sound_SendString("set time format miliseconds", 1) 
   If r 
      Return 0 
   r := Sound_SendString("status " SoundHandle " position", 1, 1) 
   Return %r% 
}

Sound_SeekSeconds(SoundHandle, Sec){ 
   r := Sound_SendString("seek " SoundHandle " to " Sec) 
   Return NOT r 
}

Sound_SetBass(SoundHandle){ 
   r := Sound_SendString("setaudio " SoundHandle " bass to 1000") 
   Return 
}

Sound_SendString(string, UseSend=0, ReturnTemp=0){ 
   If UseSend 
   { 
      VarSetCapacity(stat1, 32, 32) 
      DllCall("winmm.dll\mciSendStringA", "UInt", &string, "UInt", &stat1, "Int", 32, "Int", 0) 
   }Else{ 
      DllCall("winmm.dll\mciExecute", "str", string) 
   } 
   If(UseSend And ReturnTemp) 
      Return stat1 
   Else 
      Return %ErrorLevel% 
}

Tohhmmss(milli){ 
   min := Floor(milli / (1000 * 60)) 
   hour := Floor(milli / (1000 * 3600)) 
   sec := Floor(Floor(milli/1000) - (min * 60)) 
   Return hour ":" min ":" sec 
}
