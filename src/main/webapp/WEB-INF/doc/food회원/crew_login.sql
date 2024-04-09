/**********************************/
/* Table Name: 회원 로그인 내역 */
/**********************************/
DROP TABLE clogin;
CREATE TABLE clogin(
		cloginno                      		NUMBER(10)		 noT NULL		 PRIMARY KEY,
		crewno                        		NUMBER(10)		 noT NULL ,
		ip                            		VARCHAR2(15)	 noT NULL ,
		logindate                     		TIMESTAMP(5)		 NULL ,
  FOREIGN KEY (crewno) REFERENCES crew (crewno)
);

COMMENT ON TABLE clogin is '회원 로그인 내역';
COMMENT ON COLUMN clogin.cloginno is '로그인 번호';
COMMENT ON COLUMN clogin.crewno is '회원 번호';
COMMENT ON COLUMN clogin.ip is '접속 ip';
COMMENT ON COLUMN clogin.logindate is '로그인 날짜';

DROP SEQUENCE clogin_seq;
CREATE SEQUENCE clogin_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  noCYCLE;                     -- 다시 1부터 생성되는 것을 방지
 
--INSERT
INSERT INTO clogin(cloginno,crewno,ip,logindate) VALUES (clogin_seq.nextval,1,'127.0.0.1',sysdate);
INSERT INTO clogin(cloginno,crewno,ip,logindate) VALUES (clogin_seq.nextval,2,'127.0.0.1',sysdate);
INSERT INTO clogin(cloginno,crewno,ip,logindate) VALUES (clogin_seq.nextval,3,'127.0.0.1',sysdate);

commit;

--LIST: 전체 목록
SELECT cloginno,crewno,ip,logindate FROM clogin ORDER BY logindate DESC;

--LIST: 회원별 목록
SELECT cloginno,crewno,ip,logindate FROM clogin WHERE crewno=1 ORDER BY logindate DESC; 

--DELETE
DELETE FROM clogin WHERE cloginno=1; 
DELETE FROM clogin WHERE crewno=1;


