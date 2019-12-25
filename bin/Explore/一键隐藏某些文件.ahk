#include ..\..\
#include .\inc\inifile.aik
#include .\inc\string.aik

var_clip =          ;; 复制选中的文件
var_dir =           ;; 当前目录
FileList =          ;; 文件列表
FileCount = 0       ;; 文件列表的数目
ExtList =           ;; 扩展名列表
ExtCount = 0        ;; 扩展名列表的数量
HisExtList := ReadTempIni("隐藏文件","隐藏扩展名","")
HisPartExtList := ReadTempIni("隐藏文件","通配扩展名","")
g_title = 批量隐藏文件
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 获取参数，保存到var_clip
var_clip = %1%
if var_clip =
{
	var_clip := clipboard
}

if var_clip = 
{
	msgbox 没有选中任何文件，未能隐藏文件！
	exitapp
	return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 分析参数，得到选中的文件列表、所在目录、扩展名等信息
StringReplace, var_clip, var_clip, `r , , all
if var_clip <>
{
	FileCount = 0
	ExtCount = 0
	loop parse, var_clip, `n
	{
		var_file := a_loopfield
		SplitPath, var_file, name, dir, ext, name_no_ext
	 	if var_dir =
	 	{
	 		var_dir := dir
	 	}
	 	FileCount++
	 	FileList%FileCount% := name
	 	
	 	if ext <>
	 	{
		 	FindExt := false
		 	loop %ExtCount%
		 	{
		 		if ( ExtList%a_index% == ext )
		 		{
		 			FindExt := true
		 			break
		 		}
		 	}
		 	if not FindExt
		 	{
		 		ExtCount++
		 		ExtList%ExtCount% := ext
		 		ExtList = %ExtList%%ext%,
		 	}
	 	}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 显示窗口
Gui, Add, Text, x6 y15 w600 h15 , 本窗口用于根据文件名或文件扩展名隐藏文件，下面编辑框显示的是当前操作目录：
Gui, Add, Edit, x6 y30 w570 h20 , %var_dir%
Gui, Add, ListBox, x6 y80 w360 h340 v_ListBox, ListBox
Gui, Add, Text, x6 y65 w360 h15 v_Tip, 选中的文件列表
Gui, Add, CheckBox, x376 y70 w200 h20 v_bCurExt g【复选当前扩展名】 , 当前扩展名
Gui, Add, Edit, x376 y90 w200 h20 v_CurExt, %ExtList%
Gui, Add, CheckBox, x376 y120 w200 h20 v_bHisExt g【复选历史隐藏的扩展名】, 历史隐藏的扩展名
Gui, Add, Edit, x376 y140 w200 h20 v_HisExt, %HisExtList%
Gui, Add, CheckBox, x376 y170 w200 h20 v_bHisPartExt g【复选历史隐藏的通配扩展名】, 历史隐藏的通配扩展名
Gui, Add, Edit, x376 y190 w200 h20 v_HisPartExt, %HisPartExtList%
Gui, Add, Radio, x376 y240 w200 h20 v_HideSelect g【仅隐藏选中文件】, 仅隐藏选中文件
Gui, Add, Radio, x376 y270 w200 h20 g【仅隐藏同类型文件】, 仅隐藏同类型文件
Gui, Add, Radio, x376 y300 w200 h20 v_HideCurstom g【自定义隐藏文件】, 自定义隐藏文件
Gui, Add, Button, x476 y360 w90 h30 g【取消】, 取消
Gui, Add, Button, x376 y360 w90 h30 default g【确定】, 确定
; Generated using SmartGUI Creator 4.0
Gui, Show, h429 w584, %g_title%

GuiControl, , _HideSelect, 1
gosub 【仅隐藏选中文件】
Return


【取消】:
GuiClose:
ExitApp

【仅隐藏选中文件】:
	GuiControl, , _bCurExt, 0
	GuiControl, , _bHisExt, 0
	GuiControl, , _bHisPartExt, 0
	GuiControl, , _Tip, 以下显示选中的文件：
	GuiControl, , _ListBox, |
	loop %FileCount%
	{	
		var_temp := FileList%a_index%
		GuiControl,, _ListBox, %var_temp%
	}
	return
	
【仅隐藏同类型文件】:
	GuiControl, , _bCurExt, 1
	GuiControl, , _bHisExt, 0
	GuiControl, , _bHisPartExt, 0
	GuiControl, , _Tip, 以下显示的是与选中文件同类型的所有文件：
	GuiControl,, _ListBox, |
	loop %extcount%
	{
		var_temp := ExtList%a_index%
		var_pattern = %var_dir%\*.%var_temp%
		loop %var_pattern%
		{
			GuiControl, , _ListBox, %A_LoopFileName%
		}
	}
	return
	
【自定义隐藏文件】: 
	GuiControl, , _bCurExt, 1
	GuiControl, , _bHisExt, 1
	GuiControl, , _bHisPartExt, 1
	GuiControl, , _Tip, 以下显示的是自定义类型的文件：
	GuiControl,, _ListBox, |
	goto [得到自定义类型的文件列表]
	return
	
【确定】:
	Gui, Submit, nohide
	ControlGet, FileList, List, , ListBox1	; 获得整个ListBox 
	Loop, Parse, FileList, `n  
	{
		var_file = %var_dir%\%A_LoopField%
		ifexist %var_file%
		{
			FileSetAttrib +H, %var_file%
		}
	}
	if _bHisExt
	{
		WriteTempIni("隐藏文件","隐藏扩展名", _HisExt )
	}
	if _bHisPartExt
	{
	 	WriteTempIni("隐藏文件","通配扩展名", _HisPartExt )	
	}
	exitapp
	return
	
	
【复选当前扩展名】:	
【复选历史隐藏的通配扩展名】:
【复选历史隐藏的扩展名】:
	GuiControl, , _HideCurstom, 1
	gosub [得到自定义类型的文件列表]
	return
	
[得到自定义类型的文件列表]:
	Gui, Submit, nohide
	GuiControl,, _ListBox, |
	var_pattern = %var_dir%\*.*
	if FileCount > 0
	{
		loop %FileCount%
		{
			FileList%a_index% =
		}
	}
	FileCount = 0
	
	loop %var_pattern%
	{
		if A_LoopFileFullPath =
			continue
			
		ifinstring A_LoopFileAttrib, H
			continue
			
		SplitPath, A_LoopFileFullPath, name, dir, ext, name_no_ext
		loop %FileCount%
		{
			var_temp := FileList%a_index%
			if ( var_temp == name )
			{
				continue  ; 相同文件名已经添加过
			}
		}
		
		if ( _bCurExt && _CurExt != "" )
		{
			ifinstring  _CurExt, %ext%
			{
				 if ( StrListFind(_CurExt, ext, ",") > 0 )
				 {
				 	GuiControl, , _ListBox, %A_LoopFileName%
					FileCount++
					FileList%FileCount% := name
					continue
				 }
			}
		}
		if ( _bHisExt && _HisExt != "" )
		{
			ifinstring  _HisExt, %ext%
			{
				 if ( StrListFind(_HisExt, ext, ",") > 0 )
				 {
				 	GuiControl, , _ListBox, %A_LoopFileName%
					FileCount++
					FileList%FileCount% := name					
					continue
				 }
			}
		}		
		if ( _bHisPartExt && _HisPartExt != "" )
		{
			loop, parse, _HisPartExt, `,
			{
				if a_loopfield =
					continue

				ifinstring ext, %a_loopfield%
				{
					GuiControl, , _ListBox, %A_LoopFileName%
					FileCount++
					FileList%FileCount% := name					
					continue
				}
			} 	
		}
	}
	return
