
#SingleInstance ignore	;只运行一次，禁止多次运行

#include ..\..\
#include .\lib\AutoHotString.aik


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

