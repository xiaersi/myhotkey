#NoTrayIcon 
#SingleInstance ignore
#include ../../

;; ���� Tabҳ��
g_page = %1%
g_Version = V1.05 Alpha

change_icon()

g_title = ���ڷ����ȼ�
gosub ����ʼ��������

;FileInstall, locked.bmp,%A_ScriptDir%\teshorse.jpg
Gui,+LastFound
g_hGui := WinExist()

Gui, Add, Text, x300 y10 w180 +right  cOlive , �����ȼ� %g_Version%

HLink_Add(g_hGui, 90,  390,  100, 20, "", "'@�����ȼ�':www.weibo.com/goomood" ) ;without handler
HLink_Add(g_hGui, 220,  390,  100, 20, "", "'CSDN����':http://blog.csdn.net/teshorse/article/details/6941341" ) ;without handler
HLink_Add(g_hGui, 350,  390,  100, 20, "", "'����':http://blog.csdn.net/teshorse/article/details/6941348" ) ;without handler

/*
Gui, Add, Text, x100 y390   cBlue  g����ϵ���ߡ�, ����΢��
Gui, Add, Text, x230 y390  cBlue g���򿪲��͡�, CSDN����
Gui, Add, Text, x370 y390  cBlue g������ҳ�桿, ����
*/

;Gui, Add, Picture, x10 y375 Section,%A_ScriptDir%\teshorse.jpg


;Gui, Add, Text, x106 y10 w480 h360 ,zz
Gui, Add, Tab, x6 y10 w480 h360 v_Tab, ���|����|����|����|����|����

gui, font, s10, Tahoma  
;Gui, Color, ControlColor, %Black1%
;Gui, Color, White 

Gui, Tab, ���
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_about )
Gui, Add, Edit, x16 y40 w460 h320 cBlack, %var_about%
Gui, Tab, ����
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_Histroy )
Gui, Add, Edit, x16 y40 w460 h320 cGreen , %var_Histroy%
Gui, Tab, ����
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_Author )
Gui, Add, Edit, x16 y40 w460 h320 cNavy, %var_Author%
Gui, Tab, ����
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_Donet )
Gui, Add, Edit, x16 y40 w460 h320 cMaroon, %var_Donet%
Gui, Tab, ����
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_Help )
Gui, Add, Edit, x16 y40 w460 h320 cTeal  , %var_Help%
Gui, Tab, ����
;RichEdit_Add( g_hGui, 16, 40, 460, 320, "MULTILINE VSCROLL BORDER READONLY", var_update )
Gui, Add, Edit, x16 y40 w460 h320 cBack  , %var_update%

if g_page <>
{
	GuiControl, ChooseString, _Tab, %g_page%
}

; Generated using SmartGUI Creator 4.0
Gui, Show,  h424 w495, %g_title%
Return

GuiClose:
ExitApp

����ϵ���ߡ�:
	run http://www.weibo.com/goomood
	return 

������ҳ�桿:
	run http://blog.csdn.net/teshorse/article/details/6941348
	return


���򿪲��͡�:
	run http://blog.csdn.net/teshorse/article/details/6941341
	return



#include .\inc\common.aik	
#include .\ahklib\HLink\HLink.aik
#include .\ahklib\RichEdit\RichEdit.aik



����ʼ��������:
var_about =
(

    �����ȼ�����һ���Ż��û�����ϰ�ߡ���߹���Ч�ʵĹ��߼��ϡ���ͨ���������������ȼ�����ݲ˵��Լ��������Ϊһ�壬�ﵽ�����������򡢴��ĵ����Զ�����ģ���û����������Ŀ�ġ���Щ����ȼ����ݲ˵����������ɶ������ϣ�ÿ���û����Ը����Լ���Ҫ��ϰ�ߣ�����һ���ʺ��Լ��Ĳ�����ϡ���ϰ�����Լ��Ĳ������֮����������ٺܶ��ظ��ԵĲ���������Ч�ʽ�������ߡ�

    �����ȼ�����������Ϊ������ɫ��������ó����ƽ̨��Ҳ�����������õ��ĵ������⣬�����ȼ����Դ��˺ܶ�ʵ�õ�С���ܣ��磺��������ķ���С�ֵ䡢����м��������ڴ�С��λ�á����������ټ��������ơ�ճ����������Ϊ��������DoxyGen����ע�͡�C++����ĸ����༭��ʹ��VIM��UE���ⲿ���߿��ٱ༭����ѡ�е��ı��������ɶ������Ļ���̡�Alt+Tab�л�������ǿ���ܡ�����������ߡ���־�鿴�������ߡ��򵥵Ķ�ʱ���ѹ��ߵȵȣ�����С���ܻ��ڲ������ӣ������Լ�ȥ�ھ���!

    �����ȼ�˵������һö���տ����������ʬ��ֻΪ������̫���⣡

    ��ʾ�������ȼ� V1.0 ����Windwox XP ����ϵͳ�±���ģ���Vista/Win7����δ�����ز��ԣ�


)


var_Histroy =
(

    ��Լ��2008���ʱ��ͨ�����ü�����Ĳ��ͷ�����AutoHotkey�ű����򣬴Ӵ�����������ϲ������ߣ������������֡��ڹ��������У�����ҵ��ʱ�䲻ͣ��дһЩ�ű��������ڸ����������Ч�ʡ�ͨ������Ļ��ۣ�������䷢���Ѿ�д��һ��С�ű����򣬶�������һ������Ĵ����ܣ����Կ���������������Ľű�����Ҳ�������û��������ŵ�ʹ���ҵĽű�����

    ���𽥵��벻����ЩС�����ˣ���ЩС�����Ϊ�ҹ����бز����ٵĹ��ߡ��������Ѿ�����ͨ����ʼ�˵�����Դ���������������ˣ�������Ҽ�һ������ͨ���Լ����������˲����������дC++����ʱ��Ҳ��������Ҽ�һ�����ڵ����Ŀ�ݲ˵���ѡ��ʹ��VIM�༭����Ϊһ���������DoxyGen����ע�ͣ�����ٵ�������ķ�������빤���޹ص���ʱ��һ�����غܶര�ڡ��ڵ��Գ�����ҪƵ���޸�ϵͳʱ��ʱ��ʹ���ҵ�ϵͳʱ���޸Ĺ��ߣ������˿��Կ����л�����ʷʱ���⣬���������һָ���������ʱ�䡣����һ������ֵ��һ�ᣬ��Ϊ������Ҫ�����˺�������Ĵ��ڣ�����������ͬ�Ŀ������Ӵ��Ҳ�����Ҫ������ַ��˵��˺ź������ˡ���ȻΪ�������������˺�������ķ����ǳ��򵥣�һ����ݼ��㶨��

    һЩͬ�¿����ҵĵ��Բ����ǳ�Cool�������ݣ�����������Ҫ���򡣿������ҵ���ЩС���߻������ƹ�ļ�ֵ���ǵ���ƪ����˵��������������ڷ���͸������ǵ������Ȼ������ЩС����Ϊ��ߣ������������Ҳ�ܷ����û��Ĳ�������߹���Ч�ʣ����Ǿ�������������ó������ҷ������������ȡ�˸����֣������������ȼ��������������ʵ�ܲ����У�ֻ������������߹��ܵı�ɽһ�ǣ��Ժ��뵽���õ������ٸİɣ�

    ��Ҫ˵�����ǣ�������ҵ��ʱ��������Щ����ģ����ܰ����ĵ�д�û�Ƚ������ұȽϴֲڡ�����Щ�������ʱ���������⣬������Ҳ�й�ϵ��ϣ�������ȼ��ܹ����ô�ҵ�ϲ�����Ӷ��и�����û����и�����˼��뿪������������ȼ�����������ã���һ��Ҫ�Ƽ�������ߵĺ����ѣ�Ҳһ��Ҫ���ҷ���Ŷ��

    ���ף��ʹ�÷����ȼ���죡



)

var_Author =
(



	�ҽгɳ�(teshorse)��

	�־�ְ��ĳ֤ȯ��Ϣ��˾�������������������
	
	�������ҵ���ϵ��ʽ��






	����΢��: http://www.weibo.com/goomood
	CSDN����: http://blog.csdn.net/teshorse
	��������: teshorse@hotmail.com
	QQȺ: 10504143

)

var_Donet =
(
	
    ��������÷����ȼ�ֵ�ý�һ���ڴ��������кõĽ��飬��ô���ע�ҵ�΢�����߸������ŷ��������Ĺ�ע�����ĲƸ����Ǽ�����ǰ�Ķ�����

    ��������÷����ȼ��ܲ��������ھ������ֲ����ţ���ô��������ǰɣ����ľ�������������Ǯ�����⣬�����Է����ȼ�ʵʵ���ڵĿ϶��������ǵ���ҫ��

    �������Ͷ���ߡ���ҵ�����ߡ��ʱ������ߣ����Դ������ﶩ��һ�ݡ��²Ƹ�����־���ⲻ���ǶԷ����ȼ��ľ��������ǰ�����һ����æ����Ϊ���ǹ�˾ÿ�����������ɱ����²Ƹ�����־������ָ�ꡣ���²Ƹ�����λ�ǡ����������ʱ����ˡ�������ע�����ʱ��г������Ŷ�����ҵ�����ߺ�Ͷ������˵���ǲ��ɻ�ȱ����ʦ���ѣ�

    ����ҳ�棺 http://blog.csdn.net/teshorse/article/details/6941348
)


var_Help =
(



	�ſ�ר���������ȼ�����Ƶ���ܣ�
	http://www.youku.com/playlist_show/id_17259728.html






	���ע�ҵĲ��ͺ�΢���˽�����ĵ���չ��

	CSDN���ͣ�http://blog.csdn.net/teshorse

	����΢����@�����ȼ�
)

var_update =
(
	������־��
-----------------------------------------------------------------------------
V1.05 Alpha  (2012-04)
  - ����С�ֵ�������V2.13��
    : ������קճ���Ĺ���
    : ��ϸ�鿴״̬ʹ�ø��ı���֧�ֲ�ɫ��ʾ��

  - ��������������V1.02��֧�ֹرջ���������ʾ��

V1.04 Alpha  ( 2012-03 )  
  - ���ӷ���������� V1.0	
  - ���ﻭ������ ����V1.01 
    : ������Ļ���壬ֱ������Ļ�ϻ������ƣ���������
  - ����ħ������ ����V1.10
    : ʹ��RShift�����л������ּ��̴�Сд״̬��

V1.03 Alpha  ( 2012-02 )  ���ӷ���ħ������ V1.0

V1.02 Alpha  ( 2011 )      ��������С�ֵ䵽 V2.11

V1.00 Alpha  ( 2011 )      ���������ȼ�
  ����:
  - ��������� V3.0
  - ����С�ֵ� V2.0
  - ���ﻭ������ V1.0

)
return
