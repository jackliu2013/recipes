CREATE TABLE LOAD_CFG(
    TYPE CHARACTER(6) NOT NULL,
    HOST CHARACTER(32) NOT NULL,
    PROTO CHARACTER(2) NOT NULL,
    USER VARCHAR(32) NOT NULL,
    PASS VARCHAR(32) NOT NULL,
    RDIR VARCHAR(128) NOT NULL,
    FNAME VARCHAR(128) NOT NULL,
    PRIMARY KEY(TYPE)
);
COMMENT ON TABLE LOAD_CFG IS '凭证导入配置表';
COMMENT ON COLUMN LOAD_CFG . TYPE IS '凭证类型';
COMMENT ON COLUMN LOAD_CFG . HOST IS '服务器地址';
COMMENT ON COLUMN LOAD_CFG . PROTO IS '传输协议. 1 Ftp; 2 File; 3 Http';
COMMENT ON COLUMN LOAD_CFG . USER IS '登录用户名';
COMMENT ON COLUMN LOAD_CFG . PASS IS '登录密码';
COMMENT ON COLUMN LOAD_CFG . RDIR IS '远程服务器文件所在位置';
COMMENT ON COLUMN LOAD_CFG . FNAME IS '远程服务器文件名称'

  insert into load_cfg( type, host, proto, user, pass, rdir, fname ) values
  ( '0034', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0034.dat' ),
  ( '0035', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0035.dat' ),
  ( '0036', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0036.dat' ),
  ( '0037', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0037.dat' ),
  ( '0038', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0038.dat' ),
  ( '0039', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0039.dat' ),
  ( '0040', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0040.dat' ),
  ( '0045', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0045.dat' ),
  ( '0046', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0046.dat' ),
  ( '0047', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0047.dat' ),
  ( '0048', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0048.dat' ),
  ( '0049', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0049.dat' ),
  ( '0050', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0050.dat' ),
  ( '0051', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0051.dat' ),
  ( '0102', '127.0.0.1', '1', 'pos', 'pos', '.', 'pos-0102.dat' );


  insert into load_cfg ( type,  host,  proto,  user,  pass,  rdir,  fname )  values
  ( 'F0001',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0001.dat'  ),
  ( 'F0002',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0002.dat'  ),
  ( 'F0003',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0003.dat'  ),
  ( 'F0004',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0004.dat'  ),
  ( 'F0005',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0005.dat'  ),
  ( 'F0006',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0006.dat'  ),
  ( 'F0007',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0007.dat'  ),
  ( 'F0008',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0008.dat'  ),
  ( 'F0009',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0009.dat'  ),
  ( 'F0010',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0010.dat'  ),
  ( 'F0011',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0011.dat'  ),
  ( 'F0012',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0012.dat'  ),
  ( 'F0013',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0013.dat'  ),
  ( 'F0014',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0014.dat'  ),
  ( 'F0015',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0015.dat'  ),
  ( 'F0016',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0016.dat'  ),
  ( 'F0017',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0017.dat'  ),
  ( 'F0018',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0018.dat'  ),
  ( 'F0019',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0019.dat'  ),
  ( 'F0020',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0020.dat'  ),
  ( 'F0021',  '127.0.0.1',  '1',   'fhyd',  'fhyd',  '.',  'fhyd-F0021.dat'  ) ; 

