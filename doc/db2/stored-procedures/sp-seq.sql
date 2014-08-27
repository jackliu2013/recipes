drop procedure "MYTEST" --存储过程名字要大写
@
create procedure "MYTEST" ( --存储过程名字
        in in_yspz_name char(32),
        in in_book_name char(32)
)
begin
                         
   declare v_yspz_name char(32);   -- 声明变量
   declare v_book_name char(32); 
   declare v_yspz_id bigint;
   declare v_book_id bigint;
   declare v_jzpz_id bigint;
   
   set v_yspz_name = in_yspz_name ;      -- 为变量赋值
   set v_book_name = in_book_name ;
                                                                         
   --set v_book_id = seq_yspz1.nextval;
   values nextval for seq_yspz1 into v_yspz_id ;
   insert into yspz1_test(id, name) values (v_yspz_id, v_yspz_name);
   
   --set v_book_id = seq_book1.nextval;
   values nextval for seq_book1 into v_book_id ;
   insert into book1_test(id, yspz_id, name) values (v_book_id, v_yspz_id, v_book_name);

   --set v_jzpz_id = seq_jzpz1.nextval;
   values nextval for seq_jzpz1 into v_jzpz_id ;
   insert into jzpz1_test(id, yspz_id, book_id) values (v_jzpz_id, v_yspz_id, v_book_id);

   commit;
end
@
