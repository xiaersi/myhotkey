#include ..\..\
#include .\inc\inifile.aik
#include .\inc\string.aik

var_clip =          ;; ����ѡ�е��ļ�
var_dir =           ;; ��ǰĿ¼
FileList =          ;; �ļ��б�
FileCount = 0       ;; �ļ��б����Ŀ
ExtList =           ;; ��չ���б�
ExtCount = 0        ;; ��չ���б������
HisExtList := ReadTempIni("�����ļ�","������չ��","")
HisPartExtList := ReadTempIni("�����ļ�","ͨ����չ��","")
g_title = ���������ļ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��ȡ���������浽var_clip
var_clip = %1%
if var_clip =
{
	var_clip := clipboard
}

if var_clip = 
{
	msgbox û��ѡ���κ��ļ���δ�������ļ���
	exitapp
	return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �����������õ�ѡ�е��ļ��б�����Ŀ¼����չ������Ϣ
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
;; ��ʾ����
Gui, Add, Text, x6 y15 w600 h15 , ���������ڸ����ļ������ļ���չ�������ļ�������༭����ʾ���ǵ�ǰ����Ŀ¼��
Gui, Add, Edit, x6 y30 w570 h20 , %var_dir%
Gui, Add, ListBox, x6 y80 w360 h340 v_ListBox, ListBox
Gui, Add, Text, x6 y65 w360 h15 v_Tip, ѡ�е��ļ��б�
Gui, Add, CheckBox, x376 y70 w200 h20 v_bCurExt g����ѡ��ǰ��չ���� , ��ǰ��չ��
Gui, Add, Edit, x376 y90 w200 h20 v_CurExt, %ExtList%
Gui, Add, CheckBox, x376 y120 w200 h20 v_bHisExt g����ѡ��ʷ���ص���չ����, ��ʷ���ص���չ��
Gui, Add, Edit, x376 y140 w200 h20 v_HisExt, %HisExtList%
Gui, Add, CheckBox, x376 y170 w200 h20 v_bHisPartExt g����ѡ��ʷ���ص�ͨ����չ����, ��ʷ���ص�ͨ����չ��
Gui, Add, Edit, x376 y190 w200 h20 v_HisPartExt, %HisPartExtList%
Gui, Add, Radio, x376 y240 w200 h20 v_HideSelect g��������ѡ���ļ���, ������ѡ���ļ�
Gui, Add, Radio, x376 y270 w200 h20 g��������ͬ�����ļ���, ������ͬ�����ļ�
Gui, Add, Radio, x376 y300 w200 h20 v_HideCurstom g���Զ��������ļ���, �Զ��������ļ�
Gui, Add, Button, x476 y360 w90 h30 g��ȡ����, ȡ��
Gui, Add, Button, x376 y360 w90 h30 default g��ȷ����, ȷ��
; Generated using SmartGUI Creator 4.0
Gui, Show, h429 w584, %g_title%

GuiControl, , _HideSelect, 1
gosub ��������ѡ���ļ���
Return


��ȡ����:
GuiClose:
ExitApp

��������ѡ���ļ���:
	GuiControl, , _bCurExt, 0
	GuiControl, , _bHisExt, 0
	GuiControl, , _bHisPartExt, 0
	GuiControl, , _Tip, ������ʾѡ�е��ļ���
	GuiControl, , _ListBox, |
	loop %FileCount%
	{	
		var_temp := FileList%a_index%
		GuiControl,, _ListBox, %var_temp%
	}
	return
	
��������ͬ�����ļ���:
	GuiControl, , _bCurExt, 1
	GuiControl, , _bHisExt, 0
	GuiControl, , _bHisPartExt, 0
	GuiControl, , _Tip, ������ʾ������ѡ���ļ�ͬ���͵������ļ���
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
	
���Զ��������ļ���: 
	GuiControl, , _bCurExt, 1
	GuiControl, , _bHisExt, 1
	GuiControl, , _bHisPartExt, 1
	GuiControl, , _Tip, ������ʾ�����Զ������͵��ļ���
	GuiControl,, _ListBox, |
	goto [�õ��Զ������͵��ļ��б�]
	return
	
��ȷ����:
	Gui, Submit, nohide
	ControlGet, FileList, List, , ListBox1	; �������ListBox 
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
		WriteTempIni("�����ļ�","������չ��", _HisExt )
	}
	if _bHisPartExt
	{
	 	WriteTempIni("�����ļ�","ͨ����չ��", _HisPartExt )	
	}
	exitapp
	return
	
	
����ѡ��ǰ��չ����:	
����ѡ��ʷ���ص�ͨ����չ����:
����ѡ��ʷ���ص���չ����:
	GuiControl, , _HideCurstom, 1
	gosub [�õ��Զ������͵��ļ��б�]
	return
	
[�õ��Զ������͵��ļ��б�]:
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
				continue  ; ��ͬ�ļ����Ѿ���ӹ�
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
