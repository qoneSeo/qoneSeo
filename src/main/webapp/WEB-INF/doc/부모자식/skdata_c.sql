DROP TABLE SKDATA;

CREATE TABLE SKDATA(
    SKDATANO   NUMBER(7)     NOT NULL, -- 일정 정보 번호
    SKGRPNO    NUMBER(7)     NOT NULL, -- 날짜 그룹 번호
    TITLE      VARCHAR(40)   NOT NULL, -- 제목
    RDATE      DATE          NOT NULL, -- 등록일    
    PRIMARY KEY (SKDATANO),          -- 한번 등록된 값은 중복 안됨
    FOREIGN KEY (SKGRPNO) REFERENCES SKGRP (SKGRPNO)
);

COMMENT ON TABLE SKDATA is '일정 정보';
COMMENT ON COLUMN SKDATA.SKDATANO is '일정 정보 번호';
COMMENT ON COLUMN SKDATA.SKGRPNO is '날짜 그룹 번호';
COMMENT ON COLUMN SKDATA.TITLE is '상호';
COMMENT ON COLUMN SKDATA.RDATE is '등록일';

DROP SEQUENCE skdata_seq;

CREATE SEQUENCE skdata_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999          -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

-- INSERT 
INSERT INTO skdata(SKDATANO,SKGRPNO,TITLE,RDATE)
VALUES (skdata_seq.nextval,1,'관악산 등산',sysdate);

INSERT INTO skdata(SKDATANO,SKGRPNO,TITLE,RDATE)
VALUES (skdata_seq.nextval,2,'게임 모임 참여',sysdate);

INSERT INTO skdata(SKDATANO,SKGRPNO,TITLE,RDATE)
VALUES (skdata_seq.nextval,3,'석촌호수 맛집 모임',sysdate);

INSERT INTO skdata(SKDATANO,SKGRPNO,TITLE,RDATE)
VALUES (skdata_seq.nextval,3,'악마는 프라다를 입는다.시청',sysdate);

--SELECT
SELECT * FROM skdata;
  SKDATANO    SKGRPNO TITLE                                    RDATE              
---------- ---------- ---------------------------------------- -------------------
         1          1 관악산 등산                              2023-09-18 01:14:34
         2          2 게임 모임 참여                           2023-09-18 01:14:34
         3          3 석촌호수 맛집 모임                       2023-09-18 01:14:34
         4          3 악마는 프라다를 입는다.시청              2023-09-18 01:14:34

DELETE skdata WHERE skgrpno=3;
DELETE skdata WHERE skgrpno=2;
DELETE skdata WHERE skgrpno=1;

SELECT * FROM skdata;

