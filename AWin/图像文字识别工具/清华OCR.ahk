SetTitleMatchMode 2

g_inifile = 清华TH-OCR.ini


【加载文件】:
	g_inimem := IniFileRead(g_inifile)
	SecValueArrayFromIniMem( g_inimem, "REPLACE_WORD", "KeyArray", "ValueArray")
	g_inimem =
	return


#ifwinactive 清华TH-OCR V9.0 专业版


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
^+a::	;; 新增替换词汇
F6::
	if clipboard =
	{
		tooltip7("请复制要替换的词汇")
		return
	}
	var_replace := clipboard
	var_tip = `"%var_replace%`" 要替换成什么？
	newword := myinput("清华OCR--新增替换词汇", var_tip)
	if newword <>
	{
		var_temp := read_ini(g_inifile, "REPLACE_WORD", newword)
		if var_temp <>
		{
			ifinstring var_temp, %var_replace%
			{
				var_tip = %var_replace%  已添加到 %newword%
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
		gosub 【加载文件】
		tooltip7("新增成功")
	}
	return

insert::
!i::
	sendplay {insert}
	return


+F2::		;; 定位到左侧树结构末尾，并按F2识别
	ControlFocus SysTreeView321, 清华TH-OCR V9.0 专业版
	send {f2}
	sleep 1000
	send {right}	;; 按右键展开识别好的文本文件
	return

#ifwinactive HyperSnap 6 
F2::		;; 截屏的同时，保存为文件并使用OCR识别
    Send ^s
	filename = d:\000\snap\%a_yyyy%%a_mm%%a_dd% %a_hour%%a_min%%a_sec%.jpg
	WinWait, 另存为 ahk_class #32770, , 1
	IfWinActive  另存为 ahk_class #32770
	{
		ControlSetText, Edit1, %filename%, 另存为 ahk_class #32770
		sleep 50
		ControlClick , Button2, 另存为 ahk_class #32770
		sleep 100
		loop 5
		{
			sleep 200
			IfExist, %filename%
			{
				WinActivate  清华TH-OCR V9.0 专业版
				sleep 300
				IfWinNotActive 清华TH-OCR V9.0 专业版
					sleep 200
				IfWinNotActive 清华TH-OCR V9.0 专业版
					sleep 200

				IfWinActive 清华TH-OCR V9.0 专业版
				{
					;; 打开刚才保存的图片文件
					send !fo
					WinWaitActive 打开 ahk_class #32770,,1
					IfWinActive 打开 ahk_class #32770
					{
						Control, choose, 5, ComboBox2, 打开 ahk_class #32770
						sleep 50
						ControlSetText Edit1, %filename%, 打开 ahk_class #32770
						sleep 50
						send {enter}
						ControlClick, Button2, 打开 ahk_class #32770
					}
					;; 将鼠标移动到左侧
					MouseMove 160, 300
					sleep 600
					;; 文件打开完毕后，自动定位到打开的文件，并识别
					ControlFocus SysTreeView321, 清华TH-OCR V9.0 专业版
					send {end}
					sleep 100
					send !cr  ;;  {f2}
					sleep 1000
					send {right}	;; 按右键展开识别好的文本文件
					send {end}
				}
				break
			}
		}
	}
	return




#ifwinactive ahk_class AcrobatSDIWindow  ;; Adobe Reader
F2::		;; 按F2截屏
	IfWinExist   HyperSnap 6
	{
		send ^+R  ;; 在启动HyperSnap时，ctrl+shift+R 区域截屏
	}
	return 


#ifwinactive


#ifwinexist ahk_class AcrobatSDIWindow  ;; Adobe Reader

F3::		;; F3 截屏选择框
	click
	var_temp =
	(
调整高度：
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
