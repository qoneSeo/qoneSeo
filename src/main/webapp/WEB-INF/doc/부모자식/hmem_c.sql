DROP TABLE Hcrew;

CREATE TABLE Hcrew(
    HcrewNO     NUMBER(7)     NOT NULL,
    MNAME      VARCHAR(15)   NOT NULL, -- 성명, 한글 10자 저장 가능
    PRIMARY KEY (HcrewNO)               -- 한번 등록된 값은 중복 안됨
);

COMMENT ON TABLE Hcrew is '헬스 회원';
COMMENT ON COLUMN Hcrew.HcrewNO is '헬스 회원 번호';
COMMENT ON COLUMN Hcrew.MNAME is '성명';

DROP SEQUENCE Hcrew_SEQ;

CREATE SEQUENCE Hcrew_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999          -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

INSERT INTO hcrew(hcrewno, mname) VALUES(Hcrew_SEQ.nextval, '휴그랜트');

SELECT hcrewno, mname FROM hcrew ORDER BY hcrewno ASC;
    HcrewNO MNAME          
---------- ---------------
         1 휴그랜트       

DELETE FROM hcrew WHERE hcrewno=1;

COMMIT;

