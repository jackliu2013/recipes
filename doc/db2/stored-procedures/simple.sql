drop procedure "TESTMY"
@
create procedure "TESTMY" ( --存储过程名字
        in in_id integer,
        in in_name char(32)
)
begin
                         
   declare v_id integer;   -- 声明变量
   declare v_name char(32); 
   
   set v_id = in_id ;      -- 为变量赋值
   set v_name = in_name ;
                                                                         
   insert into test(id, name) values (9, 'hello world');
   
   commit;
end
@
