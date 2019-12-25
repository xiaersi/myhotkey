#SingleInstance force
var_tip =
(
1、启动窗口控制菜单的方法
  a.快捷键 Win+Appskey 或 Win+右键
  b.在当前窗口输入 `;WinMenu 后回车
2、鼠标右键拖动窗口边缘→向不同方向调整窗口大小
3、鼠标右键拖动窗口中央→控制水平滚动条
4、Alt + 右键拖动窗口边缘→缩放窗口
5、Alt + 右键拖动窗口中间→移动窗口
6、Win + Esc 退出
)

TrayTip , 【帮助】窗口快捷控制, %var_tip%, 3
settimer 【定时关闭提示】, 4000

::`;winmenu::
#Appskey::
	run .\右键菜单\调整窗口大小为预设值.exe
	return
	
#esc::
	ExitApp
	
	
【定时关闭提示】:
	TrayTip
	settimer 【定时关闭提示】, off
	return
	
	
#include ..\
#include .\inc\common.aik
#include .\lib\MButton.aik
	
	