
#include  .\inc\functions.aik

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAJ �����
::;set[caj]titlealttab::
	WinGetTitle title_alt_tab,A
	iniwrite %title_alt_tab%,var.ini,caj,titlealttab
	talkshow("�Ѿ���CAJ���л���������Ϊ��"+title_alt_tab)
	return

#ifwinactive CAJViewer 7.0 -,�������������ݣ�
title_alt_tab = �л�������Ч
sc070 & x::
f4::	;; �رյ�ǰ
	send !fc
	return
f7::		;;�������Ϲ���
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
;;���¡�������������ֻҪ�ƶ����Ϳ���ѡ��
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
		tooltip �Ѱ������
		settooltipvar(var_tooltip,"�Ѿ��������")
		}
	}
return
`::
	GetKeyState, state, LButton  
	if state = D
	{
	send {lbutton up}
;	tooltipshow("�ѵ���������")
	settooltipvar(var_tooltip,"�ѵ���������")
	}
	send {esc}
return 
;;ѡ���ı�
3::

	ifwinActive ,%title_caj%,%text_caj%
	{
		send !ts
	}
	return


;;����
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

;;���ι���
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
	    	tooltipshow("���Ƴɹ�")

	}
	else
	{
	    send {LButton down}
	    	tooltipshow("�Ѱ���������ٰ�C����...")
		settooltipvar(var_tooltip,"�Ѱ���������ٰ�C����...")
	}
	return

v::
	GetKeyState, state, LButton  
	if state = D
	{
		send {LButton up}^c{esc}
	    	copytoOneNote()
		send !{tab}
		tooltipshow("�Ѿ�����ѡ���ݷ��͵���OneNote")
		ifwinActive ,%title_caj%,%text_caj%
		tooltipshow("�ѷ���CAJViewer 7.0",1500)
		settooltipvar(var_tooltip,"�Ѱ���������ٰ�C����...")
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
;	talkshow("���������л����ڰ�")

	if(title_alt_tab="")
	{
		iniread title_alt_tab,var.ini,caj,titlealttab
;		var_talkshow=��Var.ini�ļ���ȡ�л����ڱ���Ϊ��%title_alt_tab%

	}
	ifwinexist %title_alt_tab%
		winactivate
	else
	{
		iniread title_alt_tab,var.ini,caj,titlealttab
		var_talkshow=�л�������Ч:`n�������л����Ĵ��ں���������<;set[caj]titlealttab>���øô���ΪCAJ���л�����
	}
	talkshow(var_talkshow)
	return

;; Foxit Reader1.3, ��Ч
#ifwinactive  ,,��ת��ͼ������ 
sc07b::
f7::		;;�������Ϲ���
	MouseClick, WheelUp, , , 3
	return
sc079::
f8::
	MouseClick, WheelDown, , , 3
	return
#ifwinactive