/**
 *@file    FreeCommander
 *@author  teshorse
 *@date    2011.12.27
 *@brief   ���FreeCommander��������TotalCommander���ļ�����������һЩ����
 */

#IfWinActive ahk_class TFcFormMain

;; �����뽹�����õ����ٹ��˿�
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

;; �رտ��ٹ��� ʹ��ǰ�Ŀ��ٹ���ʧЧ
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