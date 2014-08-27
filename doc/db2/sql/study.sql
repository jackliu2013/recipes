
select sum(tx_amt)   ,  matcher
from ( 
select matcher , sum(tx_amt)  as tx_amt from yspz_0081
where bi =120 and zjbd_date_in_bj = '2013-12-10'
group by matcher

union 

select matcher ,sum(tx_amt)  as tx_amt from yspz_0087
where bi =120 and zjbd_date_in_bj = '2013-12-10'
group by matcher

union  

select matcher ,sum(tx_amt)  as tx_amt from yspz_0082 
where bi =120 and zjbd_date_in_bj = '2013-12-10'
group by matcher

)
group by matcher 