
; DesktopSwitch
;
; AutoHotkey Version: 1.0.40.00 (that's at least the version I'm using)
; Language:       English
; Platform:       Win9x/NT/XP
; Author:         Christian Sch?c_schueler@gmx.at>
; last changes:   22. Nov. 2005
;
; Script Function:
;
; A small tool for switching between multiple virtual desktops.
; Use Alt-<desktop index> (e.g. Alt-2) to switch between desktops and
; Alt-0 to quit the script, showing all windows on all virtual desktops
; at once. Currently, 4 desktops are supported, because more will start
; to confuse me...
;
; Version history:
;
; v1.11, 22. Nov. 2005
; Fixed bug: windows are now corrrectly activated after switching/sending
;
; v1.1, 05. Nov. 2005
; Added feature: pressing Ctrl/Alt-<index> sends the active window to the desktop <index>.
;
; v1.0, 04. Nov. 2005
; It works!
; Switching can be done using Alt-<desktop index>, e.g. Alt-1. Pressing
; Alt-0 will exit the script and show all windows from all virtual desktops
; at once.

#SingleInstance ignore


FileInstall, 0.ico, %A_ScriptDir%\0.ico
FileInstall, 1.ico, %A_ScriptDir%\1.ico
FileInstall, 2.ico, %A_ScriptDir%\2.ico
FileInstall, 3.ico, %A_ScriptDir%\3.ico
FileInstall, 4.ico, %A_ScriptDir%\4.ico
FileInstall, 5.ico, %A_ScriptDir%\5.ico
FileInstall, 6.ico, %A_ScriptDir%\6.ico
FileInstall, 7.ico, %A_ScriptDir%\7.ico
FileInstall, 8.ico, %A_ScriptDir%\8.ico
FileInstall, 9.ico, %A_ScriptDir%\9.ico


change_icon("0.ico")                           ;; ����ͼ��

;; �޸��������˵�
	Menu, Tray, MainWindow
	Menu, Tray, NoStandard 
	Menu, Tray, DeleteAll 


	Menu, Tray, Add, &1 ����һ ,  ���л�������1��
	Menu, Tray, Add, &2 ����� ,  ���л�������2��
	Menu, Tray, Add, &3 ������ ,  ���л�������3��
	Menu, Tray, Add, &4 ������ ,  ���л�������4��
	Menu, Tray, Add, &0 �ƶ�����, ���ƶ����ڵ��������桿
	Menu, Tray, Add,
	Menu, Tray, Add, �˳� (&E),  ���˳���


;; �½��Ҽ��˵�
	Menu, MoveDesktopMenu, Add, &1 �ƶ�������һ ,  ���ƶ�������1��
	Menu, MoveDesktopMenu, Add, &2 �ƶ�������� ,  ���ƶ�������2��
	Menu, MoveDesktopMenu, Add, &3 �ƶ��������� ,  ���ƶ�������3��
	Menu, MoveDesktopMenu, Add, &4 �ƶ��������� ,  ���ƶ�������4��


	Menu, DesktopMenu, Add, &~ �ƶ���ǰ����, :MoveDesktopMenu
	Menu, DesktopMenu, Add, &1 ����һ ,  ���л�������1��
	Menu, DesktopMenu, Add, &2 ����� ,  ���л�������2��
	Menu, DesktopMenu, Add, &3 ������ ,  ���л�������3��
	Menu, DesktopMenu, Add, &4 ������ ,  ���л�������4��


; ***** initialization *****

SetBatchLines, -1   ; maximize script speed!
SetWinDelay, -1
OnExit, CleanUp      ; clean up in case of error (otherwise some windows will get lost)

numDesktops := 4   ; maximum number of desktops
curDesktop := 1      ; index number of current desktop

WinGet, windows1, List   ; get list of all currently visible windows

; Transparent Banner GUI
Gui, -Caption +ToolWindow +LastFound +AlwaysOnTop
Gui, Add, Picture, x0 y0, C:\Program Files\Autohotkey\Scripts\banner.png
Gui, Add, Text, x15 y5 w70 +BackgroundTrans vString

; ***** hotkeys *****
i := 1
maxDesktop := 4
#MaxThreadsPerHotkey 6
#!1::SwitchToDesktop(1)
#!2::SwitchToDesktop(2)
#!3::SwitchToDesktop(3)
#!4::SwitchToDesktop(4)

#F1::
���л�������1��:
	SwitchToDesktop(1)
	return

#f2::
���л�������2��:
	SwitchToDesktop(2)
	return

#f3::
���л�������3��:
	SwitchToDesktop(3)
	return

#f4::
���л�������4��:
	SwitchToDesktop(4)
	return

���л�������5��:
	SwitchToDesktop(5)
	return	

���˳���:
	ExitApp
	return

;; �����л�����
#!left::
	i := curDesktop - 1
	if i <= 0
		i := maxDesktop
	SwitchToDesktop(i)
	return

;; �����л�����
#!right::
	i := curDesktop + 1
	if ( i > maxDesktop )
		i := 1
	SwitchToDesktop(i)
	return
#MaxThreadsPerHotkey 1

^#1::SendActiveToDesktop(1)
^#2::SendActiveToDesktop(2)
^#3::SendActiveToDesktop(3)
^#4::SendActiveToDesktop(4)



ins & f1::SendActiveToDesktop(1)
ins & f2::SendActiveToDesktop(2)
ins & f3::SendActiveToDesktop(3)
ins & f4::SendActiveToDesktop(4)

;; ��ʾ��ݲ˵����ƶ���ǰ���ڵ�����
#Appskey::
	menu, DesktopMenu, show
	return


���ƶ�������1��:
	SendActiveToDesktop(1)
	return

���ƶ�������2��:
	SendActiveToDesktop(2)
	return

���ƶ�������3��:
	SendActiveToDesktop(3)
	return

���ƶ�������4��:
	SendActiveToDesktop(4)
	return

���ƶ����ڵ��������桿:
	tooltip ������Ҫ�ƶ��Ĵ���!
	KeyWait, LButton, T3
	if not ErrorLevel 
	{
		UniqueID := WinActive("A")
		
	}
	tooltip	
	return


;; ����ǰ������ƶ����������
^#left::
	i := curDesktop - 1
	if i >= 1
	{
		SendActiveToDesktop(i)
	}
	return

;; ����ǰ������ƶ����ұ�����
^#right::
	i := curDesktop + 1
	if i <= maxDesktop
	{
		SendActiveToDesktop(i)
	}
	return

!0::ExitApp


; ***** functions *****

; switch to the desktop with the given index number
SwitchToDesktop(newDesktop)
{
   global

	ifExist %A_ScriptDir%\%newDesktop%.ico
		Menu TRAY, Icon, %A_ScriptDir%\%newDesktop%.ico

   if (curDesktop <> newDesktop)
   {
      GetCurrentWindows(curDesktop)

      ;WinGet, windows%curDesktop%, List,,, Program Manager   ; get list of all visible windows

      ShowHideWindows(curDesktop, false)
      ShowHideWindows(newDesktop, true)

      curDesktop := newDesktop

      Send, {ALT DOWN}{TAB}{ALT UP}   ; activate the right window
   }
   
   WinClose, ahk_class SysShadow
   ShowBanner("~~ �������桾" newDesktop "��", 120 )

   return
}

; sends the given window from the current desktop to the given desktop
SendToDesktop(windowID, newDesktop)
{
   global
   RemoveWindowID(curDesktop, windowID)

   ; add window to destination desktop
   windows%newDesktop% += 1
   i := windows%newDesktop%

   windows%newDesktop%%i% := windowID
   
   WinHide, ahk_id %windowID%

   Send, {ALT DOWN}{TAB}{ALT UP}   ; activate the right window
}

; sends the currently active window to the given desktop
SendActiveToDesktop(newDesktop)
{
   WinGet, id, ID, A
   SendToDesktop(id, newDesktop)
}

; removes the given window id from the desktop <desktopIdx>
RemoveWindowID(desktopIdx, ID)
{
   global   
   Loop, % windows%desktopIdx%
   {
      if (windows%desktopIdx%%A_Index% = ID)
      {
         RemoveWindowID_byIndex(desktopIdx, A_Index)
         Break
      }
   }
}

; this removes the window id at index <ID_idx> from desktop number <desktopIdx>
RemoveWindowID_byIndex(desktopIdx, ID_idx)
{
   local idx1, idx2
   Loop, % windows%desktopIdx% - ID_idx
   {
      idx1 := % A_Index + ID_idx - 1
      idx2 := % A_Index + ID_idx
      windows%desktopIdx%%idx1% := windows%desktopIdx%%idx2%
   }
   windows%desktopIdx% -= 1
}

; this builds a list of all currently visible windows in stores it in desktop <index>
GetCurrentWindows(index)
{
   local id
   WinGet, windows%index%, List,,, Program Manager      ; get list of all visible windows

   ; now remove task bar "window" (is there a simpler way?)
   Loop, % windows%index%
   {
      id := % windows%index%%A_Index%

      WinGetClass, windowClass, ahk_id %id%
      if windowClass = Shell_TrayWnd      ; remove task bar window id
      {
         RemoveWindowID_byIndex(index, A_Index)
         Break
      }
   }
}

; if show=true then shows windows of desktop %index%, otherwise hides them
ShowHideWindows(index, show)
{
   local id
   Loop, % windows%index%
   {
      id := % windows%index%%A_Index%

      if show
         WinShow, ahk_id %id%
      else
         WinHide, ahk_id %id%
   }
}

ShowBanner(Text, width_ = 120)
{
    local xx, yy
    Trans := 200
	xx := a_screenwidth // 2
	yy := a_screenheight // 2
    GuiControl, Text, String, % Text
	GuiControl, Move, String, w%width_%
    Gui, Show, x%xx% y%yy% h24 w%width_% NoActivate, MyTransparentBanner
    WinSet, Transparent, %Trans%, MyTransparentBanner
    Sleep 500
    
    Loop
    {
        if(Trans <= 0)
        {
            Trans := 0
            WinSet, Transparent, %Trans%, MyTransparentBanner
            break
        }
                
        WinSet, Transparent, %Trans%, MyTransparentBanner
        Trans := Trans - 5
        Sleep, 10
    }
    
    return
}

; show all windows from all desktops on exit
CleanUp:
Loop, %numDesktops%
   ShowHideWindows(A_Index, true)
ExitApp




;; ����������ͼ��
change_icon( var_icofile = "", bForce = false )
{
	;; ���ִ�еĽű���EXE�ļ���ֻ��bForce = True ʱ�Ÿ���ͼ��
	if a_IsCompiled
	{
		if not bForce
		{
			Return                                  ;; ����EXE�ļ�����û��ǿ�ƻ�ͼ��ʱ�˳�
		}
	}
	;; ���ͼ���ļ�Ϊ��, ��Ĭ�ϲ�����ű��ļ�����Ŀ¼��, ��ű�����ͬ���Ƶ�ICO�ļ�
	if var_icofile =
	{
		SplitPath, a_ScriptFullPath ,  , OutDir, , OutNameNoExt
		var_icofile = %OutDir%\%OutNameNoExt%.ico
		; msgbox var_icofile = %var_icofile%
	}
	else
	{
		SplitPath, var_icofile, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
		if OutExtension <> ico
		{
			Return                                  ;; ������ͼ�겻��ICO�ļ�, ���˳�
		}
		if Outdir =
		{
			SplitPath, a_ScriptFullPath ,  , OutDir
			var_icofile = %OutDir%\%OutNameNoExt%.ico
		}
	}
	;; ���icoͼ���ļ����ڣ���ʹ��֮
	IfExist %var_icofile%
	{
		Menu TRAY, Icon,  %var_icofile%
	}
}

