
g_TxtFileList =
g_pdfFileList =
g_exe = 

Gui, Add, StatusBar,, ״̬��
Gui, Add, Button, x16 y20 w100 h30 g��ָ������Ŀ¼��, ָ������Ŀ¼
Gui, Add, Edit, x126 y20 w700 h30 v_edtDir, %a_workingdir%

gui, Add, Button, x836 y20 w100 h30 g���˳���, �˳�

Gui, Add, Button, x16 y60 w100 h30 g��ѡ��ת������, ѡ��ת������
Gui, Add, Edit, x126 y60 w700 h30 v_edtExe, ת������

gui, Add, Button, x836 y60 w100 h30 g����ʼת����, ��ʼת�� 
gui, Add, Checkbox, x836 y110 w100 h30 v_Checked g����ͣ��ѡ��, ��ͣ 

Gui, Add, Text, x526 y110 w220 h20 , �Ѿ�ת���õ�TXT�ļ�
Gui, Add, ListBox, x526 y140 w420 h484 v_TxtListBox, TxtListBox

Gui, Add, Text, x16 y110 w470 h20 , ��δ�����PDF�ļ�
Gui, Add, ListBox, x16 y140 w480 h494 v_PdfListBox , PDFListBox

; Generated using SmartGUI Creator 4.0
Gui, Show, x262 y195 h643 w958,  PDFת���������
Return

���˳���:
GuiClose:
ExitApp

��ָ������Ŀ¼��:
	FileSelectFolder, OutputVar
	if OutputVar <>
	{
		GuiControl, Text, _edtDir, %OutputVar%
	}
	return

��ѡ��ת������:
	FileSelectFile, var_SelectedFile, 3, %A_WorkingDir%, ѡ��PDFת������, ת������ (*.exe; *.ahk )

	if var_SelectedFile <>
	{
		GuiControl, Text, _edtExe, %var_SelectedFile%
	}

	return


����ʼת����:
	gui submit, nohide
	if _edtDir =
	{
		msgbox û��ѡ����Ŀ¼
		return
	}
	ifnotexist %_edtDir%
	{
		msgbox ����Ŀ¼�����ڣ�
		return
	}	
	if _edtExe =
	{
		msgbox û��ָ��ת������
		return
	}
	ifnotexist %_edtExe%
	{
		msgbox PDFת�����򲻴��ڣ�
		return
	}
	g_exe := _edtExe

	SB_SetText("���ڲ����ļ�") 
	;; ��յ�ǰlistbox�е�����
	guicontrol , , _TxtListBox, |
	guiControl , , _PdfListBox, |
	g_txtCount = 0
	g_pdfCount = 0

	;; ����TXT��PDF�ļ�
	Loop, %_edtDir%\*.txt
    	g_TxtFileList = %g_TxtFileList%%A_LoopFileName%`n

	Loop, %_edtDir%\*.pdf
    	g_pdfFileList = %g_pdfFileList%%A_LoopFileName%`n		

	SB_SetText("���ڷ���TXT�ļ�") 
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
	SB_SetText("������ʾδת����PDF�ļ���") 
	Loop, parse, g_PdfFileList, `n
	{
		if A_LoopField =  ; Ignore the blank item at the end of the list.
			continue

		var_temp := a_loopfield
		var_temp := strLeft2Sub( var_temp, ".pdf" )
		
		;; ����Ƿ��Ѿ�ת����TXT�ļ�
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

		;; �����PDF�Ѿ�ת����ɣ�������֮
		if bDeal
			continue

		guicontrol , , _PdfListBox, %var_temp%		
		g_pdfCount++
		arr_pdf%g_pdfCount% := var_temp
	}	
	gosub ������ת���ļ���
	sleep 60000
	goto ����ʼת����
	return

������ת���ļ���:
	ifnotexist %g_exe%
	{
		msgbox ת�����򲻴��ڣ�
		return
	}
	loop
	{
		if _Checked
		{
            sleep 3000                              ;; �Ѿ����û���ͣ
			continue
		}


		if g_pdfCount <= 0
			break
		var_PdfFileName := arr_pdf%g_pdfCount%
		var_PdfFile = %_edtDir%\%var_PdfFileName%.PDF
		var_txtFile = %_edtDir%\%var_PdfFileName%.txt
		var_tip = ����ת�� %var_PdfFile% ......
		SB_SetText( var_tip )
		Run, %comspec% /c %g_exe%   -layout -enc GBK   %var_PdfFile% %var_txtFile%
		;; �ȴ�ת�����
		loop 
		{
			sleep 1000
			ifexist, %var_txtFile%
			{
				;; �ı��ļ����ֻ���������ǻ�û��ת���꣬�ٵ�1��
				FileGetAttrib, Attributes, %var_txtFile%
				IfInString, Attributes, R
					continue			
					
				var_datetime = %a_yyyy%%a_mm%%a_dd% %a_hour%_%a_min%_%a_sec%
				var_newfile = %_edtDir%\%var_PdfFileName% %var_datetime%.txt
				FileMove, %var_txtFile%, %var_newfile%, 1
				if ErrorLevel 
				{
					var_tip = : ( ������ʧ��! %var_PdfFileName%  
					guicontrol , , _TxtListBox, %var_PdfFileName%.txt
				}
				else
				{
					var_tip = : ) ת����� %var_PdfFileName%  
					guicontrol , , _TxtListBox, %var_PdfFileName% %var_datetime%.txt
				}
				break 	
			}
		}
		SB_SetText( var_tip )

		arr_pdf%g_pdfCount% = 
		g_pdfCount--
		gosub ��ˢ��PDF�б�
	}
	return

��ˢ��PDF�б�:
	guiControl , , _PdfListBox, |
	loop %g_pdfCount%
	{
		var_temp := arr_pdf%a_index%
		guicontrol , , _PdfListBox, %var_temp%	
	}
	return

����ͣ��ѡ��:
	gui submit, nohide
	if _Checked
	{
		GuiControl, Text, _Checked, ����ͣ
	}
	else
	{
		GuiControl, Text, _Checked, ��ͣ
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
;����..............................
;MyStringVar = squeezer::imageset
;Var := StrLeft2Sub(MyStringVar,"::")
;var ��ֵΪsqueezer
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
;����............................
;str = [sec]
;var := StrMid2Sub(str, "[", "]")
;var ��ֵΪ sec
}

;;--��varString�У���LRָ���ķ�������subString��������subString�ұߵ��ַ���--
StrRight2Sub(varString,subString, LR="R1")
{
	StringGetPos varPos, varString, %subString%, %LR%
	stringleft varTemp,varString,%varPos%
	varLen := strlen(varTemp)
	varLen := strlen(varString) - varLen - strlen(subString)
	stringright varReturn,varString,%varLen%
	return %varReturn%
;����..............................
;MyStringVar = squeezer::imageset
;fileExtVar = StrRight2Sub(MyStringVar,"::")
;fileExtVar��ֵΪ"imageset"
}

