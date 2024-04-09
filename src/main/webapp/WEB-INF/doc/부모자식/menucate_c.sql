DROP TABLE MENUCATE;
-- 개발자용, 자식 테이블 무시
DROP TABLE MENUCATE CASCADE CONSTRAINTS;

CREATE TABLE MENUCATE(
    MENUcfoodno NUMBER(7)    NOT NULL, -- 메뉴 그룹 번호
    ANAME      VARCHAR(20)  NOT NULL, -- 분류명
    PRIMARY KEY (MENUcfoodno)
);

COMMENT ON TABLE MENUCATE is '메뉴그룹';
COMMENT ON COLUMN MENUCATE.areano is '메뉴 그룹 번호';
COMMENT ON COLUMN MENUCATE.aname is '분류명';

DROP SEQUENCE menucate_seq;

CREATE SEQUENCE menucate_seq
  START WITH 1            -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999        -- 최대값: 9999999 --> NUMBER(10) 대응
  CACHE 2                 -- 2번은 메모리에서만 계산
  NOCYCLE;                -- 다시 1부터 생성되는 것을 방지


INSERT INTO MENUCATE(MENUcfoodno, aname) VALUES(menucate_seq.nextval, '한식');  
INSERT INTO MENUCATE(MENUcfoodno, aname) VALUES(menucate_seq.nextval, '중식');
INSERT INTO MENUCATE(MENUcfoodno, aname) VALUES(menucate_seq.nextval, '양식');
SELECT * FROM MENUCATE;
MENUcfoodno ANAME               
---------- --------------------
         1 한식                
         2 중식                
         3 양식        
         
DELETE FROM MENUCATE WHERE MENUcfoodno=3;

SELECT * FROM MENUCATE;
MENUcfoodno ANAME               
---------- --------------------
         1 한식                
         2 중식    

DELETE FROM MENUCATE WHERE MENUcfoodno=2;
DELETE FROM MENUCATE WHERE MENUcfoodno=1;



