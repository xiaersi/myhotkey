SplitPath, a_scriptdir, , g_WorkDir
SetWorkingDir, %g_WorkDir%


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
g_试用券模板 		:= Read_ini( g_inifile, "试用券表", "模板文件", "试用券模板.xls" )

g_公款表文件匹配 	:= Read_ini( g_inifile, "公款表", "文件名匹配", "公款" )
g_数据表文件匹配 	:= Read_ini( g_inifile, "消费数据表", "文件名匹配", "消费" )
g_试用券文件匹配 	:= Read_ini( g_inifile, "试用券表", "文件名匹配", "试用" )

g_GKTempFile = %g_TempDir%\%g_公款表模板%
g_XFTempFile = %g_TempDir%\%g_数据表模板%
g_TryTempFile = %g_TempDir%\%g_试用券模板%


_edttip =
(
【使用步骤】

 1、将“公款表”、“试用券”和“消费数据”数据文件复制到Data子目录。
 
 2、在本窗口界面指定合并导出的文件名，默认为“汇总”。

 3、可选择“移动文件”复选框，将会把参与计算的数据文件移动到导出目录。

 4、按“开始”按钮开始合并数据，成功结束之后将会自动打开导出目录。
)

Gui, Add, Button, x416 y40 w40 h20 g【开始】, 开始
Gui, Add, Text, x6 y40 w80 h20 +Right, 导出文件名：
Gui, Add, Edit, x86 y40 w320 h20 vg_OutFileName, %g_OutFileName%

Gui, Add, CheckBox, x416 y5 w40 h30 v_MoveFile, 移动文件
Gui, Add, Text, x6 y10 w80 h20 +Right, 导出文件夹：
Gui, Add, Edit, x86 y10 w320 h20 +ReadOnly, %g_bakdir%

Gui, Add, Progress, x6 y70 w460 h20 Range0-100 v_progress, 0
Gui, Add, Edit, x6 y120 w460 h250 v_edttip, %_edttip%
Gui, Add, Text, x6 y100 w460  v_lbltip, 请准备好数据文件和设置好参数之后，按“开始”按钮开始合并数据。

; Generated using SmartGUI Creator 4.0
Gui, Show, h377 w472, 销售员交款汇总表合成工具
Return

GuiClose:
ExitApp


【开始】:
	gui submit, nohide
	if g_OutFileName =
	{
		msgbox 请指定导出文件名！
		GuiControl, Focus, g_OutFileName
		goto 【结束写日志】
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GuiControl,, _progress, 0
	GuiControl, , _lbltip , 检查模板文件是否存在...
	if not ∑检查模板文件是否存在()
	{
		GuiControl, , _lbltip , 模板文件不存在，程序结束！
		AppendTip( "`r`n模板文件不存在，程序结束！`r`n", false ) 
		goto 【结束写日志】 
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GuiControl,, _progress, 10
	GuiControl, , _lbltip , 加载模板文件数据...
	g_GKTempObj := object()
	g_XFTempObj := object()
	g_TryTempObj := object()
	if not ∑加载模板文件数据()
	{
		GuiControl, , _lbltip , 加载模板文件数据失败，程序结束！
		AppendTip( "`r`n加载模板文件数据失败，程序结束！`r`n", false ) 
		goto 【结束写日志】 
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GuiControl,, _progress, 20
	GuiControl, , _lbltip , 加载模板文件数据...
	g_GKDataObj := object()
	if not ∑加载公款数据文件()
	{
		GuiControl, , _lbltip , 加载公款数据文件失败，程序结束！
		AppendTip( "`r`n加载公款数据文件失败，程序结束！`r`n", false ) 
		goto 【结束写日志】 
		return
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GuiControl,, _progress, 30
	GuiControl, , _lbltip , 加载消费数据文件数据...
	g_XFDataObj := object()
	if not ∑加载消费数据文件()
	{
		GuiControl, , _lbltip , 加载消费数据文件失败，程序结束！
		AppendTip( "`r`n加载消费数据文件失败，程序结束！`r`n", false ) 
		goto 【结束写日志】 
		return
	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GuiControl,, _progress, 50
	GuiControl, , _lbltip , 加载试用券数据文件数据...
	g_tryDataObj := object()
	if not ∑加载试用券数据文件()
	{
		GuiControl, , _lbltip , 加载试用券数据文件失败，程序结束！
		AppendTip( "`r`n加载试用券数据文件失败，程序结束！`r`n", false ) 
		goto 【结束写日志】 
		return
	}	

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GuiControl,, _progress, 70
	GuiControl, , _lbltip , 数据运算中...
	gosub 【数据运算】

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GuiControl,, _progress, 80
	GuiControl, , _lbltip , 数据导出保存中...
	if not ∑数据导出保存()
	{
		GuiControl, , _lbltip , 数据导出失败，程序结束！
		AppendTip( "`r`n数据导出失败，程序结束！`r`n", false ) 
		goto 【结束写日志】 
		return
	}		

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	if _MoveFile
	{
		GuiControl,, _progress, 95
		GuiControl, , _lbltip , 移动参与计算的数据文件到导出目录...
		gosub 【移动数据文件】
	}

	var_log = `r`n正在打开导出目录：%g_bakdir%`r`n
	AppendTip( var_log )
	run %g_bakdir%

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GuiControl,, _progress, 100
	GuiControl, , _lbltip , 程序运行结束！
	var_log = `r`n`r`n导出的汇总表：%var_path%`r`n`r`n
	AppendTip( var_log )
	AppendTip( "`r`n程序运行结束！`r`n", false ) 
	tooltip

	goto 【结束写日志】
	return

【结束写日志】:
	fileappend `r`n%g_log%, %g_bakdir%\log.txt
	tooltip
	return


#include %a_scriptdir%\ReadExcel2Array.aik
#include %a_scriptdir%\func.aik
#include %a_scriptdir%\Lables.aik
