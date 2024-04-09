DROP TABLE AREA;
-- 개발자용, 자식 테이블 무시
DROP TABLE AREA CASCADE CONSTRAINTS;

CREATE TABLE AREA(
    AREANO   NUMBER(7)    NOT NULL, -- 지역 번호
    ANAME    VARCHAR(20)  NOT NULL, -- 지역명
    PRIMARY KEY (AREANO)
);

COMMENT ON TABLE AREA is '지역';
COMMENT ON COLUMN AREA.areano is '지역 번호';
COMMENT ON COLUMN AREA.aname is '지역명';

DROP SEQUENCE area_seq;

CREATE SEQUENCE area_seq
  START WITH 1            -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999        -- 최대값: 9999999 --> NUMBER(10) 대응
  CACHE 2                 -- 2번은 메모리에서만 계산
  NOCYCLE;                -- 다시 1부터 생성되는 것을 방지


INSERT INTO area(areano, aname) VALUES(area_seq.nextval, '홍천');  
INSERT INTO area(areano, aname) VALUES(area_seq.nextval, '가평');
INSERT INTO area(areano, aname) VALUES(area_seq.nextval, '청평');

DELETE FROM area WHERE areano=3;

SELECT * FROM area;

DELETE FROM area WHERE areano=2;
DELETE FROM area WHERE areano=1;



