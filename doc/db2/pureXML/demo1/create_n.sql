/*
把 xml 的文档数据 转存到 关系型的数据库的相应的表中 
*/

--1. 创建关系型的表 
create table customer_n( id integer not null generated always as  identity, info varchar(1000)  );
insert into customer_n(info) values ('
<customerinfo>
<Cid>1003</Cid>
<Cid>1004</Cid>
<name>jackliu</name>
<name>jackcong</name>
<addr country="china"><street>lugu road</street><city>Beijing</city></addr>
<addr country="china"><street>lugu2 road</street><city>Beijing</city></addr>
<phone type="work">010-63719999</phone>
<phone type="home">010-63719888</phone>
</customerinfo>
');


create table address_n( cid integer, name varchar(30), street varchar(40), city varchar(30) );

create table phones_n( cid integer, phonetype varchar(10), phonenum varchar(20) );

