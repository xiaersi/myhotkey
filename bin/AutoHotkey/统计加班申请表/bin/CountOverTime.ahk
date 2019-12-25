
SplitPath, a_scriptdir, , g_WorkDir
SetWorkingDir, %g_WorkDir%

g_bakdir = %g_WorkDir%\bak\%a_yyyy%_%a_mm%_%a_dd%

FileCreateDir,  %g_bakdir%


g_FirstRow = 7

xlArray := Object()

/*
FileSelectFile, Path, , %a_WorkingDir%
if ErrorLevel
	return 
*/

;Path = D:\Program files\MyHotkey\bin\AutoHotkey\AHK_L\报表组加班申请表（2012-9-3）.xls

FileList =  ; Initialize to be blank.
Loop, *.xls
    FileList = %FileList%%A_LoopFileName%`n


Loop, parse, FileList, `n
{
    if A_LoopField =  ; Ignore the blank item at the end of the list.
        continue
    
	Path = %g_WorkDir%/%A_LoopField%
	ReadOneXLS( Path )

}


MsgArray()
sleep 200
SaveArray()

return



ReadOneXLS( _Path )
{
	global g_FirstRow
	global g_bakdir


	var_FirstRow := g_FirstRow

	Xl := ComObjCreate("Excel.Application")
	Xl.Workbooks.Open(_Path) ;open an existing file
;	Xl.Visible := True


	var_temp := xl.Range("B" . var_FirstRow ).value

	;; 如果B7不为序号，则从上下行就查找，查找“序号”行作为初始行
	if var_temp <> 序号
	{
		var_FirstRow := 0
		loop 20
		{
			var_idx :=  a_index

			var_temp := Xl.Range("B" . var_idx ).Value	

			if ( var_temp = "序号" )
			{
				var_FirstRow := var_idx
				break
			}
		}		
	}

;	msgbox var_FirstRow = %var_FirstRow%

	if var_temp = 序号
	{
		date := Xl.Range("F" . var_FirstRow -1 ).Value


		while (Xl.Range("B" . A_Index + var_FirstRow ).Value != "") 
		{
			index := Xl.Range("B" . A_Index + var_FirstRow ).Value
			name := Xl.Range("C" . A_Index + var_FirstRow ).Value
			id := Xl.Range("D" . A_Index + var_FirstRow ).Value
			cause := Xl.Range("E" . A_Index + var_FirstRow ).Value
			time := Xl.Range("F" . A_Index + var_FirstRow ).Value

			if ( index = "" || id = "" )
			{
				break
			}

			AddOne( id, name, date, time, cause )
		}
		
		Xl.Workbooks.Close()

		;; 将文件移动到BAK文件夹中
		FileMove, %_Path%, %g_bakdir%
	}
	else
	{
		Xl.Workbooks.Close()
	}
	;Xl.Close()
	

}



AddOne( id, name, date, time, cause, _count=0 )
{
	local var_temp, idx
	
	stringleft id, id, instr( id, "." ) - 1
	
	if xlArray.HasKey(id)
	{
		if _count > 0 
			xlArray[id, "count"] += _count
		else
			xlArray[id, "count"] += 1
		var_temp := xlArray[id, "name"]
		ifnotinstring var_temp, %name%
			xlArray[id, "name"] := var_temp . "`n" . name

		var_temp := xlArray[id, "cause"]
		xlArray[id, "cause"] := var_temp . " `n{" . date . "  " . time . "} " . cause
	}
	else
	{
		if _count > 0 
			xlArray[id, "count"] := _count
		else 
			xlArray[id, "count"] := 1
		xlArray[id, "name"] := name
		xlArray[id, "cause"] := "{" . date . "  " . time . "} " . cause
	}
}


MsgArray()
{
	var_temp := GetArrayText()

	if var_temp =
		var_temp = 没有数据！
	else 
		var_temp = 执行成功！

	msgbox % var_temp
}

SaveArray2()
{
	local var_temp
	var_temp := GetArrayText()
	if var_temp <>
	{
		var_temp = 工号,餐票,姓名,`"                加班事由             `"`n%var_temp%
		filedelete %g_bakdir%\result.csv
		FileAppend , %var_temp%, %g_bakdir%\result.csv
	}
}


GetArrayText()
{
	local var_temp, index
	var_temp =
	for index, element in xlArray
	{
		var_temp := var_temp .  index
		var_temp := var_temp .  ","
		var_temp := var_temp .  element.count
		var_temp := var_temp .  ","
		var_temp = %var_temp%"
		var_temp := var_temp .  element.name
		var_temp = %var_temp%"
		var_temp := var_temp .  ","
		var_temp = %var_temp%"
		var_temp := var_temp .  element.cause 
		var_temp = %var_temp%"
		var_temp := var_temp . "`r`n"		
	}
	return var_temp
}


SaveArray()
{
	local var_temp, idx, index, var_path
	Xl := ComObjCreate("Excel.Application") ;handle
	Xl.Visible := false ;by default excel sheets are invisible

	var_temp = %g_WorkDir%\bak\result.xls
	ifexist %var_temp%
	{
		Xl.Workbooks.Open( var_temp )	;; 如果存在模板，则使用之
	}
	else
	{
		;; 如果不存在导出模板，则创建新模板
		Xl.Workbooks.Add ;add a new workbook
		Xl.Range("A1").Value := "工号"
		Xl.Range("B1").Value := "餐票"
		Xl.Range("C1").Value := "姓名"
		Xl.Range("D1").Value := "加班事由"
		XL.ActiveWorkbook.SaveAs(var_temp)
	}
	
	for index, element in xlArray
	{
		idx := a_index + 1
		Xl.Range("A" . idx ).Value := index
		Xl.Range("B" . idx ).Value := element.count
		Xl.Range("C" . idx ).Value := element.name
		Xl.Range("D" . idx ).Value := element.cause
	}

	;oSheet := ComObjActive("Excel.Application").ActiveWorkbook.ActiveSheet
;	oSheet := XL.ActiveWorkbook.ActiveSheet
;	oSheet.Columns("D1").ColumnWidth := 600
;	oSheet.Columns("D1").NumberFormatLocal   := "@"
;	oSheet.Columns("D:D").ColumnWidth := 600


;	Xl.Range("D1").ColumnWidth := 600

	var_path = %g_bakdir%\result.xls
	filedelete %var_path%
	XL.ActiveWorkbook.SaveAs(var_path)
	Xl.Workbooks.Close()
}
