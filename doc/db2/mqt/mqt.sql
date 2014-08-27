/* 物化查询表MQT 立即刷新实验 */
-- 1. 创建基础数据表 basetable
create table basetable 
(c1 int not null primary key, c2 int, c3 int, c4 int); 
 
-- 2. 向基础数据表插入数据
insert into basetable 
values
(1,1,1,1),
(2,2,2,2),
(3,3,3,3),
(11,11,11,11)
(12,12,12,12); 
 
-- 3. 创建立即刷新的MQT表 mqttab
create table mqttab as 
(select c1, c2, c3 from basetable where c1 > 10) 
data initially deferred refresh immediate; 
 
-- 删除MQT物化关系
/* alter table mqttab drop materialized query ; 
drop table mqttab ;  */

-- 4. 对MQT表 mqttab 立即进行约束检查，并且把基础数据表现在的数据刷新到mqttab
set integrity for mqttab   immediate checked  not  incremental ; 

-- 对MQT表 mqttab 不立即进行约束检查，基础数据表现在的数据不会刷新到mqttab，基础表新增的数据会刷新到mqttab
-- set integrity for mqttab materialized query immediate unchecked  ; 
 
--5.  从MQT表mqttab  查询数据
select * from mqttab;
 
 
/* 物化查询表MQT 延迟刷新实验  (无登台表staging table，即完全刷新) */
--1.  创建基础数据表
create table basetab2 
(c1 int not null primary key, c2 int, c3 int, c4 int); 
 
--2. 向基础数据表插入数据 
insert into basetab2 
values(1,1,1,1),(2,2,2,2),(3,3,3,3),(11,11,11,11); 

--3. 创建延迟刷新的MQT表
create table mqttab2 as 
(select c1, c2, c3 from basetab2 where c1 > 10) 
data initially deferred refresh deferred; 

--4. 立即执行约束检查，把基础表现有的数据刷新到mqttab2
set integrity for mqttab2 immediate checked not incremental ;
 
--5. 从MQT表 mqttab2 查询数据 发现现有的数据同步到mqttab2
select * from mqttab2 ; 

--6. 向基础数据表插入新的数据 
insert into basetab2 
values(12,12,12,12),(13,13,13,13); 

--7. 刷新MQT表mqttab2，否则查询mqttab2的时候，新增加的数据不会刷新到mqttab2
refresh table mqttab2;

--8. 从MQT表 mqttab2 查询数据，发现新增的数据已经刷新到mqttab2
select * from mqttab2 ; 
 
 /* 物化查询表MQT 延迟刷新实验  (登台表staging table，即增量刷新)  */
 -- 1. 创建基础数据表
 create table basetab3 
 (c1 int not null primary key, c2 int, c3 int, c4 int); 
 
 --2. 向基础数据表插入数据
 insert into basetab3 
 values(1,1,1,1),(2,2,2,2),(3,3,3,3),(11,11,11,11); 

--3. 创建延迟刷新的MQT表 mqttab3
 create table mqttab3 as 
 (select c1, c2, c3 from basetab3 where c1 > 10)
 data initially deferred refresh deferred; 

--4. 创建登台表staging table mqttab3_stg
create table mqttab3_stg for mqttab3 propagate immediate; 

--5. 对MQT表mqttab3 及登台表mqttab3_stg 执行约束检查命令
set integrity for mqttab3 materialized query immediate unchecked;  --对MQT表mqttab3的基础表不进行约束检查
-- set integrity for mqttab3 immediate checked not incremental ;             -- 
set integrity for mqttab3_stg staging immediate unchecked  ;             --对登台表mqttab3_stg不进行约束检查(基础表以前的数据不会刷新到登台表中)
 
select * from mqttab3_stg ;    -- 查询登台表mqttab3_stg
select * from mqttab3 ;           -- 查询MQT表mqttab
select * from basetab3 ;          -- 查询基础数据表basetab3
 
 --6. 再次插入数据
insert into basetab3 
values(22,22,22,22),(23,23,23,23); 

--刷新MQT表把登台表数据刷新到MQT表 mqttab3
refresh table mqttab3 ;

select * from mqttab3_stg ;    -- 查询登台表mqttab3_stg
select * from mqttab3 ;           -- 查询MQT表mqttab
select * from basetab3 ;          -- 查询基础数据表basetab3

