/**********************************/
/* Table Name: 관리자 */
-- 개인 프로젝트에서는 개발자가 유일한 관리자로 처리됨.
/**********************************/
DROP TABLE MANAGE;

CREATE TABLE MANAGE(
    MANAGENO    NUMBER(5)    NOT NULL,
    ID         VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
    PASSWD     VARCHAR(15)   NOT NULL, -- 패스워드, 영숫자 조합
    MNAME      VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
    MDATE      DATE          NOT NULL, -- 가입일    
    GRADE      NUMBER(2)     NOT NULL, -- 등급(1~10: 관리자, 정지 관리자: 20, 탈퇴 관리자: 99)    
    PRIMARY KEY (MANAGENO)              -- 한번 등록된 값은 중복 안됨
);

COMMENT ON TABLE MANAGE is '관리자';
COMMENT ON COLUMN MANAGE.MANAGENO is '관리자 번호';
COMMENT ON COLUMN MANAGE.ID is '아이디';
COMMENT ON COLUMN MANAGE.PASSWD is '패스워드';
COMMENT ON COLUMN MANAGE.MNAME is '성명';
COMMENT ON COLUMN MANAGE.MDATE is '가입일';
COMMENT ON COLUMN MANAGE.GRADE is '등급';

DROP SEQUENCE MANAGE_SEQ;

CREATE SEQUENCE MANAGE_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 99999            -- 최대값: 99999 --> NUMBER(5) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

-- CREATE
INSERT INTO manage(manageno, id, passwd, mname, mdate, grade) VALUES(manage_seq.nextval, 'manage1', '1234', '관리자1', sysdate, 1);

INSERT INTO manage(manageno, id, passwd, mname, mdate, grade) VALUES(manage_seq.nextval, 'manage2', '1234', '관리자2', sysdate, 1);

INSERT INTO manage(manageno, id, passwd, mname, mdate, grade) VALUES(manage_seq.nextval, 'manage3', '1234', '관리자3', sysdate, 1);

commit;

-- READ: List
SELECT manageno, id, passwd, mname, mdate, grade FROM manage ORDER BY manageno ASC;


-- READ         
SELECT manageno, id, passwd, mname, mdate, grade FROM manage WHERE manageno=1;

-- READ by id
SELECT manageno, id, passwd, mname, mdate, grade FROM manage WHERE id='manage1';

-- UPDATE
UPDATE manage SET passwd='1234', mname='관리자1', mdate=sysdate, grade=1 WHERE MANAGENO=1;

COMMIT;

-- DELETE
DELETE FROM manage WHERE manageno=3;
         
-- 로그인, 1: 로그인 성공, 0: 로그인 실패
SELECT COUNT(*) as cnt
FROM manage
WHERE id='manage1' AND passwd='1234'; 
