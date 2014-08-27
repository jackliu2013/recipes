/*
把 xml 的文档数据 转存到 关系型的数据库的相应的表中 
*/

--1. 创建关系型的表 
-- drop table customer;
create table customer( id integer not null generated always as  identity, info XML  );
insert into customer(info) values ('
<customerinfo Cid="1003">
<name>jackliu</name>
<addr country="china">
<street>lugu road</street>
<city>Beijing</city>
</addr>
<phone type="work">010-63719999</phone>
<phone type="home">010-63719888</phone>
</customerinfo>
');


create table address( cid integer, name varchar(30), street varchar(40), city varchar(30) );

create table phones( cid integer, phonetype varchar(10), phonenum varchar(20) );

--2
insert into address (cid, name, street, city)
     select x.custid, x.custname, x.str, x.place
     from customer, XMLTABLE ( '$i/customerinfo' passing info as "i"
        columns
                custid          integer                path    '@Cid',
                custname    varchar(30)          path    'name',
                str                varchar(40)          path    'addr/street',
                place            varchar(30)          path    'addr/city' ) as x;
 
 insert into phones(cid, phonetype, phonenum)
        select x.custid, x.ptype, x.number
        from customer, XMLTABLE('$i/customerinfo/phone' passing info as "i"
        columns 
                custid          integer         path    '../@Cid',
                number        varchar(20)  path    '.',
                ptype           varchar(10)   path    './@type' ) as x;               

/*
-- 使用SQL 访问关系和XML数据
select info from customer;

-- 使用Xquery访问XML数据
xquery db2-fn:xmlcolumn ('CUSTOMER.INFO') ;  -- 表名 字段名需要大写

xquery
for $d in db2-fn:xmlcolumn('CUSTOMER.INFO')/customerinfo/name
return $d;

*/



