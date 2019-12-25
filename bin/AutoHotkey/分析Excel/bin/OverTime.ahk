
SplitPath, a_scriptdir, , g_WorkDir
SetWorkingDir, %g_WorkDir%

tooltip 1、正在读取配置信息......

g_debug := false
g_inifile = 加班申请表.ini
g_date = %a_yyyy%_%a_mm%_%a_dd%
g_bakdir = %g_WorkDir%\bak\%a_yyyy%_%a_mm%_%a_dd%
FileCreateDir,  %g_bakdir%
filedelete  %g_bakdir%\log.txt
WriteLog("程序已经启动，开始记录日志`r`n")

;; 检查配置文件
ifnotexist %g_inifile%
{
	var_log = 没有配置文件 %g_inifile% !
	WriteLog( var_log , true )
	return
}

g_OutFileName 		:= Read_ini( g_inifile, "setting", "导出文件名", "汇总" )

g_TempDir = %g_WorkDir%\temp
g_DataDir = %g_WorkDir%\data

g_加班申请表模板 		:= Read_ini( g_inifile, "加班申请表", "模板文件", "加班申请表模板.xls" )
g_加班统计模板 			:= Read_ini( g_inifile, "加班申请表", "统计模板", "加班统计模板.xls" )

g_加班申请表文件匹配 	:= Read_ini( g_inifile, "加班申请表", "文件名匹配", "加班" )

g_TempFile = %g_TempDir%\%g_加班申请表模板%


;; 检查模板文件是否存在
tooltip 2、检查模板文件是否存在

ifnotexist %g_TempFile%
{
	FileSelectFile, g_TempFile, , %g_TempDir%,  请选择加班申请表模板文件, Excel (*%g_加班申请表文件匹配%*.xls; *%g_加班申请表文件匹配%*.xlsx)
	if ErrorLevel
	{
		WriteLog( "没有指定加班申请表模板文件！`r`n`r`n程序结束！", true ) 
		return 	
	}
}



;; 检查数据文件是否存在
g_DataFile := SelectFile( g_DataDir, g_加班申请表文件匹配, "请选择加班申请表数据文件" )
ifnotexist %g_DataFile%
{
	WriteLog( "加班申请表数据文件名：" . g_DataFile )
	WriteLog( "没有加班申请表数据文件！`r`n`r`n程序结束！", true ) 
	return 	
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 加载模板文件数据至Object

g_TempObj := object()

var_log = 开始加载加班申请表模板: %g_TempFile%
WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 
WriteLog( var_log, false ) 
WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 
tooltip 3、%var_log%

if not ReadXlsTemp( g_TempFile, g_TempObj )
{
	WriteLog( "加班申请表模板数据 加载失败！`r`n`r`n程序结束！", true ) 
	return 
}


var_temp := GetObjectText( g_TempObj )
WriteLog( "`r`ng_TempObj：" . var_temp, false ) 

;; 检验 消费数据表模板 是否指定了时间单元格位置
R_date := GetTempParam( g_TempObj, "DateRange" )
if R_date =
{
	WriteLog( "加班申请表模板数据 没有设置时间单元格 DateRange ！`r`n`r`n程序结束！", true ) 
	return 
}



tooltip 4、加载加班数据文件
g_DataObj := object()


DataFileArray0 := 0
FileList := SeachXlsFile( g_DataDir, g_加班申请表文件匹配 )
loop parse, FileList, `n
{
	if a_loopfield =
		continue

	v_file = %g_DataDir%\%a_loopfield%
	ifnotexist %v_file%
		continue

	;; 从消费数据文件中读取日期
	var_log = 开始加载加班申请表数据: %v_file%
	WriteLog( ";`r`n;--------------------------------------------------------------------------------------------------------------" ) 
	WriteLog( var_log, false ) 
	WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 


	if not LoadXlsData( v_file, g_TempObj, g_DataObj, errOutput )
	{
		WriteLog( "加班申请表文件加载失败！`r`n`r`n程序结束！", true ) 
		if errOutput <>
		{
			WriteLog("错误信息如下：`r`n" . errOutput)
		}
		return 
	}
	else
	{
		DataFileArray0++
		DataFileArray%DataFileArray0% := v_file


		var_temp := GetObjectText( g_DataObj )
		WriteLog( "`r`ng_DataObj." . v_date . ": " . var_temp, false ) 
		WriteLog( "-------------------------------------------------------`r`n" , false ) 


		if errOutput <>
		{
			WriteLog("错误信息如下：`r`n" . errOutput)
		}
	}
}

;; 加载消费数据文件
tooltip 5、数据运算中...
v_user_num := 0
v_piao_num := 0
g_Date_Obj := object()
for v_user, oDate in g_DataObj
{
	v_user_num := v_user_num + 1
	v_count := oDate.maxindex()
	loop %v_count%
	{
		v_piao_num := v_piao_num + 1
		v_datetime := oDate[a_index, "time"]
		if regexmatch( v_datetime, "^\s*[01]\d[0123]\d", v_match ) > 0
		{
			v_date := a_yyyy . "-" . substr(v_match, 1, 2 ) . "-" . Substr(v_match, 3, 2 )
		}
		else
		{
			v_date = --
		}
		v_index := g_Date_Obj[v_date].MaxIndex() 
		if v_index =
			v_index := 1
		else
			v_index := v_index + 1

		v_count := oDate[0, "count"]
		if v_count =
			v_count := 0
		oDate[0, "count"] 	:= v_count + 1  ;; 计算餐票

		var_name := oDate[0, "name"]
		v_name := oDate[a_index, "name"]
		if var_name =
			oDate[0, "name"] := v_name
		else ifnotinstring var_name, %v_name%
			oDate[0, "name"] 	:= var_name . v_name . "`n"

		oDate[0, "cause"] 	:= oDate[0, "cause"] . v_datetime . "   " . oDate[a_index, "cause"] . "`n"

		g_Date_Obj[v_date, v_index, "id"] := v_user
		g_Date_Obj[v_date, v_index, "name"] := oDate[a_index, "name"]
		g_Date_Obj[v_date, v_index, "cause"] := oDate[a_index, "cause"]
		g_Date_Obj[v_date, v_index, "time"] := v_datetime
	}
}



		var_temp := GetObjectText( g_Date_Obj )
		WriteLog( "`r`ng_Date_Obj: " . var_temp, false ) 
		WriteLog( "-------------------------------------------------------`r`n" , false ) 


/*
WriteLog( ";`r`n;--------------------------------------------------------------------------------------------------------------" ) 
var_temp := GetObjectText( g_GKDataObj )
WriteLog( "`r`ng_GKDataObj：" . var_temp, false ) 
WriteLog( "-------------------------------------------------------`r`n" , false ) 
*/

tooltip 6、保存数据...

	v_titleRow := GetTempParam( g_TempObj, "TitleRow" )  
	v_MaxLine  := GetTempParam( g_TempObj, "MaxLine" ) 
	v_dataRow  := GetTempParam( g_TempObj, "DataRow" )  

	v_MaxLine  := GetTempParam( g_TempObj, "MaxLine" )
	if v_MaxLine <= 0
		v_MaxLine := 10000



	;; 读取EXCEL文件数据
	Xl := ComObjCreate("Excel.Application")
	Xl.Workbooks.Open(g_DataFile) ;open an existing file

	v_DataLine := LocalTitleLine( Xl, g_TempObj )


	v_row := v_DataLine - 1
	if v_DataLine > 1
	{
		for v_date, oData in g_Date_Obj
		{
			for v_idx, element in oData
			{
				v_row++
				Xl.Range( "B" . v_row ).Value := element["name"]
				Xl.Range( "C" . v_row ).Value := element["id"]
				Xl.Range( "D" . v_row ).Value := element["cause"]
				Xl.Range( "E" . v_row ).Value := element["time"]
			}
		}
	}
	v_row ++ 

	Xl.Range( "A" . v_row ).Value := "合计:"	
	Xl.Range( "B" . v_row ).Value := v_user_num . "人"
	Xl.Range( "C" . v_row ).Value := v_piao_num . "张"

	;; 将生成的Excell保存
	SplitPath, g_DataFile, OutFileName, OutDir, OutExtension
	var_path = %g_bakdir%\%g_OutFileName%.%OutExtension%	
	filedelete %var_path%
	Xl.ActiveWorkbook.SaveAs(var_path)
	Xl.Workbooks.Close()	

;; 保存统计信息
	var_temp = %g_TempDir%\%g_加班统计模板%
	/*
	ifexist %var_temp%
	{
		Xl.Workbooks.Open( var_temp )	;; 如果存在模板，则使用之
	}
	else
	*/
	{
		;; 如果不存在导出模板，则创建新模板
		Xl.Workbooks.Add ;add a new workbook
		Xl.Range("A1").Value := "工号"
		Xl.Range("C1").Value := "餐票"
		Xl.Range("B1").Value := "姓名"
		Xl.Range("D1").Value := "加班事由"
		Xl.Columns("D:D").ColumnWidth := 72.75
		Xl.Columns("A:C").Select.VerticalAlignment := "xlCenter"
		Xl.Range("A1").select
	;	XL.ActiveWorkbook.SaveAs(var_temp)
	}
	
	idx := 0
	for v_user, oDate in g_DataObj
	{
		idx := a_index + 1
		Xl.Range("A" . idx ).Value := v_user
		Xl.Range("C" . idx ).Value := oDate[0, "count"]
		Xl.Range("B" . idx ).Value := oDate[0, "name"]
		Xl.Range("D" . idx ).Value := oDate[0, "cause"]
	}

	if idx > 1
	{
		v_temp = =SUM(C2:C%idx%)
		Xl.Range("C" . idx + 1).Value := v_temp
		Xl.Range("C" . idx + 1).select
	}

	;oSheet := ComObjActive("Excel.Application").ActiveWorkbook.ActiveSheet
;	oSheet := XL.ActiveWorkbook.ActiveSheet
;	oSheet.Columns("D1").ColumnWidth := 600
;	oSheet.Columns("D1").NumberFormatLocal   := "@"
;	oSheet.Columns("D:D").ColumnWidth := 600


;	Xl.Range("D1").ColumnWidth := 600

	var_path = %g_bakdir%\加班统计.xls
	filedelete %var_path%
	XL.ActiveWorkbook.SaveAs(var_path)
	Xl.Workbooks.Close()

	run %g_bakdir%


tooltip 结束！
WriteLog( "-------------------------------------------------------`r`n`r`n" , false ) 
WriteLog( "程序结束！", false )
sleep 500
return 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 

SetTotalLine_FS( xlDoc, insertObj_, startline_, endline_ )
{
	if endline_ < 2
		return

	;; 如果有需要插入的行，则先插入数据
	iRow := endline_ 

	;; 插入新增的数据
	for v_date, oDate in insertObj_
	{
		for v_user, oUser in oDate
		{
			R_LastLine = %iRow%:%iRow%
			xlDoc.Rows(R_LastLine).Insert	

			Range := CellRange( 6, iRow )	;; F列：日期
			xlDoc.Range( Range ).Value := v_date

			Range := CellRange( 4, iRow )	;; D列：工号
			xlDoc.Range( Range ).NumberFormatLocal := "@" ;; 单元格数据格式为文本
			xlDoc.Range( Range ).Value := UserID2String(v_user)

			Range := CellRange( 16, iRow )	;; P列：月结
			xlDoc.Range( Range ).Value := oUser["AMT_YJ"]
	
			iRow ++
		}
	}

	endline_ := iRow



	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 以下设置合计信息
	var_000 := endline_ - 1
	var_temp = =SUM(P%startline_%:P%var_000%)
	xlDoc.Range("P" . endline_ ).Value :=  var_temp
}


SetTotalLine( xlDoc, insertObj_, startline_, endline_ )
{
	if endline_ < 2
		return

	;; 如果有需要插入的行，则先插入数据
	iRow := endline_ 

	;; 插入新增的数据
	for v_date, oDate in insertObj_
	{
		for v_user, oUser in oDate
		{
			R_LastLine = %iRow%:%iRow%
			xlDoc.Rows(R_LastLine).Insert	

			Range := CellRange( 1, iRow )	;; A列：日期
			xlDoc.Range( Range ).Value := v_date

			Range := CellRange( 5, iRow )	;; E列：工号
			xlDoc.Range( Range ).NumberFormatLocal := "@" ;; 单元格数据格式为文本
			xlDoc.Range( Range ).Value :=  UserID2String(v_user)

			Range := CellRange( 7, iRow )	;; G列：散单
			xlDoc.Range( Range ).Value := oUser["AMT_XF"]

			Range := CellRange( 8, iRow )	;; H列：月结
			xlDoc.Range( Range ).Value := oUser["AMT_YJ"]
	
			iRow ++
		}
	}

	endline_ := iRow

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 以下设置合计信息
	xlDoc.Range("L" . endline_ - 1 ).Value := "差异"

	;; 散单合计
	var_temp = =SUMIF(C:C,`"散单`",G:G)+SUMIF(C:C,`"纸箱费`",G:G) 
	xlDoc.Range("G" . endline_ ).Value :=  var_temp

	var_temp = =SUMIF(C:C,`"散单`",H:H)+SUMIF(C:C,`"纸箱费`",H:H) 
	xlDoc.Range("H" . endline_ ).Value :=  var_temp	

	var_000  := endline_ 
	var_temp = =D%var_000% - G%var_000% - H%var_000%
	xlDoc.Range("L" . var_000 ).Value :=  var_temp				

	;; 代收货款合计
	var_temp = =SUMIF(C:C,"代收货款",G:G)
	xlDoc.Range("G" . endline_ + 1 ).Value :=  var_temp

	var_temp = =SUMIF(C:C,"代收货款",H:H)
	xlDoc.Range("H" . endline_ + 1 ).Value :=  var_temp	

	var_000  := endline_ + 1
	var_temp = =D%var_000% - G%var_000% - H%var_000%
	xlDoc.Range("L" . var_000 ).Value :=  var_temp				

	;; 其他小计
	var_temp = =SUMIF(C:C,"其他",G:G)
	xlDoc.Range("G" . endline_ + 2 ).Value :=  var_temp

	var_temp = =SUMIF(C:C,"其他",H:H)
	xlDoc.Range("H" . endline_ + 2 ).Value :=  var_temp	

	var_000  := endline_ + 2
	var_temp = =D%var_000% - G%var_000% - H%var_000%
	xlDoc.Range("L" . var_000 ).Value :=  var_temp				

	;; 总合计
	var_000 := endline_ - 1
	var_temp = =SUM(G%startline_%:G%var_000%)
	xlDoc.Range("G" . endline_ + 3 ).Value :=  var_temp

	var_temp = =SUM(H%startline_%:H%var_000%)
	xlDoc.Range("H" . endline_ + 3 ).Value :=  var_temp				

	var_000  := endline_ + 3
	var_temp = =D%var_000% - G%var_000% - H%var_000%
	xlDoc.Range("L" . var_000 ).Value :=  var_temp				

}

处理加班申请表重复数据( oGKData_, date_, user_, v_type = "?" )
{
	;; 如果有重复数据，合并之
	nCount := oGKData_.MaxIndex()
	v_gk_amt := 0
	if nCount = 1
	{
		v_gk_amt := oGKData_[1, "Amt"]
	}
	else if nCount >= 2
	{
		var_log = 重复数据合并: g_GKDataObj.%date_%.%user_%.%v_type%.i.Amt = 0 

		for v_idx, oAmt in oGKData_
		{
			v_temp := oAmt["AMT"]
			if v_temp is number
			{
				v_gk_amt += v_temp
				var_log = %var_log% + %v_temp%
			}
			else
			{
				var_log = %var_log% + {[%v_idx%]%v_temp% Error: not number}
			}
		}
		var_log = %var_log% = [%v_gk_amt%]
		WriteLog( var_log )
	}
	else
		return

	;; 设置默认的扣储值卡消费值为0
	oGKData_[1, "AMT_XF"] := "0"				;; 扣储值卡消费
	oGKData_[1, "AMT_YJ"] := v_gk_amt  		;; 实际应交款					
}

合并消费数据到加班申请表结构( oGKData_, oXFData_, date_, user_ )
{
	;; 将消费数据合并过来
	if oXFData_.HasKey(date_)
	{
		if oXFData_[date_].HasKey(user_)
		{
			v_amt := oXFData_[date_, user_, 1, "AMT"] + oXFData_[date_, user_, 1, "SFP"]

			oXFData_[date_, user_, 1, "Flag"] := true 		;; 标志该条数据已经处理过，下次寻找新插入数据时可以忽略

		;	var_log = 消费数据合并: %v_amt% := oXFData_[%date_%, %user_%, AMT] + oXFData_[%date_%, %user_%, SFP]
		;	WriteLog( var_log )

			if v_amt is number
			{
				v_temp := oGKData_[1, "AMT_YJ"]

				oGKData_[1, "AMT_XF"] := v_amt				;; 扣储值卡消费
				oGKData_[1, "AMT_YJ"] := oGKData_[1, "AMT_YJ"] - v_amt   ;; 实际应交款

				;msgbox oGKData_[1`, `"AMT_YJ`"] = %v_temp%`noGKData_[%date_%`, %user_%`, 1`, `"AMT_XF`"] := %v_amt%
			}
			else
			{
				var_log = 消费数据合并时出错: %v_amt% = oXFData_.%date_%.%user_%.1.Amt + oXFData_.%date_%.%user_%.1.Amt
				WriteLog( var_log )
			}
		}
		else
		{
			var_log = >>>消费数据合并: 消费数据表[%date_%]天没有用户(%user_%)的数据。
			WriteLog( var_log )
		}
	}
	else 
	{
		var_log = >>消费数据合并: 消费数据表不存在[%date_%]天的数据。
		WriteLog( var_log )
	}
}

#include %a_scriptdir%\ReadExcel2Array.aik
#include %a_scriptdir%\func.aik
