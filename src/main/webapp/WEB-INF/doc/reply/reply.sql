/**********************************/
/* Table Name: 댓글 */
/**********************************/
DROP TABLE reply;

CREATE TABLE reply(
        replyno                                NUMBER(10)        NOT NULL       PRIMARY KEY,
        createsno                              NUMBER(10)        NOT NULL,  --fk
        crewno                                 NUMBER(6)         NOT NULL,  --fk
        content                                VARCHAR2(1000)    NOT NULL,
        rdate                                  DATE NOT NULL,
        id                                     VARCHAR2(50)     NOT NULL,       
  FOREIGN KEY (createsno) REFERENCES creates (createsno) ON DELETE CASCADE,
  FOREIGN KEY (crewno) REFERENCES crew (crewno)
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.replyno is '댓글번호';
COMMENT ON COLUMN reply.createsno is '컨텐츠번호';
COMMENT ON COLUMN reply.crewno is '회원 번호';
COMMENT ON COLUMN reply.content is '내용';
COMMENT ON COLUMN reply.id is '아이디';
COMMENT ON COLUMN reply.rdate is '등록일';

DROP SEQUENCE reply_seq;
CREATE SEQUENCE reply_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지


-- 등록
INSERT INTO reply(replyno, createsno, crewno, content, rdate, id)
VALUES(reply_seq.nextval, 12, 1, '댓글1', sysdate, 'user1@gmail.com');        
INSERT INTO reply(replyno, createsno, crewno, content,  rdate, id)
VALUES(reply_seq.nextval, 12, 1, '댓글2', sysdate, 'user1@gmail.com');
INSERT INTO reply(replyno, createsno, crewno, content,  rdate, id)
VALUES(reply_seq.nextval, 12, 14, '댓글3', sysdate, 'user1@gmail.com'); 

-- 전체 목록
SELECT replyno, createsno, crewno, content, rdate, id
FROM reply
ORDER BY replyno DESC;

       
  
-- SELECT 조회
SELECT replyno, createsno, crewno, content, rdate, id
FROM reply
WHERE replyno = 1;  

   
-- 삭제
DELETE FROM reply
WHERE replyno=1;

-- createsno에 해당하는 댓글 수 확인 및 삭제
SELECT replyno, createsno, crewno, content, rdate, id
FROM reply
WHERE createsno=7;

DELETE FROM reply
WHERE createsno=5;

-- crewno에 해당하는 댓글 수 확인 및 삭제
SELECT replyno, createsno, crewno, content, rdate, id
FROM reply
WHERE crewno=1;

DELETE FROM reply
WHERE crewno=14;
 
--댓글 회원 아이디 출력
SELECT r.replyno, r.createsno, r.crewno, r.content, r.rdate, c.id
FROM reply r, crew c
WHERE createsno=7 AND (r.crewno = c.crewno)
ORDER BY r.replyno DESC;

--페이징

SELECT *
FROM reply;


-- 삭제
DELETE FROM reply
WHERE createsno=7;

commit;
