DROP TABLE MENUDATA;

CREATE TABLE MENUDATA(
    MENUDATANO  NUMBER(7)    NOT NULL,  -- 메뉴 정보 번호
    MENUcfoodno  NUMBER(7)    NOT NULL,  -- 메뉴 그룹 번호
    TITLE       VARCHAR(30)  NOT NULL,  -- 상호
    RDATE       DATE         NOT NULL,  -- 등록일    
    PRIMARY KEY (MENUDATANO),           -- 한번 등록된 값은 중복 안됨
    FOREIGN KEY (MENUcfoodno) REFERENCES MENUCATE (MENUcfoodno)
);

COMMENT ON TABLE MENUDATA is '메뉴 정보';
COMMENT ON COLUMN MENUDATA.MENUDATANO is '메뉴 그룹 번호';
COMMENT ON COLUMN MENUDATA.MENUcfoodno is '분류명';
COMMENT ON COLUMN MENUDATA.TITLE is '상호';
COMMENT ON COLUMN MENUDATA.RDATE is '등록일';

DROP SEQUENCE MENUDATA_SEQ;

CREATE SEQUENCE MENUDATA_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999          -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

-- areatrip 테이블에 areano 컬럼의 값이 1인 레코드를 1건 등록 할 것.
INSERT INTO MENUDATA (MENUDATANO, MENUcfoodno, title, rdate)
VALUES(MENUDATA_SEQ.nextval, 1, '시골 한정식', sysdate);

INSERT INTO MENUDATA (MENUDATANO, MENUcfoodno, title, rdate)
VALUES(MENUDATA_SEQ.nextval, 2, '짜장면', sysdate);

INSERT INTO MENUDATA (MENUDATANO, MENUcfoodno, title, rdate)
VALUES(MENUDATA_SEQ.nextval, 3, '돈까스', sysdate);

SELECT * FROM menudata;
MENUDATANO MENUcfoodno TITLE                          RDATE              
---------- ---------- ------------------------------ -------------------
         1          1 시골 한정식                    2023-09-18 12:14:30
         2          2 짜장면                         2023-09-18 12:14:30
         3          3 돈까스                         2023-09-18 12:14:30

DELETE FROM MENUDATA WHERE MENUDATANO=3;

SELECT * FROM MENUDATA;
         계곡  
         
DELETE FROM MENUDATA WHERE MENUDATANO=2;
DELETE FROM MENUDATA WHERE MENUDATANO=1;


  