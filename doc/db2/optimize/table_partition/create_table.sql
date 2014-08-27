-- 创建已分区表和已分区索引
CREATE TABLE purchaseOrders(
    po_id INT,
    po_date DATE,
    po_customer CHAR(200),
    po_item VARCHAR(20),
    po_quantity INT,
    po_price DECFLOAT
  ) INDEX IN global_index_tbsp PARTITION BY(po_date) (
    PARTITION jan2010 STARTING('1/1/2010') ENDING
      '1/31/2010' IN jan2010_data_tbsp INDEX IN jan2010_index_tbsp,
    PARTITION feb2010 STARTING('2/1/2010') ENDING
      '2/28/2010' IN feb2010_data_tbsp INDEX IN feb2010_index_tbsp,
    PARTITION mar2010 STARTING('3/1/2010') ENDING
      '3/31/2010' IN mar2010_data_tbsp INDEX IN mar2010_index_tbsp
  );

CREATE INDEX purchaseOrdersIndex1 ON purchaseOrders(po_customer) PARTITIONED;
