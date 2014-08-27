-- drop table yspz_test;
-- drop table book_test;
-- drop table jzpz_test;

-- 创建table yspz_test 主键自赠
create table yspz_test ( 
  id integer not null generated always as identity,
  name char(32) not null unique,
  primary key(id)
);

-- 创建table book_test主键自赠
create table book_test ( 
  id integer not null generated always as identity,
  yspz_id integer not null ,
  name char(32) not null unique,
  primary key(id)
);

-- 创建table jzpz_test主键自赠
create table jzpz_test ( 
  id integer not null generated always as identity,
  yspz_id integer not null ,
  book_id integer not null ,
  name char(32),
  primary key(id)
);

/*
    此种情况下调用存储过程 call TESTMY('yspz', 'book')
*/
