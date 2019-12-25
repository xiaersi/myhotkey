#include ..\..\

;;---全局变量----------------------------------------------------------------
g_title = 文件批量处理
var_clip = %1%						;; 文件名称
g_dir = 

if var_clip =
	var_clip := clipboard

stringreplace, var_clip, var_clip, `r , , all

if var_clip <>
{
	filecount = 0
;	msgbox clip[%var_clip%]
	loop parse, var_clip, `n
	{
		var_file := a_loopfield
		ifexist %var_file%
		{
;			msgbox exist %var_file%

			splitpath, var_file, name, dir, ext, name_no_ext
			if g_dir =
			{
				g_dir := dir
			}
			filecount++
			filelist%filecount% := name
;	msgbox filelist%filecount% := %name%
	 	}
		else
		{
;			msgbox not exist %var_file%
		}
	}
}

;;---显示窗口----------------------------------------------------------------
gui +resize
Gui, Add, StatusBar,, 状态栏

Gui, Add, Tab2, x6 y170 w760 h280 v_ListTab, 文件列表|过滤文件列表|重复文件列表
Gui, tab, 文件列表
Gui, Add, ListView, x16 y210 w580 h260 +Checked -WantF2 v_MyListView, 文件名|扩展名|大小|修改时间|路径

Gui, tab, 过滤文件列表
Gui, Add, ListBox, x16 y210 w580 h260 v_FilterList

Gui, tab, 重复文件列表
Gui, Add, ListBox, x16 y210 w580 h260 v_ExistList

;;---产生分页选项卡----------------------------------------------------------
Gui, Add, Tab2, x6 y10 w760 h150 v_MyTab, 打开|查找过滤|复制移动|批量命名|设置属性
Gui, Tab, 打开
Gui, Add, Text, x15 y45 w80 h20 	+Right, 过滤文件夹
Gui, Add, Text, x385 y45 w90 h20 	+Right, 过滤完整扩展名
Gui, Add, Text, x15 y75 w80 h20 	+Right, 过滤文件名
Gui, Add, Text, x385 y75 w90 h20 	+Right, 过滤通配扩展名
Gui, Add, Edit, x95 y40 w280 h25  	v_FiltDir, .svn|debug
Gui, Add, Edit, x95 y75 w280 h25  	v_FiltFile, 
Gui, Add, Edit, x475 y40 w280 h25 	v_FiltExtension, bak
Gui, Add, Edit, x475 y75 w280 h25 	v_FiltExt, ~
Gui, Add, Edit, x117 y118 w480 h25 	v_WorkingDir
Gui, Add, Button, x600 y115 w60 h30 g【加载目录】, 加  载
Gui, Add, Button, x660 y115 w98 h30 g【显示选中文件】, 显示选中文件
Gui, Add, Button, x15 y115 w100 h30 g【打开目录】, 打开目录

Gui, Tab, 查找过滤
Gui, Add, Text, x65 y35 w100 h15 , 文件名
Gui, Add, Text, x435 y35 w100 h15 , 扩展名
Gui, Add, Text, x25 y55 w30 h20 , 查找
Gui, Add, Text, x25 y85 w30 h20 , 过滤
Gui, Add, Text, x25 y125 w70 h20 , 过滤文件夹
Gui, Add, Text, x380 y125 w50 h15 , 文件大小
Gui, Add, Edit, x65 y50 w360 h25  	v_findName	g【实时查找文件名】
Gui, Add, Edit, x435 y50 w180 h25 	v_findExt		g【实时查找扩展名】
Gui, Add, Edit, x65 y85 w360 h25 	v_edtFiName
Gui, Add, Edit, x435 y85 w180 h25  	v_edtFiExt
Gui, Add, Edit, x95 y125 w270 h22  	v_edtFiDir
Gui, Add, DropDownList,  x435 y125 w50 h28 R6 v_MyDropList, >||<|=|>=|<=|介于
Gui, Add, Edit, x490 y125 w125 h22  v_fileSize
Gui, Add, Button, x635 y47 w100 h30 g【查找按钮】, 查  找
Gui, Add, Button, x635 y83 w100 h30 g【过滤按钮】, 查找并过滤


Gui, Tab, 复制移动
Gui, Add, Text, x350 y65 w40 h20 , <变量>

Gui, Tab, 批量命名
Gui, Add, Text, x16 y43 w50 h20 +Right , 开始条件


; Generated using SmartGUI Creator 4.0
Gui, Show, h556 w800, %g_title%

goto 【显示选中文件】

Return


;;---退出事件----------------------------------------------------------------
GuiClose:
ExitApp

;;---窗口大小调整事件--------------------------------------------------------
GuiSize:
	;; 调整选项卡与、编辑框的位置
	GuiControlGet, EditPos, Pos, _ListTab
	width := A_GuiWidth - 15
	height := a_GuiHeight - 30 - EditPosY
	if height < 10
		height = 10
		
	GuiControl, MoveDraw, _MyTab,  w%width% 
	GuiControl, MoveDraw, _ListTab, w%width% h%height%
	width := width - 20
	height := height - 50
	GuiControl, MoveDraw, _MyListView, w%width% h%height%
	GuiControl, MoveDraw, _FilterList, w%width% h%height%
	GuiControl, MoveDraw, _ExistList,  w%width% h%height%
	
	LV_ModifyCol( 1, A_GuiWidth // 2 )
	return	
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 分析参数，得到选中的文件列表、所在目录、扩展名等信息
【显示选中文件】:
	LV_Delete()
;	msgbox filecount[%filecount%]
	if filecount > 0
	{
		GuiControl, -Redraw, _MyListView
		loop %filecount%
		{
			filename :=  filelist%a_index%
			filefullname = %g_dir%\%Filename%
			FileGetSize, filesize, %filefullname%
			SplitPath, filename , OutFileName, OutDir, OutExtension
			FileGetTime, modtime , %filefullname%, M

			LV_Add("", filename, OutExtension, filesize, modtime, g_dir )
		}
		AutoModifyCol()
		GuiControl, +Redraw, _MyListView		
	}
	return

【打开目录】:
	FileSelectFolder, OutputVar , , 1, 请选择要打开的目录:
	SplitPath, OutputVar , OutFileName, OutDir, , , OutDrive
	if ( OutDir == OutDrive && OutFileName == "" )
	{
		msgbox 4, 警告, 您正在打开一个磁盘分区 %OutDrive% 盘 ！`n`n打开完整的分区可能会很慢！确定要搜索整个分区吗？
		ifmsgbox no
			return
	}

	
	guicontrol, text, _workingdir, %OutputVar%
	
【加载目录】:
	SB_SetText("正在加载目录......")
	gui, submit, nohide
	if _WorkingDir =
		return
	ifnotexist %_workingdir%
	{
		msgbox 设定的目录不存在！
		return
	}
	SetWorkingDir %_workingdir%

	GuiControl, -Redraw, _MyListView
	;; 清空内存
	lv_delete()
	loop %g_loadCount%
	{
		aFileName%a_index% = 
		aFileExt%a_index%  = 
		aFileSize%a_index% =
		aFileDir%a_index%  =
		aFileModTime%a_index% = 
		aFileAttrib%a_index% =
	}

	;; 分解要过滤的文件夹
	nFiltDir = 0
	loop parse, _filtDir, |
	{
		if a_loopfield =
			continue
		nFiltDir++
		aFiltDir%nFiltDir% := a_loopfield
	}

	nFiltFile = 0
	loop parse, _filtFile, |
	{
		if a_loopfield =
			continue
		nFiltFile++
		aFiltFile%nFiltFile% := a_loopfield
	}

	nFiltExt = 0
	loop parse, _filtExt, |
	{
		if a_loopfield =
		 	continue

		nFiltExt++
		aFiltExt%nFiltExt% := a_loopfield
	}

	nFiltExtension = 0
	loop parse, _filtExtension, |
	{
		if a_loopfield =
			continue
		nFiltExtension++
		aFiltExtension%nFiltExtension% := a_loopfield
	}
	
	;; 开始遍历文件
	g_loadCount = 0
	loop *.*, 0, 1
	{
		if nFiltDir > 0
		{
			bFilt := false
			loop %nFiltDir%
			{
				var_temp := aFiltDir%a_index%
				var_pos := instr( A_LoopFileDir, var_temp )
				if var_pos = 1
				{
					bFilt := true
					break
				}
				if ( strlen( var_temp ) == strlen( a_loopfiledir ) - var_pos + 1 )
				{
					bFilt := true
					break
				}
				ifinstring a_loopfiledir, \%var_temp%\
				{
					bFilt := true
					break
				}
			}
			if bFilt
				continue
		}
		if nFiltExt > 0
		{
			bFilt := false
			loop %nFiltExt%
			{
				var_temp := aFiltExt%a_index%
				ifinstring A_LoopFileExt, %var_temp%
				{
					bFilt := true
					break
				}
			}
			if bFilt
				continue
		}
		if nFiltExtension > 0
		{
			bFilt := false
			loop %nFiltExtension%
			{
				var_temp := aFiltExtension%a_index%
				if ( A_LoopFileExt == var_temp )
				{
					bFilt := true
					break
				}
			}
			if bFilt
				continue
		}
		var_pos := instr( a_LoopFileName, "." )
		if var_pos > 0
		{
			stringleft FileNameNoExt, a_LoopFileName,  var_pos - 1
		}
		else
		{
			FileNameNoExt := a_loopfileName
		}
		if nFiltFile > 0
		{
			bFilt := false
			loop %nFiltFile%
			{
				var_temp := aFiltFile%a_index%
				ifinstring FileNameNoExt, %var_temp%
				{
					bFilt := true
					break
				}
			}
			if bFilt
				continue
		}		
		g_loadCount++
		aFileName%g_loadCount% 	:= a_loopfilename
		aFileExt%g_loadCount%  	:= a_LoopFileExt
		aFileSize%g_loadCount% 	:= a_LoopFileSizeKB
		aFileDir%g_loadCount%  	:= a_LoopFileDir
		aFileModTime%g_loadCount% := A_LoopFileTimeModified
		aFileAttrib%g_loadCount%  := A_LoopFileAttrib
	}

	loop %g_loadcount%
	{
		LV_AddIndex( a_index )
	}
	AutoModifyCol()
	GuiControl, +Redraw, _MyListView
	return


#include .\bin\Explore\文件批量处理_查找过滤.aik
#include .\bin\Explore\文件批量处理_复制移动.aik
#include .\bin\Explore\文件批量处理_批量命名.aik

LV_AddIndex( var_index )
{
	global
	if ( var_index > 0 && var_index <= g_loadcount )
	{
		LV_Add("", aFileName%var_index%, aFileExt%var_index%, aFileSize%var_index%, aFileModTime%var_index%, aFileDir%var_index% )
	}
}


AutoModifyCol()
{
	global 
	LV_ModifyCol()
;	GetLVColWidth()
}

GetLVColWidth( var_GuiID, var_row )
{
	SendMessage, 0x1029, %var_row%, 0,, ahk_id %var_GuiID%
  	return ErrorLevel
}

GetChildHWND(ParentHWND, ChildClassNN)
{
   WinGetPos, ParentX, ParentY,,, ahk_id %ParentHWND%
   if ParentX =
      return  ; Parent window not found (possibly due to DetectHiddenWindows).
   ControlGetPos, ChildX, ChildY,,, %ChildClassNN%, ahk_id %ParentHWND%
   if ChildX =
      return  ; Child window not found, so return a blank value.
   ; Convert child coordinates -- which are relative to its parent's upper left
   ; corner -- to absolute/screen coordinates for use with WindowFromPoint().
   ; The following INTENTIONALLY passes too many args to the function because
   ; each arg is 32-bit, which allows the function to automatically combine
   ; them into one 64-bit arg (namely the POINT structure):
   return DllCall("WindowFromPoint", "int", ChildX + ParentX, "int", ChildY + ParentY)
}
