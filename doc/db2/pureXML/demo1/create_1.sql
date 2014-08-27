/*
把 xml 的文档数据 转存到 关系型的数据库的相应的表中 
*/

--1. 创建关系型的表 
create table customer( cid integer not null generated always as  identity, info XML  );
insert into customer(info) values ('
<customerinfo Cid="1003">
<name>jackliu</name>
<addr country="china">
<street>lugu road</street>
<city>Beijing</city>
<prov-state>bj</prov-state>
<pcode-zip>10010</pcode-zip>
</addr>
<phone type="work">010-63719999</phone>
<phone type="home">010-63719888</phone>
</customerinfo>
');


create table address( cid integer, name varchar(30), street varchar(40), city varchar(30) );

create table phones( cid integer, phonetype varchar(10), phonenum varchar(20) );

