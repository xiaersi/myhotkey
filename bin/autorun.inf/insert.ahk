;; ���ô����Ƿ������ö�����������͸����
;; var_title,var_text Ϊ���ڱ���
;; bool_top �����Ƿ��ö�
SetWin_Top_Transparent(var_title,var_text,bool_top=true,var_Transparent=0,var_Transparent2=0)
{
	ifwinexist %var_title%,%varPrompt%
	{
		WinGet, varGetTransparent,Transparent,%var_title%,%varPrompt%

		if bool_top
			winset,AlwaysOnTop, ON
		if(var_Transparent=0) ;Ϊ0ʱ���ڻʱ��͸�����ǻʱ��͸��
		{
		ifwinactive %var_title%,%varPrompt%
		  {
			WinSet, Transparent,off
		  }
		else
		  {
			WinSet, Transparent,100
		  }
		}
		else   ;var_Transparent!=0�������ô���͸����Ϊ��ֵ
		{
			ifwinactive  %var_title%,%varPrompt%	;���ڻʱ����͸����Ϊvar_Transparent
			  {
			    if not(varGetTransparent=var_Transparent)
				WinSet, Transparent,%var_Transparent%
			  }
			else 	; var_Transparent2 ��var_Transparent����Ϊ0ʱ
			{
			  if (var_Transparent2=0)  ; 
				{
				   if not(varGetTransparent=var_Transparent)
					WinSet, Transparent,%var_Transparent%
				}
				else		;�ǻʱ͸����Ϊvar_Transparent2
				{
				   if not(varGetTransparent=var_Transparent2)
					WinSet, Transparent,%var_Transparent2%
				}
			}
		}
	}
}

launchy_ini_input(inifile,varsection="file",varaddstr="")
{
	var_sec := varsection
	SetTimer, �������_��λ���, 10
	SetTimer, �������_�Զ�����͸����, 80
	vartitle = �������%inifile%��
	varPrompt = ���������룺file@num8=+notepad
�����������:
	InputBox, varHotstring,%vartitle% ,%varPrompt%,,,120,,,,,%varsection%@=%varaddstr%
	if ErrorLevel  ; The user pressed Cancel.u
	    return 0
	StartingPos := instr(varHotstring,"@")
	MidPos := instr(varHotstring,"=")
;	msgbox StartingPos=%StartingPos%   midpos=%midpos%
	var_sec:=substr(varHotstring,1,StartingPos-1)
	var_key:=substr(varHotstring,StartingPos+1,midpos-StartingPos-1)
	var_temp:=substr(varHotstring,midpos+1)
	if(var_key="")
	{
;		tipword(" ����Ϊ�գ�������")
		goto �����������
;		return
	}


	iniread,var_read,%inifile%,%var_sec%,%var_key%
	if not (var_read="" or var_read="ERROR")
	{
		MsgBox, 4,, %inifile%�ļ���%var_sec%���У�`n%var_key%�Ѿ����ڣ�Ҫ�滻�� ��`n%var_key%��%var_read%`n���滻Ϊ`n%var_key%��%var_temp%
		IfMsgBox No
		{
			return
		}
	}
	STRINGLEFT drivedir,A_ScriptDir,2
	IFNOTINSTRING var_temp, %drivedir%
	{
	    MSGBOX ,4,,%var_temp%`n���ڵ�ǰ�ű����ڵķ���%drivedir%`n�Ƿ�������棿
		IfMsgBox No
		{
			return
		}
	}
	if not (var_sec="file")
	{
	iniwrite,%var_temp%,%inifile%,%var_sec%,%var_key%
	}
	var_firstchar := substr(var_temp,1,1)
	if not(var_firstchar="`;" or var_firstchar="+" or var_firstchar="-" )
	{
;		var_temp:=substr(var_temp,2)
		iniwrite,%var_temp%,%inifile%,send,%var_key%
		return
	}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	StringGetPos, varPos, var_temp, (*)
	if not errorlevel
	{ 
	var_path:=substr(var_temp,2,varpos-1)
	StringReplace, var_temp, var_temp, (*), \, All
	}

	StringGetPos, varPos, var_temp, (|)
	if not errorlevel
	{ 
	var_path:=substr(var_temp,2,varpos-1)
	var_temp:=substr(var_temp,1,1) + substr(var_temp,varpos+1)
	msgbox path=%var_path%`nfile=%var_temp%
	}
	if(var_path="")
	{
		ifinstring var_temp,:
		{
		StringGetPos, varPos, var_temp, \, R1
		var_path := substr(var_temp,2,varPos-1)
;		msgbox var_temp=%var_temp%`nvar_path=%var_path%`nvarPos=%varPos%
		}
	}
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	iniwrite,%var_path%,%inifile%,path,%var_key%
	iniwrite,%var_temp%,%inifile%,file,%var_key%

	�������_��λ���:
	IfWinNotActive,  �������%inifile%��
	    return 0
	; Otherwise, move the InputBox's insertion point to where the user will type the abbreviation.
	var_pianyi:=strlen(varsection)+1
	Send {home}{right %var_pianyi%}
	SetTimer, �������_��λ���, Off
	�������_�Զ�����͸����:
	ifwinexist %var_title%,%varPrompt%
		SetWin_Top_Transparent( vartitle,varPrompt)
	else
		SetTimer, �������_�Զ�����͸����, Off
	return 1

}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
��ӳ����ļ���Launchy()
{
	AutoTrim Off  ; Retain any leading and trailing whitespace on the clipboard.
	ClipboardOld = %ClipboardAll%
	Clipboard =  ; Must start off blank for detection to work.

	Send ^c

	ClipWait 120
	if ErrorLevel  ; ClipWait timed out.
	    return 0
;	var_temp = `;
	var_temp = `;%Clipboard%
	if not( var_temp = "")
	launchy_ini_input("run.ini","file",var_temp)

}

#ifwinactive �������run.ini�� ahk_class #32770,���������룺file@num8=+notepad
enter::
	ControlClick,Button1,�������run.ini�� ahk_class #32770,���������룺file@num8=+notepad
	ifwinexist ahk_class #32770,����ͼ��(&C)...
	ControlClick,Button5,ahk_class #32770,����ͼ��(&C)...
	return
home::
pgdn::
^\::
f1::
	send {end}\
	return

^+v::
f2::
	send {end}\
	send ^v
	return
f3::
tab::
	send {end}
	StringGetPos, varPos, clipboard,:
;	msgbox %var_temp%
	if errorlevel 
		send (*)
	else 	
		send (|)
	send ^v
	return
#ifwinactive

;; ���ÿ�����������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

sc07B & ins::
^+ins::
ins & r::
	��ӳ����ļ���Launchy()
	return


::;exitins::
::;exitinsert::
	exitapp
	return