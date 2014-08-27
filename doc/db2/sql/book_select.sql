select * from  
book_bfee_zqqr_zg
where id <= 100;

select * from 
book_cost_bfee_zg
where id <=100;

select distinct period 
from book_bfee_zqqr_zg ;

select distinct period 
from book_cost_bfee_zg ;

select max(id) from book_bfee_zqqr_zg ; 
select max(id) from book_cost_bfee_zg ;

select * from
sum_bfee_zqqr_zg;


select * from book_cost_bfee_zg 
where id not in (
 select  distinct book_cost_bfee_zg.id  from book_cost_bfee_zg, book_bfee_zqqr_zg 
 where book_cost_bfee_zg.jzpz_id = book_bfee_zqqr_zg.jzpz_id
)
order by id ;

select sum(j), sum(d) from book_bfee_zqqr_zg where ys_type = '0031';

select sum(j), sum(d) from book_cost_bfee_zg where ys_type = '0031';
select sum(j), sum(d) from book_cost_bfee_zg  ;

select distinct ys_type from book_cost_bfee_zg ; 


