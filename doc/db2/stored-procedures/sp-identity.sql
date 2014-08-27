drop procedure "TESTMY" --存储过程名字要大写
@
create procedure "TESTMY" ( --存储过程名字
        in in_yspz_name char(32),
        in in_book_name char(32)
)
begin
                         
   declare v_yspz_name char(32);   -- 声明变量
   declare v_book_name char(32); 
   declare v_yspz_id integer;
   declare v_book_id integer;
   
   set v_yspz_name = in_yspz_name ;      -- 为变量赋值
   set v_book_name = in_book_name ;
                                                                         
   insert into yspz_test(name) values (v_yspz_name);
   select id into v_yspz_id from yspz_test where name = v_yspz_name;
   
   insert into book_test(yspz_id, name) values (v_yspz_id, v_book_name);
   select id into v_book_id from book_test where name = v_book_name;

   insert into jzpz_test(yspz_id, book_id) values (v_yspz_id, v_book_id);

   commit;
end
@
