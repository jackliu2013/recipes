/*
把 xml 的文档数据 转存到 关系型的数据库的相应的表中 
*/

--1. 创建关系型的表 
-- drop table customer;

-- create table hybrid( cid integer not null primary key, name varchar(30), city varchar(25), info XML );


--2
insert into hybrid (cid, name, city, info)
     select x.custid, x.custname, x.city, x.doc
     from XMLTABLE ( '$i' passing 
	 XMLPARSE(document
		'<customerinfo Cid="1001">
		<name>jackliu</name>
		<addr country="china">
			<street>lugu east</street>
			<city>Bj</city>
			<prov-state>Good</prov-state>
			<pcode-zip>100010</pcode-zip>
		</addr>
		<phone type="work">88888888</phone>
		</customerinfo>' ) as "i"
        columns
                custid      integer              path    'customerinfo/@Cid',
                custname    varchar(30)          path    'customerinfo/name',
                city        varchar(25)          path    'customerinfo/addr/city',
                doc         XML                  path    '.' ) as x;
 
-- 使用SQL 访问关系和XML数据
-- select info from customer;

-- 使用Xquery访问XML数据
-- xquery db2-fn:xmlcolumn ('CUSTOMER.INFO') ;  -- 表名 字段名需要大写

-- xquery
-- for $d in db2-fn:xmlcolumn('CUSTOMER.INFO')/customerinfo/name
-- return $d;
