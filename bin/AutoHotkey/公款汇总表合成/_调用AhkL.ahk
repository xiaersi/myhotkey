;; 通过AutoHotkey_L调用运行Ahk文件
SetWorkingDir, %a_scriptdir%\bin
SplitPath, a_scriptdir, , g_ParentDir

SplitPath, a_ScriptFullPath, OutFileName, OutDir, OutExtension, OutNameNoExt

IniRead, ahk_file, %a_scriptdir%\bin\%OutNameNoExt%.ini, CallFile, CallFile, Error

if ahk_file = Error
{
	FileSelectFile, ahk_file, , %a_ScriptDir%
	if ErrorLevel
		return 
}	


if ahk_file =
{
	msgbox 尚未配置CallFile！
	return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 准备autohotkey_L.exe
IniRead, ahk_exe, %a_scriptdir%\bin\%OutNameNoExt%.ini, AutoHotkey, AHK_L, Error
if ahk_exe = Error
{
	ifexist %a_ScriptDir%\bin\AutoHotkey_L.exe
		ahk_exe = %a_ScriptDir%\bin\AutoHotkey_L.exe
	else ifexist %g_ParentDir%\AHK_L\AutoHotkey.exe
		ahk_exe = %g_ParentDir%\AHK_L\AutoHotkey.exe
	else
	{
		msgbox 没有配置AutoHotkey_L程序！`n`n请配置[AutoHotkey] AHK_L = autohotkey_l.exe 
		return
	}
}	

if ahk_exe <>
{
	run %ahk_exe% `"%a_ScriptDir%\bin\%ahk_file%`"
}
