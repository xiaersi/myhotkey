
SplitPath, a_scriptdir, , g_WorkDir
SetWorkingDir, %g_WorkDir%

tooltip 1、正在读取配置信息......

g_debug := false
g_bakdir := g_WorkDir
filedelete %g_bakdir%\log.txt

g_TempFile = %g_WorkDir%\temp\zhangxiang.xls


;; 检查模板文件是否存在
tooltip 2、检查模板文件是否存在

ifnotexist %g_TempFile%
{
	var_log = 模板文件不存在!
	msgbox %var_log%
	return
}



;; 检查数据文件是否存在
g_DataDir = %g_WorkDir%\data
g_DataFile := SelectFile( g_DataDir, "*", "请选择数据文件" )
ifnotexist %g_DataFile%
{
	var_log = 数据文件不存在!
	msgbox %var_log%
	return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 加载模板文件数据至Object

g_TempObj := object()

var_log = 开始加载加班模板: %g_TempFile%
tooltip 3、%var_log%

if not ReadXlsTemp( g_TempFile, g_TempObj )
{
	var_log = 加班申请表模板数据 加载失败！`r`n`r`n程序结束！
	msgbox %var_log%
	return 
}


var_temp := GetObjectText( g_TempObj )
WriteLog( "`r`ng_TempObj：" . var_temp, false ) 



tooltip 4、加载加班数据文件
g_DataObj := object()


DataFileArray0 := 0
FileList := SeachXlsFile( g_DataDir, "*" )
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

/*
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
*/

/*
WriteLog( ";`r`n;--------------------------------------------------------------------------------------------------------------" ) 
var_temp := GetObjectText( g_GKDataObj )
WriteLog( "`r`ng_GKDataObj：" . var_temp, false ) 
WriteLog( "-------------------------------------------------------`r`n" , false ) 
*/


tooltip 数据加载完毕！
WriteLog( "-------------------------------------------------------`r`n`r`n" , false ) 
WriteLog( "程序结束！", false )
sleep 1000
tooltip
return 

#include %a_scriptdir%\ReadExcel2Array.aik
#include %a_scriptdir%\func.aik


#ifwinactive  泰海网络POSP管理系统 V1.0 - Microsoft Internet Explorer ahk_class IEFrame
F7::
	clipboard := g_sf_term
	sleep 20
	send ^v
	send `t`t{enter}
	return

F8::
	send `t
	clipboard := g_bk_cod
	sleep 20
	send ^v
	sleep 20
	send `t
	clipboard := g_bk_term
	sleep 20
	send ^v
	;; 
	send `t`t`t`t{space}

	msgbox 4, 下一条？, 点击 是 获取下一条数据！
	ifmsgbox yes
	{
		GetNextData()
	}
	return
	

#ifwinactive

;; AutoHotkey
GetNextData()
{
	global

}

