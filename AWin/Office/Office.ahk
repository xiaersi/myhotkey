; Winword 窗口中，pageup,pagedown分别上下滚动
#include .\inc\functions.inc


;;//////////////////////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Word窗口
#ifwinactive ahk_class OpusApp,MsoDockTop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sc07b::
f7::		;;滚轮向上滚动
	MouseClick, WheelUp, , , %var_wheelnum%
	return
sc079::
f8::
	MouseClick, WheelDown, , , %var_wheelnum%
	return

f9::
	send ^c!{tab}
	return
f10:: 	;;word中选择性粘贴
	ifwinactive ahk_class OpusApp,Microsoft Word 文档
	{
	send !es
	sleep 300
	send {end}
	send {enter}
	}
	return

;;---------------------------------------------------------
;;首先缩进两个字符
^+2::
	send !op
	winwait 段落 ahk_class bosa_sdm_Microsoft Office Word 11.0
	winactivate
	send {tab 4}{up 2}{down}{tab}2
	return
^+m::	;插入批注
	send !im
	return
^+o:: 	;项目符号
	send !on!b{tab}{right}
	return
^+p:: 	;编号
	send !on!n{tab}{right}
	return
^+z::
	talkshow("Ctr+shift+2: 首行缩进两个字符`nCtr+shift+m: 插入批注`nCtr+shift+o: 项目符号`nCtr+shift+p: 编号`nCtr+shift+h: 局部替换",3000)
	return
^+/::
	var_show = Ctr+shift+2: `t首行缩进两个字符`nCtr+shift+m: `t插入批注`nCtr+shift+o: `t项目符号（^+p::编号）`n右Alt+0`t||无变换+0: `t隐藏/显示工具栏`n右Alt+=`t||无变换+=: `tWord最大化`n右Alt+-`t||无变换+-: `tWord缩小至右下角 `n无变换+e||无变换+v: `t选择性粘贴
	talkshow(var_show,5000)
	return
;;---------------------------------------------------word--------
sc07b & z::
	var_show = 右Alt+0`t||无变换+0: `t隐藏/显示工具栏`n右Alt+=`t||无变换+=: `tWord最大化`n右Alt+-`t||无变换+-: `tWord缩小至右下角 `n无变换+e||无变换+v: `t选择性粘贴
	talkshow(var_show,4000)
	return

sc07b & 0::	; 隐藏/显示工具栏
>!0::
	send !vt{enter}
	send !vt{down }{enter}
;	send !vt{down 13}{enter}
;	send !vt{down 20}{enter}
	send !vt{up 2}{enter}
	send !vd
	send !vl
	return

sc079 & v::
sc079 & e::	;;word中选择性粘贴
	ifwinactive ahk_class OpusApp,Microsoft Word 文档
	{
	send !es
	sleep 300
	send {end}
	}
	return

sc07b & d::	; 无变换+D 修改表格颜色
	click right
	send b
	winwait 边框和底纹 ahk_class bosa_sdm_Microsoft Office Word 11.0,,3
	if(ErrorLevel) 
	{
		talkshow(" “边框和底纹” 窗口没有出现")
		sleep 3000
		return
	}
	send !o
	winwait 颜色 ahk_class bosa_sdm_Microsoft Office Word 11.0
	if(ErrorLevel) 
	{
		talkshow(" “边框和底纹” 窗口没有出现")
		sleep 3000
		return
	}
	click 90,44
;	click 113,258
	send {tab 4}
	return

;------------------------------------------------------word--
^+H:: 	;局部替换，常见替换
	send ^h
	winwait 查找和替换 ahk_class bosa_sdm_Microsoft Office Word 11.0,,3
	if errorlevel
		return
loop
{
	if(a_index=1) 
	{
	var_before = :
	var_after = ：
	}
	else if(a_index=2) 
	{
	var_before =`;
	var_after =；
	}
	else if(a_index=3) 
	{
	var_before =`,
	var_after =，
	}
	else if(a_index>=4) 
	{
	InputBox, var_before,继续替换,已经替换%a_index%次，还要替换？请输入,,300,120
	if (var_before="")
		goto,结束替换关闭替换窗口
	InputBox, var_after,替换为,将%var_before%替换为什么？,,300,120
	}

	ifwinexist 查找和替换 ahk_class bosa_sdm_Microsoft Office Word 11.0
	{
		tooltip 等待将“ %var_before% ”替换为将“ %var_after% ”
		ControlSetText,RichEdit20W1,%var_before%
		ControlSetText,RichEdit20W2,%var_after%
	}
	else
	{
		tipshow(" 替换窗口已经关闭，即将退出",2000)
		return
	}
	winwait Microsoft Office Word ahk_class #32770,Word 已完成对所选内容的搜索,20
;	pleasewait("Microsoft Office Word ahk_class #32770","Word 已完成对所选内容的搜索",1000)

	if  errorlevel
	{
	msgbox 4,超时,等待搜索完毕超时，是否进入下一轮替换？,5
	ifmsgbox No
		goto,结束替换关闭替换窗口
	}
	else
	{
	sleep 800
	ControlClick,Button2
	tipshow("搜索完毕，进入下一轮替换")
	}
}
	return
结束替换关闭替换窗口:
	tipshow("结束替换,关闭替换窗口")
	ifwinexist 查找和替换 ahk_class bosa_sdm_Microsoft Office Word 11.0
	winclose
	return

;;///////////////////////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MathType公式编辑器
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive ahk_class EQNWINCLASS
sc079 & x::
F4::
	winclose ahk_class EQNWINCLASS
	return 
Mbutton::
	click
	winset,AlwaysOnTop,, A
	return
^+/::
	var_show = 鼠标中键 `t公式编辑器置顶`nF4||无变换+x: `t关闭公式编辑器并插入公式
	talkshow(var_show,3000)
	return


;;//////////////////////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive ahk_class Notepad2 ;记事本
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sc07b & 0::
  send !t!u
  return
sc07b & =::
  send !so{enter}
	WinGet, ExStyle, ExStyle, A
	if not(ExStyle & 0x1000000) 
  WinMaximize, A
	return

sc07b & -::
  send !so{enter}
  WinRestore , A
	winmove, A,,A_ScreenWidth-450-20,A_ScreenHeight-260,450,230
	return
;;/////////////////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Word 里设置颜色时，回车完全确定
/*
#ifwinactive 颜色 ahk_class bosa_sdm_Microsoft Office Word 11.0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enter::
	click 280,44
	sleep 300
	ifwinactive 边框和底纹 ahk_class bosa_sdm_Microsoft Office Word 11.0,,3
	{
		click 390,355
	}
*/
#ifwinactive
