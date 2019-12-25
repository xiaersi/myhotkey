/**
 *@file    FreeCommander
 *@author  teshorse
 *@date    2011.12.27
 *@brief   针对FreeCommander（类似于TotalCommander的文件管理器）的一些操作
 */

#IfWinActive ahk_class TFcFormMain

;; 将输入焦点设置到快速过滤框
#F2::
^y::
	ControlGetFocus, var_control, ahk_class TFcFormMain
	if not ErrorLevel
	{
		if ( var_control == "TfcDragDropFileListView1" || var_control == "TfcPathEdit1" )
		{
			ControlFocus TfcQuickFilterEditField1, ahk_class TFcFormMain
		}
		else if ( var_control == "TfcDragDropFileListView2" || var_control == "TfcPathEdit2" )
		{
			ControlFocus TfcQuickFilterEditField2, ahk_class TFcFormMain
		}
	}
	Return

;; 关闭快速过滤 使当前的快速过滤失效
#F3::
!y::
	ControlGetFocus, var_control, ahk_class TFcFormMain
	if not ErrorLevel
	{
		if ( var_control == "TfcDragDropFileListView1" || var_control == "TfcPathEdit1" )
		{
			;ControlClick TfcQuickFilterPanel1, ahk_class TFcFormMain
			ControlGetPos , X, Y, Width, Height, TfcQuickFilterPanel1, ahk_class TFcFormMain
			;msgbox ControlClick TfcQuickFilterPanel2 [ %x%, %y% ]
			x := x + 70
			y := y + 10
			;MouseMove x, y
			ControlClick x%x% y%y%,  ahk_class TFcFormMain
		}
		else if ( var_control == "TfcDragDropFileListView2" || var_control == "TfcPathEdit2" )
		{
			;ControlClick TfcQuickFilterPanel2
			ControlGetPos , X, Y, Width, Height, TfcQuickFilterPanel2, ahk_class TFcFormMain
			;msgbox ControlClick TfcQuickFilterPanel2 [ %x%, %y% ]
			x := x + 70
			y := y + 10
			;MouseMove x, y
			ControlClick x%x% y%y%,  ahk_class TFcFormMain

		}
	}
	Return

#IfWinActive