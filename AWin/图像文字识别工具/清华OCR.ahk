SetTitleMatchMode 2

g_inifile = �廪TH-OCR.ini


�������ļ���:
	g_inimem := IniFileRead(g_inifile)
	SecValueArrayFromIniMem( g_inimem, "REPLACE_WORD", "KeyArray", "ValueArray")
	g_inimem =
	return


#ifwinactive �廪TH-OCR V9.0 רҵ��


^+F5::
	reload
	return


^+v::
	clipboard =
	sleep 50
	send ^c
	sleep 50
F7::
	var_temp := clipboard
;	msgbox KeyArray0 = %KeyArray0%
	loop %KeyArray0%
	{
		var_key := KeyArray%a_index%
		var_value := ValueArray%a_index%
	; msgbox key = %var_key%`nvalue = %var_value%
		if  var_key =
			continue
		if  var_value =
			continue
		
 		var_temp := RegexReplace(var_temp, var_value, var_key )
	}
	clipboard := var_temp
	send ^v
	return


^+=::
^+c::
	send ^c
	sleep 50
^+a::	;; �����滻�ʻ�
F6::
	if clipboard =
	{
		tooltip7("�븴��Ҫ�滻�Ĵʻ�")
		return
	}
	var_replace := clipboard
	var_tip = `"%var_replace%`" Ҫ�滻��ʲô��
	newword := myinput("�廪OCR--�����滻�ʻ�", var_tip)
	if newword <>
	{
		var_temp := read_ini(g_inifile, "REPLACE_WORD", newword)
		if var_temp <>
		{
			ifinstring var_temp, %var_replace%
			{
				var_tip = %var_replace%  ����ӵ� %newword%
				tooltip7(var_tip)
				return
			}
			ifinstring var_temp, )
				StringReplace var_temp, var_temp, ), |%var_replace%)
			else
				var_temp = (%var_temp%|%var_replace%)
		}
		else
		{
			var_temp := var_replace
		}
		write_ini(g_inifile, "REPLACE_WORD", newword, var_temp, true)
		gosub �������ļ���
		tooltip7("�����ɹ�")
	}
	return

insert::
!i::
	sendplay {insert}
	return


+F2::		;; ��λ��������ṹĩβ������F2ʶ��
	ControlFocus SysTreeView321, �廪TH-OCR V9.0 רҵ��
	send {f2}
	sleep 1000
	send {right}	;; ���Ҽ�չ��ʶ��õ��ı��ļ�
	return

#ifwinactive HyperSnap 6 
F2::		;; ������ͬʱ������Ϊ�ļ���ʹ��OCRʶ��
    Send ^s
	filename = d:\000\snap\%a_yyyy%%a_mm%%a_dd% %a_hour%%a_min%%a_sec%.jpg
	WinWait, ���Ϊ ahk_class #32770, , 1
	IfWinActive  ���Ϊ ahk_class #32770
	{
		ControlSetText, Edit1, %filename%, ���Ϊ ahk_class #32770
		sleep 50
		ControlClick , Button2, ���Ϊ ahk_class #32770
		sleep 100
		loop 5
		{
			sleep 200
			IfExist, %filename%
			{
				WinActivate  �廪TH-OCR V9.0 רҵ��
				sleep 300
				IfWinNotActive �廪TH-OCR V9.0 רҵ��
					sleep 200
				IfWinNotActive �廪TH-OCR V9.0 רҵ��
					sleep 200

				IfWinActive �廪TH-OCR V9.0 רҵ��
				{
					;; �򿪸ղű����ͼƬ�ļ�
					send !fo
					WinWaitActive �� ahk_class #32770,,1
					IfWinActive �� ahk_class #32770
					{
						Control, choose, 5, ComboBox2, �� ahk_class #32770
						sleep 50
						ControlSetText Edit1, %filename%, �� ahk_class #32770
						sleep 50
						send {enter}
						ControlClick, Button2, �� ahk_class #32770
					}
					;; ������ƶ������
					MouseMove 160, 300
					sleep 600
					;; �ļ�����Ϻ��Զ���λ���򿪵��ļ�����ʶ��
					ControlFocus SysTreeView321, �廪TH-OCR V9.0 רҵ��
					send {end}
					sleep 100
					send !cr  ;;  {f2}
					sleep 1000
					send {right}	;; ���Ҽ�չ��ʶ��õ��ı��ļ�
					send {end}
				}
				break
			}
		}
	}
	return




#ifwinactive ahk_class AcrobatSDIWindow  ;; Adobe Reader
F2::		;; ��F2����
	IfWinExist   HyperSnap 6
	{
		send ^+R  ;; ������HyperSnapʱ��ctrl+shift+R �������
	}
	return 


#ifwinactive


#ifwinexist ahk_class AcrobatSDIWindow  ;; Adobe Reader

F3::		;; F3 ����ѡ���
	click
	var_temp =
	(
�����߶ȣ�
1 100, 	2 138
3 177,	4 198
5 213,	6 220
7 250
	)
	tooltip %var_temp%, A_ScreenWidth-200, 0
	var_temp =
	Input , var_temp, T2 L1
	if var_temp = 1
		MouseMove, 212, 100 , 0, R
	else if var_temp = 2
		MouseMove, 212, 140 , 0, R
	else if var_temp = 3
		MouseMove, 212, 177 , 0, R
	else if var_temp = 4
		MouseMove, 212, 197 , 0, R
	else if var_temp = 5
		MouseMove, 212, 213 , 0, R
	else if var_temp = 6
		MouseMove, 212, 220 , 0, R
	else if var_temp = 7
		MouseMove, 212, 250 , 0, R
	else 
		MouseMove, 212, 177 , 0, R

	tooltip
	return
#ifwinexist

#include ../../
#include inc/inifile.aik
#include inc/common.aik
#include inc/tip.aik
