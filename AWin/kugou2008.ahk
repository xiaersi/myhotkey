

;msgbox 您已经启用了ACDsee3.1的热键文件`,按键映射如下:`nw、s、a、d分别对应上下左右键`nf、r对应Pagedown、PageUP`nj、c对应数字数字键/，使用图片适应窗口 `nk、v对应数字键*，以原始图像大小查看`nh、e对应数字键+，放大图片 `nl、q对应数字键-，缩小图片`ng全屏 `tm 移动图片 `tx删除图片`n你可以按F4+4或Alt+esc关闭本热键功能。
::kugoogeci::
::kugougeci::
::;geci::
	WinGetActiveTitle, OutputVar 
	sleep 100
	ifwinexist ahk_class TfrmMain
	{
	winactivate
	sleep 200
	send !R
;	sleep 200
	winactivate %OutputVar%
	}
	return
#ifwinactive ahk_class TfrmMain

f4 & 4::
!esc::exitapp

F4::
	tooltip 删掉了选中的歌曲
	send +{del}
;	winwait 警告 ahk_class #32770,是否确定从硬盘上删除选中的,3
;	if not errorlevel 
;	{
;	controlclick Button1, 警告 ahk_class #32770,是否确定从硬盘上删除选中的
;	}
	sleep 500
	tooltip
	return

#ifwinactive

