
#SingleInstance ignore	;只运行一次，禁止多次运行

#include ..\..\
#include .\lib\AutoHotString.aik


;; 创建本程序的快捷方式到系统Windows目录下，使得在WIN+R弹出的运行窗口中可以输入ahk启动本程序
ifnotexist %a_windir%\ahk.lnk
{
	msgbox 4, 创建快捷方式, 在Window目录下创建本程序的快捷方式吗?
	ifmsgbox, YES
	{
		FileCreateShortcut , %a_ScriptFullPath%, %a_windir%\ahk.lnk, %a_scriptdir%
	}
}


;; 处理任务栏图标的右键菜单TrayMenu
gosub 【清空原有的TrayMenu】
gosub 【添加默认的TrayMenu菜单项】
return


#include .\SubUI\TrayMenu.aik

;#include .\lib\timer.aik
#include .\lib\common.aik
#include .\inc\inifile.aik
#include .\inc\string.aik
#include .\inc\path.aik
#include .\inc\cmdstring.aik
#include .\inc\mousemoveinfo.aik
#include .\inc\MouseGesture.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\SubUI\21屏幕画板窗口.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\lib\insert.aik
#include .\lib\appkey.aik
#include .\lib\AutoLable.aik

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#include .\AWin\IE\IE.ahk
#include .\AWin\Explore\Explore.aik
#include .\AWin\vim.aik


#include .\SubUI\TrayMenu.aik
#include .\SubUI\22InputListBox.aik
#include .\SubUI\23编辑飞扬命令串.aik
#include .\SubUI\24添加画屏命令禁用列表.aik
#include .\SubUI\25修改当前画屏手势.aik


:?:;c::	; 切换到QQ五笔
	switchime("QQ五笔")
	return


:?:;e::	; 左 Alt+shift+0 切换至英文
	switchime("中文 (简体) - 美式键盘")
	return	


^+c::
	clipboard =
	send ^c
	sleep 100
	var_temp := clipboard
	clipboard := var_temp
	return

^+v::
	CreateMenuByIni( "菜单扩展粘贴", "A", "", false )
	menu 菜单扩展粘贴, show
	/*
	var_oldclip := ClipBoardAll
	StringUpper, clipboard, clipboard
	sleep 100
	send ^v
	clipboard := var_oldclip
	*/
	return



