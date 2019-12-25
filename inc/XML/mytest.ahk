#SingleInstance force

;LoadXString( xmldoc )

;var_step = /root/word[@name=`"word1`"]/text()

;var_step = /root/word[key="teshorse"]/item[2]/case/remove()
;var := xpath( xmldoc, var_step )

;var := GetXString( xmldoc, "TempArray", "teshorse", "", "wintitle:_$AllWindow$_" )

/*
var := AddXString( xmldoc, "web", "sina.com", "EndChar:3|WinFlag:2|WinTitle:IE" )
var := AddXString( xmldoc, "web", "sina.com", "WinTitle:firefox" )
var := AddXString( xmldoc, "web", "sina.com", "opera" )
var := AddXString( xmldoc, "web", "qq.com", "" )

SaveXString( xmldoc )

*/



;var := GetXWordList( xmldoc )
;msgbox var = %var%

∑打开飞扬个性输入( )


F7::
	WinGetActiveTitle, _XString_title
	WinGetClass, _XString_class, A
	g_oldclip := clipboard
	clipboard=
	send ^c
	clipwait 0.5
	_XString_text := clipboard
	gosub 【飞扬个性输入之增加短语】
	clipboard := g_oldclip
	return



msgbox end

return

#include ../../
#include ./lib/xhotstring.aik
#include ./inc/xml/xhotstring.aik
#include ./subui/26为飞扬个性输入添加短语.aik
