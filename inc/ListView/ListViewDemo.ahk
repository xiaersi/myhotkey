#include ..\..\
g_LVTitle = Name|Modified|FullPath
g_GuiID =    ;; 存放窗口GuiID
g_lvOptions =  r20 w525 ;; ListView的位置
EnableSingleClick = 1   ;whether or not to do cell highlighting on singleclick
LV_ED = Edit1			;; 指定与ListView相关的Edit名称
LV_ST = Static1		;; 指定与ListView相关的Text名称

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
