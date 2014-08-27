

-- 删除MQT表sum_wlzj_yfbf 与基表对应的物化查询关系
alter table sum_wlzj_yfbf drop materialized query ;

-- 给基础数据表book_wlzj_yfbf 添加上MQT表 sum_wlzj_yfbf
alter table sum_wlzj_yfbf add materialized query (
    select period as period,
        sum(j)     as j,
        sum(d)     as d,
        count(*)   as cnt
    from book_wlzj_yfbf
    group by period
)
data initially deferred refresh deferred;

set integrity for sum_wlzj_yfbf materialized query immediate unchecked;


-- 创建MQT表sum_wlzj_yfbf对应的登台表 staging  此时有个警告 SQLSTATE 01504   这个警告该怎么解决呢？？？ 在Zark.pm里面的
-- _add_mqt_stg方法里 忽略此警告      
-- # 忽略警告 01504 
-- local $self->{dbh}->{RaiseError};

create table stg_sum_wlzj_yfbf for sum_wlzj_yfbf propagate immediate ;

set integrity for stg_sum_wlzj_yfbf staging immediate unchecked;
