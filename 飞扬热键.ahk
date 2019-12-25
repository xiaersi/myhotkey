#SingleInstance ignore	;只运行一次，禁止多次运行

g_username := read_ini("root.cfg", "users", "lastuser", "" )
change_icon()

ifnotexist Users
	FileCreateDir, Users

FileInstall, Users\AutoHotKey.ini, %A_ScriptDir%\Users\AutoHotKey.ini
FileInstall, Users\ShortcutMenu.ini, %A_ScriptDir%\Users\ShortcutMenu.ini

∑设置工作目录( g_username )

FileInstall, 飞扬热键.ico,%A_ScriptDir%\飞扬热键.ico
FileInstall, Suspend.ico, %A_ScriptDir%\Suspend.ico



#include .\lib\AutoHotString.aik

;; 处理任务栏图标的右键菜单TrayMenu
gosub 【清空原有的TrayMenu】
gosub 【添加默认的TrayMenu菜单项】

;; 开启飞扬个性输入(要放置到最后处理，否则后面的代码会停止执行)
if g_GlobalSwitch_xHotString
{
	g_GlobalSwitch_xHotString := false
	∑打开飞扬个性输入( )	
}		
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
#include .\inc\XML\xhotstring.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\SubUI\21屏幕画板窗口.aik
#include .\SubUI\22InputListBox.aik
#include .\SubUI\23编辑飞扬命令串.aik
#include .\SubUI\24添加画屏命令禁用列表.aik
#include .\SubUI\25修改当前画屏手势.aik
#include .\SubUI\26为飞扬个性输入添加短语.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\lib\insert.aik
#include .\lib\appkey.aik
#include .\lib\AutoLable.aik
#include .\lib\XHotString.aik

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#include .\AWin\IE\IE.ahk
#include .\AWin\Explore\Explore.aik
#include .\AWin\vim.aik
#include .\Awin\MyHotkey\PhiyonKeyboard.ahk


∑设置工作目录( _userName = "" )
{
	;; 先判断脚本下面有没有root.cfg，没有则创建之, 该文件是根目录的标志
	ifnotexist %a_scriptdir%\root.cfg
	{
		;; 如果没有root.cfg，说明是第一次运动本程序
		var_prompt = 第一次运行飞扬热键，请仔细阅读下面注意事项，确定是否要继续执行飞扬热键！
		var_text =
(
当您第一次运行飞扬热键时，会看到本提示框，请认真阅读下面的注意事项:

【飞扬热键说明】
------------------------------------------------------------------------
当前版本 V1.04Alpha内测版，在Windows XP在开发，
在Windows Vista和Window 7 下也能运行，但尚未经过充分测试。


【注意事项】
------------------------------------------------------------------------
1、关于开源
	飞扬热键使用AutoHotkey编写，是开源项目，如果需要源代码请与作者联系，
	欢迎有兴趣的朋友加入一同开发。

	为了让不了解AutoHotkey或者不愿意安装AutoHotkey的朋友也能使用飞扬热键，
	我们将飞扬热键编译成EXE可执行文件，但可能会带来以下问题:

2、关于某些杀毒软件报木马的问题
	AutoHotkey是通过将代码以资源方式内置到编译器方式进行编译的，这种编译方式
	可能会被一些较懒的杀毒软件（比如金山安全卫士）直接认为是木马，（360安全卫士
	曾经也这么懒）。飞扬热键以及AutoHotkey都是开源项目，每一行代码都暴露在众目
	之下，绝对不会故意做有损用户利益的事情。

3、关于疑似木马行为
	飞扬热键的一些功能需要捕捉鼠标右键、窗口信息等，这些行为可能会被一些安全
	软件（如360安全卫士）警告有疑似木马行为，请允许通过。如果不允许捕捉一些必要
	的信息，很多功能无法使用，飞扬热键就残废了。


【异常处理】
------------------------------------------------------------------------
1、如果使用飞扬热键的过程中遇到异常，请按Win+F5重启飞扬热键。

2、在某些系统中（可能是受到其他程序的影响），画屏命令会使得右键失效，
此时请通过画屏手势 “↓→↑←” 禁用画屏命令，恢复右键菜单。


【下一步】
------------------------------------------------------------------------
如果您对飞扬热键还有疑虑，请按“取消”按钮退出飞扬热键。

如果您信任飞扬热键请按“确定”按钮，然后在弹出的创建用户的对话框中输入用户名。
飞扬热键将在Users文件夹下，创建此用户名命名的子文件夹作为工作目录，并且在
此工作目录中创建若干默认的配置文件。

最后，祝愿您使用飞扬热键愉快！
)		
		
		if not MsgTipBox( "飞扬热键警告", var_prompt, var_text )
		{
			ExitApp
		}
		fileappend 	#root.cfg  飞扬热键根目录的标志，仅在根目录可以有此文件,  %a_scriptdir%\root.cfg
	}

	;; 参数给定的用户名是否有效，有效用户则切换之
	if _userName <>
	{
		ifexist Users\%_userName%\
		{
			change_user( _userName )		
			return
		}
	}
	;; 参数给定的用户名无效时，查找所有的用户列表
	UserList =
	UserCount = 0
	LastUser =
	Loop, Users\*.*, 2
	{
		if A_LoopFileName <>
		{
			ifnotinstring A_LoopFileName, .
			{
				UserList = %UserList%%A_LoopFileName%|
				LastUser := A_LoopFileName
				UserCount++
			}
		}
	}
	;; 当前还没有用户，询问用户创建一个
	if UserCount = 0
	{
		loop
		{
			LastUser := ∑创建用户()
			if LastUser <>
			{
				change_user( LastUser )		
				reload   ;; 创建用户之后重启飞扬热键（不然画屏命令无效）
				break
			}
		}
	}
	else ;; 已经有用户，让用户选择一个用户名
	{
		loop 
		{
			LastUser := InputListBox( UserList )
			if LastUser <>
			{
				change_user( LastUser )	
				break
			}
			else
			{
				msgbox 请选择一个用户！
			}
		}
	}
}





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
