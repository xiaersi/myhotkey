
SplitPath, a_scriptdir, , g_WorkDir
SetWorkingDir, %g_WorkDir%

g_bakdir = %g_WorkDir%\bak\%a_yyyy%_%a_mm%_%a_dd%
g_date = %a_yyyy%_%a_mm%_%a_dd%
g_tempdate = ;; 公款日期

g_FirstRow = 7
xlArray := Object()		;; 保存消费数据表中的数据
xlArray_re := Object()	;; 保存重复的数据

tooltip 1、公款汇总工具已经启动！正在校验公款表格式......
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 先检查模板文件是否存在！

g_tempfile := SelectFile( "公款", "请选择“公款表”模板文件" )
if not g_tempfile
{
	msgbox 公款模板文件不存在！
	return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 用户选择数据文件“消费数据表”
Path := SelectFile( "消费", "请选择“消费数据表”" )
if not Path
{
	msgbox 消费数据文件不存在！
	return
}


;; 检查模板文件格式是否正确
xlDoc := ComObjCreate("Excel.Application")
xlDoc.Workbooks.Open(g_tempfile) ;open an existing file

var_temp := xlDoc.Range("E6" ).value ;; E6 应该为 “销售员编号”
if var_temp <> 销售员编号
{
	msgbox 模板文件格式不正确，单元格 E6 应该为 “销售员编号”!
	xlDoc.Workbooks.Close()
	return
}

var_temp := xlDoc.Range("G7" ).value 
if var_temp <> 散单
{
	msgbox 模板文件格式不正确，单元格 G7 应该为 “散单”!
	xlDoc.Workbooks.Close()
	return
}

var_temp := xlDoc.Range("H7" ).value 
if var_temp <> 月结
{
	msgbox 模板文件格式不正确，单元格 H7 应该为 “月结”!
	xlDoc.Workbooks.Close()
	return
}

;; 获取公款表的时间
var_FirstRow := 7
loop 10000
{
	var_a := xlDoc.Range("A" . A_Index + var_FirstRow ).Value

	ifinstring var_a, 合计
		break

	if var_a <>
	{
		g_tempdate := var_a
		break
	}
}


xlDoc.Workbooks.Close()


tooltip 2、从“消费数据表”中读取数据......
;; 从“消费数据表”中读取数据到数组xlArray
if not ReadOneXLS( Path )
{
	WriteLog("消费数据表读取出错!`n`n程序结束！")
	return
}
else
{
	if g_tempdate =
		g_tempdate := g_date
	else if ( g_tempdate <> g_date )
	{
		msgbox, 4, 日期不同, 公款表[%g_tempdate%]与消费数据表日期[%g_date%]不同，`n`n是否继续执行？
		ifmsgbox no
		{
			var_log = 公款表[%g_tempdate%]与消费数据表日期[%g_date%]不同。`n`n用户结束程序！
			WriteLog(var_log)
			return
		}
	}
	WriteLog("消费数据表读取成功。`n")
}

tooltip 3、合并数据到汇总表......
;; 已经成功读取到“消费数据表”的数据，接下来合并到汇总表中。
if 合并到汇总表(g_tempfile)
{
	tooltip 数据合并完毕！
	WriteLog("合并到汇总表成功`n")

	FileMove, %Path%, %g_bakdir%
	if ErrorLevel 
		var_log = 消费数据文件移动出错! `r`n`t`"%Path%`"  `r`n`t==>  `"%g_bakdir%`"
	else
		var_log = 成功移动消费数据文件! `r`n`t`"%Path%`"  `r`n`t==>  `"%g_bakdir%`"
	WriteLog( var_log . "`r`n" )

	FileMove, %g_tempfile%, %g_bakdir%
	if ErrorLevel 
		var_log = 公款文件移动出错! `r`n`t`"%g_tempfile%`"  `r`n`t==>  `"%g_bakdir%`"
	else 
		var_log = 成功移动公款文件! `r`n`t`"%g_tempfile%`"  `r`n`t==>  `"%g_bakdir%`"
	WriteLog( var_log . "`r`n" )	
	
	WriteArrayLog() ;; 将详细信息写入log文件

	msgbox 执行成功！

	;; 自动打开目标文件夹
	run %g_bakdir%
}
else
{
	tooltip 数据合并失败！
	WriteLog("合并到汇总表失败！`n")
	msgbox 执行失败！
}

WriteLog("程序结束！`n")

return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ReadOneXLS( _Path )
{
	global g_bakdir, g_date, g_WorkDir
	Xl := ComObjCreate("Excel.Application")
	Xl.Workbooks.Open(_Path) ;open an existing file
;	Xl.Visible := True

	var_FirstRow := 3
	var_temp := xl.Range("E" . var_FirstRow ).value

	;; 如果B7不为序号，则从上下行就查找，查找“序号”行作为初始行
	if var_temp <> 收派员工号
	{
		var_FirstRow := 0
		loop 20
		{
			var_idx :=  a_index

			var_temp := Xl.Range("E" . var_idx ).Value	

			if  var_temp = 收派员工号
			{
				var_FirstRow := var_idx
				break
			}
		}		
	}


	;; 检查“消费数据表”表的格式是否正确
	if var_temp <> 收派员工号
	{
		WriteLog( "消费数据文件格式不正确，单元格 E3 应该为 “收派员工号”!", true)
		xl.Workbooks.Close()
		return false
	}	

	var_temp := xl.Range("U" . var_FirstRow ).value 
	if var_temp <> 实际消费
	{
		WriteLog("消费数据文件格式不正确，单元格 U3 应该为 “实际消费”!", true )
		xl.Workbooks.Close()
		return false
	}	

	var_FirstRow++

	var_temp := xl.Range("W" . var_FirstRow ).value 
	if var_temp <> 本金消费
	{
		WriteLog("消费数据文件格式不正确，单元格 W4 应该为 “本金消费”!", true )
		xl.Workbooks.Close()
		return false
	}	

	var_temp := xl.Range("X" . var_FirstRow ).value 
	if var_temp <> 积分消费
	{
		WriteLog("消费数据文件格式不正确，单元格 X4 应该为 “积分消费”!", true )
		xl.Workbooks.Close()
		return false
	}		

	date := Xl.Range("V" . var_FirstRow -2 ).Value
	if date <>
	{
		g_bakdir = %g_WorkDir%\bak\%date%
		g_date := date
	}
	FileCreateDir,  %g_bakdir%
	filedelete  %g_bakdir%\log.txt
	WriteLog("程序已经启动，开始记录日志`r`n")

	loop 10000
	{
		var_a := Xl.Range("A" . A_Index + var_FirstRow ).Value
		ifinstring var_a, 合计
			break

		if var_a =
			break
	

		id := Xl.Range("E" . A_Index + var_FirstRow ).Value
		benjin := Xl.Range("W" . A_Index + var_FirstRow ).Value
		jifen := Xl.Range("X" . A_Index + var_FirstRow ).Value

		if id =
			continue

		AddOne( id, benjin, jifen )

	;	if ( mod(var_tempcount, 10 ) == 1 )
	;		msgbox AddOne( %id%`, %benjin%`, %jifen% )  `n`n var_a[%A_Index%] = %var_a%
	}
	
	Xl.Workbooks.Close()

	return true
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AddOne( id, benjin_, jifen_ )
{
	local vartemp, idx
	local var_tempcount
	stringreplace benjin_, benjin_, `,, , all
	stringreplace jifen_, jifen_, `,, , all
	
;	stringleft id, id, instr( id, "." ) - 1
	
	if xlArray.HasKey(id)
	{
		xlArray_re[id, "benjin"] := benjin_
		xlArray_re[id, "jifen"] := jifen_
		xlArray_re[id, "sum"] := benjin_ + jifen_
	}
	else
	{
		xlArray[id, "benjin"] := benjin_
		xlArray[id, "jifen"] := jifen_
		xlArray[id, "sum"] := benjin_ + jifen_	;; 散单
		xlArray[id, "flag"] := "F"				;; 是否已经合并到汇总表之中
	}
	vartemp := benjin_ + jifen_
;	msgbox AddOne( %id%`, %benjin_%`, %jifen_%`, %vartemp% ) 
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
合并到汇总表( path_ )
{
	local var_temp, var_count, var_000
	local var_FirstRow, var_path
	local var_a, var_type, var_amt, var_userid 
	var_FirstRow := 7
	xlDoc.Workbooks.Open(path_)

;	msgbox 合并到汇总表( %path_% )

	loop 10000
	{
		var_a := xlDoc.Range("A" . A_Index + var_FirstRow ).Value

		;; 遇到合计行，数据行结束，处理合计公式之后退出循环
		ifinstring var_a, 合计
		{
			;; G、H总合计行汇总公式
			var_a := xlDoc.Range("A" . A_Index + var_FirstRow + 3 ).Value	
			ifinstring var_a, 合计
			{
				xlDoc.Range("L" . A_Index + var_FirstRow - 1 ).Value := "差异"

				;; 散单合计
				var_temp = =SUMIF(C:C,`"散单`",G:G)+SUMIF(C:C,`"纸箱费`",G:G) 
				xlDoc.Range("G" . A_Index + var_FirstRow ).Value :=  var_temp

				var_temp = =SUMIF(C:C,`"散单`",H:H)+SUMIF(C:C,`"纸箱费`",H:H) 
				xlDoc.Range("H" . A_Index + var_FirstRow ).Value :=  var_temp	

				var_000  := A_Index + var_FirstRow 
				var_temp = =D%var_000% - G%var_000% - H%var_000%
				xlDoc.Range("L" . var_000 ).Value :=  var_temp				

				;; 代收货款合计
				var_temp = =SUMIF(C:C,"代收货款",G:G)
				xlDoc.Range("G" . A_Index + var_FirstRow + 1 ).Value :=  var_temp

				var_temp = =SUMIF(C:C,"代收货款",H:H)
				xlDoc.Range("H" . A_Index + var_FirstRow + 1 ).Value :=  var_temp	

				var_000  := A_Index + var_FirstRow + 1
				var_temp = =D%var_000% - G%var_000% - H%var_000%
				xlDoc.Range("L" . var_000 ).Value :=  var_temp				

				;; 其他小计
				var_temp = =SUMIF(C:C,"其他",G:G)
				xlDoc.Range("G" . A_Index + var_FirstRow + 2 ).Value :=  var_temp

				var_temp = =SUMIF(C:C,"其他",H:H)
				xlDoc.Range("H" . A_Index + var_FirstRow + 2 ).Value :=  var_temp	

				var_000  := A_Index + var_FirstRow + 2
				var_temp = =D%var_000% - G%var_000% - H%var_000%
				xlDoc.Range("L" . var_000 ).Value :=  var_temp				

				;; 总合计
				var_000 := A_Index + var_FirstRow - 1
				var_temp = =SUM(G8:G%var_000%)
				xlDoc.Range("G" . A_Index + var_FirstRow + 3 ).Value :=  var_temp

				var_temp = =SUM(H8:H%var_000%)
				xlDoc.Range("H" . A_Index + var_FirstRow + 3 ).Value :=  var_temp				

				var_000  := A_Index + var_FirstRow + 3
				var_temp = =D%var_000% - G%var_000% - H%var_000%
				xlDoc.Range("L" . var_000 ).Value :=  var_temp				
			}
			break
		}
			
		var_type   := xlDoc.Range("C" . A_Index + var_FirstRow ).Value
		var_amt    := xlDoc.Range("D" . A_Index + var_FirstRow ).Value
		var_userid := xlDoc.Range("E" . A_Index + var_FirstRow ).Value

		;; 处理一下工号，不足6位补充0
		stringleft var_userid, var_userid, instr( var_userid, "." ) - 1
		/*
		var_000 := 6 - strlen(var_userid)
		if ( var_000 > 0 && var_000 <= 6 )
		{
			loop %var_000%
				var_userid = 0%var_userid%
		}
		*/

		if ( var_userid == "" )
		{
			continue
		}
		
		if ( var_type != "散单" )
		{
			var_temp := xlDoc.Range("G" . A_Index + var_FirstRow ).Value
			if var_temp =
			{
				var_temp = 0
				xlDoc.Range("G" . A_Index + var_FirstRow ).Value := var_temp
			}
			else
			{
			 	StringReplace var_temp, var_temp, `, , , all
			}
			xlDoc.Range("H" . A_Index + var_FirstRow ).Value := var_amt - var_temp
		}
		else if xlArray.HasKey(var_userid)
		{
			var_temp := xlArray[var_userid, "sum"]
			xlArray[var_userid, "flag"] := "T"
			xlDoc.Range("G" . A_Index + var_FirstRow ).Value :=  var_temp
			xlDoc.Range("H" . A_Index + var_FirstRow ).Value := var_amt - var_temp
			var_count++
		}
		else
		{
			xlDoc.Range("G" . A_Index + var_FirstRow ).Value :=  0
			xlDoc.Range("H" . A_Index + var_FirstRow ).Value := var_amt 
		}
	}

	var_path = %g_bakdir%\汇总.xls
	filedelete %var_path%

	var_temp = 总共合并了 %var_count% 条消费数据到汇总表。`r`n
	WriteLog( var_temp )

	;; G、H列修改标题之后保存
	xlDoc.Range("G7").Value  := "扣储值卡消费" 
	xlDoc.Range("H7" ).Value := "实际应交款"
	xlDoc.ActiveWorkbook.SaveAs(var_path)
	xlDoc.Workbooks.Close()
	if var_count <= 0 
	{
		ifexist %var_path%
			filedelete %var_path%

		return false
	}
	return true
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SelectFile( pattern_, prompt_ )
{
	global g_WorkDir
	g_filecount := 0
	FileList =  ; Initialize to be blank.
	Loop, *%pattern_%*.xls
	{
		if A_LoopFileName =
			continue

		g_filecount++
		FileList = %FileList%%A_LoopFileName%`n
	}

	Loop, *%pattern_%*.xlsx
	{
		if A_LoopFileName =
			continue

		g_filecount++
		FileList = %FileList%%A_LoopFileName%`n
	}
	;; 如果bak目录下只有一个Excel文档，则视为模板文档
	if g_filecount = 1
	{
		Loop, parse, FileList, `n
		{
			if A_LoopField =  ; Ignore the blank item at the end of the list.
				continue
			
			tempfile = %g_WorkDir%\%A_LoopField%
			break
		}
	}
	;; 如果bak目录下只有多个Excel文档，则需要选择一个
	else if g_filecount > 1
	{
		FileSelectFile, tempfile, , %a_WorkingDir%,  %prompt_%, Excel (*%pattern_%*.xls; *%pattern_%*.xlsx)
		if ErrorLevel
			return 	
	}
	;; 如果bak目录下没有个Excel文档，则需要退出
	else 
	{
		return 
	}

	return tempfile
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GetArrayText(flag_="")
{
	local var_temp, index
	var_temp =
	for index, element in xlArray
	{
		if ( flag_ != "" && flag_ != element.flag )
		 	continue

		var_temp := var_temp .  index
		var_temp := var_temp .  ", "
		var_temp := var_temp .  element.benjin
		var_temp := var_temp .  ", "
		var_temp := var_temp .  element.jifen
		var_temp := var_temp .  ", "
		var_temp := var_temp .  element.sum 
		var_temp := var_temp .  ", "
		var_temp := var_temp .  element.flag
		var_temp := var_temp . "`r`n"	
	}
	return var_temp
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WriteLog(text_, bMsgbox=false)
{
	local var_temp		
	var_temp = [%a_yyyy%-%a_mm%-%a_dd% %a_hour%:%a_min%:%a_sec%]: %text_%
	fileappend %var_temp%, %g_bakdir%\log.txt

	if bMsgbox
		msgbox %text_%
}

WriteArrayLog()
{
	local var_temp, index
	var_temp = `r`n`r`n`r`n`r`n 数据合并详细信息：`r`n------------------------------------------------------------`r`n
	fileappend %var_temp%, %g_bakdir%\log.txt

	var_temp =
	var_temp  := GetArrayText( "T" )
	if var_temp <>
	{
		var_temp = `r`n成功合并的消费数据： `r`n（工号，本金，积分， 本金+积分，已合并T/F）`r`n%var_temp%
		fileappend %var_temp%, %g_bakdir%\log.txt
	}

	var_temp =
	var_temp := GetArrayText( "F" )
	if var_temp <>
	{
		var_temp = `r`n`r`n没有合并的消费数据：`r`n（工号，本金，积分， 本金+积分，已合并T/F）`r`n%var_temp%
		fileappend %var_temp%, %g_bakdir%\log.txt
	}
	
	var_temp =
	for index, element in xlArray_re
	{
		var_temp := var_temp .  index
		var_temp := var_temp .  ", "
		var_temp := var_temp .  element.benjin
		var_temp := var_temp .  ", "
		var_temp := var_temp .  element.jifen
		var_temp := var_temp .  ", "
		var_temp := var_temp .  element.sum 
		var_temp := var_temp . "`r`n"		
	}	
	if var_temp <>
	{
		var_temp = `r`n`r`n重复的消费数据：`r`n（工号，本金，积分， 本金+积分）`r`n%var_temp%
		fileappend %var_temp%, %g_bakdir%\log.txt
	}

	var_temp = `r`n------------------------------------------------------------`r`n`r`n`r`n
	fileappend %var_temp%, %g_bakdir%\log.txt
}
