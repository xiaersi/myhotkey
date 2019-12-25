;;进入特殊模式，用键盘来控制鼠标滚动，以及将方向键等功能键映射到左手位置，鼠标操作映射到右手位置

#SingleInstance ignore	;只运行一次，禁止多次运行

#include ..\

::;muosou::
	run D:\Program Files\魔兽争霸3冰封王座V1.17简体中文硬盘版\Frozen Throne.exe
	return

mytip(stringvar,second=800)
{
	tooltip %stringvar%
	sleep %second%
	tooltip
}
InputFun()
{
	input inputvar, T1 L1, {lbutton}{rbutton}{F1}{F2}{F3}{f4}
	RETURN inputvar
}

AllAttack1(arrackWith2=false)
{
	global varF1P1,varF2P1,varF3P1
	MouseGetPos, mouseX, mouseY
	send {f1}%varF1P1%
	click %mouseX%, %mouseY%
	send {f2}%varF2P1%
	click %mouseX%, %mouseY%
	send {f3}%varF3P1%
	click %mouseX%, %mouseY%
;	send 
	if arrackWith2
	{
	send 2a
	click %mouseX%, %mouseY%
	mytip("[全体强烈攻击]")
	}
	else
	{
	mytip("[全体攻击]")
	}
	send {Alt down}
	sleep 800
	send {alt up}
	RETURN

}

AllAttack2(arrackWith2=false)
{
	global varF1P1,varF2P1,varF3P1
	MouseGetPos, mouseX, mouseY
	send {f1}%varF1P2%
	click %mouseX%, %mouseY%
	send {f2}%varF2P2%
	click %mouseX%, %mouseY%
	send {f3}%varF3P2%
	click %mouseX%, %mouseY%
;	send 
	if arrackWith2
	{
	send 2a
	click %mouseX%, %mouseY%
	mytip("《全体强烈攻击》")
	}
	else
	{
	mytip("《全体攻击》")
	}
	send {Alt down}
	sleep 1000
	send {alt up}
	RETURN

}

StopAttack()
{
	MouseGetPos, mouseX, mouseY
	send 8
	rightclick %mouseX%, %mouseY%
	send 9
	rightclick %mouseX%, %mouseY%
	sleep 200
	send {f1}
	rightclick %mouseX%, %mouseY%
	sleep 200
	send {f2}
	rightclick %mouseX%, %mouseY%
	sleep 200
	send {f3}
	rightclick %mouseX%, %mouseY%
	sleep 200
	send 0
	rightclick %mouseX%, %mouseY%

}

moveslecect()
{
	MouseGetPos, mouseX, mouseY
	rightclick %mouseX%, %mouseY%
}

#ifwinactive Warcraft III ahk_class Warcraft III
SC07B::LAlt
`::f1
#::
lwin::
	return
F4 & f5::
	reload
	tooltip reloaded
	sleep 1000
	tooltip
	return
;攻击
f4 & t::
	if isSecondAttack
	  AllAttack2(true)
	else
	  AllAttack1(true)
	return

~4 & lbutton::
F4 & lBUTTON::
	if isSecondAttack
	  AllAttack2()
	else
	  AllAttack1()
	return

!wheeldown::
~4 & rbutton::
f4 & R::
f4 & RButton::
	StopAttack()
	return

!lbutton::
	MouseGetPos, mouseX, mouseY
	send {f1}
	rightclick %mouseX%, %mouseY%
	sleep 200
	send {f2}
	rightclick %mouseX%, %mouseY%
	sleep 200
	send {f3}
	rightclick %mouseX%, %mouseY%
	return

~f1 & lbutton::
	MouseGetPos, mouseX, mouseY
	send {f1}%varF1P1%
	click %mouseX%, %mouseY%
	return

~f1 & wheelup::
	MouseGetPos, mouseX, mouseY
	send {f1}%varF1P2%
	click %mouseX%, %mouseY%
	return

~f1 & rbutton::
	moveslecect()
	return
~f2 & rbutton::
	moveslecect()
	return
~f3 & rbutton::
	moveslecect()
	return

;防守休养
!rbutton::
~f5 & lbutton::
	MouseGetPos, mouseX, mouseY
	if(jiaxuehero=1)
	{
	  send {f1}t
	  click %mouseX%, %mouseY%
	}
	else if(jiaxuehero=2)
	{  
	  send {f2}t
	  click %mouseX%, %mouseY%
	}
	else if(jiaxuehero=3)
	{  
	  send {f3}t
	  click %mouseX%, %mouseY%
	}
	else
	{  
	  mytip("请设置加血英雄ID")
	  jiaxuehero := inputfun()
	}
	return

;设置英雄的功能
~f1 & M::
	varF1P1 = T
	varF1P2 = C
	shanqiuhero = 1
	return

~f2 & M::
	varF2P1 = T
	varF2P2 = C
	shanqiuhero = 2
	return
	
~f3 & M::
	varF3P1 = T
	varF3P2 = C
	shanqiuhero = 3
	return

~f1 & a::
	varF1P1 = 
	varF1P2 = w
	fashihero = 1
	return

~f2 & a::
	varF2P1 = 
	varF2P2 = w
	fashihero = 2
	return
	
~f3 & a::
	varF3P1 = 
	varF3P2 = w
	fashihero = 3
	return
;;加血英语
~f1 & l::
	varF1P1 = 
	varF1P2 = w
	jiaxuehero = 1
	return

~f2 & l::
	varF2P1 = 
	varF2P2 = w
	jiaxuehero = 2
	return
	
~f3 & l::
	varF3P1 = 
	varF3P2 = w
	jiaxuehero = 3
	return

~f1 & 1::
	sleep 100
	input varF1P1, T2 L1, {lbutton}{rbutton}
	tipVar = F1P1=%varF1P1%
	mytip(%tipVar%)
	RETURN 
~f1 & 2::
	sleep 100
	input varF1P2, T2 L1, {lbutton}{rbutton}
	tipVar = F1P2=%varF1P2%
	mytip(%tipVar%)
	RETURN 

~f2 & 1::
	sleep 100
	input varF2P1, T2 L1, {lbutton}{rbutton}
	tipVar = F2P1=%varF2P1%
	mytip(%tipVar%)
	RETURN 
~f2 & 2::
	sleep 100
	input varF2P2, T2 L1, {lbutton}{rbutton}
	tipVar = F2P2=%varF2P2%
	mytip(%tipVar%)
	RETURN 

~f3 & 1::
	sleep 100
	input varF3P1, T2 L1, {lbutton}{rbutton}
	tipVar = F3P1=%varF3P1%
	mytip(%tipVar%)
	RETURN 
~f3 & 2::
	sleep 100
	input varF3P2, T2 L1, {lbutton}{rbutton}
	tipVar = F3P2=%varF3P2%
	mytip(%tipVar%)
	RETURN 



^b::
Mbutton & 1::
	send {shift down}1{shift up}
	mytip("+1")
	return
Mbutton & 2::
	send {shift down}2{shift up}
	mytip("+2")
	return 
Mbutton & 3::
	send {shift down}3{shift up}
	mytip("+3")
	return 
Mbutton & 4::
	send {shift down}4{shift up}
	mytip("+4")
	return 
Mbutton & 5::
	send {shift down}5{shift up}
	mytip("+5")
	return 
Mbutton & 6::
	send {shift down}6{shift up}
	mytip("+6")
	return 
Mbutton & 7::
	send {shift down}7{shift up}
	mytip("+7")
	return 
^n::
Mbutton & 8::
	send {shift down}8{shift up}
	mytip("+8")
	return 
^m::
^v::
Mbutton & 9::
	send {shift down}9{shift up}
	mytip("+9")
	return 
^p::
Mbutton & 0::
	send {shift down}0{shift up}
	mytip("+0")
	return 






f4 & f1::
	send {f1 2}
	return 

f4 & f2::
	send {f2 2}
	return 

f4 & f3::
	send {f3 2}
	return 

;wheelup::
;	tempVar := InputFun()
;;	if(tempVar="``")
;;	else if (tempVar="1")
;;	else if (tempVar="2")
;;	else if (tempVar="3")
;;	else if (tempVar="4")
;;	else if (tempVar="5")
;;	else if (tempVar="6")
;;	else if (tempVar="7")
;;	else if (tempVar="8")
;;	else if (tempVar="9")
;;	else if (tempVar="0")
;;	else 
;	RETURN 
;
;
;wheeldown::
;	tempVar := InputFun()
;	msgbox %tempVgar%
;	RETURN 


#ifwinactive

