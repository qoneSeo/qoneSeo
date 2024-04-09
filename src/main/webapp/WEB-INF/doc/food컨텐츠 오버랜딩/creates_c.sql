DROP TABLE creates CASCADE CONSTRAINTS; -- 자식 무시하고 삭제 가능
CREATE TABLE creates(
        createsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        manageno                              NUMBER(10)        NOT NULL , -- FK
        cfoodno                                NUMBER(10)       NOT NULL , -- FK
        title                                 VARCHAR2(50)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        word                                  VARCHAR2(100)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(50)          NULL,  -- 원본 파일명 image
        file1saved                            VARCHAR(50)          NULL,  -- 저장된 파일명, image
        thumb1                              VARCHAR(50)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- 파일 사이즈
        price                                 NUMBER(10)      DEFAULT 0 NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,  
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 NUMBER(10)      DEFAULT 0 NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL,
        map                                   VARCHAR2(1000)            NULL,
        youtube                               VARCHAR2(1000)            NULL,
        FOREIGN KEY (manageno) REFERENCES manage (manageno),
        FOREIGN KEY (cfoodno) REFERENCES CFOOD (cfoodno)
);

COMMENT ON TABLE creates is '컨텐츠 - 순례길';
COMMENT ON COLUMN creates.createsno is '컨텐츠 번호';
COMMENT ON COLUMN creates.manageno is '관리자 번호';
COMMENT ON COLUMN creates.cfoodno is '카테고리 번호';
COMMENT ON COLUMN creates.title is '제목';
COMMENT ON COLUMN creates.content is '내용';
COMMENT ON COLUMN creates.recom is '추천수';
COMMENT ON COLUMN creates.cnt is '조회수';
COMMENT ON COLUMN creates.replycnt is '댓글수';
COMMENT ON COLUMN creates.passwd is '패스워드';
COMMENT ON COLUMN creates.word is '검색어';
COMMENT ON COLUMN creates.rdate is '등록일';
COMMENT ON COLUMN creates.file1 is '메인 이미지';
COMMENT ON COLUMN creates.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN creates.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN creates.size1 is '메인 이미지 크기';
COMMENT ON COLUMN creates.price is '정가';
COMMENT ON COLUMN creates.dc is '할인률';
COMMENT ON COLUMN creates.saleprice is '판매가';
COMMENT ON COLUMN creates.point is '포인트';
COMMENT ON COLUMN creates.salecnt is '수량';
COMMENT ON COLUMN creates.map is '지도';
COMMENT ON COLUMN creates.youtube is 'Youtube 영상';
DROP SEQUENCE creates_seq;

CREATE SEQUENCE creates_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 999999  -- 최대값: 999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 등록 화면 유형 1: 커뮤니티(공지사항, 게시판, 자료실, 갤러리,  Q/A...)글 등록
INSERT INTO creates(createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(creates_seq.nextval, 1, 31, '오버랜딩', '4WD 준비', 0, 0, 0, '123',
       '자연', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000 );
INSERT INTO creates(createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(creates_seq.nextval, 4, 30, '오버랜딩', '4WD 준비', 0, 0, 0, '123',
       '자연', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000 );

-- 유형 1 전체 목록
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1
FROM creates
ORDER BY createsno DESC;

-- 유형 2 카테고리별 목록
INSERT INTO creates(createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(creates_seq.nextval, 1, 2, '태백', '산악 주행', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);
            
INSERT INTO creates(createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(creates_seq.nextval, 1, 2, '속초', '비포장 임도', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

INSERT INTO creates(createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(creates_seq.nextval, 1, 2, '홍천', '서울에서 가까운 지역', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

COMMIT;

-- 1번 cfoodno 만 출력
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE cfoodno=1
ORDER BY createsno DESC;

-- 2번 cfoodno 만 출력
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE cfoodno=2
ORDER BY createsno ASC;

-- 3번 cfoodno 만 출력
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE cfoodno=3
ORDER BY createsno ASC;

-- 모든 레코드 삭제
DELETE FROM creates;
commit;

-- 삭제
DELETE FROM creates
WHERE createsno = 25;
commit;

DELETE FROM creates
WHERE cfoodno=12 AND createsno <= 41;

commit;


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
WHERE cfoodno=8 AND word LIKE '%부대찌게%'
ORDER BY createsno DESC;

-- title, content, word column search
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE cfoodno=8 AND (title LIKE '%부대찌게%' OR content LIKE '%부대찌게%' OR word LIKE '%부대찌게%')
ORDER BY createsno DESC;

-- ② 검색 레코드 갯수
-- 전체 레코드 갯수, 집계 함수
SELECT COUNT(*)
FROM creates
WHERE cfoodno=8;

         
SELECT COUNT(*) as cnt -- 함수 사용시는 컬럼 별명을 선언하는 것을 권장
FROM creates
WHERE cfoodno=8;


-- cfoodno 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM creates
WHERE cfoodno=8 AND word LIKE '%부대찌게%';

SELECT COUNT(*) as cnt
FROM creates
WHERE cfoodno=8 AND (title LIKE '%부대찌게%' OR content LIKE '%부대찌게%' OR word LIKE '%부대찌게%');

-- SUBSTR(컬럼명, 시작 index(1부터 시작), 길이), 부분 문자열 추출
SELECT createsno, SUBSTR(title, 1, 4) as title
FROM creates
WHERE cfoodno=8 AND (content LIKE '%부대%');

-- SQL은 대소문자를 구분하지 않으나 WHERE문에 명시하는 값은 대소문자를 구분하여 검색
SELECT createsno, title, word
FROM creates
WHERE cfoodno=8 AND (word LIKE '%FOOD%');

SELECT createsno, title, word
FROM creates
WHERE cfoodno=8 AND (word LIKE '%food%'); 

SELECT createsno, title, word
FROM creates
WHERE cfoodno=8 AND (LOWER(word) LIKE '%food%'); -- 대소문자를 일치 시켜서 검색

SELECT createsno, title, word
FROM creates
WHERE cfoodno=8 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- 대소문자를 일치 시켜서 검색 ★

SELECT createsno, title, word
FROM creates
WHERE cfoodno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색

SELECT createsno || '. ' || title || ' 태그: ' || word as title -- 컬럼의 결합, ||
FROM creates
WHERE cfoodno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색


SELECT UPPER('한글') FROM dual; -- dual: 오라클에서 SQL 형식을 맞추기위한 시스템 테이블

-- ----------------------------------------------------------------------------------------------------
-- 검색 + 페이징 + 메인 이미지
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE cfoodno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
ORDER BY createsno DESC;

-- step 2
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, rownum as r
FROM (
          SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, map, youtube
          FROM creates
          WHERE cfoodno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
          ORDER BY createsno DESC
);

-- step 3, 1 page
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM creates
                     WHERE cfoodno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY createsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM creates
                     WHERE cfoodno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY createsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- 대소문자를 처리하는 페이징 쿼리
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM creates
                     WHERE cfoodno=1 AND (UPPER(title) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(content) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(word) LIKE '%' || UPPER('단풍') || '%')
                     ORDER BY createsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- ----------------------------------------------------------------------------
-- 조회
-- ----------------------------------------------------------------------------
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM creates
WHERE createsno = 1;

-- ----------------------------------------------------------------------------
-- 다음 지도, MAP, 먼저 레코드가 등록되어 있어야함.
-- map                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP 등록/수정
UPDATE creates SET map='카페산 지도 스크립트' WHERE createsno=1;

-- MAP 삭제
UPDATE creates SET map='' WHERE createsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, 먼저 레코드가 등록되어 있어야함.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube 등록/수정
UPDATE creates SET youtube='Youtube 스크립트' WHERE createsno=1;

-- youtube 삭제
UPDATE creates SET youtube='' WHERE createsno=1;

commit;

-- 패스워드 검사, id="password_check"
SELECT COUNT(*) as cnt 
FROM creates
WHERE createsno=1 AND passwd='123';

-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
UPDATE creates
SET title='기차를 타고', content='계획없이 여행 출발',  word='나,기차,생각' 
WHERE createsno = 2;

-- ERROR, " 사용 에러
UPDATE creates
SET title='기차를 타고', content="계획없이 '여행' 출발",  word='나,기차,생각'
WHERE createsno = 1;

-- ERROR, \' 에러
UPDATE creates
SET title='기차를 타고', content='계획없이 \'여행\' 출발',  word='나,기차,생각'
WHERE createsno = 1;

-- SUCCESS, '' 한번 ' 출력됨.
UPDATE creates
SET title='기차를 타고', content='계획없이 ''여행'' 출발',  word='나,기차,생각'
WHERE createsno = 1;

-- SUCCESS
UPDATE creates
SET title='기차를 타고', content='계획없이 "여행" 출발',  word='나,기차,생각'
WHERE createsno = 1;

commit;

-- 파일 수정
UPDATE creates
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE createsno = 1;

-- 삭제
DELETE FROM creates
WHERE createsno = 42;

commit;

DELETE FROM creates
WHERE createsno >= 7;

commit;

-- 추천
UPDATE creates
SET recom = recom + 1
WHERE createsno = 1;

-- cfoodno FK 특정 그룹에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM creates 
WHERE cfoodno=1;

-- manageno FK 특정 관리자에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM creates 
WHERE manageno=1;

-- cfoodno FK 특정 그룹에 속한 레코드 모두 삭제
DELETE FROM creates
WHERE cfoodno=1;

-- manageno FK 특정 관리자에 속한 레코드 모두 삭제
DELETE FROM creates
WHERE manageno=1;

commit;

-- 다수의 카테고리에 속한 레코드 갯수 산출: IN
SELECT COUNT(*) as cnt
FROM creates
WHERE cfoodno IN(1,2,3);

-- 다수의 카테고리에 속한 레코드 모두 삭제: IN
SELECT createsno, manageno, cfoodno, title
FROM creates
WHERE cfoodno IN(1,2,3);

createsNO    manageno     cfoodno TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       
         
SELECT createsno, manageno, cfoodno, title
FROM creates
WHERE cfoodno IN('1','2','3');

createsNO    manageno     cfoodno TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       

-- ----------------------------------------------------------------------------------------------------
-- cfood + creates INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT c.name,
       t.createsno, t.manageno, t.cfoodno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube
FROM cfood c, creates t
WHERE c.cfoodno = t.cfoodno
ORDER BY t.createsno DESC;

-- creates, manage INNER JOIN
SELECT t.createsno, t.manageno, t.cfoodno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM manage a, creates t
WHERE a.manageno = t.manageno
ORDER BY t.createsno DESC;

SELECT t.createsno, t.manageno, t.cfoodno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM manage a INNER JOIN creates t ON a.manageno = t.manageno
ORDER BY t.createsno DESC;

-- ----------------------------------------------------------------------------------------------------
-- View + paging
-- ----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vcreates
AS
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, word, rdate,
        file1, file1saved, thumb1, size1, map, youtube
FROM creates
ORDER BY createsno DESC;
                     
-- 1 page
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vcreates -- View
     WHERE cfoodno=14 AND (title LIKE '%야경%' OR content LIKE '%야경%' OR word LIKE '%야경%')
)
WHERE r >= 1 AND r <= 3;

-- 2 page
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vcreates -- View
     WHERE cfoodno=14 AND (title LIKE '%야경%' OR content LIKE '%야경%' OR word LIKE '%야경%')
)
WHERE r >= 4 AND r <= 6;


-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 좋아요(recom) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT createsno, manageno, cfoodno, title, thumb1, r
FROM (
           SELECT createsno, manageno, cfoodno, title, thumb1, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, thumb1
                     FROM creates
                     WHERE cfoodno=1
                     ORDER BY recom DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 평점(score) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM creates
                     WHERE cfoodno=1
                     ORDER BY score DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 최신 상품 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM creates
                     WHERE cfoodno=1
                     ORDER BY rdate DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 조회수 높은 상품기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM creates
                     WHERE cfoodno=1
                     ORDER BY cnt DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 낮은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM creates
                     WHERE cfoodno=1
                     ORDER BY price ASC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 높은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT createsno, manageno, cfoodno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM creates
                     WHERE cfoodno=1
                     ORDER BY price DESC
           )          
)
WHERE r >= 1 AND r <= 7;

1) 댓글수 증가
UPDATE creates
SET replycnt = replycnt + 1
WHERE createsno = 1;

2) 댓글수 감소
UPDATE creates
SET replycnt = replycnt - 1
WHERE createsno = 1;  

 

