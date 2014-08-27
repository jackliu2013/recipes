--- 查询某个schema下的所有tables
select * from syscat.tables 
where tabschema = 'DB2INST' ;

-- 查询某个schema下的每个table的数据条数
select tabschema,  tabname,  card as counts 
from syscat.tables 
where tabschema = 'DB2INST' 
order by counts desc; 

-- 查询数据库的表分区信息
select * from syscat.datapartitions 
-- where tabname like 'PURCHASEORDERS' ; 
where tabschema = 'DB2INST'
-- 创建已分区表和已分区索引

CREATE TABLE purchaseOrders ( po_id INT, po_date DATE, po_customer CHAR(200), 
                              po_item VARCHAR(20),po_quantity INT, po_price DECFLOAT )
  INDEX IN tbs_idx
  PARTITION BY (po_date)
    (PARTITION jan2010 STARTING ('1/1/2010') ENDING '1/31/2010' IN tbs_dat
                                        INDEX IN tbs_idx,
     PARTITION feb2010 STARTING ('2/1/2010') ENDING '2/28/2010' IN tbs_dat
                                        INDEX IN tbs_idx, 
     PARTITION mar2010 STARTING ('3/1/2010') ENDING '3/31/2010' IN tbs_dat
                                        INDEX IN tbs_idx);

CREATE INDEX purchaseOrdersIndex1 ON purchaseOrders(po_customer) PARTITIONED;
