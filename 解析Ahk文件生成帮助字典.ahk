/**
 *@file    ����Ahk�ļ����ɰ����ֵ�.ahk
 *@author  teshorse
 *@date    2012.02.03
 *@brief   �����ýű��ļ�Ŀ¼�µ�����ahk/aik�ļ������ɰ����ֵ�
 *
 * ���������еĺ�������������ģ�����ơ��ȼ����ơ����������ǵ�ע�ͣ�
 *- ��������Ŀ¼���зֽڣ������һ��dic�ֵ��ļ�����Ϊ�����ļ��Ա��ѯ��
 */

;#NoTrayIcon

g_tiltle = ����Ahk�ļ����ɰ����ֵ�
g_state  := 0 ;; ��ǰ����״̬, 0��ʼ״̬��1������2������3��ͣ��4ȡ����5�˳�
g_index	 := 0
g_FindExtList = ahk,aik,inc  ;; ����Ҫ��������չ��

;; ��ʾGUI����
Gui, Add, Text, x6 y10 w460 h20 v_lbl1, ����AHK�ļ����ɰ����ĵ�
Gui, Add, Progress, x6 y30 w460 h20  v_Progress, 0
Gui, Add, Text, x6 y100 w460 h20 v_lbl2, ����ϸ�ڣ�
Gui, Add, ListBox, x6 y120 w460 h250  v_listbox,
Gui, Add, Button, x6 y60 w80 h30   g�������ļ��� v_btnSearch, ��  ��
Gui, Add, Button, x96 y60 w80 h30  g��������ť�� v_btnAna, ��  ��
Gui, Add, Button, x186 y60 w80 h30 Disable g����ͣ��ť�� v_btnPause, ��  ͣ
Gui, Add, Button, x296 y60 w80 h30 g��ȡ����ť�� v_btnCancel, ȡ  ��
Gui, Add, Button, x386 y60 w80 h30 g���˳���ť�� v_btnExit, ��  ��
; Generated using SmartGUI Creator 4.0
Gui, Show, h377 w477, %g_tiltle%

���л�״̬( 0 )  ;; �л�״̬����ʼ״̬

Return


���˳���ť��:
GuiClose:
	ExitApp
	Return



�������ļ���:
	if g_state in 1,2
	{
		var := g_state == 1 ? "����" : "����"
		MsgBox ��ǰ�����ڡ�%g_state%��״̬���޷�ִ�С����������ܣ�
		return
	}
	;; �л�����������״̬
	���л�״̬( 1 )

	var_filelist = ;; ��ʱ�����������ļ��б�Ϊ�ַ�����
	clearArray( "FileArray" )
	GuiControl, , _listbox, |
	GuiControl, , _lbl1, ���������ļ�......
    Loop *.*, 0, 1  ; Retrieve all of Folder's sub-folders.
	{
		if g_state <> 1
		{
			break 	;; �����������״̬��ֹͣ����
		}
		if  A_LoopFileExt in %g_FindExtList%
		{
			AppendArray( "FileArray", A_LoopFileFullPath )
			GuiControl, , _listbox, %A_LoopFileFullPath%
		}
	}
	g_tip = ������ϣ����� %FileArray0% ���ļ���������
	GuiControl, , _lbl1, %g_tip%

	;; ���ý�����
	GuiControl, +Range0-%FileArray0%, _progress
	GuiControl, , _progress, 0
	GuiControl, , _listbox, %var_filelist%

	���л�״̬( 0 )
	Return


��������ť��:
	if g_state <> 2
	{
		���л�״̬( 2)   	;; �л�������״̬

		if g_index = 0		;; ��ʼ����
		{
			GuiControl, , _progress, 0
			GuiControl, , _lbl1, ��ʼ����
		}
		Else				;; ����ͣ�󣬻ָ�����
		{
			/*
			if ( g_index > FileArray0 )
			{
				g_index := 0
				GuiControl, , _progress, 0
			}
			*/
		}

		;; ��ʼѭ�����������������ļ����类��ͣ�ģ��������
		Loop
		{
			;; ��������ͣ
			if g_state = 3
				Break

			;; �����ǰ��ȡ��״̬����ֹͣ
			if g_state = 4
			{
				g_index := 0
				GuiControl, , _lbl1, ֹͣ������
				���л�״̬( 0 )   	;; �л�����ʼ״̬
				Break
			}

			g_index++

			;; ������ϣ���ֹͣ
			if ( g_index > FileArray0 )
			{
				g_index := 0
				GuiControl, , _lbl1, �����ļ�������ϣ�
				���л�״̬( 0 )   	;; �л�����ʼ״̬
				Break ;; �������
			}

			;; �����ļ�
			var_file := FileArray%g_index%
			GuiControl, , _progress, %g_index%
			GuiControl, , _lbl1, ���ڷ��� (%g_index%/%FileArray0%)��%var_file%
			GuiControl, ChooseString, _listbox, %var_file%
			�Ʒ���һ���ļ�( var_file )
		;	GuiControl, , _listbox, %var_file%
		}
	}

	Return

��ȡ����ť��:
	���л�״̬( 4 )
	Return


����ͣ��ť��:
	Gui, Submit, NoHide
	���л�״̬( 3 )
	Return



���л�״̬( iState )
{
	global

	if iState = 1			;; ����״̬
	{
		GuiControl, Disable, _btnSearch
		GuiControl, Disable, _btnAna
		GuiControl, Disable, _btnPause
		GuiControl, Enable, _btnCancel
		GuiControl, Enable, _btnExit
	}
	else if iState = 2		;; ����״̬
	{
		GuiControl, Disable, _btnSearch
		GuiControl, Disable, _btnAna
		GuiControl, Enable, _btnPause
		GuiControl, Enable, _btnCancel
		GuiControl, Enable, _btnExit
	}
	else if iState = 3		;; ��ͣ״̬
	{
		GuiControl, Disable, _btnSearch
		GuiControl, Enable, _btnAna
		GuiControl, Disable, _btnPause
		GuiControl, Enable, _btnCancel
		GuiControl, Enable, _btnExit
	}
	else if iState = 4		;; ȡ��״̬
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
		iState := 0			;; ��ʼ״̬
	}

	g_state := iState

}


�Ʒ���һ���ļ�( filename_ )
{
	FileMem =		;; �ļ�ԭʼ���ݻ���
	Contents = 		;; �洢���ļ��м��ص�����
	tempContents = 	;; ������ʱ�洢���ڴ�����ļ�����
	FileRead, Contents, %filename_%
	FileMem := Contents
	if ErrorLevel  ;; �����ļ�����
		Return

	;; ������ص��ļ�����
	StringReplace Contents, Contents, `r, , All
	loop parse, Contents, `n
	{
		if a_loopfield =
		Continue

		;; ɾ��ע��, �� ; ��ͷ����Ϊ��ע��
		var_line := RegExReplace( a_loopfield, "(\s|^)`;.*", "" )
		if var_line =
			Continue

		tempContents = %tempContents%%var_line%`n
	}
	;; ɾ������ע��  /* ... */
	Contents := RegExReplace( tempContents, "m)/\*(\s|.)*?\*/", "" )
	Contents := RegExReplace( Contents, "``[```"]", "_" )  ;; ɾ��ת����`��"
	Contents := RegExReplace( Contents, "`".*?`"", "" ) 	 ;; ɾ���ַ���


	;; ɾ���ı���Ķ��� var=(
	;; ...
	;; )
	Contents := RegExReplace( Contents, "m)\s*\S+[^\S=]*=\s*\r*\n*\(.*?\n\s*\)", "" )


	tempContents =

	;; ��������
	var_state = 0 ;; ��ǰ�ڷ���ʲô���� 0δ֪��1�ȼ��� 2Label��ǩ��3����
	StartPos := 1
	Pos0 := -1		;; ����/**/����ע�͵Ŀ�ʼλ��
	Pos1 := -1		;; 1�ȼ� �����õ���λ��
	Pos2 := -1		;; 2Label��ǩ �����õ���λ��
	Pos3 := -1		;; 3���� �����õ���λ��

	Match1 =
	Match2 =
	Match3 =

	Loop
	{
		"m)(^|\n)\s*[^\s:=]*(?=:)"

	}

	;; ���з���
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
			;; ƥ�亯����
		}

	}



	;; Free the memory.
	Contents =
	FileMem =

}


�Ʒ���һ���ļ�2( filename_ )
{
	FileRead, filemem, %filename_%

	if ErrorLevel
		Return

	if filemem =
		Return

	;; ����˵��
	state = 0 		;; ��ǰ�ڷ���ʲô���� 0δ֪��1�ȼ��� 2Label��ǩ��3����
	StartPos := 1
	EndPos := -1
	Pos0 := -1		;; ����/**/����ע�͵Ŀ�ʼλ��
	Pos1 := -1		;; 1�ȼ� �����õ���λ��
	Pos2 := -1		;; 2Label��ǩ �����õ���λ��
	Pos3 := -1		;; 3���� �����õ���λ��

	prePos0 := -1   ;; ��һ������/**/����ע�͵Ŀ�ʼλ��
	preMatch0 = 	;; ��һ������/**/�õ���ƥ��ֵ

	Match0 =
	Match1 =
	Match2 =
	Match3 =

	;; ��һ������
	Gosub ����������ע�͡�
	Gosub �������ȼ���
	Gosub ��������ǩ��
	Gosub ��������������

	;; ��ʼ�����ļ�����
	Loop
	{
		;; ����ļ����Ѿ��޷��ٲ�ѯ���ȼ�����ǩ���������˳�
		if ( Pos1 == 0 && Pos2 == 0 && Pos3 == 0 )
		{
			Break
		}

		;; ��Pos1��Pos2��Pos3��������, ��ȡ >0 ����Сֵ��ֵ�� EndPos
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

		;; û���ҵ���������������ݣ����˳�ѭ��
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
			msgbox EndPos <> Pos1~3 `n �ļ���������
			Break
		}

		;; Ѱ�� EndPos �����Ķ���ע������
		if ( Pos0  < EndPos )
			Gosub ����������ע�͡�

		;; ������ǰ��ǩ���ұ��浽�����ֵ���

		;; ׼����һ��ѭ��
		StartPos := EndPos
		if state = 1
			Gosub �������ȼ���
		else if state = 2
			Gosub ��������ǩ��
		else if state = 3
			Gosub ��������������
		else
			Break
	}

	filemem = ;; �ͷ��ڴ�
}


#include ./inc/common.aik
#Include ./inc/array.aik
