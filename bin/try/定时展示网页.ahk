bStop := true
CurUrl =
CurIndex = 0
CurPid =
PrePid =
IEEXE = C:\Program Files\Internet Explorer\IEXPLORE.EXE


UrlArray0 := ReadTempIni("定时展示网页", "COUNT", "0" )
UrlTime	  := ReadTempIni("定时展示网页", "Time", "5000" )
if UrlTime < 500
	UrlTime = 500

if UrlArray0 <= 0 
{
	msgbox 请先设置URL！
	exitapp
}

loop %UrlArray0%
{
	UrlArray%a_index% := ReadTempIni( "定时展示网页", "url" . a_index, "" )
}


!F5::
	bStop := bStop ? false : true
	if bStop 
	{
		settimer, 【定时器轮换展示网页】, off
	}
	else
	{
		CurIndex := 0
		settimer, 【定时器轮换展示网页】, %UrlTime%
	}
	return
	
	
【定时器轮换展示网页】:
	CurIndex++
	if ( CurIndex > UrlArray0 )
		CurIndex := 1
		
	PreIndex := CurIndex - 1
	if PreIndex < 1
		PreIndex := UrlArray0		
		
	;; 显示之前准备好的网页
	if WinID%CurIndex%
	{
		WinID0 := WinID%CurIndex%
		WinActivate ahk_id %WinID0%
		WinShow ahk_id %WinID0%
	}
	else if Pid%CurIndex%
	{
		pid0 := Pid%CurIndex%
		WinGet, WinID%CurIndex%, ID, ahk_pid %pid0%
		WinID0 := WinID%CurIndex%
		WinShow ahk_id %WinID0%
	}
	else
	{
		CurUrl := UrlArray%CurIndex%
		Run, %IEEXE% %CurUrl% , , , Pid%CurIndex%
/*		sleep 1000
		
		pid0 := Pid%CurIndex%
		WinGet, WinID%CurIndex%, ID, ahk_pid %pid0%
		WinID0 := WinID%CurIndex%
		WinShow ahk_id %WinID0%		
		*/
	}
	
	if WinID%PreIndex%
	{
		WinID0 := WinID%PreIndex%
		WinHide ahk_id %WinID0%
	}
	return
	
	
!Esc::
	gosub CloseAllWindow
	exitapp
	
	
	
CloseAllWindow:
	loop %UrlArray0%
	{
		WinID0 := WinID%PreIndex%
		WinClose ahk_id %WinID0%		
	}
	return
	
	
ReadTempIni( var_sec, var_key, var_default = "" )
{
	IniRead var_temp, temp.ini, %var_sec%, %var_key%, %var_default%
	if ( var_temp == "ERROR" )
		var_temp := var_default
	Return var_temp
}