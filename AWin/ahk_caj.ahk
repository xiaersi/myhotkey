
#include  .\inc\functions.aik

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAJ 浏览器
::;set[caj]titlealttab::
	WinGetTitle title_alt_tab,A
	iniwrite %title_alt_tab%,var.ini,caj,titlealttab
	talkshow("已经将CAJ的切换窗口设置为："+title_alt_tab)
	return

#ifwinactive CAJViewer 7.0 -,请输入搜索内容：
title_alt_tab = 切换窗口无效
sc070 & x::
f4::	;; 关闭当前
	send !fc
	return
f7::		;;滚轮向上滚动
	send {mbutton}
	MouseClick, WheelUp, , , 3
	return
f8::
	send {mbutton}
	MouseClick, WheelDown, , , 3
	return
/*
mbutton::
	GetKeyState, state, LButton  
	if state = D
	    send ^c{LButton up}
	else
	    send {LButton down}
	return

sc07b & mbutton::
	GetKeyState, state, LButton  

	if state = D
	    send ^c{LButton up}!{tab}^v
	else
	    send {LButton down}
	return
*/
;;按下、弹起鼠标左键，只要移动鼠标就可以选择
m::
d::
	ifwinActive ,%title_caj%,%text_caj%
	{
		if(is_clickdown)
		{
		is_clickdown := false
		send {lbutton up}
		copytoOneNote()
		tooltip 
	;	sendevent !{tab}
		click
		}
		else
		{
		send {lbutton down}
		is_clickdown := true
		tooltip 已按下左键
		settooltipvar(var_tooltip,"已经按下左键")
		}
	}
return
`::
	GetKeyState, state, LButton  
	if state = D
	{
	send {lbutton up}
;	tooltipshow("已弹起鼠标左键")
	settooltipvar(var_tooltip,"已弹起鼠标左键")
	}
	send {esc}
return 
;;选中文本
3::

	ifwinActive ,%title_caj%,%text_caj%
	{
		send !ts
	}
	return


;;画线
1::
	ifwinActive ,%title_caj%,%text_caj%
	{
		send !tu
		keywait,f

		GetKeyState, state, f
		if state = U
		{
		send !ts
		}
	}
	return

;;手形工具
2::
	ifwinActive ,%title_caj%,%text_caj%
	{
		send !th
		keywait,h

		GetKeyState, state, h
		if state = U
		{
		send !ts
		}
	}
	return

4::
	send !tn
	return

c::
	ifwinnotActive ,%title_caj%,%text_caj%
	{
		return
	}
	GetKeyState, state, LButton  
	if state = D
	{
	    send ^c{LButton up}{esc}
	    	tooltipshow("复制成功")

	}
	else
	{
	    send {LButton down}
	    	tooltipshow("已按下左键，再按C复制...")
		settooltipvar(var_tooltip,"已按下左键，再按C复制...")
	}
	return

v::
	GetKeyState, state, LButton  
	if state = D
	{
		send {LButton up}^c{esc}
	    	copytoOneNote()
		send !{tab}
		tooltipshow("已经将所选内容发送到了OneNote")
		ifwinActive ,%title_caj%,%text_caj%
		tooltipshow("已返回CAJViewer 7.0",1500)
		settooltipvar(var_tooltip,"已按下左键，再按C复制...")
	}
	return

	
k::
	ifwinActive ,%title_caj%,%text_caj%
	{
		send {down 3}
	}
	return
i::
	ifwinActive ,%title_caj%,%text_caj%
	{
		send {up 3}
	}
	return

sc079::
s::
j::
	ifwinActive ,%title_caj%,%text_caj%
	{
		send {down 6}
	}
	return
sc07b::
u::
w::
	ifwinActive ,%title_caj%,%text_caj%
	{
		send {up 6}
	}
	return
f::
g::
	ifwinActive ,%title_caj%,%text_caj%
	{
		send {pgup}
	}
	return
b::
	ifwinActive ,%title_caj%,%text_caj%
	{
		send {pgdn}
	}
	return
t::
sc079 & t::
;	talkshow("你现在想切换窗口吧")

	if(title_alt_tab="")
	{
		iniread title_alt_tab,var.ini,caj,titlealttab
;		var_talkshow=从Var.ini文件读取切换窗口标题为：%title_alt_tab%

	}
	ifwinexist %title_alt_tab%
		winactivate
	else
	{
		iniread title_alt_tab,var.ini,caj,titlealttab
		var_talkshow=切换窗口无效:`n激活想切换到的窗口后，输入命令<;set[caj]titlealttab>设置该窗口为CAJ的切换窗口
	}
	talkshow(var_talkshow)
	return

;; Foxit Reader1.3, 无效
#ifwinactive  ,,旋转视图工具栏 
sc07b::
f7::		;;滚轮向上滚动
	MouseClick, WheelUp, , , 3
	return
sc079::
f8::
	MouseClick, WheelDown, , , 3
	return
#ifwinactive