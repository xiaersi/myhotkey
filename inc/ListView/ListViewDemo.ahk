#include ..\..\
g_LVTitle = Name|Modified|FullPath
g_GuiID =    ;; ��Ŵ���GuiID
g_lvOptions =  r20 w525 ;; ListView��λ��
EnableSingleClick = 1   ;whether or not to do cell highlighting on singleclick
LV_ED = Edit1			;; ָ����ListView��ص�Edit����
LV_ST = Static1		;; ָ����ListView��ص�Text����

#include .\inc\listview\guiaddeditListView.aik
Loop, %A_MyDocuments%\*.*
{   If A_Index>40
      Break
   LV_Add("", A_LoopFileName, A_LoopFileTimeModified, A_LoopFileLongPath)
}
LV_ModifyCol()   ;autosize columns

Gui, Show
Return

#include .\inc\ListView\EditListViewBody.aik

guiClose:
   ExitApp
Return
