#include common.aik


var_str =
(
title:我的窗口
name:测试
text:未知

)


var_temp  := GetValueFromParams( var_str, "text" )
msgbox 111 %var_temp%