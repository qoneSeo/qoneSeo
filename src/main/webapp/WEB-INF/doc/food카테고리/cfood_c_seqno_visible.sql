/**********************************/
/* Table Name:  음식*/
/**********************************/
DROP TABLE CFOOD;

CREATE TABLE CFOOD (
		cfoodno                        		NUMBER(10)		   NOT NULL		 PRIMARY KEY,
		NAME                          		    VARCHAR2(30)		 NOT NULL,
		CNT                           		      NUMBER(7)		     DEFAULT 0		 NOT NULL,
		RDATE                         		    DATE		               NOT NULL,
        SEQNO                                NUMBER(5)              DEFAULT 1 NOT NULL,
        VISIBLE                             CHAR(1)                 DEFAULT 'N' NOT NULL
);

COMMENT ON TABLE CFOOD is '음식';
COMMENT ON COLUMN CFOOD.cfoodno is '음식 번호';
COMMENT ON COLUMN CFOOD.NAME is '음식 이름';
COMMENT ON COLUMN CFOOD.CNT is '관련 자료수';
COMMENT ON COLUMN CFOOD.RDATE is '등록일';
COMMENT ON COLUMN CFOOD.SEQNO is '출력 순서';
COMMENT ON COLUMN CFOOD.VISIBLE is '출력 모드';

DROP SEQUENCE CFOOD_SEQ;

CREATE SEQUENCE CFOOD_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 99999  -- 최대값: 99999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
-- CREATE
INSERT INTO cfood(cfoodno, name, cnt, rdate) VALUES(cfood_seq.nextval, '김치찌개', 0, sysdate); 
INSERT INTO cfood(cfoodno, name, cnt, rdate) VALUES(cfood_seq.nextval, '볶음밥', 0, sysdate); 
INSERT INTO cfood(cfoodno, name, cnt, rdate) VALUES(cfood_seq.nextval, '라면', 0, sysdate); 
INSERT INTO cfood(cfoodno, name, cnt, rdate)VALUES(cfood_seq.nextval, '간장계란밥', 0, sysdate); 

-- 우선 순위 높임, 10 등 -> 1 등
UPDATE cfood SET visible = seqno - 1 WHERE cfoodno=1;
SELECT cfoodno, name, cnt, rdate, seqno FROM cfood ORDER BY cfoodno ASC;

-- 우선 순위 낮춤, 1 등 -> 10 등
UPDATE cfood SET visible = seqno + 1 WHERE cfoodno=1;
SELECT cfoodno, name, cnt, rdate, seqno FROM cfood ORDER BY cfoodno ASC;

-- 카테고리 공개 설정
UPDATE cfood SET visible='Y' WHERE cfoodno=1;
SELECT cfoodno, name, cnt, rdate, seqno, visible FROM cfood ORDER BY cfoodno ASC;

-- 카테고리 비공개 설정
UPDATE cfood SET visible='N' WHERE cfoodno=1;
SELECT cfoodno, name, cnt, rdate, seqno, visible FROM cfood ORDER BY cfoodno ASC;

COMMIT;

-- 비회원/회원 SELECT LIST, id: list_all_y
SELECT cfoodno, name, cnt, rdate, seqno, visible 
FROM cfood 
WHERE visible='Y'
ORDER BY seqno ASC;

-- COUNT
SELECT COUNT(*) as cnt FROM cfood;
       CNT
----------
         2

  
