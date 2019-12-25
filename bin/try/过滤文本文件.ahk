;; 根据ini文件指定的过滤内容，过滤包含这些内容的行，保存成另外的文本文件 
g_inifile = 过滤文本文件.cfg

ifnotexist %g_inifile%
{
	fileappend `;`;过滤样例，每行添加一个过滤条件, %g_inifile%
	msgbox 4, 设置过滤条件, 打开配置文件？（%g_inifile%）
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
	msgbox 过滤条件为空，将退出程序！
	exitapp
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StrLeft2Sub(SearchString, Needle ) 在SearchString字符串中寻找子串Needle
;; 找到Needle则截取它的左边，作为子字符串返回，举个例子：
;; SearchString = squeezer@imageset
;; Needle  = @
;; OutString = StrLeft2Sub( SearchString, Needle  )
;; 那么得到的OutString的值为squeezer

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
;举例..............................
;MyStringVar = squeezer::imageset
;fileExtVar = StrRight2Sub(MyStringVar,"::")
;fileExtVar的值为"imageset"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FileSelectFile, var_SelectedFile, 3, %A_WorkingDir%, 选择需要分析的文本文件, Log Documents (*.txt; *.log;  )

if var_SelectedFile =
{
    MsgBox, The user didn't select anything.
}
else
{
	SplitPath, var_SelectedFile, , dir, ext, name_no_ext
	if name_no_ext =
	{
		MsgBox 文件路径出错`n%var_SelectedFile%
		return
	}
	var_outfile = %dir%\%name_no_ext%_过滤.text
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



; 如果InputString 中第一个非空字符等于varChar则返回真
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

