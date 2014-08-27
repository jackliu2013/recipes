/*
	收款交易勾兑后数据
*/
db2 set current schema zdb_ltl;
DROP TABLE SKTX_GDH_DATA ;
CREATE TABLE
    SKTX_GDH_DATA 
    (
        C_MERCHANT_NO VARCHAR(32) ,
        C_PAY_SERIALNO VARCHAR(32),
        D_PAY_DATE TIMESTAMP,
        F_PAY_BALANCE DECIMAL(22,2) ,
        F_INCOME_BALANCE DECIMAL(22,2) ,
        C_CHANNEL_NO VARCHAR(32),
        C_BANK_SERIALNO VARCHAR(32),
        D_BANK_CONFIRM_DATE TIMESTAMP,
        D_BANK_CLEAR_DATE TIMESTAMP,
        F_INNER_BANK_BALANCE DECIMAL(22,2) ,
        F_OUTER_BANK_BALANCE DECIMAL(22,2) ,
        C_RECONCILE_TYPE CHARACTER(1) NOT NULL,
        D_CREATE_DATE TIMESTAMP NOT NULL
        --PRIMARY KEY (C_MERCHANT_NO, C_PAY_SERIALNO, C_RECONCILE_TYPE)
    )in tbs_dat index in tbs_idx;

comment on column sktx_gdh_data.c_merchant_no           is '收款商户号';
comment on column sktx_gdh_data.c_pay_serialno          is '支付记录编号';
comment on column sktx_gdh_data.d_pay_date            	is '支付时间';
comment on column sktx_gdh_data.f_pay_balance           is '支付金额';
comment on column sktx_gdh_data.f_income_balance        is '收入金额';
comment on column sktx_gdh_data.c_channel_no            is '通道号';
comment on column sktx_gdh_data.c_bank_serialno         is '银行支付记录编号';
comment on column sktx_gdh_data.d_bank_confirm_date     is '成功日期';
comment on column sktx_gdh_data.d_bank_clear_date       is '清算勾兑日期';
comment on column sktx_gdh_data.f_inner_bank_balance    is '内扣手续费';
comment on column sktx_gdh_data.f_outer_bank_balance    is '外扣手续费';
comment on column sktx_gdh_data.c_reconcile_type        is '对账类型';
comment on column sktx_gdh_data.d_create_date           is '记录生成日期';


/*
	结算出款
*/
DROP TABLE SOURCE_JSCK ;
CREATE TABLE
    SOURCE_JSCK
    (
        C_MERCHANT_NO VARCHAR(32) NOT NULL,
        C_OUT_SERIALNO VARCHAR(32) NOT NULL,
        C_OUT_TYPE CHARACTER(1) NOT NULL,
        F_OUT_BALANCE DECIMAL(22,2) ,
        F_INCOME_BALANCE DECIMAL(22,2) ,
        C_BANK_NO VARCHAR(32),
        D_BANK_CONFIRM_DATE TIMESTAMP,
        F_INNER_BANK_BALANCE DECIMAL(22,2) ,
        F_OUTER_BANK_BALANCE DECIMAL(22,2) ,
        D_CREATE_DATE TIMESTAMP,
        PRIMARY KEY (C_MERCHANT_NO, C_OUT_SERIALNO, C_OUT_TYPE)
    )in tbs_dat index in tbs_idx;

comment on column source_jsck.c_merchant_no           is '收款商户号';
comment on column source_jsck.c_out_serialno          is '支付记录编号';
comment on column source_jsck.c_out_type              is '出款产品类型';
comment on column source_jsck.f_out_balance           is '出款金额';
comment on column source_jsck.f_income_balance        is '收入金额';
comment on column source_jsck.c_bank_no            	  is '银行接口编号';
comment on column source_jsck.d_bank_confirm_date     is '银行成功日期';
comment on column source_jsck.f_inner_bank_balance    is '内扣手续费';
comment on column source_jsck.f_outer_bank_balance    is '外扣手续费';
comment on column source_jsck.d_create_date           is '记录生成日期';
