;虫眼鏡	by流行らせるページ管理人

/*
edit by wz520 [wingzero520@hotmail.com]
原脚本地址(日文): http://lukewarm.s101.xrea.com/myscripts/index.html
最终更新：2009.6.7

主要更改:
1. 改成了矩形放大镜，原脚本只能是正方形的（宽高相等）。
2. 可以用快捷键实时地改变放大镜的宽度和高度。
3. 可以设置拉伸模式(调用 SetStretchBltMode 函数)。
4. 可以设置最小倍率和倍率的增量（每按一次快捷键放大或缩小多少倍率）。
5. 退出时调用ReleaseDC函数释放DC。
6. 添加了一些注释。
7. 可以给放大镜加上边框。
*/

#SingleInstance, ignore

; --- 设置

FrameSize := 5 ;边框粗细，如果不要可以设成0
FrameColor = C0C0C0 ;边框颜色

w:=300 ;初始放大镜的宽度
h:=200 ;初始放大镜的高度
Min_w := 10 ;最小宽度
Min_h := 10 ;最小高度
SizeStep:=10 ;宽高增量

Magnification := 2 ;初始放大倍率
Min := Magnification ;最小倍率
Step := 1 ;倍率增量
/* 拉伸模式
1=BLACKONWHITE, 2=WHITEONBLACK
3=COLORONCOLOR, 4=HALFTONE

HALFTONE可以比较好的解决放大后失真问题但占CPU多。
一般用3. 如果删除下面 SetStretchBltMode 的调用, 系统通常会使用1。
*/
StretchBltMode := 3

; --- 设置结束

Process,Exist
pid:=ErrorLevel
DetectHiddenWindows,On
WinGet,ahkhwnd,id,ahk_pid %pid% ahk_class AutoHotkey
DetectHiddenWindows,Off

Gui,+LastFound +0x02000000 -0x0CC00000 -Border +ToolWindow +AlwaysOnTop
WinGet,myhwnd,id
WinSet,Trans,255
Gui,+E0x00080020
Gui, Color, %FrameColor%

myhdc:=DllCall("GetDC",UInt,myhwnd,UInt)
dthwnd:=DllCall("GetDesktopWindow",UInt)
dthdc:=DllCall("GetWindowDC",UInt,dthwnd,UInt)

DllCall("SetStretchBltMode", uint, myhdc,int, StretchBltMode, int)

pStretchBlt := DllCall("GetProcAddress", uint
		,DllCall("GetModuleHandle", str, "Gdi32")
		, str, "StretchBlt") ;由于要频繁调用 StretchBlt 函数，所以先取得它的地址以提高效率（其实基本不明显……）。

CoordMode,Mouse,Screen

SetTimer,Timer,100
Timer:
	Draw()
return

Draw(){
	global w,h,Magnification, FrameSize,myhwnd,myhdc,dthdc,pStretchBlt
	MouseGetPos,x,y
	;被放大区域的左上角坐标
	left:=x-w/2
	top:=y-h/2
	;放大镜的宽高
	sw:=w*Magnification+FrameSize*2
	sh:=h*Magnification+FrameSize*2
	;GUI的左上角坐标
	l2:=x-sw/2-FrameSize
	t2:=y-sh/2-FrameSize

	Gui,Show,w%sw% h%sh% x%l2% y%t2% NoActivate
	DllCall(pStretchBlt
		,UInt,myhdc
		,Int,FrameSize,Int,FrameSize
		,Int,sw-FrameSize*2,Int,sh-FrameSize*2
		,UInt,dthdc
		,Int,left,Int,top
		,Int,w,Int,h
		,UInt,0x00CC0020)
	WinSet,Top,,ahk_id %myhwnd% ;保持置顶
}

;退出
Esc::
	SetTimer, Timer, Off
	DllCall("ReleaseDC",UInt,myhwnd,UInt,myhdc,int)
	DllCall("ReleaseDC",UInt,dthwnd,UInt,dthdc,int)
	ExitApp

;更改倍率
#1::Magnification > Min ? Magnification-=Step : Magnification := Min
#2::Magnification += Step

;更改放大镜的宽高
#Down::h > Min_h ? h -= SizeStep : h := Min_h
#Up::h += SizeStep
#Left::w > Min_w ? w -= SizeStep : w := Min_w
#Right::w += SizeStep
