; 无下面这行, sqlite_exec 貌似会出错
#NoEnv
#Include SQLite.ahk

^esc::reload
+esc::Edit
!esc::ExitApp
F1::
	DBpath = %A_scriptdir%\FoxMsgUTF8.db  ; 数据库路径
	If ! A_IsCompiled
		SQLite_DLLPath(A_scriptdir . "\sqlite3.dll") ; Dll文件路径

	STime := A_tickcount ; 计时开始

	IfNotExist, %DBPath% ; 当不存在数据库文件时，创建数据库，顺便初始化表结构
		CreateDB(DBPath)

	SQLite_Startup() , SQLite_OpenDB(DBPath)

; 说明: 为什么要将插入的字符串转换为UTF8, 而且查询的时候还要转来
;       这是因为 SQlite 3 只支持 UTF8 编码内容的搜索(狐狸实验过，不晓得以后会不会改进)
;       也就是说，插入的字符串为GBK编码时，你搜中文是得不到正确结果的

;连续插入1000条记录
	; 参考 表 Page: 字段: ID|Name|Content|BookID|About

	SQLite_Exec(-1, "BEGIN;")         ; 事务开始, 当有批量任务时，使用事务能加速
	loop, 1000 {
		SQLstr = INSERT INTO Page (Name, Content) VALUES ('记录%A_index%', '现在时间是: %A_now%')
		SQLite_Exec(-1, Ansi2UTF8(SQLstr))
	}
	SQLite_Exec(-1, "COMMIT;")        ; 事务结束

;查询记录并写入文本文件
	SQLstr = select ID, Name from Page where ID > 888
	SQLite_GetTable(-1, Ansi2UTF8(SQLstr), RowNum, ColNum, Names, Result)
	AnsiResult := UTF82ANSI(Result)
	Fileappend, %AnsiResult%, %A_scriptdir%\查询结果.txt

	SQLite_Exec(-1, "vacuum") ; 这个语句可以'压缩'数据库大小，当操作很多次数据库后，可以运行一下，嘿嘿
	SQLite_CloseDB(-1) , SQLite_ShutDown()

	etime := A_tickcount - STime ; 计时结束
	TrayTip, 耗时:, %etime% ms
return


; ---------------- 自写函数

GetSQLResult(SQLstr="") ; 查询，返回结果
{
	SQLite_GetTable(-1, SQLstr, RowNum, ColNum, Names, Result)
	return, UTF82ANSI(Result)
}


CreateDB(DBPath) ; 创建数据库，顺便初始化表结构
{
	SQLite_Startup() , SQLite_OpenDB(DBPath)
;	SQLite_Exec(-1, "BEGIN;")         ; 事务开始, 当有批量任务时，使用事务能加速

	; 表 Book: 字段: ID|Name|About
	SQLstr = create table Book (ID integer primary key, Name text, About text)
	SQLite_Exec(-1, Ansi2UTF8(SQLstr))

	; 表 Page: 字段: ID|Name|Content|BookID|About
	SQLstr = create table Page (ID integer primary key, Name text, Content text, BookID text, About text)
	SQLite_Exec(-1, Ansi2UTF8(SQLstr))

;	SQLite_Exec(-1, "COMMIT;")        ; 事务结束
	SQLite_CloseDB(-1) , SQLite_ShutDown()
}


; ------------------下面是编码转换函数--------------------------
Ansi2UTF8(sString)
{
   Ansi2Unicode(sString, wString, 0) , Unicode2Ansi(wString, zString, 65001)
   Return zString
}

UTF82Ansi(zString)
{
   Ansi2Unicode(zString, wString, 65001) , Unicode2Ansi(wString, sString, 0)
   Return sString
}

Ansi2Unicode(ByRef sString, ByRef wString, CP = 0)
{
  nSize := DllCall("MultiByteToWideChar", "Uint", CP, "Uint", 0, "Uint", &sString, "int",  -1, "Uint", 0, "int",  0) 
  VarSetCapacity(wString, nSize * 2)
  DllCall("MultiByteToWideChar", "Uint", CP, "Uint", 0, "Uint", &sString, "int",  -1, "Uint", &wString, "int", nSize)
}

Unicode2Ansi(ByRef wString, ByRef sString, CP = 0)
{
  nSize := DllCall("WideCharToMultiByte", "Uint", CP, "Uint", 0, "Uint", &wString, "int",  -1, "Uint", 0, "int", 0, "Uint", 0, "Uint", 0) 
  VarSetCapacity(sString, nSize)
  DllCall("WideCharToMultiByte", "Uint", CP, "Uint", 0, "Uint", &wString, "int",  -1, "str",  sString, "int",  nSize, "Uint", 0, "Uint", 0)
}

