drop procedure "Y0055" --存储过程名字要大写
@
create procedure "Y0055" ( --存储过程名字
     in   serialno    varchar(64),
     in   txdate      date,
     in   c           char(32),
     in   cardtype    integer,
     in   p           integer,
     in   txamt       double,
     in   cfee        double,
     in   cwwscfee    double,
     in   bfjacctbj   integer,
     in   bi          varchar(64),
     in   bserialno   varchar(64),  
     in   btxdate     date,
     in   cleardate   date,
     in   bfee        double,
     in   dealdate    date

)
begin
                         
   -- 声明变量
   declare v_serialno    varchar(64);
   declare v_txdate      date;
   declare v_c           char(32);
   declare v_cardtype    integer;
   declare v_p           integer;
   declare v_txamt       double;
   declare v_cfee        double;
   declare v_cwwscfee    double;
   declare v_bfjacctbj   integer;
   declare v_bi          varchar(64);
   declare v_bserialno   varchar(64);  
   declare v_btxdate     date;
   declare v_cleardate   date;
   declare v_bfee        double;
   declare v_dealdate    date;
   
   -- 为变量赋值
   set  v_serialno  = serialno;  
   set  v_txdate    = txdate;  
   set  v_c         = c;  
   set  v_cardtype  = cardtype;  
   set  v_p         = p;  
   set  v_txamt     = txamt;  
   set  v_cfee      = cfee;  
   set  v_cwwscfee  = cwwscfee;  
   set  v_bfjacctbj = bfjacctbj;  
   set  v_bi        = bi;  
   set  v_bserialno = bserialno;    
   set  v_btxdate   = btxdate;  
   set  v_cleardate = cleardate;  
   set  v_bfee      = bfee;  
   set  v_dealdate  = dealdate;  
                                                                         
   insert into y0055(serialno, txdate, c, cardtype, p, txamt,
                     cfee, cwwscfee, bfjacctbj, bi, bserialno,
                     btxdate, cleardate, bfee, dealdate ) 
          values (v_serialno, v_txdate, v_c, v_cardtype, v_p, v_txamt,
                     v_cfee, v_cwwscfee, v_bfjacctbj, v_bi, v_bserialno,
                     v_btxdate, v_cleardate, v_bfee, v_dealdate ); 

end
@
