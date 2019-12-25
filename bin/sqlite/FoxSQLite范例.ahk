; ����������, sqlite_exec ò�ƻ����
#NoEnv
#Include SQLite.ahk

^esc::reload
+esc::Edit
!esc::ExitApp
F1::
	DBpath = %A_scriptdir%\FoxMsgUTF8.db  ; ���ݿ�·��
	If ! A_IsCompiled
		SQLite_DLLPath(A_scriptdir . "\sqlite3.dll") ; Dll�ļ�·��

	STime := A_tickcount ; ��ʱ��ʼ

	IfNotExist, %DBPath% ; �����������ݿ��ļ�ʱ���������ݿ⣬˳���ʼ����ṹ
		CreateDB(DBPath)

	SQLite_Startup() , SQLite_OpenDB(DBPath)

; ˵��: ΪʲôҪ��������ַ���ת��ΪUTF8, ���Ҳ�ѯ��ʱ��Ҫת��
;       ������Ϊ SQlite 3 ֻ֧�� UTF8 �������ݵ�����(����ʵ������������Ժ�᲻��Ľ�)
;       Ҳ����˵��������ַ���ΪGBK����ʱ�����������ǵò�����ȷ�����

;��������1000����¼
	; �ο� �� Page: �ֶ�: ID|Name|Content|BookID|About

	SQLite_Exec(-1, "BEGIN;")         ; ����ʼ, ������������ʱ��ʹ�������ܼ���
	loop, 1000 {
		SQLstr = INSERT INTO Page (Name, Content) VALUES ('��¼%A_index%', '����ʱ����: %A_now%')
		SQLite_Exec(-1, Ansi2UTF8(SQLstr))
	}
	SQLite_Exec(-1, "COMMIT;")        ; �������

;��ѯ��¼��д���ı��ļ�
	SQLstr = select ID, Name from Page where ID > 888
	SQLite_GetTable(-1, Ansi2UTF8(SQLstr), RowNum, ColNum, Names, Result)
	AnsiResult := UTF82ANSI(Result)
	Fileappend, %AnsiResult%, %A_scriptdir%\��ѯ���.txt

	SQLite_Exec(-1, "vacuum") ; ���������'ѹ��'���ݿ��С���������ܶ�����ݿ�󣬿�������һ�£��ٺ�
	SQLite_CloseDB(-1) , SQLite_ShutDown()

	etime := A_tickcount - STime ; ��ʱ����
	TrayTip, ��ʱ:, %etime% ms
return


; ---------------- ��д����

GetSQLResult(SQLstr="") ; ��ѯ�����ؽ��
{
	SQLite_GetTable(-1, SQLstr, RowNum, ColNum, Names, Result)
	return, UTF82ANSI(Result)
}


CreateDB(DBPath) ; �������ݿ⣬˳���ʼ����ṹ
{
	SQLite_Startup() , SQLite_OpenDB(DBPath)
;	SQLite_Exec(-1, "BEGIN;")         ; ����ʼ, ������������ʱ��ʹ�������ܼ���

	; �� Book: �ֶ�: ID|Name|About
	SQLstr = create table Book (ID integer primary key, Name text, About text)
	SQLite_Exec(-1, Ansi2UTF8(SQLstr))

	; �� Page: �ֶ�: ID|Name|Content|BookID|About
	SQLstr = create table Page (ID integer primary key, Name text, Content text, BookID text, About text)
	SQLite_Exec(-1, Ansi2UTF8(SQLstr))

;	SQLite_Exec(-1, "COMMIT;")        ; �������
	SQLite_CloseDB(-1) , SQLite_ShutDown()
}


; ------------------�����Ǳ���ת������--------------------------
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

