; ��PDFתTXT��Ŀ�в����Ľ����־���з�������ת���ɹ���ת��ʧ�ܰ�ԭ����й��ࡣ

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StrLeft2Sub(SearchString, Needle ) ��SearchString�ַ�����Ѱ���Ӵ�Needle
;; �ҵ�Needle���ȡ������ߣ���Ϊ���ַ������أ��ٸ����ӣ�
;; SearchString = squeezer@imageset
;; Needle  = @
;; OutString = StrLeft2Sub( SearchString, Needle  )
;; ��ô�õ���OutString��ֵΪsqueezer

#include ..\..\..\

#include inc\string.aik
/*
StrLeft2Sub(SearchString, Needle )
{
	StringGetPos, varPos, SearchString, %Needle%
	if  errorlevel
	{ 
		return ""
	}
	stringleft varReturn, SearchString, %varPos%
	return %varReturn%
}


StrMid2Sub(varString,subString1,subString2)
{
	StringGetPos, varPos, varString, %subString1%
	if errorlevel
	{
		return ""
	}
	varLen := strlen(subString1)
	varTemp := substr(varString,varPos+varLen+1)

	ifinstring varTemp,%subString2%
	  varTemp := StrLeft2Sub(varTemp,subString2)
;	msgbox varTemp=%varTemp%
	return varTemp
}

StrRight2Sub(varString,subString)
{
	StringGetPos varPos, varString, %subString% , R1
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
*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
var_SelectedFile = %1%
if var_SelectedFile = 
{
	FileSelectFile, var_SelectedFile, 3, %A_WorkingDir%, ѡ����Ҫ��������־�ļ�, Log Documents (*.txt; *.log )
}
if var_SelectedFile =
{
    MsgBox, The user didn't select anything.
}
else
{
	g_pages := 0
	g_p2 := 0
	g_t1 := 0
	g_t2 := 0
	g_time := 0
	SplitPath, var_SelectedFile, , dir, ext, name_no_ext
	if name_no_ext =
	{
		MsgBox �ļ�·������`n%var_SelectedFile%
		return
	}
	var_outfile = %dir%\%name_no_ext%_rpt.%ext%
	FileDelete, %var_outfile%

	Loop, read, %var_SelectedFile%, %var_outfile%
	{
		if A_LoopReadLine =
			continue

		var_sub := StrRight2Sub( A_LoopReadLine, "[��������ҳ" )
		
		if var_sub =
			continue
		;; �������շ���ҳ
		var_page := StrLeft2Sub( var_sub, "��,�ķ�1:")
		
		if var_page is not integer
		{
			msgbox ���շ���ҳ����[%var_page%]��`nvar_sub=%var_sub%`n%A_LoopReadLine%
			return
		}
		g_pages := g_pages + var_page
		
		;; �ķ�ʱ�� 
		var_sub := StrRight2Sub( var_sub, "��,�ķ�1: " )
		var_t1 := StrLeft2Sub( var_sub, "��][ˢ���б�ҳ")
		strtrim( var_t1 )
		g_t1 := var_t1 + g_t1


		var_sub := StrRight2Sub( var_sub, "��][ˢ���б�ҳ" )
		var_p2 := StrLeft2Sub( var_sub, "��,�ķ�2:")
		strtrim( var_p2 )
		g_p2 := var_p2 + g_p2

		var_sub := StrRight2Sub( var_sub, "��,�ķ�2:" )
		var_t2 := StrLeft2Sub( var_sub, "��][�ܹ��ķ�:")
		strtrim( var_t2 )
		g_t2 := var_t2 + g_t2	

		var_sub := StrRight2Sub( var_sub, "��][�ܹ��ķ�:" )
		var_time := StrLeft2Sub( var_sub, "��]")
		strtrim( var_time )
	}
	g_time := var_time + g_time	
	var_tip = 
	(
�ļ���%var_SelectedFile%
���ҳ1�� ��%g_pages%��ҳ, ��ʱ1 ��%g_t1%��
���ҳ2�� ��%g_p2%��ҳ, ��ʱ2 ��%g_t2%��
���ʱ ��%g_time%��
	)

	msgbox %var_tip%
}



