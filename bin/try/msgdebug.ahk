#include ..\..\
#include .\inc\common.aik

::msgdebug;::
	g_msgdebug := myinput( "����msgdebug��ʼ���", "������msgdebug��ʼ���", g_msgdebug )
::msgd;::
	if g_msgdebug is not integer
		g_msgdebug = 0
		
	sendinput {raw} msgbox [%g_msgdebug%]------------------------------------
	g_msgdebug++ 
	return