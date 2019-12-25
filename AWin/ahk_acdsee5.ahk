/*
#include .\inc\functions.aik
title_acdsee := "ACDSee v3.1"



return
*/


;msgbox 您已经启用了ACDsee3.1的热键文件`,按键映射如下:`nw、s、a、d分别对应上下左右键`nf、r对应Pagedown、PageUP`nj、c对应数字数字键/，使用图片适应窗口 `nk、v对应数字键*，以原始图像大小查看`nh、e对应数字键+，放大图片 `nl、q对应数字键-，缩小图片`ng全屏 `tm 移动图片 `tx删除图片`n你可以按F4+4或Alt+esc关闭本热键功能。

#ifwinactive - ACDSee v5.0
f4 & 4::
!esc::exitapp


w::up

s::down
a::left
d::right
f::PgDn
r::PgUp
j::
c::NumpadDiv
k::
v::NumpadMult
h::
e::NumpadAdd
l::
q::NumpadSub
g::^f
m::!m
n::!n
x::delete
#ifwinactive
