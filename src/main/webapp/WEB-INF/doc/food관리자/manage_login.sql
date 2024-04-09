/**********************************/
/* Table Name: 관리자 로그인 내역 */
/**********************************/
DROP TABLE mlogin;
CREATE TABLE mlogin(
		mloginno                      		NUMBER(10)		 NULL 		 PRIMARY KEY,
		manageno                      		NUMBER(10)		 NOT NULL,
		ip                            		VARCHAR2(15)		 NULL ,
		logindate                     		TIMESTAMP(5)		 NULL ,
  FOREIGN KEY (manageno) REFERENCES MANAGE (manageno)
);

COMMENT ON TABLE mlogin is '관리자 로그인 내역';
COMMENT ON COLUMN mlogin.mloginno is '로그인 번호';
COMMENT ON COLUMN mlogin.manageno is '관리자 번호';
COMMENT ON COLUMN mlogin.ip is '접속 ip';
COMMENT ON COLUMN mlogin.logindate is '로그인 날짜';

DROP SEQUENCE mlogin_seq;
CREATE SEQUENCE mlogin_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
 
--INSERT
INSERT INTO mlogin(mloginno,manageno,ip,logindate) VALUES (mlogin_seq.nextval,1,'127.0.0.1',sysdate);
INSERT INTO mlogin(mloginno,manageno,ip,logindate) VALUES (mlogin_seq.nextval,1,'127.0.0.2',sysdate);
INSERT INTO mlogin(mloginno,manageno,ip,logindate) VALUES (mlogin_seq.nextval,4,'127.0.0.1',sysdate);
INSERT INTO mlogin(mloginno,manageno,ip,logindate) VALUES (mlogin_seq.nextval,4,'127.0.0.2',sysdate);


commit;

--LIST: 전체 목록
SELECT mloginno,manageno,ip,logindate FROM mlogin ORDER BY logindate DESC;

--LIST: 관리자별 목록
SELECT mloginno,manageno,ip,logindate FROM mlogin WHERE manageno=1 ORDER BY logindate DESC; 

--DELETE
DELETE FROM mlogin WHERE mloginno=1; 
DELETE FROM mlogin WHERE manageno=1;

