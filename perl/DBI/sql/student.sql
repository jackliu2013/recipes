
drop table student;
create table student(
    ID      char(6)     not null primary key,
    Name    varchar(50) ,
    phone   varchar(15) ,
    ts_c    timestamp   default current timestamp
) in tbs_dat index in tbs_idx ;

insert into student( ID, Name ) values
('0000', 'jack' ),
('0001', 'lilei' ),
('0002', 'will' ),
('0003', 'tom' ),
('0004', 'jim' ),
('0005', 'lily' ),
('0006', 'lucy' );
