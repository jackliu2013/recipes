-- select * from syscat.tables where tbspaceid=2 and tableid=18

-- values nextval for seq_yspz1;
-- select seq_yspz1.nextval from system.dual
-- 创建table yspz1_test sequence
create table yspz1_test ( 
  id bigint primary key not null,
  name char(32)
);
create sequence seq_yspz1 as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle cache 200 order;

-- 创建table book1_test
create table book1_test ( 
  id bigint primary key not null,
  yspz_id bigint not null,
  name char(32)
);
create sequence seq_book1 as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle cache 200 order;

-- 创建table jzpz
create table jzpz1_test ( 
  id bigint primary key not null,
  yspz_id bigint not null,
  book_id bigint not null,
  name char(32)
);
create sequence seq_jzpz1 as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle cache 200 order;

--    此种情况下调用存储过程 call TESTMY('yspz1', 'book1')
