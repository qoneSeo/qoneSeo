DROP TABLE HDAY;

CREATE TABLE HDAY(
    HDAYNO     NUMBER(7)     NOT NULL, -- 등록 번호
    HcrewNO     NUMBER(7)     NOT NULL, -- 회원 번호
    RDATE      DATE          NOT NULL, -- 출석일    
    PRIMARY KEY (HDAYNO),              -- 한번 등록된 값은 중복 안됨
    FOREIGN KEY (HcrewNO) REFERENCES Hcrew (HcrewNO)
);

COMMENT ON TABLE HDAY is '헬스 출석 정보';
COMMENT ON COLUMN HDAY.HDAYNO is '헬스 출석 정보 번호';
COMMENT ON COLUMN HDAY.HcrewNO is '헬스 회원 번호';
COMMENT ON COLUMN HDAY.RDATE is '출석일';

DROP SEQUENCE HDAY_SEQ;

CREATE SEQUENCE HDAY_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999          -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

INSERT INTO hday(hdayno, hcrewno, rdate) VALUES(HDAY_SEQ.nextval, 1, sysdate);

SELECT hdayno, hcrewno, rdate FROM hday ORDER BY hdayno ASC;
    HDAYNO     HcrewNO RDATE              
---------- ---------- -------------------
         2          1 2023-09-15 03:39:39
         
DELETE FROM hday WHERE hdayno=2;

COMMIT;

