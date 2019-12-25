
g_TxtFileList =
g_pdfFileList =
g_exe = 

Gui, Add, StatusBar,, 状态栏
Gui, Add, Button, x16 y20 w100 h30 g【指定工作目录】, 指定工作目录
Gui, Add, Edit, x126 y20 w700 h30 v_edtDir, %a_workingdir%

gui, Add, Button, x836 y20 w100 h30 g【退出】, 退出

Gui, Add, Button, x16 y60 w100 h30 g【选择转换程序】, 选择转换程序
Gui, Add, Edit, x126 y60 w700 h30 v_edtExe, 转换程序

gui, Add, Button, x836 y60 w100 h30 g【开始转换】, 开始转换 
gui, Add, Checkbox, x836 y110 w100 h30 v_Checked g【暂停复选框】, 暂停 

Gui, Add, Text, x526 y110 w220 h20 , 已经转换好的TXT文件
Gui, Add, ListBox, x526 y140 w420 h484 v_TxtListBox, TxtListBox

Gui, Add, Text, x16 y110 w470 h20 , 尚未处理的PDF文件
Gui, Add, ListBox, x16 y140 w480 h494 v_PdfListBox , PDFListBox

; Generated using SmartGUI Creator 4.0
Gui, Show, x262 y195 h643 w958,  PDF转换程序测试
Return

【退出】:
GuiClose:
ExitApp

【指定工作目录】:
	FileSelectFolder, OutputVar
	if OutputVar <>
	{
		GuiControl, Text, _edtDir, %OutputVar%
	}
	return

【选择转换程序】:
	FileSelectFile, var_SelectedFile, 3, %A_WorkingDir%, 选择PDF转换程序, 转换程序 (*.exe; *.ahk )

	if var_SelectedFile <>
	{
		GuiControl, Text, _edtExe, %var_SelectedFile%
	}

	return


【开始转换】:
	gui submit, nohide
	if _edtDir =
	{
		msgbox 没有选择工作目录
		return
	}
	ifnotexist %_edtDir%
	{
		msgbox 工作目录不存在！
		return
	}	
	if _edtExe =
	{
		msgbox 没有指定转换程序
		return
	}
	ifnotexist %_edtExe%
	{
		msgbox PDF转换程序不存在！
		return
	}
	g_exe := _edtExe

	SB_SetText("正在查找文件") 
	;; 清空当前listbox中的内容
	guicontrol , , _TxtListBox, |
	guiControl , , _PdfListBox, |
	g_txtCount = 0
	g_pdfCount = 0

	;; 查找TXT和PDF文件
	Loop, %_edtDir%\*.txt
    	g_TxtFileList = %g_TxtFileList%%A_LoopFileName%`n

	Loop, %_edtDir%\*.pdf
    	g_pdfFileList = %g_pdfFileList%%A_LoopFileName%`n		

	SB_SetText("正在分析TXT文件") 
	Loop, parse, g_TxtFileList, `n
	{
		if A_LoopField =  ; Ignore the blank item at the end of the list.
			continue

		var_temp := a_loopfield
		var_temp := strLeft2Sub( var_temp, ".txt" )
		/*
		ifinstring var_temp, $
		{
			var_temp := strRight2sub( var_temp, "$" )
			if var_temp =
				continue
		}
		*/
		guicontrol , , _TxtListBox, %a_loopfield%		
		g_txtCount++
		arr_txt%g_txtCount% := var_temp
	}
	SB_SetText("正在显示未转换的PDF文件！") 
	Loop, parse, g_PdfFileList, `n
	{
		if A_LoopField =  ; Ignore the blank item at the end of the list.
			continue

		var_temp := a_loopfield
		var_temp := strLeft2Sub( var_temp, ".pdf" )
		
		;; 检查是否已经转换成TXT文件
		/*
		bDeal := false
		loop %g_txtCount%
		{
			txtname := arr_txt%a_index%
			if ( var_temp == txtname )
			{
				bDeal := true
				break
			}
		}
		*/

		;; 如果该PDF已经转换完成，则跳过之
		if bDeal
			continue

		guicontrol , , _PdfListBox, %var_temp%		
		g_pdfCount++
		arr_pdf%g_pdfCount% := var_temp
	}	
	gosub 【正在转换文件】
	sleep 60000
	goto 【开始转换】
	return

【正在转换文件】:
	ifnotexist %g_exe%
	{
		msgbox 转换程序不存在！
		return
	}
	loop
	{
		if _Checked
		{
            sleep 3000                              ;; 已经被用户暂停
			continue
		}


		if g_pdfCount <= 0
			break
		var_PdfFileName := arr_pdf%g_pdfCount%
		var_PdfFile = %_edtDir%\%var_PdfFileName%.PDF
		var_txtFile = %_edtDir%\%var_PdfFileName%.txt
		var_tip = 正在转换 %var_PdfFile% ......
		SB_SetText( var_tip )
		Run, %comspec% /c %g_exe%   -layout -enc GBK   %var_PdfFile% %var_txtFile%
		;; 等待转换完成
		loop 
		{
			sleep 1000
			ifexist, %var_txtFile%
			{
				;; 文本文件如果只读，可能是还没有转换完，再等1秒
				FileGetAttrib, Attributes, %var_txtFile%
				IfInString, Attributes, R
					continue			
					
				var_datetime = %a_yyyy%%a_mm%%a_dd% %a_hour%_%a_min%_%a_sec%
				var_newfile = %_edtDir%\%var_PdfFileName% %var_datetime%.txt
				FileMove, %var_txtFile%, %var_newfile%, 1
				if ErrorLevel 
				{
					var_tip = : ( 重命名失败! %var_PdfFileName%  
					guicontrol , , _TxtListBox, %var_PdfFileName%.txt
				}
				else
				{
					var_tip = : ) 转换完成 %var_PdfFileName%  
					guicontrol , , _TxtListBox, %var_PdfFileName% %var_datetime%.txt
				}
				break 	
			}
		}
		SB_SetText( var_tip )

		arr_pdf%g_pdfCount% = 
		g_pdfCount--
		gosub 【刷新PDF列表】
	}
	return

【刷新PDF列表】:
	guiControl , , _PdfListBox, |
	loop %g_pdfCount%
	{
		var_temp := arr_pdf%a_index%
		guicontrol , , _PdfListBox, %var_temp%	
	}
	return

【暂停复选框】:
	gui submit, nohide
	if _Checked
	{
		GuiControl, Text, _Checked, 已暂停
	}
	else
	{
		GuiControl, Text, _Checked, 暂停
	}
	return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
StrLeft2Sub(varString,subString)
{
	StringGetPos, varPos, varString, %subString%
	if  errorlevel
	{ 
		return ""
	}
	stringleft varReturn,varString,%varPos%
	return %varReturn%
;举例..............................
;MyStringVar = squeezer::imageset
;Var := StrLeft2Sub(MyStringVar,"::")
;var 的值为squeezer
}

StrMid2Sub(varString,subString1,subString2)
{
	varTemp = 
	StringGetPos, varPos, varString, %subString1%
	if ErrorLevel 
	{
		return varTemp
	}
	varLen := strlen(subString1)
	varTemp := substr(varString,varPos+varLen+1)

	ifinstring varTemp,%subString2%
	{
		varTemp := StrLeft2Sub(varTemp,subString2)
	}
	else
	{
		varTemp =
		return varTemp
	}
;	msgbox varTemp=%varTemp%
	return varTemp
;举例............................
;str = [sec]
;var := StrMid2Sub(str, "[", "]")
;var 的值为 sec
}

;;--在varString中，从LR指定的方向搜索subString，并返回subString右边的字符串--
StrRight2Sub(varString,subString, LR="R1")
{
	StringGetPos varPos, varString, %subString%, %LR%
	stringleft varTemp,varString,%varPos%
	varLen := strlen(varTemp)
	varLen := strlen(varString) - varLen - strlen(subString)
	stringright varReturn,varString,%varLen%
	return %varReturn%
;举例..............................
;MyStringVar = squeezer::imageset
;fileExtVar = StrRight2Sub(MyStringVar,"::")
;fileExtVar的值为"imageset"
}

