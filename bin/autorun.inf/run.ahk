#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������
;;�����������������Ӣ���ַ�
sendbyclip(var_string)
{
	ClipboardOld = %ClipboardAll%
	Clipboard =%var_string%
	sleep 100
	send ^v
	sleep 100
	Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.
}

;����ini�ļ���ָ���ĳ���
runini(mkey)
{
	iniread,var_path,run.ini,path,%mkey%
	iniread,var_temp,run.ini,file,%mkey%
	if (var_path="" or var_path="ERROR")
	{
		var_path=
	}
	else
	{
		StringRight varbuf,var_path,1
		if not (varbuf="\")
			var_path = %var_path%\
	}
	if(var_temp="" or var_temp="ERROR")
	{
		iniread,var_temp,run.ini,send,%mkey%
		if(var_temp="" or var_temp="ERROR")  return
		sendbyclip(var_temp)
	}

	var_firstchar := substr(var_temp,1,1)
	if (var_firstchar="`;" or var_firstchar="+" or var_firstchar="-" )
		var_temp:=substr(var_temp,2)

	StringGetPos, varpos, var_temp, :
	if errorlevel
	{
	    var_temp =%var_path%%var_temp%
;		msgbox var_path=%var_path%  var_temp = %var_temp%
	}
	sleep 100
;	substrvar = substr(var_temp,1,1)
	if (var_firstchar="`;")
		run,%var_temp%,%var_path%
	else if (var_firstchar="+")
		run,%var_temp%,%var_path%,max
	else if (var_firstchar="-")
		run,%var_temp%,%var_path%,min
	else
		send %var_temp%
;	Sendevent {esc}
	return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	vartitle = ����
	varPrompt = ��������Ҫ�����ĳ�����
	var_user := ""
	iniread lastvar,run.ini,last,last
	SetTimer, �������д���,80
	inputbox,var_user,%vartitle%,%varPrompt%,,260,120,,,,20,%lastvar%
	if ErrorLevel 	
		return 
	iniread,var_temp,run.ini,file,%var_user%
	if(var_temp="" or var_temp="ERROR")
	{
		;msgbox errora
;		run %var_user%
		tooltip �ղ�������������
		sleep 1000
		tooltip
		return
	}
	else
	{
		iniwrite, %var_user%,run.ini,last,last
		runini(var_user)
	}
	exitapp

�������д���:
	ifwinexist %var_title%,%varPrompt%
	{
		winset,AlwaysOnTop, ON
		ifwinactive %var_title%,%varPrompt%
			WinSet, Transparent,off
		else
			WinSet, Transparent,100
	}
	else
	SetTimer, �������д���, Off
	return


