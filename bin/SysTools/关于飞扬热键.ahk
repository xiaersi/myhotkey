#NoTrayIcon 
#SingleInstance ignore
#include ../../

;; 参数 Tab页面
g_page = %1%
g_Version = V1.05 Alpha

change_icon()

g_title = 关于飞扬热键
gosub 【初始化变量】

;FileInstall, locked.bmp,%A_ScriptDir%\teshorse.jpg
Gui,+LastFound
g_hGui := WinExist()

Gui, Add, Text, x300 y10 w180 +right  cOlive , 飞扬热键 %g_Version%

HLink_Add(g_hGui, 90,  390,  100, 20, "", "'@飞扬热键':www.weibo.com/goomood" ) ;without handler
HLink_Add(g_hGui, 220,  390,  100, 20, "", "'CSDN博客':http://blog.csdn.net/teshorse/article/details/6941341" ) ;without handler
HLink_Add(g_hGui, 350,  390,  100, 20, "", "'捐助':http://blog.csdn.net/teshorse/article/details/6941348" ) ;without handler

/*
Gui, Add, Text, x100 y390   cBlue  g【联系作者】, 新浪微博
Gui, Add, Text, x230 y390  cBlue g【打开博客】, CSDN博客
Gui, Add, Text, x370 y390  cBlue g【捐助页面】, 捐助
*/

;Gui, Add, Picture, x10 y375 Section,%A_ScriptDir%\teshorse.jpg


;Gui, Add, Text, x106 y10 w480 h360 ,zz
Gui, Add, Tab, x6 y10 w480 h360 v_Tab, 简介|由来|作者|捐助|帮助|更新

gui, font, s10, Tahoma  
;Gui, Color, ControlColor, %Black1%
;Gui, Color, White 

Gui, Tab, 简介
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_about )
Gui, Add, Edit, x16 y40 w460 h320 cBlack, %var_about%
Gui, Tab, 由来
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_Histroy )
Gui, Add, Edit, x16 y40 w460 h320 cGreen , %var_Histroy%
Gui, Tab, 作者
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_Author )
Gui, Add, Edit, x16 y40 w460 h320 cNavy, %var_Author%
Gui, Tab, 捐助
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_Donet )
Gui, Add, Edit, x16 y40 w460 h320 cMaroon, %var_Donet%
Gui, Tab, 帮助
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_Help )
Gui, Add, Edit, x16 y40 w460 h320 cTeal  , %var_Help%
Gui, Tab, 更新
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_update )
Gui, Add, Edit, x16 y40 w460 h320 cBack  , %var_update%

if g_page <>
{
	GuiControl, ChooseString, _Tab, %g_page%
}

; Generated using SmartGUI Creator 4.0
Gui, Show,  h424 w495, %g_title%
Return

GuiClose:
ExitApp

【联系作者】:
	run http://www.weibo.com/goomood
	return 

【捐助页面】:
	run http://blog.csdn.net/teshorse/article/details/6941348
	return


【打开博客】:
	run http://blog.csdn.net/teshorse/article/details/6941341
	return



#include .\inc\common.aik	
#include .\ahklib\HLink\HLink.aik
#include .\ahklib\RichEdit\RichEdit.aik



【初始化变量】:
var_about =
(

    飞扬热键，是一种优化用户操作习惯、提高工作效率的工具集合。它通过将画屏命令、快捷热键、快捷菜单以及命令窗口融为一体，达到快速启动程序、打开文档、自定义短语、模拟用户输入输出的目的。这些命令、热键与快捷菜单都可以自由定义和组合，每个用户可以根据自己需要和习惯，定义一套适合自己的操作组合。当习惯了自己的操作组合之后，您将会减少很多重复性的操作，工作效率将会大大提高。

    飞扬热键，可用来作为管理绿色软件及常用程序的平台，也可用来管理常用的文档。此外，飞扬热键还自带了很多实用的小功能，如：辅助记忆的飞扬小字典、鼠标中键调整窗口大小与位置、仅用鼠标快速剪贴、复制、粘贴与搜索、为代码生成DoxyGen风格的注释、C++代码的辅助编辑、使用VIM、UE等外部工具快速编辑任意选中的文本、可自由定义的屏幕键盘、Alt+Tab切换窗口增强功能、多桌面管理工具、日志查看分析工具、简单的定时提醒工具等等，各种小功能还在不断增加，请您自己去挖掘发现!

    飞扬热键说：我是一枚向日葵，不帮你打僵尸，只为您贡献太阳光！

    提示：飞扬热键 V1.0 是在Windwox XP 操作系统下编译的，在Vista/Win7下尚未完整地测试！


)


var_Histroy =
(

    大约在2008年的时候，通过善用佳软件的博客发现了AutoHotkey脚本程序，从此它成了我最喜欢的玩具，对它爱不释手。在工作生活中，利用业余时间不停地写一些脚本程序，用于辅助工作提高效率。通过几年的积累，不经意间发现已经写了一批小脚本程序，而且有了一个合理的代码框架，可以快速吸纳其他优秀的脚本程序，也允许多个用户互不干扰地使用我的脚本程序。

    我逐渐地离不开这些小程序了，这些小程序成为我工作中必不可少的工具。我现在已经很少通过开始菜单和资源管理器启动程序了，用鼠标右键一划或者通过自己定义的命令瞬间启动。在写C++代码时，也经常鼠标右键一划，在弹出的快捷菜单中选择使用VIM编辑，或为一个函数添加DoxyGen风格的注释，或快速调整代码的风格。在做与工作无关的事时，一键隐藏很多窗口。在调试程序需要频繁修改系统时间时，使用我的系统时间修改工具，它除了可以快速切换到历史时间外，还会提醒我恢复到正常的时间。还有一个秘密值得一提，我为所有需要输入账号与密码的窗口，都设置了相同的快捷命令，从此我不再需要记忆各种烦人的账号和密码了。当然为各个窗口设置账号与密码的方法非常简单，一个快捷键搞定！

    一些同事看到我的电脑操作非常Cool，方便快捷，于是向我索要程序。看来，我的这些小工具还是有推广的价值。记得有篇文章说，软件的意义在于方便和改善人们的生活，虽然我视这些小程序为玩具，但它多多少少也能方便用户的操作，提高工作效率，于是决定将其整理后拿出来与大家分享。最近，给它取了个名字，叫做“飞扬热键”。这个名字其实很不贴切，只描述了这个工具功能的冰山一角，以后想到更好的名字再改吧！

    需要说明的是，我是用业务时间来做这些事情的，可能帮助文档写得会比较慢而且比较粗糙。做这些事情除了时间有限以外，与心情也有关系。希望飞扬热键能够博得大家的喜欢，从而有更多的用户，有更多的人加入开发。如果飞扬热键对你真的有用，请一定要推荐给你身边的好朋友，也一定要给我反馈哦！

    最后，祝您使用飞扬热键愉快！



)

var_Author =
(



	我叫成城(teshorse)，

	现就职于某证券信息公司，从事软件开发工作。
	
	下面是我的联系方式：






	新浪微博: http://www.weibo.com/goomood
	CSDN博客: http://blog.csdn.net/teshorse
	电子邮箱: teshorse@hotmail.com
	QQ群: 10504143

)

var_Donet =
(
	
    如果您觉得飞扬热键值得进一步期待，或者有好的建议，那么请关注我的微博或者给我来信反馈。您的关注是最宝贵的财富，是继续向前的动力！

    如果您觉得飞扬热键很不错，而且在经济上又不紧张，那么请捐助我们吧！您的捐助，不仅仅是钱的问题，是您对飞扬热键实实在在的肯定，是我们的荣耀！

    如果您是投资者、企业管理者、资本管理者，可以从我这里订阅一份《新财富》杂志，这不仅是对飞扬热键的捐助，更是帮了我一个大忙，因为我们公司每人有推销若干本《新财富》杂志的任务指标。《新财富》定位是“面向掌握资本的人”，它关注的是资本市场，相信对于企业管理者和投资者来说，是不可或缺的良师益友！

    捐助页面： http://blog.csdn.net/teshorse/article/details/6941348
)


var_Help =
(



	优酷专辑“飞扬热键”视频介绍：
	http://www.youku.com/playlist_show/id_17259728.html






	请关注我的博客和微博了解帮助文档进展！

	CSDN博客：http://blog.csdn.net/teshorse

	新浪微博：@飞扬热键
)

var_update =
(
	更新日志：
-----------------------------------------------------------------------------
V1.05 Alpha  (2012-04)
  - 飞扬小字典升级到V2.13：
    : 增加拖拽粘贴的功能
    : 详细查看状态使用富文本框，支持彩色显示。

  - 画屏命令升级到V1.02：支持关闭画屏手势提示。

V1.04 Alpha  ( 2012-03 )  
  - 增加飞扬个性输入 V1.0	
  - 飞扬画屏命令 升级V1.01 
    : 舍弃屏幕画板，直接在屏幕上绘制手势，更流畅！
  - 飞扬魔术键盘 升级V1.10
    : 使用RShift键，切换并保持键盘大小写状态。

V1.03 Alpha  ( 2012-02 )  增加飞扬魔术键盘 V1.0

V1.02 Alpha  ( 2011 )      升级飞扬小字典到 V2.11

V1.00 Alpha  ( 2011 )      发布飞扬热键
  包含:
  - 飞扬命令窗口 V3.0
  - 飞扬小字典 V2.0
  - 飞扬画屏命令 V1.0

)
return
