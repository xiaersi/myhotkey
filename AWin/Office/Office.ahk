; Winword �����У�pageup,pagedown�ֱ����¹���
#include .\inc\functions.inc


;;//////////////////////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Word����
#ifwinactive ahk_class OpusApp,MsoDockTop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sc07b::
f7::		;;�������Ϲ���
	MouseClick, WheelUp, , , %var_wheelnum%
	return
sc079::
f8::
	MouseClick, WheelDown, , , %var_wheelnum%
	return

f9::
	send ^c!{tab}
	return
f10:: 	;;word��ѡ����ճ��
	ifwinactive ahk_class OpusApp,Microsoft Word �ĵ�
	{
	send !es
	sleep 300
	send {end}
	send {enter}
	}
	return

;;---------------------------------------------------------
;;�������������ַ�
^+2::
	send !op
	winwait ���� ahk_class bosa_sdm_Microsoft Office Word 11.0
	winactivate
	send {tab 4}{up 2}{down}{tab}2
	return
^+m::	;������ע
	send !im
	return
^+o:: 	;��Ŀ����
	send !on!b{tab}{right}
	return
^+p:: 	;���
	send !on!n{tab}{right}
	return
^+z::
	talkshow("Ctr+shift+2: �������������ַ�`nCtr+shift+m: ������ע`nCtr+shift+o: ��Ŀ����`nCtr+shift+p: ���`nCtr+shift+h: �ֲ��滻",3000)
	return
^+/::
	var_show = Ctr+shift+2: `t�������������ַ�`nCtr+shift+m: `t������ע`nCtr+shift+o: `t��Ŀ���ţ�^+p::��ţ�`n��Alt+0`t||�ޱ任+0: `t����/��ʾ������`n��Alt+=`t||�ޱ任+=: `tWord���`n��Alt+-`t||�ޱ任+-: `tWord��С�����½� `n�ޱ任+e||�ޱ任+v: `tѡ����ճ��
	talkshow(var_show,5000)
	return
;;---------------------------------------------------word--------
sc07b & z::
	var_show = ��Alt+0`t||�ޱ任+0: `t����/��ʾ������`n��Alt+=`t||�ޱ任+=: `tWord���`n��Alt+-`t||�ޱ任+-: `tWord��С�����½� `n�ޱ任+e||�ޱ任+v: `tѡ����ճ��
	talkshow(var_show,4000)
	return

sc07b & 0::	; ����/��ʾ������
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
sc079 & e::	;;word��ѡ����ճ��
	ifwinactive ahk_class OpusApp,Microsoft Word �ĵ�
	{
	send !es
	sleep 300
	send {end}
	}
	return

sc07b & d::	; �ޱ任+D �޸ı����ɫ
	click right
	send b
	winwait �߿�͵��� ahk_class bosa_sdm_Microsoft Office Word 11.0,,3
	if(ErrorLevel) 
	{
		talkshow(" ���߿�͵��ơ� ����û�г���")
		sleep 3000
		return
	}
	send !o
	winwait ��ɫ ahk_class bosa_sdm_Microsoft Office Word 11.0
	if(ErrorLevel) 
	{
		talkshow(" ���߿�͵��ơ� ����û�г���")
		sleep 3000
		return
	}
	click 90,44
;	click 113,258
	send {tab 4}
	return

;------------------------------------------------------word--
^+H:: 	;�ֲ��滻�������滻
	send ^h
	winwait ���Һ��滻 ahk_class bosa_sdm_Microsoft Office Word 11.0,,3
	if errorlevel
		return
loop
{
	if(a_index=1) 
	{
	var_before = :
	var_after = ��
	}
	else if(a_index=2) 
	{
	var_before =`;
	var_after =��
	}
	else if(a_index=3) 
	{
	var_before =`,
	var_after =��
	}
	else if(a_index>=4) 
	{
	InputBox, var_before,�����滻,�Ѿ��滻%a_index%�Σ���Ҫ�滻��������,,300,120
	if (var_before="")
		goto,�����滻�ر��滻����
	InputBox, var_after,�滻Ϊ,��%var_before%�滻Ϊʲô��,,300,120
	}

	ifwinexist ���Һ��滻 ahk_class bosa_sdm_Microsoft Office Word 11.0
	{
		tooltip �ȴ����� %var_before% ���滻Ϊ���� %var_after% ��
		ControlSetText,RichEdit20W1,%var_before%
		ControlSetText,RichEdit20W2,%var_after%
	}
	else
	{
		tipshow(" �滻�����Ѿ��رգ������˳�",2000)
		return
	}
	winwait Microsoft Office Word ahk_class #32770,Word ����ɶ���ѡ���ݵ�����,20
;	pleasewait("Microsoft Office Word ahk_class #32770","Word ����ɶ���ѡ���ݵ�����",1000)

	if  errorlevel
	{
	msgbox 4,��ʱ,�ȴ�������ϳ�ʱ���Ƿ������һ���滻��,5
	ifmsgbox No
		goto,�����滻�ر��滻����
	}
	else
	{
	sleep 800
	ControlClick,Button2
	tipshow("������ϣ�������һ���滻")
	}
}
	return
�����滻�ر��滻����:
	tipshow("�����滻,�ر��滻����")
	ifwinexist ���Һ��滻 ahk_class bosa_sdm_Microsoft Office Word 11.0
	winclose
	return

;;///////////////////////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MathType��ʽ�༭��
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
	var_show = ����м� `t��ʽ�༭���ö�`nF4||�ޱ任+x: `t�رչ�ʽ�༭�������빫ʽ
	talkshow(var_show,3000)
	return


;;//////////////////////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive ahk_class Notepad2 ;���±�
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
;; Word ��������ɫʱ���س���ȫȷ��
/*
#ifwinactive ��ɫ ahk_class bosa_sdm_Microsoft Office Word 11.0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enter::
	click 280,44
	sleep 300
	ifwinactive �߿�͵��� ahk_class bosa_sdm_Microsoft Office Word 11.0,,3
	{
		click 390,355
	}
*/
#ifwinactive
