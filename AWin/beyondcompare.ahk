/*
 文件夹比较，设置过滤条件的对话框
*/
;#IfWinActive  文件夹比较 - 会话设置 ahk_class TSessionDialog.UnicodeClass
#IfWinActive ahk_class TSessionDialog.UnicodeClass
F10::
	ControlSetText, TUiMemo.UnicodeClass3, .classpath`r`n.project`r`n.tmp
	ControlSetText, TUiMemo.UnicodeClass1, target`r`n.svn`r`n.settings`r`nlogs`r`n.metadata`r`nbuild`r`nServers
	return
#IfWinActive 

