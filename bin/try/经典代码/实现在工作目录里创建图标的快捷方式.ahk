
;实现在工作目录里创建图标的快捷方式
#c::
;先保护剪贴板的内容
ClipSaved := ClipboardAll ;将剪贴板的所有内容存储到你选的一个变量里。
;开始工作
clipboard = ;清空剪贴板
Send, ^c
ClipWait, 2
if ErrorLevel
{
    MsgBox, 尝试复制文本到剪贴板失败。
    return
}
;先用变量提取文件路径
Hs_Lnk = %clipboard%
Hs_LnkName = %Hs_Lnk%
;用正则表达式提取文件名
Hs_LnkName := RegExReplace(Hs_LnkName,".*\\","")
;利用命令在脚本的工作目录下创建快捷方式
FileCreateShortcut , %Hs_Lnk%, %Hs_LnkName%.lnk
;处理后事，恢复剪贴板内容
Clipboard := ClipSaved ;恢复剪贴板原本的内容
ClipSaved = ;释放内存以防原来剪贴板里是巨大的内容。
Return

