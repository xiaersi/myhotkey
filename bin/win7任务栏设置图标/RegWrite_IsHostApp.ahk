/*
   Window 7 操作系统，任务栏不会显示ahk文件自定义的图标，而是显示AutoHotkey程序的默认H图标。
   只需要修改一下注册表即可解决此问题。
*/

; Give each instance of AutoHotkey.exe its own button:
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, Applications\AutoHotkey.exe, IsHostApp


