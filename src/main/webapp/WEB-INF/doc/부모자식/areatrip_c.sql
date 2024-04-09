DROP TABLE AREATRIP;

CREATE TABLE AREATRIP(
    AREATRIPNO  NUMBER(7)    NOT NULL,  -- 여행 정보 번호
    AREANO      NUMBER(7)    NOT NULL,  -- 지역 번호
    TITLE       VARCHAR(20)  NOT NULL,  -- 여행지 제목
    RDATE       DATE         NOT NULL,  -- 등록일    
    PRIMARY KEY (AREATRIPNO),           -- 한번 등록된 값은 중복 안됨
    FOREIGN KEY (AREANO) REFERENCES AREA (AREANO)
);

COMMENT ON TABLE AREATRIP is '여행 정보';
COMMENT ON COLUMN AREATRIP.AREATRIPNO is '여행 정보 번호';
COMMENT ON COLUMN AREATRIP.AREANO is '지역 번호';
COMMENT ON COLUMN AREATRIP.TITLE is '여행지 제목';
COMMENT ON COLUMN AREATRIP.RDATE is '등록일';

DROP SEQUENCE AREATRIP_SEQ;

CREATE SEQUENCE AREATRIP_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999          -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

-- areatrip 테이블에 areano 컬럼의 값이 1인 레코드를 1건 등록 할 것.
INSERT INTO areatrip (areatripno, areano, title, rdate)
VALUES(AREATRIP_SEQ.nextval, 1, '차박 캠핑', sysdate);

INSERT INTO areatrip (areatripno, areano, title, rdate)
VALUES(AREATRIP_SEQ.nextval, 2, '계곡', sysdate);

INSERT INTO areatrip (areatripno, areano, title, rdate)
VALUES(AREATRIP_SEQ.nextval, 3, '카페', sysdate);

DELETE FROM areatrip WHERE areano=3;

SELECT * FROM areatrip;
AREATRIPNO     AREANO TITLE                RDATE              
---------- ---------- -------------------- -------------------
         1          1 차박 캠핑            2023-09-18 11:18:17
         2          2 계곡                 2023-09-18 11:18:17             계곡  
         
DELETE FROM areatrip WHERE areano=2;
DELETE FROM areatrip WHERE areano=1;


  