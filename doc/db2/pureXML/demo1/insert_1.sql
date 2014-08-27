insert into address (cid, name, street, city)
     select x.custid, x.custname, x.str, x.place
     from customer, XMLTABLE ( '$i/customerinfo' passing info as "i"
        columns
                custid          integer                path    '@Cid',
                custname    varchar(30)          path    'name',
                str                varchar(40)          path    'addr/street',
                place            varchar(30)          path    'addr/city' ) as x;
 
insert into phones(cid, phonetype, phonenum)
        select x.custid, x.ptype, x.number
        from customer, XMLTABLE('$i/customerinfo/phone' passing info as "i"
        columns 
                custid          integer         path    '../@Cid',
                number        varchar(20)  path    '.',
                ptype           varchar(10)   path    './@type' ) as x;               
                
