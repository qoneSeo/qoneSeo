/**********************************/
/* Table Name:  음식*/
/**********************************/
DROP TABLE CFOOD;

CREATE TABLE CFOOD (
		cfoodno                        		NUMBER(10)		   NOT NULL		 PRIMARY KEY,
		NAME                          		    VARCHAR2(30)		 NOT NULL,
		CNT                           		      NUMBER(7)		     DEFAULT 0		 NOT NULL,
		RDATE                         		    DATE		               NOT NULL
);

COMMENT ON TABLE CFOOD is '음식';
COMMENT ON COLUMN CFOOD.cfoodno is '음식 번호';
COMMENT ON COLUMN CFOOD.NAME is '음식 이름';
COMMENT ON COLUMN CFOOD.CNT is '관련 자료수';
COMMENT ON COLUMN CFOOD.RDATE is '등록일';

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

commit;

-- READ: LIST
SELECT * FROM cfood;
SELECT cfood, name, cnt, rdate FROM cfood ORDER BY cfoodno ASC;
   cfoodno NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 김치찌개                                0 2023-09-20 01:03:22
         2 볶음밥                                  0 2023-09-20 01:03:22
         3 라면                                    0 2023-09-20 01:03:22
-- READ
SELECT cfoodno, name, cnt, rdate FROM cfood WHERE cfoodno=1;
   cfoodno NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 김치찌개                                0 2023-09-20 01:03:22
         
-- UPDATE
UPDATE cfood SET name='볶음밥', cnt=1 WHERE cfoodno=1;
    cfoodno NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 볶음밥                                  1 2023-09-06 12:09:45

-- DELETE
DELETE FROM cfood WHERE cfoodno = 1;
DELETE FROM cfood WHERE cfoodno >= 10;

COMMIT;

-- SELECT 목록
SELECT cfoodno, name, cnt, rdate
FROM cfood
ORDER BY cfoodno ASC;

-- COUNT
SELECT COUNT(*) as cnt FROM cfood;
       CNT
----------
         2
         
-- ----------------------------------------------------------------------------------------------------
-- 검색, cfoodno별 검색 목록
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM creates
ORDER BY createsno ASC;

-- 카테고리별 목록
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE cfoodno=2
ORDER BY createsno ASC;

-- 1) 검색
-- ① cfoodno별 검색 목록
-- word 컬럼의 존재 이유: 검색 정확도를 높이기 위하여 중요 단어를 명시
-- 글에 'swiss'라는 단어만 등장하면 한글로 '스위스'는 검색 안됨.
-- 이런 문제를 방지하기위해 'swiss,스위스,스의스,수의스,유럽' 검색어가 들어간 word 컬럼을 추가함.
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE cfoodno=2 AND word LIKE '%탐험%'
ORDER BY createsno DESC;

-- title, content, word column search
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE cfoodno=2 AND (title LIKE '%급여%' OR content LIKE '%급여%' OR word LIKE '%급여%')
ORDER BY createsno DESC;

-- ② 검색 레코드 갯수
-- 전체 레코드 갯수, 집계 함수
SELECT COUNT(*)
FROM creates
WHERE cfoodno=2;

  COUNT(*)  <- 컬럼명
----------
         5
         
SELECT COUNT(*) as cnt -- 함수 사용시는 컬럼 별명을 선언하는 것을 권장
FROM creates
WHERE cfoodno=2;

       CNT <- 컬럼명
----------
         4

-- cfoodno 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM creates
WHERE cfoodno=2 AND word LIKE '%급여%';

SELECT COUNT(*) as cnt
FROM creates
WHERE cfoodno=2 AND (title LIKE '%급여%' OR content LIKE '%급여%' OR word LIKE '%급여%');

-- SUBSTR(컬럼명, 시작 index(1부터 시작), 길이), 부분 문자열 추출
SELECT createsno, SUBSTR(title, 1, 4) as title
FROM creates
WHERE cfoodno=2 AND (content LIKE '%급여%');

-- SQL은 대소문자를 구분하지 않으나 WHERE문에 명시하는 값은 대소문자를 구분하여 검색
SELECT createsno, title, word
FROM creates
WHERE cfoodno=1 AND (word LIKE '%FOOD%');

SELECT createsno, title, word
FROM creates
WHERE cfoodno=1 AND (word LIKE '%food%'); 

SELECT createsno, title, word
FROM creates
WHERE cfoodno=1 AND (LOWER(word) LIKE '%food%'); -- 대소문자를 일치 시켜서 검색

-- ||: 문자열 연결
-- LIKE '%' || UPPER('FOOD') || '%' -> LIKE '%FOOD%'
SELECT createsno, title, word
FROM creates
WHERE cfoodno=1 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- 대소문자를 일치 시켜서 검색 ★

SELECT createsno, title, word
FROM creates
WHERE cfoodno=1 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색

SELECT createsno || '. ' || title || ' 태그: ' || word as title -- 컬럼의 결합, ||
FROM creates
WHERE cfoodno=1 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색


SELECT UPPER('한글') FROM dual; -- dual: 오라클에서 SQL 형식을 맞추기위한 시스템 테이블

-- DELETE
DELETE FROM cfood WHERE cfoodno=1;
DELETE FROM cfood WHERE cfoodno >= 10;

COMMIT;
