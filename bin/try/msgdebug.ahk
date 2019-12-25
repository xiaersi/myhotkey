#include ..\..\
#include .\inc\common.aik

::msgdebug;::
	g_msgdebug := myinput( "设置msgdebug起始序号", "请设置msgdebug起始序号", g_msgdebug )
::msgd;::
	if g_msgdebug is not integer
		g_msgdebug = 0
		
	sendinput {raw} msgbox [%g_msgdebug%]------------------------------------
	g_msgdebug++ 
	return