/**********************************/
/* Table Name: 관리자 */
/**********************************/
CREATE TABLE MANAGE(
		MANAGENO                      		NUMBER(5)		 NOT NULL		 PRIMARY KEY,
		ID                            		VARCHAR2(20)		 NOT NULL,
		PASSWD                        		VARCHAR2(15)		 NOT NULL,
		MNAME                         		VARCHAR2(20)		 NOT NULL,
		MDATE                         		DATE		 NOT NULL,
		GRADE                         		NUMBER(2)		 NOT NULL,
  CONSTRAINT SYS_C007060 UNIQUE (ID)
);

COMMENT ON TABLE MANAGE is '관리자';
COMMENT ON COLUMN MANAGE.MANAGENO is '관리자 번호';
COMMENT ON COLUMN MANAGE.ID is '아이디';
COMMENT ON COLUMN MANAGE.PASSWD is '패스워드';
COMMENT ON COLUMN MANAGE.MNAME is '성명';
COMMENT ON COLUMN MANAGE.MDATE is '가입일';
COMMENT ON COLUMN MANAGE.GRADE is '등급';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE CREW(
		CREWNO                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ID                            		VARCHAR2(30)		 NOT NULL,
		PASSWD                        		VARCHAR2(60)		 NOT NULL,
		NAME                          		VARCHAR2(30)		 NOT NULL,
		TEL                           		VARCHAR2(14)		 NOT NULL,
		ZIPCODE                       		VARCHAR2(5)		 NULL ,
		ADDRESS1                      		VARCHAR2(80)		 NULL ,
		ADDRESS2                      		VARCHAR2(50)		 NULL ,
		CDATE                         		DATE		 NOT NULL,
		GRADE                         		NUMBER(2)		 NOT NULL,
		REPLYNO                       		NUMBER(10)		 NULL ,
		GOOD                          		NUMBER(10)		 NULL ,
  CONSTRAINT SYS_C007411 UNIQUE (ID)
);

COMMENT ON TABLE CREW is '회원';
COMMENT ON COLUMN CREW.CREWNO is '회원 번호';
COMMENT ON COLUMN CREW.ID is '아이디';
COMMENT ON COLUMN CREW.PASSWD is '패스워드';
COMMENT ON COLUMN CREW.NAME is '성명';
COMMENT ON COLUMN CREW.TEL is '전화번호';
COMMENT ON COLUMN CREW.ZIPCODE is '우편번호';
COMMENT ON COLUMN CREW.ADDRESS1 is '주소1';
COMMENT ON COLUMN CREW.ADDRESS2 is '주소2';
COMMENT ON COLUMN CREW.CDATE is '가입일';
COMMENT ON COLUMN CREW.GRADE is '등급';
COMMENT ON COLUMN CREW.REPLYNO is '댓글 번호';
COMMENT ON COLUMN CREW.GOOD is '좋아요 번호';


/**********************************/
/* Table Name: 메뉴카테고리 */
/**********************************/
CREATE TABLE FOOD(
		CFOODNO                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		NAME                          		VARCHAR2(30)		 NOT NULL,
		CNT                           		NUMBER(7)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
		SEQNO                         		NUMBER(5)		 NOT NULL,
		VISIBLE                       		CHAR(1)		 NOT NULL
);

COMMENT ON TABLE FOOD is '메뉴카테고리';
COMMENT ON COLUMN FOOD.CFOODNO is '음식 번호';
COMMENT ON COLUMN FOOD.NAME is '음식 이름';
COMMENT ON COLUMN FOOD.CNT is '관련 자료수';
COMMENT ON COLUMN FOOD.RDATE is '등록일';
COMMENT ON COLUMN FOOD.SEQNO is '출력 순서';
COMMENT ON COLUMN FOOD.VISIBLE is '출력 모드';


/**********************************/
/* Table Name: FOOD-컨텐츠 */
/**********************************/
CREATE TABLE CREATES(
		CREATESNO                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MANAGENO                      		NUMBER(10)		 NOT NULL,
		CFOODNO                       		NUMBER(10)		 NOT NULL,
		TITLE                         		VARCHAR2(50)		 NOT NULL,
		CONTENT                       		CLOB(4000)		 NOT NULL,
		GOOD                          		NUMBER(7)		 NOT NULL,
		CNT                           		NUMBER(7)		 NOT NULL,
		REPLYCNT                      		NUMBER(7)		 NOT NULL,
		PASSWD                        		VARCHAR2(15)		 NOT NULL,
		WORD                          		VARCHAR2(50)		 NULL ,
		RDATE                         		DATE		 NOT NULL,
		FILE1                         		VARCHAR2(50)		 NULL ,
		FILE1SAVED                    		VARCHAR2(50)		 NULL ,
		THUMB1                        		VARCHAR2(50)		 NULL ,
		SIZE1                         		NUMBER(10)		 NULL ,
		POINT                         		NUMBER(10)		 NULL ,
		MAP                           		VARCHAR2(1000)		 NULL ,
		YOUTUBE                       		VARCHAR2(1000)		 NULL ,
  FOREIGN KEY (CFOODNO) REFERENCES FOOD (CFOODNO),
  FOREIGN KEY (MANAGENO) REFERENCES MANAGE (MANAGENO)
);

COMMENT ON TABLE CREATES is 'FOOD-컨텐츠';
COMMENT ON COLUMN CREATES.CREATESNO is '컨텐츠 번호';
COMMENT ON COLUMN CREATES.MANAGENO is '관리자 번호';
COMMENT ON COLUMN CREATES.CFOODNO is '음식 번호';
COMMENT ON COLUMN CREATES.TITLE is '제목';
COMMENT ON COLUMN CREATES.CONTENT is '내용';
COMMENT ON COLUMN CREATES.GOOD is '추천수';
COMMENT ON COLUMN CREATES.CNT is '조회수';
COMMENT ON COLUMN CREATES.REPLYCNT is '댓글수';
COMMENT ON COLUMN CREATES.PASSWD is '패스워드';
COMMENT ON COLUMN CREATES.WORD is '검색어';
COMMENT ON COLUMN CREATES.RDATE is '등록일';
COMMENT ON COLUMN CREATES.FILE1 is '메인 이미지';
COMMENT ON COLUMN CREATES.FILE1SAVED is '실제 저장된 메인 이미지';
COMMENT ON COLUMN CREATES.THUMB1 is '메인 이미지 Preview';
COMMENT ON COLUMN CREATES.SIZE1 is '메인 이미지 크기';
COMMENT ON COLUMN CREATES.POINT is '포인트';
COMMENT ON COLUMN CREATES.MAP is '지도';
COMMENT ON COLUMN CREATES.YOUTUBE is 'Youtube 영상';


/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE REPLY(
		REPLYNO                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		CREWNO                        		NUMBER(10)		 NULL ,
		CREATESNO                     		NUMBER(10)		 NULL ,
		REPLY                         		CLOB(2000)		 NULL ,
		DATE                          		TIMESTAMP(10)		 NULL ,
  FOREIGN KEY (CREATESNO) REFERENCES CREATES (CREATESNO),
  FOREIGN KEY (CREWNO) REFERENCES CREW (CREWNO)
);

COMMENT ON TABLE REPLY is '댓글';
COMMENT ON COLUMN REPLY.REPLYNO is '댓글 번호';
COMMENT ON COLUMN REPLY.CREWNO is '회원 번호';
COMMENT ON COLUMN REPLY.CREATESNO is '컨텐츠 번호';
COMMENT ON COLUMN REPLY.REPLY is '댓글';
COMMENT ON COLUMN REPLY.DATE is '날짜';


/**********************************/
/* Table Name: 공지사항 */
/**********************************/
CREATE TABLE NOTICE(
		NOTICENO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MANAGENO                      		NUMBER(5)		 NULL ,
		TITLE                         		VARCHAR2(10)		 NOT NULL,
		CONTENT                       		CLOB(10)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
  FOREIGN KEY (MANAGENO) REFERENCES MANAGE (MANAGENO)
);

COMMENT ON TABLE NOTICE is '공지사항';
COMMENT ON COLUMN NOTICE.NOTICENO is '공지사항 번호';
COMMENT ON COLUMN NOTICE.MANAGENO is '관리자 번호';
COMMENT ON COLUMN NOTICE.TITLE is '제목';
COMMENT ON COLUMN NOTICE.CONTENT is '내용';
COMMENT ON COLUMN NOTICE.RDATE is '등록일';


/**********************************/
/* Table Name: 관리자 로그인 내역 */
/**********************************/
CREATE TABLE MLOGIN(
		MLOGINNO                      		NUMBER(10)		 NULL 		 PRIMARY KEY,
		MANAGENO                      		NUMBER(10)		 NOT NULL,
		IP                            		VARCHAR2(15)		 NULL ,
		LOGINDATE                     		TIMESTAMP(10)		 NULL ,
  FOREIGN KEY (MANAGENO) REFERENCES MANAGE (MANAGENO)
);

COMMENT ON TABLE MLOGIN is '관리자 로그인 내역';
COMMENT ON COLUMN MLOGIN.MLOGINNO is '로그인 번호';
COMMENT ON COLUMN MLOGIN.MANAGENO is '관리자 번호';
COMMENT ON COLUMN MLOGIN.IP is '접속 IP';
COMMENT ON COLUMN MLOGIN.LOGINDATE is '로그인 날짜';


/**********************************/
/* Table Name: 회원 로그인 내역 */
/**********************************/
CREATE TABLE CLOGIN(
		CLOGINNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		CREWNO                        		NUMBER(10)		 NULL ,
		IP                            		VARCHAR2(15)		 NULL ,
		LOGINDATE                     		TIMESTAMP(10)		 NULL ,
  FOREIGN KEY (CREWNO) REFERENCES CREW (CREWNO)
);

COMMENT ON TABLE CLOGIN is '회원 로그인 내역';
COMMENT ON COLUMN CLOGIN.CLOGINNO is '로그인 번호';
COMMENT ON COLUMN CLOGIN.CREWNO is '회원 번호';
COMMENT ON COLUMN CLOGIN.IP is '접속 IP';
COMMENT ON COLUMN CLOGIN.LOGINDATE is '로그인 날짜';


