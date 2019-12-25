
var_blat = D:\Program Files\MyHotkey\bin\blat\blat.exe 
;runwait,%comspec% /c blat -install smtp.foxmail.com cwin@foxmail.com 2 25, ,Hide
runwait,%comspec% /c %var_blat% -body "xxxxxxxxxxxxxxx"  -subject "Greetings" -to cwin@live.cn -u cwin@foxmail.com -pw janruhai" -serverSMTP smtp.foxmail.com -port 25, ,Hide


; Runwait,%comspec% /c Blat - -body "hallo garry" -subject "Greetings" -to %SENDTO% -attachi %inlfil% -atf %txtfil% -af %binfil% -log %FileLog% -timestamp,,hide
