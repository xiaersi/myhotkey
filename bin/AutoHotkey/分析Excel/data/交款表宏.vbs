Private Sub Workbook_BeforeClose(Cancel As Boolean)
    On Error Resume Next
    密码 = 密码设置.Cells(2, 1)
    明细表.Visible = 2
    明细表.Name = "sf1" & 密码
    密码设置.Visible = 2
    密码设置.Name = "sf2" & 密码
    Sheet1.Visible = 2
End Sub
Private Sub Workbook_Open()
  汇总表.Range("8:65535").Delete
  ActiveWindow.ScrollRow = 1
  ActiveWindow.ScrollColumn = 1
  Application.ScreenUpdating = False
  汇总表.Visible = -1
  明细表.Visible = 2
  密码设置.Visible = 2
  Sheet1.Visible = 2
  Dim 网络明细
  密码 = InputBox("请输入密码：", "登录")
  密码行 = 密码设置.Cells(65536, 1).End(xlUp).Row
  ReDim 网络明细(密码行)
  For ii = 2 To 密码行
     If Trim(密码) = Trim(密码设置.Cells(ii, 1)) Then Exit For
  Next ii
  If ii > 密码行 Then MsgBox "密码错误", vbOKOnly: ThisWorkbook.Close: End
  
  If 密码设置.Cells(ii, 2) = "解密用户" Then
       明细表.Visible = -1
       明细表.Name = "明细表"
       密码设置.Visible = -1
       密码设置.Name = "密码设置"
       Sheet1.Visible = -1
     Else
       明细表.Visible = 2
       密码设置.Visible = 2
       Sheet1.Visible = 2
       Dim qsh, jsh, jsl, bbh1, bbh2, i, j As Long
       Dim sjb2 As String
       sjb2 = Sheet1.Name
       If 密码设置.Cells(ii, 3) = "All" Then
           网络 = 密码设置.Cells(ii, 2) & "分部"
           For abc = 1 To 密码行
             If 密码设置.Cells(ii, 2) = 密码设置.Cells(abc, 2) And 密码设置.Cells(abc, 3) <> "All" Then
               网络行 = 网络行 + 1
               网络明细(网络行) = 密码设置.Cells(abc, 3)
             End If
           Next abc
         Else
           网络行 = 1
           网络明细(网络行) = 密码设置.Cells(ii, 3)
           网络 = 密码设置.Cells(ii, 3)
       End If
       
       Dim 数据, 报表, shuj2
       行 = 明细表.Cells(65536, 1).End(xlUp).Row - 1
       列 = 12
       qsh = 5: jsl = 26
       jsh = Sheets(sjb2).Cells(65536, 26).End(xlUp).Row - qsh + 1
       shijie = Sheets(sjb2).Cells(2, 22)
       ReDim 数据(行, 列), 报表(1 To 行, 1 To 列), shuj2(1 To jsh, 1 To jsl)
       For i = 1 To 行
         For j = 1 To 列
           数据(i, j) = 明细表.Cells(i + 1, j)
         Next j
       Next i
       For i = 1 To jsh
         For abc = 1 To 网络行
            If Sheets(sjb2).Cells(i + qsh - 1, 2) = 网络明细(abc) Then
               bbh1 = bbh1 + 1
               For j = 1 To jsl
                 shuj2(bbh1, j) = Sheets(sjb2).Cells(i + qsh - 1, j)
               Next j
            End If
         Next abc
       Next i
       
       For i = 1 To 行
         For abc = 1 To 网络行
            If 数据(i, 3) = 网络明细(abc) Then
              报表行 = 报表行 + 1
              If 报表行 = 1 Then 账套 = 数据(i, 2)
              报表(报表行, 1) = 数据(i, 4)
              报表(报表行, 2) = 数据(i, 5)
              If 数据(i, 7) = "运费" Then
                  报表(报表行, 3) = "散单"
                ElseIf 数据(i, 7) = "代收货款" Or 数据(i, 7) = "纸箱费" Then
                  报表(报表行, 3) = 数据(i, 7)
                 Else
                  报表(报表行, 3) = "其他"
              End If
              报表(报表行, 4) = 数据(i, 6)
              报表(报表行, 6) = Format(数据(i, 8), "000000")
              报表(报表行, 7) = 数据(i, 9)
              If 网络行 <> 1 Then 报表(报表行, 11) = 数据(i, 3)
            End If
         Next abc
       Next i
       'bbh2 = 报表行
       For j = 1 To bbh1
          For i = 1 To 报表行
            If 报表(i, 6) = shuj2(j, 5) And 报表(i, 3) = "散单" And 报表(i, 1) = shijie Then
              报表(i, 5) = 报表(i, 5) + shuj2(j, 26)
              Exit For
            End If
          Next i
          If i > 报表行 Then
              报表行 = 报表行 + 1
              报表(报表行, 1) = shijie
              报表(报表行, 3) = "散单"
              报表(报表行, 5) = shuj2(j, 26)
              报表(报表行, 6) = shuj2(j, 5)
          End If
       Next j
       '报表行 = bbh2
       If 报表行 <> 0 Then
          For i = 1 To 报表行
            For j = i - 1 To 1 Step -1
              If 报表(j, 6) > 报表(j + 1, 6) Then
                 For ii = 1 To 11
                   转换 = 报表(j, ii)
                   报表(j, ii) = 报表(j + 1, ii)
                   报表(j + 1, ii) = 转换
                 Next ii
              End If
            Next j
          Next i
          汇总表.Range(汇总表.Cells(8, 1), 汇总表.Cells(8 + 报表行 - 1, 11)) = 报表
          汇总表.Cells(8 + 报表行, 1) = "收支项目" & Chr(10) & "合计"
          汇总表.Cells(8 + 报表行, 2) = "散单小计"
          汇总表.Cells(8 + 报表行, 4) = "=SUMIF(C:C,""散单"",D:D)+SUMIF(C:C,""纸箱费"",D:D)"
          汇总表.Cells(9 + 报表行, 2) = "代收货款小计"
          汇总表.Cells(9 + 报表行, 4) = "=SUMIF(C:C,""代收货款"",D:D)"
          汇总表.Cells(10 + 报表行, 2) = "其他小计"
          汇总表.Cells(10 + 报表行, 4) = "=SUMIF(C:C,""其他"",D:D)"
          汇总表.Cells(11 + 报表行, 1) = "合计："
          汇总表.Cells(11 + 报表行, 4) = "=R[-1]C+R[-2]C+R[-3]C"
          汇总表.Cells(12 + 报表行, 2) = "收款员："
          汇总表.Cells(12 + 报表行, 7) = "收款时间："
          汇总表.Range("A" & Trim(Str(8 + 报表行)) & ":A" & Trim(Str(10 + 报表行)) & ",B" & Trim(Str(8 + 报表行)) & ":C" & Trim(Str(8 + 报表行)) & ",B" & Trim(Str(9 + 报表行)) & ":C" & Trim(Str(9 + 报表行)) & ",B" & Trim(Str(10 + 报表行)) & ":C" & Trim(Str(10 + 报表行)) & ",A" & Trim(Str(11 + 报表行)) & ":C" & Trim(Str(11 + 报表行)) & "").MergeCells = True
          汇总表.Range(汇总表.Cells(8, 1), 汇总表.Cells(11 + 报表行, 10)).Borders.LineStyle = xlContinuous
          汇总表.Range(汇总表.Cells(8 + 报表行, 1), 汇总表.Cells(11 + 报表行, 3)).HorizontalAlignment = xlCenter
          汇总表.Range(汇总表.Cells(8 + 报表行, 1), 汇总表.Cells(11 + 报表行, 3)).VerticalAlignment = xlCenter
       End If
  End If
  行 = 密码设置.Cells(65536, 6).End(xlUp).Row - 1
  For i = 2 To 行
    If Trim(账套) = Trim(密码设置.Cells(i, 6)) Then Exit For
  Next i
  汇总表.Cells(2, 1) = 账套 & "(" & Trim(密码设置.Cells(i, 7)) & ")"
  汇总表.Cells(4, 2) = 网络
  汇总表.Cells(5, 2) = 网络
  汇总表.Activate
  汇总表.Cells(8, 1).Select
End Sub

