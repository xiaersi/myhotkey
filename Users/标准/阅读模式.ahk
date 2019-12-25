;;进入特殊模式，用键盘来控制鼠标滚动，以及将方向键等功能键映射到左手位置，鼠标操作映射到右手位置

#SingleInstance ignore	;只运行一次，禁止多次运行
;#SingleInstance force ; 强制重新加载，不弹出提示窗口
var_tooltip = 《阅读模式》

SetTimer, Movetooltip, 80 
Movetooltip:
	tooltip %var_tooltip%
	return 

#include ../../
#include ./Bin/ReadMode/common.aik

