;�����R	by���Ф餻��ک`��������

/*
edit by wz520 [wingzero520@hotmail.com]
ԭ�ű���ַ(����): http://lukewarm.s101.xrea.com/myscripts/index.html
���ո��£�2009.6.7

��Ҫ����:
1. �ĳ��˾��ηŴ󾵣�ԭ�ű�ֻ���������εģ������ȣ���
2. �����ÿ�ݼ�ʵʱ�ظı�Ŵ󾵵Ŀ�Ⱥ͸߶ȡ�
3. ������������ģʽ(���� SetStretchBltMode ����)��
4. ����������С���ʺͱ��ʵ�������ÿ��һ�ο�ݼ��Ŵ����С���ٱ��ʣ���
5. �˳�ʱ����ReleaseDC�����ͷ�DC��
6. �����һЩע�͡�
7. ���Ը��Ŵ󾵼��ϱ߿�
*/

#SingleInstance, ignore

; --- ����

FrameSize := 5 ;�߿��ϸ�������Ҫ�������0
FrameColor = C0C0C0 ;�߿���ɫ

w:=300 ;��ʼ�Ŵ󾵵Ŀ��
h:=200 ;��ʼ�Ŵ󾵵ĸ߶�
Min_w := 10 ;��С���
Min_h := 10 ;��С�߶�
SizeStep:=10 ;�������

Magnification := 2 ;��ʼ�Ŵ���
Min := Magnification ;��С����
Step := 1 ;��������
/* ����ģʽ
1=BLACKONWHITE, 2=WHITEONBLACK
3=COLORONCOLOR, 4=HALFTONE

HALFTONE���ԱȽϺõĽ���Ŵ��ʧ�����⵫ռCPU�ࡣ
һ����3. ���ɾ������ SetStretchBltMode �ĵ���, ϵͳͨ����ʹ��1��
*/
StretchBltMode := 3

; --- ���ý���

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
		, str, "StretchBlt") ;����ҪƵ������ StretchBlt ������������ȡ�����ĵ�ַ�����Ч�ʣ���ʵ���������ԡ�������

CoordMode,Mouse,Screen

SetTimer,Timer,100
Timer:
	Draw()
return

Draw(){
	global w,h,Magnification, FrameSize,myhwnd,myhdc,dthdc,pStretchBlt
	MouseGetPos,x,y
	;���Ŵ���������Ͻ�����
	left:=x-w/2
	top:=y-h/2
	;�Ŵ󾵵Ŀ��
	sw:=w*Magnification+FrameSize*2
	sh:=h*Magnification+FrameSize*2
	;GUI�����Ͻ�����
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
	WinSet,Top,,ahk_id %myhwnd% ;�����ö�
}

;�˳�
Esc::
	SetTimer, Timer, Off
	DllCall("ReleaseDC",UInt,myhwnd,UInt,myhdc,int)
	DllCall("ReleaseDC",UInt,dthwnd,UInt,dthdc,int)
	ExitApp

;���ı���
#1::Magnification > Min ? Magnification-=Step : Magnification := Min
#2::Magnification += Step

;���ķŴ󾵵Ŀ��
#Down::h > Min_h ? h -= SizeStep : h := Min_h
#Up::h += SizeStep
#Left::w > Min_w ? w -= SizeStep : w := Min_w
#Right::w += SizeStep
