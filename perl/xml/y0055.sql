create table y0055(
serialno    varchar(64),
txdate      date,
c           char(32),
cardtype    integer,
p           integer,
txamt       double,
cfee        double,
cwwscfee    double,
bfjacctbj   integer,
bi          varchar(64),
bserialno   varchar(64),  
btxdate     date,
cleardate   date,
bfee        double,
dealdate    date
);


CREATE TABLE test0055
    (
        ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
        INFO XML,
        UNIQUE (INFO)
    );
