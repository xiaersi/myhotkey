;; ����ini�ļ�ָ���Ĺ������ݣ����˰�����Щ���ݵ��У������������ı��ļ� 
g_inifile = �����ı��ļ�.cfg

ifnotexist %g_inifile%
{
	fileappend `;`;����������ÿ�����һ����������, %g_inifile%
	msgbox 4, ���ù�������, �������ļ�����%g_inifile%��
	ifmsgbox yes
	{
		run notepad %g_inifile%
	}
	exitapp
}

g_count = 0
Loop, read, %g_inifile%
{
	if a_Loopreadline =
		continue
	if (equal_first_char(a_Loopreadline, ";"))
		continue
	g_count ++
	g_array%g_count% = %a_loopreadline%
}

if g_count <= 0 
{
	msgbox ��������Ϊ�գ����˳�����
	exitapp
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StrLeft2Sub(SearchString, Needle ) ��SearchString�ַ�����Ѱ���Ӵ�Needle
;; �ҵ�Needle���ȡ������ߣ���Ϊ���ַ������أ��ٸ����ӣ�
;; SearchString = squeezer@imageset
;; Needle  = @
;; OutString = StrLeft2Sub( SearchString, Needle  )
;; ��ô�õ���OutString��ֵΪsqueezer

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FileSelectFile, var_SelectedFile, 3, %A_WorkingDir%, ѡ����Ҫ�������ı��ļ�, Log Documents (*.txt; *.log;  )

if var_SelectedFile =
{
    MsgBox, The user didn't select anything.
}
else
{
	SplitPath, var_SelectedFile, , dir, ext, name_no_ext
	if name_no_ext =
	{
		MsgBox �ļ�·������`n%var_SelectedFile%
		return
	}
	var_outfile = %dir%\%name_no_ext%_����.text
	FileDelete, %var_outfile%


	Loop, read, %var_SelectedFile%, %var_outfile%
	{
		if a_loopreadline = 
			continue 

		var_isfilt := false

		Loop  %g_count%
		{
			element  := g_array%a_index%
			if element =
				continue
			ifinstring a_loopreadline, %element%
			{
				if element <>
				{
					var_isfilt := true
					break
				}
			}
		}
		if ( var_isfilt == true )
		{
			
			continue
		}
	
		FileAppend, %A_LoopReadLine%`n
	}
}



; ���InputString �е�һ���ǿ��ַ�����varChar�򷵻���
equal_first_char( InputString, varChar )
{
	varLen := strlen(InputString)
	Loop %varLen%
	{
		StringMid var_char, InputString, %a_index%, 1
		if var_char is not space
		{
			if ( varChar == var_char )
			{
				return true
			}
			return false
		}
	}
	return false	
}

