
Loop 2 ;��Ҫ��½���ٸ�QQ��ִ�м���
{ 
 FileReadLine, line, 1.txt, %A_Index% 
if ErrorLevel 

  StringLen, cd, line    ;;;�����Ƶľ������У�û��ִ�С�������˼�ǻ�����еĳ���
  StringLen, changdu, line ;;�Ͼ�û��ִ�У����ͱ�ִ���ˡ�
StringGetPos, fengehaoweizhi, line, ---- ;Ѱ�ҡ�----��������ŵ�λ��
if fengehaoweizhi>=0  ;���ã�������ֲ��淶�ĺ�����߿���
{
QQhaochangdu:=fengehaoweizhi ; �ָ����λ�þ��൱��QQ�ŵ�λ��
mimachangdu:=changdu-QQhaochangdu-4 ;����ľ���----ռ4���ַ�
stringleft, hm, line , %QQhaochangdu% ;��ȡQQ����
 stringright, mm, line, %mimachangdu% ;��ȡQQ����

;=======���¹��͹�championer �Լ���λ�����������ֵ���=======
 run, QQ.exe, , , ThisPID ;;����QQ��ý���id
 WinWait, ahk_class TXGuiFoundation ahk_pid %ThisPID% ;�ȴ�����
 WinGet, ThisHWND, ID, ahk_class TXGuiFoundation ahk_pid %ThisPID% ;��ȡ���ھ��
 WinGet, control, ControlList, ahk_class TXGuiFoundation ahk_pid %ThisPID% ����ȡ�ؼ��б�

;��ȡ�ؼ����
 i = 0
 Loop, Parse, Control, `n
 {
    if i = 1
       mma = %A_LoopField%  ;������ֻ�������ſ��ԣ���֪�������˶Բ���
    else
       hma = %A_LoopField%
       i ++= 1
}

 ControlSettext, %hma%, %hm%, ahk_id %ThisHWND% ;�������
 Controlsend, %mma%, %mm%, ahk_id %ThisHWND% ;��������

sleep 600
send {enter}
 sleep 10000
}
}

