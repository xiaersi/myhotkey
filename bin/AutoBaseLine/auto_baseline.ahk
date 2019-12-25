;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

g_inifile =  自动发基线.ini

change_icon()

#include %A_ScriptDir%
#include TrotoiseCommand.aik
path = http://10.79.11.211/svn/common/trunk/report/report/src/main 
path2 = http://10.79.11.211/svn/common/branches/20-140731(sf-card)/report/report/src/main
;svn_diff(path, path2)
;return


gosub 【创建菜单】
gosub 【创建窗口】

#include auto_baseline_ui.aik
#include auto_baseline_ui2.aik
#include auto_baseline.aik



#include ../../
#include .\inc\path.aik
#include .\inc\inifile.aik
