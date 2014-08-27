-- 插入周期确认0031凭证的导入配置
/*

insert into load_cfg ( type, host, proto, user, pass, rdir, fname ) values
( '0031', '127.0.0.1', '2', 'pack', 'pack', '/pack', 'pack-0031.dat');

*/

-- 指定确认规则id, 按交易日期分类汇总， 获取 暂估周期确认银行手续费
select tx_date,sum(j) as j, sum(d) as d 
from sum_bfee_zqqr_zg 
where fp = 4 group by tx_date   ;

-- 根据确认规则id，查询某一确认周期时间段内的所有的贷方总额
select sum(d) as d 
from 
(
select tx_date,sum(j) as j, sum(d) as d 
from sum_bfee_zqqr_zg 
where fp = 4 group by tx_date
)  a    ;

-- 查询科目表book_bfee_zqqr_zg 根据确认规则id
select sum(d) 
from book_bfee_zqqr_zg
where fp = 4 


/*  折扣比例>0时，(指定确认规则id按各核算项分类汇总暂估手续费, 进行分摊，并且(逐笔折扣后的汇总 - 实际算出来的手续费)进ark0)
*/
with pack_yspz(bi, c, fp, p, tx_date, zg_bfee, bfee) as 
(
    select  bi,
            c,
            fp,
            p,
            tx_date,
           sum(d) - sum(j)                           as zg_bfee,
          round((sum(d) - sum(j)) * 1000000 / 1000000, 0) as bfee
    from sum_bfee_zqqr_zg
    where c = '31.10011487906' and 
    fp = 4 and tx_date >= '2013-12-05' and tx_date <= '2013-12-31'
    -- group by bi, c, fp, p, tx_date
)
select * from pack_yspz 
union
select null as bi, null as c, fp, null as p, null as tx_date, 0 as zg_bfee, 27510611 - sum(bfee) as bfee 
from pack_yspz 
group by fp ;

-- 查询 sum_bfee_zqqr_zg 里面 j d 不相等的数据
select * from 
(
select bi, c, fp, p, tx_date, sum(j) as j, sum(d) as d 
from sum_bfee_zqqr_zg 
where  bi = 64 and tx_date >= '2013-12-01' and tx_date <='2013-12-31'
group by  bi, c, fp, p, tx_date 
order by tx_date
) a 
where j<>d and c = '31.10001502100'
order by tx_date ;

-- 查询 科目表 客户编号 的重复数据
select * from 
book_bfee_zqqr_zg 
where c  =  '31.10011487906' and tx_date = '2013-12-05' and bi = 64 ;


    select  bi,
            c,
            fp,
            p,
            tx_date,
         sum(d) - sum(j)                           as zg_bfee,
          round((sum(d) - sum(j)) * 1000000 / 1000000, 0) as bfee
    from sum_bfee_zqqr_zg
    where c = '31.10011487906' and fp = 4 and tx_date >= '2013-12-05' and tx_date <= '2013-12-05'
    group by bi, c, fp, p, tx_date ;
    
    
 with pack_yspz(bi, c, fp, p, tx_date, zg_bfee, bfee) as 
( 
    select  bi,
            c,
            fp,
            p,
            tx_date,
           d - j   as zg_bfee,
          round((d - j) * 1000000 / 1000000, 0) as bfee
    from sum_bfee_zqqr_zg
    where  fp = 4 and tx_date >= '2013-12-05' and tx_date <= '2013-12-31'  and c = '31.10011487906' 
    order by tx_date
)
select * from pack_yspz
union all
select null as bi, null as c, fp, null as p, null as tx_date, 0 as zg_bfee, 27510611 - sum(bfee) as bfee 
from pack_yspz 
group by fp ; 


    
    
         select  bi,
            c,
            fp,
            p,
            tx_date,
           d - j   as zg_bfee,
         0   as bfee
    from sum_bfee_zqqr_zg
    where  fp = 4 and tx_date >= '2013-12-05' and tx_date <= '2013-12-31' and c = '31.10011487906' 
    order by tx_date
