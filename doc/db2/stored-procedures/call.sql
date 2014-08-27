-- 调用存储过程
db2 connect to zdb_dev user db2inst using db2inst;

-- call 存储过程名(存储过程参数)
call TESTMY( 7 , 'hello');
