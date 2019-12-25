; 保证 sqlite3.exe 和 sqlite3.dll 在同一目录

; 添加引用
#Include SQLite.ahk

; 这个是建立一张 user 表, 有 3 列, 的 sql 语句
sql := "create table user(name, sex, age);"

; 利用上面建表的语句建立数据库叫 test.db , 同时返回一个值表示执行是否出错
has_error := _SQLite_SQLiteExe("test.db", sql, output)
; 如果返回值不为 0 表示出错, 为了方便下面的都没做判断了
if (has_error <> 0)
{
    ; $SQLITE_s_ERROR 是全局变量, 保存当前错误信息
    MsgBox % $SQLITE_s_ERROR "`n" output
    Return
}

; 初始化, 这个是必须的, 否则运行下面的脚本直接 over
has_error := _SQLite_Startup()
; 读取 test.db 文件
has_error := _SQLite_OpenDB("test.db")

; 插入两条数据, 第一个参数就写 -1 就可以了
has_error := _SQLite_Exec(-1, "insert into user values('helfee', 'male', 18)")
has_error := _SQLite_Exec(-1, "insert into user values('BLooM2', 'male', 24)")

; 再读取所有出来, 后面几个变量的用处同变量名
has_error := _SQLite_GetTable(-1, "select * from user", result, row_count, col_count)
; 查询结果行数
MsgBox % row_count
; 查询结果列数
MsgBox % col_count

; 查询结果, 每行存储一条数据, 数据用 | 分隔, 第一行存储的是列名
Loop, Parse, result, `n
{
    Loop, Parse, A_LoopField, |
    {
        MsgBox % A_LoopField
    }
}

; 关闭数据库连接
has_error := _SQLite_CloseDB(-1)
has_error := _SQLite_ShutDown()

