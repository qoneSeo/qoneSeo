DROP TABLE SKGRP;

CREATE TABLE SKGRP(
    SKGRPNO    NUMBER(7)    NOT NULL, -- 날짜 그룹 번호
    SKGRPNAME  DATE         NOT NULL, -- 분류명
    PRIMARY KEY (SKGRPNO)
);

COMMENT ON TABLE SKGRP is '날짜 그룹';
COMMENT ON COLUMN SKGRP.SKGRPNO is '날짜 그룹 번호';
COMMENT ON COLUMN SKGRP.SKGRPNAME is '분류명';

DROP SEQUENCE skgrp_seq;

CREATE SEQUENCE skgrp_seq
  START WITH 1            -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999        -- 최대값: 9999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지
  
--INSERT 
INSERT INTO skgrp(skgrpno,skgrpname) VALUES (skgrp_seq.nextval,'2023-09-20');
INSERT INTO skgrp(skgrpno,skgrpname) VALUES (skgrp_seq.nextval,'2023-09-21');
INSERT INTO skgrp(skgrpno,skgrpname) VALUES (skgrp_seq.nextval,'2023-09-22');

--SELECT 
SELECT * FROM SKGRP;

   SKGRPNO SKGRPNAME          
---------- -------------------
         1 2023-09-20 12:00:00
         2 2023-09-21 12:00:00
         3 2023-09-22 12:00:00        

-- DELETE
DELETE skgrp WHERE skgrpno=3;
DELETE skgrp WHERE skgrpno=2;
DELETE skgrp WHERE skgrpno=1;

SELECT * FROM skgrp;

