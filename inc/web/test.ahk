; exmpl.formdump.httpquery.ahk
; Form Dumper v0.1b (w) 9th July 2008 by derRaphael
#NoEnv
InputBox
 ,URL                                                                  ; OutputVariable
 ,Enter URL to analyze                                                 ; Title of box
 ,Please enter the complete URL starting with http:// to be analysed   ; Descriptive text 
 ,,,,,,,,http://pai.groupon.cn/                    ; default value

   html := ""
   g_hh := a_hour
   g_mm := a_min
   g_ss := a_sec
   g_ms := A_MSec
   htmlLength := httpQuery(html,URL)
   VarSetCapacity(html,-1)
   msgbox %g_hh%:%g_mm%:%g_ss%   %g_ms% `n`n %a_hour%:%a_min%:%a_sec%    %a_msec%
; The Complete Form Node from given URL's HTML
   RegExMatch(html,"i)<form.+?</form>",formNode)
; Just the formtag for further analyzing
   RegExMatch(formNode,"i)<form[^>]+?>",formTag)
; The name of the form
   RegExMatch(formTag,"i)NAME=""?(?P<Name>.+?)""?>",form)
; The method used to process Data
   RegExMatch(formTag,"i)METHOD=""?(?P<Method>.+?)""?\s",form)
; The complete address used to send data to
   RegExMatch(formTag,"i)ACTION=""?(?P<Action>.+?)""?\s",form)
; just the url
   RegExMatch(formAction,"i)(?P<URL>[^\?]+)",formA_)
; any existing GET parameters
   RegExMatch(formAction,"i)\?(?P<GET>.*)",formA_)
   ; Fix &amp; to & as delimiter
   StringReplace,formA_GET,formA_GET,&amp`;,&,All

   startPosI := startPosS := startPosT := 0
   inpCount := selCount := txtCount := 0

   Loop,
   {
      If (startPosI:=RegExMatch(formNode,"i)<input[^>]+>",inputTag,startPosI+1)) {
         inpCount++
         formInput%InpCount% := inputTag
      } else {
         noMoreInput := 1
      }
      If (startPosS:=RegExMatch(formNode,"i)<select.*?</select>",selectNode,startPosS+1)) {
         selCount++
         formSelect%selCount% := selectNode
      } else {
         noMoreSelectOptions := 1
      }
      If (startPosT:=RegExMatch(formNode,"i)<textarea.*?</textarea>",textareaNode,startPosT+1)) {
         txtCount++
         formTextarea%txtCount% := textareaNode
      } else {
         noMoreTextArea := 1
      }
      if (NoMoreInput) && (NoMoreTextarea) && (NoMoreSelectOptions) {
         break
      }
   }
   Loop,% inpCount
      Inputs .= formInput%A_Index% "`n"
   StringReplace,inputs,inputs,<,%A_Tab%<,All
   Loop,% selCount
      Selects .= formSelect%A_Index% "`n"
   StringReplace,Selects,Selects,</option>,</option>`n,All
   StringReplace,Selects,Selects,<option,%A_Tab%<option,All
   Selects := RegExReplace(selects,"i)<select[^>]+>","$0`n")
      
   Loop,% txtCount
      txtAreas .= formTextArea%A_Index% "`n"
   StringReplace,txtAreas,txtAreas,</textarea>,</textarea>`n,All
   StringReplace,txtAreas,txtAreas,<textarea,%A_Tab%<textarea,All

; dump results to Gui
Gui,Add,Tab2, w800 h20,Analyzed Content|found Form|raw HTML
Gui,Tab,1
Gui,Add,Edit,w800 h600 yp+20 xp , % ""
      . "formTag:`n" formTag "`n`n"
        . "formMethod:`t" formMethod "`n"
        . "formAction:`t" formAction "`n"
        . "formActionURL:`t" formA_URL "`n"
        . "formActionGET:`t" formA_GET "`n`n"
      . "Total Inputs:`t" inpCount "`n"
      . inputs
      . "`nTotal Selects:`t" selCount "`n"
      . selects "`n"
      . "`nTotal TextAreas:`t" txtCount "`n"
      . txtAreas "`n"
Gui,Tab,2
Gui,Add,Edit,w800 h600 yp xp , % formNode
Gui,Tab,3
Gui,Add,Edit,w800 h600 yp xp , % html
Gui,Show,,Statistics for Form: "%formName%" (%URL%)
return

GuiClose:
GuiEscape:
   ExitApp
   
#include httpQuery.aik

