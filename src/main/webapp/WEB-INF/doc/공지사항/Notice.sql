/**********************************/
/* Table Name: 공지사항 */
/**********************************/
DROP TABLE notice;

CREATE TABLE NOTICE(
		NOTICENO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		manageno                      		NUMBER(10)		 NOT NULL ,   --FK
		TITLE                         		VARCHAR2(100)		 NOT NULL,
		CONTENT                       		VARCHAR2(4000)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
  FOREIGN KEY (manageno) REFERENCES MANAGE (manageno)
);

COMMENT ON TABLE NOTICE is '공지사항';
COMMENT ON COLUMN NOTICE.NOTICENO is '공지사항 번호';
COMMENT ON COLUMN NOTICE.manageno is '관리자 번호';
COMMENT ON COLUMN NOTICE.TITLE is '제목';
COMMENT ON COLUMN NOTICE.CONTENT is '내용';
COMMENT ON COLUMN NOTICE.RDATE is '등록일';


DROP SEQUENCE notice_seq;
CREATE SEQUENCE notice_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지
  
  
-- 등록
INSERT INTO notice(noticeno, manageno, title, content, rdate)
VALUES(notice_seq.nextval, 1, '전체공지', TO_CLOB('주의사항1'), sysdate);
INSERT INTO notice(noticeno, manageno, title, content, rdate)
VALUES(notice_seq.nextval, 4, '개인공지', TO_CLOB('주의사항2'), sysdate);
  
-- SELECT 목록
SELECT noticeno, manageno, title, content, rdate
FROM notice
ORDER BY noticeno ASC;  
  
-- SELECT 조회
SELECT noticeno, manageno, title, content, rdate
FROM notice
WHERE noticeno = 1;  

-- 텍스트 수정: 
UPDATE notice
SET title='제목 변경', content='내용 변경' 
WHERE noticeno = 1;

-- 삭제
DELETE FROM notice
WHERE noticeno = 1;

commit;