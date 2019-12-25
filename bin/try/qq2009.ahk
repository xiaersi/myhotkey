
Loop 2 ;需要登陆多少个QQ就执行几遍
{ 
 FileReadLine, line, 1.txt, %A_Index% 
if ErrorLevel 

  StringLen, cd, line    ;;;最郁闷的就是这行，没被执行。。。意思是获得这行的长度
  StringLen, changdu, line ;;上句没被执行，这句就被执行了。
StringGetPos, fengehaoweizhi, line, ---- ;寻找“----”这个符号的位置
if fengehaoweizhi>=0  ;作用：避免出现不规范的号码或者空行
{
QQhaochangdu:=fengehaoweizhi ; 分割符号位置就相当于QQ号的位数
mimachangdu:=changdu-QQhaochangdu-4 ;这个四就是----占4个字符
stringleft, hm, line , %QQhaochangdu% ;读取QQ号码
 stringright, mm, line, %mimachangdu% ;读取QQ密码

;=======以下功劳归championer 以及各位帮助过他的兄弟们=======
 run, QQ.exe, , , ThisPID ;;启动QQ获得进程id
 WinWait, ahk_class TXGuiFoundation ahk_pid %ThisPID% ;等待窗口
 WinGet, ThisHWND, ID, ahk_class TXGuiFoundation ahk_pid %ThisPID% ;获取窗口句柄
 WinGet, control, ControlList, ahk_class TXGuiFoundation ahk_pid %ThisPID% ；获取控件列表

;获取控件句柄
 i = 0
 Loop, Parse, Control, `n
 {
    if i = 1
       mma = %A_LoopField%  ;我这里只有这样才可以，不知道其他人对不对
    else
       hma = %A_LoopField%
       i ++= 1
}

 ControlSettext, %hma%, %hm%, ahk_id %ThisHWND% ;输入号码
 Controlsend, %mma%, %mm%, ahk_id %ThisHWND% ;输入密码

sleep 600
send {enter}
 sleep 10000
}
}

