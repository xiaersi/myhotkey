
SplitPath, a_scriptdir, , g_WorkDir
SetWorkingDir, %g_WorkDir%

tooltip 1、正在读取配置信息......

g_debug := false
g_inifile = config.ini
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

g_公款表模板 		:= Read_ini( g_inifile, "公款表", "模板文件", "公款表模板.xls" )
g_数据表模板 		:= Read_ini( g_inifile, "消费数据表", "模板文件", "消费数据模板.xls" )

g_公款表文件匹配 	:= Read_ini( g_inifile, "公款表", "文件名匹配", "公款" )
g_数据表文件匹配 	:= Read_ini( g_inifile, "消费数据表", "文件名匹配", "消费" )

g_GKTempFile = %g_TempDir%\%g_公款表模板%
g_XFTempFile = %g_TempDir%\%g_数据表模板%


;; 检查模板文件是否存在
tooltip 2、检查模板文件是否存在

ifnotexist %g_GKTempFile%
{
	FileSelectFile, g_GKTempFile, , %g_TempDir%,  请选择公款表模板文件, Excel (*%g_公款表文件匹配%*.xls; *%g_公款表文件匹配%*.xlsx)
	if ErrorLevel
	{
		WriteLog( "没有指定公款表模板文件！`r`n`r`n程序结束！", true ) 
		return 	
	}
}


ifnotexist %g_XFTempFile%
{
	FileSelectFile, g_XFTempFile, , %g_TempDir%,  请选择消费数据表模板文件, Excel (*%g_数据表文件匹配%*.xls; *%g_数据表文件匹配%*.xlsx)
	if ErrorLevel
	{
		WriteLog( "没有指定消费数据表模板文件！`r`n`r`n程序结束！", true ) 
		return 	
	}
}

;; 检查数据文件是否存在
g_GKDataFile := SelectFile( g_DataDir, g_公款表文件匹配, "请选择公款表数据文件" )
;msgbox %g_GKDataFile% := SelectFile( %g_公款表文件匹配%`, 请选择公款表数据文件 )
ifnotexist %g_GKDataFile%
{
	WriteLog( "公款表数据文件名：" . g_GKDataFile )
	WriteLog( "没有公款表数据文件！`r`n`r`n程序结束！", true ) 
	return 	
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 加载模板文件数据至Object

g_GKTempObj := object()
g_XFTempObj := object()

var_log = 开始加载公款表模板: %g_GKTempFile%
WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 
WriteLog( var_log, false ) 
WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 
tooltip 3、%var_log%

if not ReadXlsTemp( g_GKTempFile, g_GKTempObj )
{
	WriteLog( "公款表模板数据 加载失败！`r`n`r`n程序结束！", true ) 
	return 
}
else
{
	;; 公款表模板 加载成功，检查是否已经设置了 
	;; AMT_XF （扣储值卡消费） 和  AMT_YJ（实际应交款） 列变量
	iCol_AMT_XF =
	iCol_AMT_YJ =
	for col, oCol in g_GKTempObj["data"]
	{
		var_name := oCol["name"]
		if var_name = AMT_XF
		{
			iCol_AMT_XF := col
		}
		else if var_name = AMT_YJ
		{
			iCol_AMT_YJ := col
		}
	}

	if iCol_AMT_XF < 1
	{
		WriteLog( "公款表模板数据 没有设置（扣储值卡消费）列的变量名为 AMT_XF ！", false ) 
	}
	if iCol_AMT_YJ < 1
	{
		WriteLog( "公款表模板数据 没有正确设置（实际应交款）列的变量名为 AMT_YJ ！`r`n`r`n程序结束！", true ) 
		return
	}
}


/*
var_temp := GetObjectText( g_GKTempObj )
WriteLog( "`r`ng_GKTempObj：" . var_temp, false ) 
*/
var_log = 开始加载消费数据表模板: %g_XFTempFile%
WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 
WriteLog( var_log, false ) 
WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 
tooltip 4、%var_log%

if not ReadXlsTemp( g_XFTempFile, g_XFTempObj )
{
	WriteLog( "消费数据表模板数据 加载失败！`r`n`r`n程序结束！", true ) 
	return 
}

/*
var_temp := GetObjectText( g_XFTempObj )
WriteLog( "`r`ng_GKTempObj：" . var_temp, false ) 
*/
;; 检验 消费数据表模板 是否指定了时间单元格位置
R_date := GetTempParam( g_XFTempObj, "DateRange" )
if R_date =
{
	WriteLog( "消费数据表模板数据 没有设置时间单元格 DateRange ！`r`n`r`n程序结束！", true ) 
	return 
}

;; 加载公款数据文件
g_GKDataObj := object()

var_log = 开始加载公款表数据: %g_GKDataFile%
WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 
WriteLog( var_log, false ) 
WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 
tooltip 5、%var_log%

if not LoadXlsData( g_GKDataFile, g_GKTempObj, g_GKDataObj, errOutput )
{
	WriteLog( "公款表数据文件加载失败！`r`n`r`n程序结束！", true ) 
	if errOutput <>
	{
		WriteLog("错误信息如下：`r`n" . errOutput)
	}
	return 
}
else
{
/*
	var_temp := GetObjectText( g_GKDataObj )
	WriteLog( "`r`ng_GKDataObj：" . var_temp, false ) 
	WriteLog( "-------------------------------------------------------`r`n" , false ) 
*/


	if errOutput <>
	{
		WriteLog("错误信息如下：`r`n" . errOutput)
	}
}


;; 加载消费数据文件
tooltip 6、加载消费数据文件
g_XFDataObj := object()


DataFileArray0 := 0
FileList := SeachXlsFile( g_DataDir, g_数据表文件匹配 )
loop parse, FileList, `n
{
	if a_loopfield =
		continue

	v_file = %g_DataDir%\%a_loopfield%
	ifnotexist %v_file%
		continue

	;; 从消费数据文件中读取日期
	var_log = 开始加载消费数据表数据: %v_file%
	WriteLog( ";`r`n;--------------------------------------------------------------------------------------------------------------" ) 
	WriteLog( var_log, false ) 
	WriteLog( ";--------------------------------------------------------------------------------------------------------------" ) 

	Xl := ComObjCreate("Excel.Application")
	Xl.Workbooks.Open(v_file) 
	v_date := xl.Range( R_Date ).value
	v_date := GetFormatDate(v_date)		;; 将"yyyy-mm-dd"格式的日期格式化为"yyyy-m-d"
	Xl.Workbooks.Close()

	if v_date =
	{
		WriteLog( "Error: 消费数据表中的日期 [" + R_Date + "] 不能为空！", true )
	}
	else
	{
		if not g_XFDataObj.HasKey(v_date)
			g_XFDataObj[v_date] := object()

		if not LoadXlsData( v_file, g_XFTempObj, g_XFDataObj[v_date], errOutput )
		{
			WriteLog( "消费数据表文件加载失败！`r`n`r`n程序结束！", true ) 
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
/*
			var_temp := GetObjectText( g_XFDataObj[v_date] )
			WriteLog( "`r`ng_XFDataObj." . v_date . ": " . var_temp, false ) 
			WriteLog( "-------------------------------------------------------`r`n" , false ) 
*/


			if errOutput <>
			{
				WriteLog("错误信息如下：`r`n" . errOutput)
			}
		}
	}
}

;; 加载消费数据文件
tooltip 7、数据运算中...

;; 先处理重复的公款数据，将数据加起来
;; 同时将消费数据 g_XFDataObj 合并到公款数据 g_GKDataObj 中
v_AreaType := GetTempParam( g_GKTempObj, "AreaType" )
for v_date, oDate in g_GKDataObj
{
	for v_user, oUser in oDate
	{
		;; 佛山区
		if v_AreaType = 1
		{
			处理公款表重复数据( oUser, v_date, v_user )
			合并消费数据到公款表结构( oUser, g_XFDataObj, v_date, v_user )
		}
		;; 非佛山区
		else
		{
			for v_type, oType in oUser
			{
				if v_type = 散单
				{
					处理公款表重复数据( oType, v_date, v_user, v_type )
					合并消费数据到公款表结构( oType, g_XFDataObj, v_date, v_user )
				}
				else ;; if v_type != 散单
				{
					for v_idx, oAmt in oType
					{
						oAmt["AMT_XF"] := "0"
						oAmt["AMT_YJ"] := oAmt["AMT"]
					}			
				}
			}
		}
	}
}



;; 将公款表中不存在的消费数据统计出来以待插入。
g_InsertDataObj := object()

for v_date, oDate in g_XFDataObj
{
	for v_user, oUser in oDate
	{
		if not oUser[1, "Flag"]
		{
			var_amt := oUser[1, "AMT"] + oUser[1, "SFP"]
			g_InsertDataObj[v_date, v_user, "AMT_XF"] := var_amt
			g_InsertDataObj[v_date, v_user, "AMT_YJ"] := 0 - var_amt 
		}
	}
}





/*
WriteLog( ";`r`n;--------------------------------------------------------------------------------------------------------------" ) 
var_temp := GetObjectText( g_GKDataObj )
WriteLog( "`r`ng_GKDataObj：" . var_temp, false ) 
WriteLog( "-------------------------------------------------------`r`n" , false ) 
*/

tooltip 7、保存数据...

	v_titleRow := GetTempParam( g_GKTempObj, "TitleRow" )  
	v_MaxLine  := GetTempParam( g_GKTempObj, "MaxLine" ) 
	v_dataRow  := GetTempParam( g_GKTempObj, "DataRow" )  

	v_MaxLine  := GetTempParam( g_GKTempObj, "MaxLine" )
	if v_MaxLine <= 0
		v_MaxLine := 10000


	;; 读取EXCEL文件数据
	Xl := ComObjCreate("Excel.Application")
	Xl.Workbooks.Open(g_GKDataFile) ;open an existing file

	v_DataLine := LocalTitleLine( Xl, g_GKTempObj )

	;msgbox iCol_AMT_YJ = %iCol_AMT_YJ%

	;msgbox 查找到 数据行 为 【%v_DataLine%】
	if v_DataLine > 0
	{
		v_row := v_DataLine - 1
		v_TotalType := GetTempParam( g_GKTempObj, "TotalType" )

		loop %v_MaxLine%
		{
			v_row ++
			;; 判断是否到了结束行
			bMatch := true
			n := 0
			for col, needle in g_GKTempObj["EndMatch"]
			{
				n++

				if ( col >= 1 and needle != "" )
				{
					R_Cell := CellRange( col , v_row )
					;tooltip %R_Cell% := CellRange( %col% `, %v_row% )s
					cell := Xl.Range( R_Cell ).Value
				
					x := RegExMatch( cell, needle )

					;if v_row >= 440
					;	msgbox %R_Cell% := CellRange( %col% `, %v_row% )`n %cell% := Xl.Range( %R_Cell% ).Value`n%x% := RegExMatch( %cell%`, %needle% )

					if x <= 0 ; RegExMatch( cell, needle ) <= 0
					{
						bMatch := false
						break	
					}					
				}
			}
			;; 已经到了结束行，结束循环
			if ( bMatch && n > 0 )
			{
				;; 佛山区需要设置统计栏公式
				if v_AreaType = 1
						SetTotalLine_FS( XL, g_InsertDataObj, v_DataLine, v_row )

				;; 非佛山区需要设置统计栏公式
				else
					if v_TotalType = 1
						SetTotalLine( XL, g_InsertDataObj, v_DataLine, v_row )
			

			    tooltip [%v_row%]已经到了结束行，结束循环!
				var_ret := true
				break
			}

			;; 设置数据

			keyArray0 := 0
			isError := false  ;; 是否存在值为空的的关键字

			;; 没有遇到结束行，则读取数据
			for l, element in g_GKTempObj["key"]
			{
				col  := element["col"]
				name := element["name"]
			;	stringleft col, 	col, 	instr( col, "." ) - 1
				R_Cell := CellRange( col , v_row )
			;	msgbox %R_Cell% := CellRange( %col% `, %v_row% )`ncol=%col%`nname=%name%
				cell := Xl.Range( R_Cell ).Value

				var_type := element["type"]
				if var_type in float,int
				{
					Stringreplace cell, cell, `,,, all
					if var_type = int
						cell := round(cell)
				}
				else if var_type = date
				{
					cell := GetFormatDate( cell )
				}

				keyArray0++
				keyArray%keyArray0% := cell

				if cell = 
					isError := true
					
			}

			
			if not isError
			{
				bHasKey := true
				node := g_GKDataObj
				loop %keyArray0%
				{
					key := keyArray%a_index%
					if node.HasKey(key)
					{
						node := node[key]
					}
					else
					{
						bHasKey := false
					}
				}
				if bHasKey
				{
					for idx, element in node
					{
						var_line := element["_i_"]
						if ( var_line == v_row )
						{
							if iCol_AMT_XF > 1
							{
								Range := CellRange( iCol_AMT_XF, v_row )
								Xl.Range( Range ).Value := element["AMT_XF"]
							}

							Range := CellRange( iCol_AMT_YJ, v_row )
							Xl.Range( Range ).Value := element["AMT_YJ"]
						}
					}
				}
			}
			
		}

	}
	;; 将生成的Excell保存
	SplitPath, g_GKDataFile, OutFileName, OutDir, OutExtension
	var_path = %g_bakdir%\%g_OutFileName%.%OutExtension%	
	filedelete %var_path%
	Xl.ActiveWorkbook.SaveAs(var_path)
	Xl.Workbooks.Close()	



;; 移动数据文件
FileMove, %g_GKDataFile%, %g_bakdir%
if ErrorLevel 
	var_log = 公款文件移动出错! `r`n`t`"%g_GKDataFile%`"  `r`n`t==>  `"%g_bakdir%`"
else 
	var_log = 成功移动公款文件! `r`n`t`"%g_GKDataFile%`"  `r`n`t==>  `"%g_bakdir%`"
WriteLog( var_log . "`r`n" )	


loop %DataFileArray0%
{	
	v_file := DataFileArray%a_index%

	FileMove, %v_file%, %g_bakdir%
	if ErrorLevel 
		var_log = 消费数据文件移动出错! `r`n`t`"%v_file%`"  `r`n`t==>  `"%g_bakdir%`"
	else
		var_log = 成功移动消费数据文件! `r`n`t`"%v_file%`"  `r`n`t==>  `"%g_bakdir%`"
	WriteLog( var_log )	
}

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

处理公款表重复数据( oGKData_, date_, user_, v_type = "?" )
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

合并消费数据到公款表结构( oGKData_, oXFData_, date_, user_ )
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
