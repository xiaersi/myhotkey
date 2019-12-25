#include ..\..\

SplitPath, a_ScriptFullPath, OutFileName, OutDir, OutExtension, OutNameNoExt


g_Pattern = *.*

;; 读取配置参数
g_sperator := "==>"
g_bRegEx := false






;; 读取要替换的内容
ReadReplace( OutNameNoExt . "txt" )


;; 循环查找文件
FileList =  ; Initialize to be blank.
Loop, %g_Pattern%
    FileList = %FileList%%A_LoopFileName%`n

Loop, parse, FileList, `n
{
    if A_LoopField =  ; Ignore the blank item at the end of the list.
        continue
    MsgBox, 4,, File number %A_Index% is %A_LoopField%.  Continue?
    IfMsgBox, No
        break
}


;; 替换某个文件
∑替换一个文件( _file, _newfile )
{
	local var_temp, var_content, var_newcontent, searchText, replaceText
	FileRead, var_content, %_file%
	if ErrorLevel  
		return 

	if var_content=
		return

	loop %SearchArray0%
	{
		searchText := SearchArray%a_index%
		replaceText := ReplaceArray%a_index%

		if g_bRegEx 
		{
			var_newcontent := RegExReplace(var_content, searchText , replaceText)			
		}
		else
		{
			StringReplace, var_newcontent, var_content, searchText, replaceText, all
		}
	}

	if ( var_newcontent != var_content )
	{
		ifExist %_newFile%
		{
			fileDelete  %_newFile%
		}
		FileAppend %var_newcontent%, %_newfile%
	}
}




;; 读取Ini文件到内存，过滤掉无关的行，行与行之间用`n间隔（非`r`n间隔）
ReadReplace( var_fileName )
{
	global 
	FileRead var_fileContent, %var_fileName%
	if ErrorLevel
	Return

	if var_fileContent =
	Return

	ClearArray("SearchArray")
	ClearArray("ReplaceArray")

	var_newContent =                        ;; 处理之后的IniFile内容
	StringReplace var_fileContent, var_fileContent, `r, , All
	loop parse, var_fileContent, `n
	{
		if a_loopfield =
			Continue

		;; 删除注释, 以 ; 开头的认为是注释
		var_line := RegExReplace( a_loopfield, "(\s|^)`;`;.*", "" )
		if var_line =
			continue


		;; 删除不包含 ==> 的行
		IfInString var_line, %g_sperator%
		{
			StrSplit2Sub( var_line, g_sperator,  OutStringLeft, OutStringRight )
			
			AppendArray( "SearchArray", OutStringLeft )
			AppendArray( "ReplaceArray", OutStringRight )
		}
	}
}



#include inc/common.aik
#include inc/string.aik
#include inc/array.aik
