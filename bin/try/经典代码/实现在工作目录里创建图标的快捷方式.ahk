
;ʵ���ڹ���Ŀ¼�ﴴ��ͼ��Ŀ�ݷ�ʽ
#c::
;�ȱ��������������
ClipSaved := ClipboardAll ;����������������ݴ洢����ѡ��һ�������
;��ʼ����
clipboard = ;��ռ�����
Send, ^c
ClipWait, 2
if ErrorLevel
{
    MsgBox, ���Ը����ı���������ʧ�ܡ�
    return
}
;���ñ�����ȡ�ļ�·��
Hs_Lnk = %clipboard%
Hs_LnkName = %Hs_Lnk%
;��������ʽ��ȡ�ļ���
Hs_LnkName := RegExReplace(Hs_LnkName,".*\\","")
;���������ڽű��Ĺ���Ŀ¼�´�����ݷ�ʽ
FileCreateShortcut , %Hs_Lnk%, %Hs_LnkName%.lnk
;������£��ָ�����������
Clipboard := ClipSaved ;�ָ�������ԭ��������
ClipSaved = ;�ͷ��ڴ��Է�ԭ�����������Ǿ޴�����ݡ�
Return

