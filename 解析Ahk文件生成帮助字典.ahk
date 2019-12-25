/**
 *@file    解析Ahk文件生成帮助字典.ahk
 *@author  teshorse
 *@date    2012.02.03
 *@brief   解析该脚本文件目录下的所有ahk/aik文件，生成帮助字典
 *
 * 即搜索所有的函数名、功能子模块名称、热键名称。（包含它们的注释）
 *- 并按所在目录进行分节，保存成一个dic字典文件，作为帮助文件以便查询。
 */

;#NoTrayIcon

g_tiltle = 解析Ahk文件生成帮助字典
g_state  := 0 ;; 当前所处状态, 0初始状态、1搜索、2分析、3暂停、4取消、5退出
g_index	 := 0
g_FindExtList = ahk,aik,inc  ;; 设置要搜索的扩展名

;; 显示GUI界面
Gui, Add, Text, x6 y10 w460 h20 v_lbl1, 分析AHK文件生成帮助文档
Gui, Add, Progress, x6 y30 w460 h20  v_Progress, 0
Gui, Add, Text, x6 y100 w460 h20 v_lbl2, 处理细节：
Gui, Add, ListBox, x6 y120 w460 h250  v_listbox,
Gui, Add, Button, x6 y60 w80 h30   g【搜索文件】 v_btnSearch, 搜  索
Gui, Add, Button, x96 y60 w80 h30  g【分析按钮】 v_btnAna, 分  析
Gui, Add, Button, x186 y60 w80 h30 Disable g【暂停按钮】 v_btnPause, 暂  停
Gui, Add, Button, x296 y60 w80 h30 g【取消按钮】 v_btnCancel, 取  消
Gui, Add, Button, x386 y60 w80 h30 g【退出按钮】 v_btnExit, 退  出
; Generated using SmartGUI Creator 4.0
Gui, Show, h377 w477, %g_tiltle%

∑切换状态( 0 )  ;; 切换状态到初始状态

Return


【退出按钮】:
GuiClose:
	ExitApp
	Return



【搜索文件】:
	if g_state in 1,2
	{
		var := g_state == 1 ? "搜索" : "分析"
		MsgBox 当前正处于“%g_state%”状态，无法执行【搜索】功能！
		return
	}
	;; 切换到“搜索”状态
	∑切换状态( 1 )

	var_filelist = ;; 临时保存搜索的文件列表为字符串列
	clearArray( "FileArray" )
	GuiControl, , _listbox, |
	GuiControl, , _lbl1, 正在搜索文件......
    Loop *.*, 0, 1  ; Retrieve all of Folder's sub-folders.
	{
		if g_state <> 1
		{
			break 	;; 如果不在搜索状态，停止搜索
		}
		if  A_LoopFileExt in %g_FindExtList%
		{
			AppendArray( "FileArray", A_LoopFileFullPath )
			GuiControl, , _listbox, %A_LoopFileFullPath%
		}
	}
	g_tip = 搜索完毕：共有 %FileArray0% 个文件待分析！
	GuiControl, , _lbl1, %g_tip%

	;; 设置进度条
	GuiControl, +Range0-%FileArray0%, _progress
	GuiControl, , _progress, 0
	GuiControl, , _listbox, %var_filelist%

	∑切换状态( 0 )
	Return


【分析按钮】:
	if g_state <> 2
	{
		∑切换状态( 2)   	;; 切换到分析状态

		if g_index = 0		;; 开始分析
		{
			GuiControl, , _progress, 0
			GuiControl, , _lbl1, 开始分析
		}
		Else				;; 被暂停后，恢复分析
		{
			/*
			if ( g_index > FileArray0 )
			{
				g_index := 0
				GuiControl, , _progress, 0
			}
			*/
		}

		;; 开始循环分析搜索出来的文件（如被暂停的，则继续）
		Loop
		{
			;; 分析被暂停
			if g_state = 3
				Break

			;; 如果当前是取消状态，则停止
			if g_state = 4
			{
				g_index := 0
				GuiControl, , _lbl1, 停止分析！
				∑切换状态( 0 )   	;; 切换到初始状态
				Break
			}

			g_index++

			;; 分析完毕，则停止
			if ( g_index > FileArray0 )
			{
				g_index := 0
				GuiControl, , _lbl1, 所有文件分析完毕！
				∑切换状态( 0 )   	;; 切换到初始状态
				Break ;; 处理完毕
			}

			;; 分析文件
			var_file := FileArray%g_index%
			GuiControl, , _progress, %g_index%
			GuiControl, , _lbl1, 正在分析 (%g_index%/%FileArray0%)：%var_file%
			GuiControl, ChooseString, _listbox, %var_file%
			∑分析一个文件( var_file )
		;	GuiControl, , _listbox, %var_file%
		}
	}

	Return

【取消按钮】:
	∑切换状态( 4 )
	Return


【暂停按钮】:
	Gui, Submit, NoHide
	∑切换状态( 3 )
	Return



∑切换状态( iState )
{
	global

	if iState = 1			;; 搜索状态
	{
		GuiControl, Disable, _btnSearch
		GuiControl, Disable, _btnAna
		GuiControl, Disable, _btnPause
		GuiControl, Enable, _btnCancel
		GuiControl, Enable, _btnExit
	}
	else if iState = 2		;; 分析状态
	{
		GuiControl, Disable, _btnSearch
		GuiControl, Disable, _btnAna
		GuiControl, Enable, _btnPause
		GuiControl, Enable, _btnCancel
		GuiControl, Enable, _btnExit
	}
	else if iState = 3		;; 暂停状态
	{
		GuiControl, Disable, _btnSearch
		GuiControl, Enable, _btnAna
		GuiControl, Disable, _btnPause
		GuiControl, Enable, _btnCancel
		GuiControl, Enable, _btnExit
	}
	else if iState = 4		;; 取消状态
	{
		GuiControl, Enable, _btnSearch
		GuiControl, Enable, _btnAna
		GuiControl, Disable, _btnPause
		GuiControl, Enable, _btnCancel
		GuiControl, Enable, _btnExit
	}
	Else
	{
		GuiControl, Enable, _btnSearch
		GuiControl, Enable, _btnAna
		GuiControl, Disable, _btnPause
		GuiControl, Enable, _btnCancel
		GuiControl, Enable, _btnExit
		GuiControl, , _progress, 0
		iState := 0			;; 初始状态
	}

	g_state := iState

}


∑分析一个文件( filename_ )
{
	FileMem =		;; 文件原始内容缓存
	Contents = 		;; 存储从文件中加载的内容
	tempContents = 	;; 用于临时存储正在处理的文件内容
	FileRead, Contents, %filename_%
	FileMem := Contents
	if ErrorLevel  ;; 加载文件出错
		Return

	;; 处理加载的文件内容
	StringReplace Contents, Contents, `r, , All
	loop parse, Contents, `n
	{
		if a_loopfield =
		Continue

		;; 删除注释, 以 ; 开头的认为是注释
		var_line := RegExReplace( a_loopfield, "(\s|^)`;.*", "" )
		if var_line =
			Continue

		tempContents = %tempContents%%var_line%`n
	}
	;; 删除多行注释  /* ... */
	Contents := RegExReplace( tempContents, "m)/\*(\s|.)*?\*/", "" )
	Contents := RegExReplace( Contents, "``[```"]", "_" )  ;; 删除转义后的`和"
	Contents := RegExReplace( Contents, "`".*?`"", "" ) 	 ;; 删除字符串


	;; 删除文本块的定义 var=(
	;; ...
	;; )
	Contents := RegExReplace( Contents, "m)\s*\S+[^\S=]*=\s*\r*\n*\(.*?\n\s*\)", "" )


	tempContents =

	;; 搜索变量
	var_state = 0 ;; 当前在分析什么内容 0未知，1热键， 2Label标签，3函数
	StartPos := 1
	Pos0 := -1		;; 搜索/**/多行注释的开始位置
	Pos1 := -1		;; 1热键 搜索得到的位置
	Pos2 := -1		;; 2Label标签 搜索得到的位置
	Pos3 := -1		;; 3函数 搜索得到的位置

	Match1 =
	Match2 =
	Match3 =

	Loop
	{
		"m)(^|\n)\s*[^\s:=]*(?=:)"

	}

	;; 逐行分析
	loop parse, Contents, `n
	{
		if a_loopfield =
		Continue

		;;
		if RegExMatch( a_loopfield, "^\s*:.*?:.*::", var_match ) > 0
		{
			var_match := RegExReplace( var_match, "^\s*:.*?:", "" )
			var_match := RegExReplace( var_match, "::$", "" )

		}
		else if RegExMatch( a_loopfield, "^\s*[^\s:=]*(?=:)", var_match ) > 0
		{
			;; Label
		}
		else if RegExMatch( a_loopfield, "m)(^|\n)\s*[^\s:=\(\)]+(?=\([^\n\(\)]*?\)[\s\n\r]*?\{)", var_match ) > 0
		{
			;; 匹配函数名
		}

	}



	;; Free the memory.
	Contents =
	FileMem =

}


∑分析一个文件2( filename_ )
{
	FileRead, filemem, %filename_%

	if ErrorLevel
		Return

	if filemem =
		Return

	;; 变量说明
	state = 0 		;; 当前在分析什么内容 0未知，1热键， 2Label标签，3函数
	StartPos := 1
	EndPos := -1
	Pos0 := -1		;; 搜索/**/多行注释的开始位置
	Pos1 := -1		;; 1热键 搜索得到的位置
	Pos2 := -1		;; 2Label标签 搜索得到的位置
	Pos3 := -1		;; 3函数 搜索得到的位置

	prePos0 := -1   ;; 上一次搜索/**/多行注释的开始位置
	preMatch0 = 	;; 上一次搜索/**/得到的匹配值

	Match0 =
	Match1 =
	Match2 =
	Match3 =

	;; 第一次搜索
	Gosub 【搜索多行注释】
	Gosub 【搜索热键】
	Gosub 【搜索标签】
	Gosub 【搜索函数名】

	;; 开始分析文件内容
	Loop
	{
		;; 如果文件中已经无法再查询到热键、标签或函数，则退出
		if ( Pos1 == 0 && Pos2 == 0 && Pos3 == 0 )
		{
			Break
		}

		;; 对Pos1、Pos2、Pos3进行排序, 并取 >0 的最小值赋值给 EndPos
		EndPos := 0
		var_temp = %Pos1%`n%Pos2%`n%Pos3%
		Sort var_temp, N
		loop parse, var_temp, `n
		{
			If a_loopfield > 0
			{
				EndPos := a_loopfield
				break
			}
		}

		;; 没有找到最近搜索到的内容，则退出循环
		if EndPos <= 0
			break

		if ( EndPos == Pos1 )
			state := 1
		else if ( EndPos == Pos2 )
			state := 2
		else if ( EndPos == Pos3 )
			state := 3
		else
		{
			msgbox EndPos <> Pos1~3 `n 文件分析结束
			Break
		}

		;; 寻找 EndPos 附近的多行注释所在
		if ( Pos0  < EndPos )
			Gosub 【搜索多行注释】

		;; 分析当前标签并且保存到帮助字典中

		;; 准备下一次循环
		StartPos := EndPos
		if state = 1
			Gosub 【搜索热键】
		else if state = 2
			Gosub 【搜索标签】
		else if state = 3
			Gosub 【搜索函数名】
		else
			Break
	}

	filemem = ;; 释放内存
}


#include ./inc/common.aik
#Include ./inc/array.aik
