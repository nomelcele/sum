-- 0530 까지 쿼리

CREATE TABLE dept(
	denum NUMBER(3),
    dename VARCHAR2(20) CONSTRAINT dept_dename_nn NOT NULL,
    CONSTRAINT dept_denum_pk PRIMARY KEY(denum)
);

INSERT INTO DEPT VALUES(100,'인사부');
INSERT INTO DEPT VALUES(200,'총무부');
INSERT INTO DEPT VALUES(300,'영업부');
INSERT INTO DEPT VALUES(400,'전산부');
INSERT INTO DEPT VALUES(500,'기획부');

CREATE TABLE member(
	memnum NUMBER(5), -- 사원번호 pk
    memname VARCHAR2(30), -- 사원이름 nn
    memaddr VARCHAR2(300), -- 사원주소 nn
    mempwd VARCHAR2(20),
    memprofile VARCHAR2(30),-- 사원사진 nn
    memjob VARCHAR2(20) DEFAULT '일반',
    memauth NUMBER(1), -- 사원권한
    memmail VARCHAR2(50)  CONSTRAINT member_meminmail_nn NOT NULL, -- 사원 외부 메일 uq
    meminmail VARCHAR2(50),
    memmgr NUMBER(5), -- 사원상급자 fk
    memdept NUMBER(3), -- 부서 번호 fk
    CONSTRAINT member_memnum_pk PRIMARY KEY(memnum),
    CONSTRAINT member_meminmail_uq UNIQUE(meminmail),
    CONSTRAINT member_memmgr_fk FOREIGN KEY(memmgr) REFERENCES member(memnum),
    CONSTRAINT member_memdept_fk FOREIGN KEY(memdept) REFERENCES dept(denum)
);

create sequence member_seq increment by 1 start with 10000;

INSERT INTO MEMBER VALUES
(member_seq.nextVal,'김명준', '서울','1004','kmj.jpg','대표이사',1,'kmj85skier@naver.com','mjkim',NULL,100);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'김주상', '경기','1004','kjs.jpg','이사',2,'kjs@naver.com','jskim',10000,100);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'홍명표', '성남','1004','hmp.jpg','부장',3,'hmp@naver.com','mphong',10001,100);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'김성호', '대구','1004','ksh.jpg','팀장',4,'ksh@naver.com','shkim',10002,100);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'모하람', '대전','1004','mhr.jpg','사원',5,'mhr@naver.com','hrmo',10000,200);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'김영은', '부산','1004','kye.jpg','사원',5,'kye@naver.com','yekim',10000,300);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'안지영', '목성','1004','ajy.jpg','사원',5,'ajy@naver.com','jyan',10003,100);



CREATE TABLE calendar(
	calnum NUMBER(11), -- 일정번호 pk
	calstart DATE CONSTRAINT calendar_calstart_nn NOT NULL,-- 일정시작
    calend DATE, -- 일정시작
    calcont VARCHAR2(100) CONSTRAINT calendar_calcont_nn NOT NULL, -- 일정내용
    caldept NUMBER(3), -- 부서 일정 fk
    calmem NUMBER(5), -- 사원일정 fk
    CONSTRAINT calendar_calnum_pk PRIMARY KEY(calnum),
    CONSTRAINT calendar_caldept_fk FOREIGN KEY(caldept) REFERENCES dept(denum)
    on delete set null,
    CONSTRAINT calendar_calmem_fk FOREIGN KEY(calmem) REFERENCES member(memnum)
    on delete cascade
);

CREATE SEQUENCE calendar_seq INCREMENT BY 1 START WITH 1;


CREATE TABLE board(
	bnum number(11), -- 글번호
    btitle VARCHAR2(50) CONSTRAINT board_btitle_nn NOT NULL, -- 글제목
    bcont CLOB, -- 글내용
    bimg VARCHAR2(50), --
    bmem NUMBER(5),
    bdate DATE CONSTRAINT board_bdate_nn NOT NULL,
    bhit number(11),
    bgnum NUMBER(4) CONSTRAINT board_bgnum_nn NOT NULL, -- 게시판 index 번호
    bdeptno NUMBER(3),
    CONSTRAINT board_bnum_pk PRIMARY KEY(bnum),
    CONSTRAINT board_bmem_fk FOREIGN KEY(bmem) REFERENCES member(memnum) on delete set null,
    constraint board_bdeptno_fk foreign key(bdeptno) references dept(denum)
);
--0529 테이블 추가
create table bname(
	bname varchar2(30),
	bgnum number(4),
	bdeptno number(3),
	constraint bname_bgnum_pk primary key(bgnum),
	constraint bname_bdeptno_fk foreign key(bdeptno) references dept(denum)
);


DROP TABLE BOARD;
INSERT INTO BOARD VALUES(0,'test','This is testContent','img.jpg',10000,SYSDATE,0,1);
INSERT INTO BOARD VALUES(1,'test','This is testContent','img.jpg',10002,SYSDATE,0,1);
INSERT INTO BOARD VALUES(2,'test','This is testContent','img.jpg',10003,SYSDATE,0,1);
INSERT INTO BOARD VALUES(3,'test','This is testContent','img.jpg',10005,SYSDATE,0,1);
INSERT INTO BOARD VALUES(4,'test','This is testContent','img.jpg',10002,SYSDATE,0,1);
INSERT INTO BOARD VALUES(5,'test','This is testContent','img.jpg',10003,SYSDATE,0,1);
INSERT INTO BOARD VALUES(6,'test','This is testContent','img.jpg',10004,SYSDATE,0,1);

CREATE SEQUENCE board_seq INCREMENT BY 1 START WITH 7;

COMMIT;

-- 0526 변경
-- 메일 삭제 여부를 확인하기 위한 컬럼
-- 1: 기본값, 2: 보낸 사람이 메일 삭제(메일이 보낸 사람의 휴지통으로 이동),
-- 3: 보낸 사람이 메일 영구 삭제
-- 1: 기본값, 2: 받은 사람이 메일 삭제(메일이 받은 사람의 휴지통으로 이동),
-- 3: 받은 사람이 메일 영구 삭제

CREATE TABLE mail(
	mailnum NUMBER(11), -- pk
    mailtitle VARCHAR2(50) CONSTRAINT mail_mailtitle_nn NOT NULL,
    mailcont CLOB,
    mailfile VARCHAR2(50),
    mailmem NUMBER(5), -- fk
    mailreceiver varchar2(50), -- fk
    maildate DATE,
    mailsdelete number(1),
    mailrdelete number(1),
    CONSTRAINT mail_mailnum_pk PRIMARY KEY(mailnum),
    CONSTRAINT mail_mailmem_fk
    FOREIGN KEY(mailmem) REFERENCES member(memnum) on delete set null,
    CONSTRAINT mail_mailreceiver_fk
    FOREIGN KEY(mailreceiver) REFERENCES member(meminmail) on delete set null
);

create sequence mail_seq increment by 1 start with 1;

CREATE TABLE administer(
	adnum NUMBER(3),  -- 관리자 번호 pk
    adgrade NUMBER(2) CONSTRAINT admin_adgrade_nn NOT NULL, -- 관리자 등급 not null
    admem NUMBER(5), -- 사원넘버 fk
    CONSTRAINT admin_adnum_pk PRIMARY KEY(adnum),
    CONSTRAINT admin_admem_fk FOREIGN KEY(admem) REFERENCES member(memnum)
);


CREATE TABLE login(
	lonum NUMBER(11), -- 번호 pk
    locheck VARCHAR2(1), -- 최초 로그인 결정
    lostdate DATE, -- 로그인 시작 시간.
    loendate DATE, -- 로그인 종료 시간.
    lomem NUMBER(5), -- fk member.memnum
 	CONSTRAINT login_lonum_pk PRIMARY KEY(lonum),
    CONSTRAINT login_lomem_fk FOREIGN KEY(lomem) REFERENCES MEMBER(memnum)
    on delete cascade
);

CREATE SEQUENCE login_seq INCREMENT BY 1 START WITH 1;

CREATE TABLE todo(
	tonum NUMBER(11), -- 번호 pk
    tostdate DATE, -- 업무시작 날짜
    toendate DATE,  -- 업무 종료 날짜
    totitle VARCHAR2(50), -- 업무 제목
    tocont VARCHAR2(200), -- 업무 내용
    tofile VARCHAR2(100), -- 상세내용 첨부 파일명
    todept number(3), -- 업무 담당 부서 fk dept.denum
    tomem NUMBER(5), -- 업무 담당 부서 아래 담당팀 fk
    toconfirm VARCHAR2(4),
    tocomm VARCHAR2(200),
    constraint todo_tonum_pk PRIMARY KEY(tonum),
    constraint todo_todept_fk FOREIGN KEY(todept) REFERENCES dept(denum)
    ON DELETE SET NULL,
    CONSTRAINT todo_tomem_fk FOREIGN KEY(tomem) REFERENCES member(memnum)
    ON DELETE SET NULL
);

CREATE SEQUENCE todo_seq INCREMENT BY 1 START WITH 1;

CREATE TABLE sns(
	snum number(10), -- pk
	scont VARCHAR2(600),
    simg VARCHAR2(40),
    sdate DATE,
    sdept NUMBER(3), -- fk dept.denum
    smem NUMBER(5), -- fk member.memnum
    CONSTRAINT sns_snum_pk PRIMARY KEY(snum),
    CONSTRAINT sns_smem_fk FOREIGN KEY(smem) REFERENCES MEMBER(memnum) on delete set null,
    CONSTRAINT sns_sdept_fk FOREIGN KEY(sdept) REFERENCES DEPT(denum) on delete set null
);

create sequence sns_seq increment by 1 start with 1;

CREATE TABLE comm(
	conum NUMBER(11),
    cocont VARCHAR2(600),
    codate DATE, -- coicon VARCHAR2(40), 2015.05.26 에 칼럼 삭제함.
    comem NUMBER(5), -- fk member.memnum
    coboard NUMBER(11), -- fk board.bnum
    commsns number(10),
    constraint comm_commsns_fk foreign key(commsns) references sns(snum) on delete cascade,
    CONSTRAINT comm_conum_pk PRIMARY KEY(conum),
    CONSTRAINT comm_comem_fk FOREIGN KEY(comem) REFERENCES MEMBER(memnum) on delete cascade,
    CONSTRAINT comm_coboard_fk FOREIGN KEY(coboard) REFERENCES board(bnum) on delete cascade
);


create sequence comm_seq INCREMENT BY 1 START WITH 1;

-- 0526 추가함. ---------------------------------------------------------------------
INSERT INTO COMM VALUES(COMM_SEQ.NEXTVAL,'This is comment',SYSDATE, 10000, 67);
INSERT INTO COMM VALUES(COMM_SEQ.NEXTVAL,'This is comment2',SYSDATE, 10001, 67);
INSERT INTO COMM VALUES(COMM_SEQ.NEXTVAL,'This is comment3',SYSDATE, 10002, 67);
INSERT INTO COMM VALUES(COMM_SEQ.NEXTVAL,'This is comment4',SYSDATE, 10003, 67);
INSERT INTO COMM VALUES(COMM_SEQ.NEXTVAL,'This is comment5',SYSDATE, 10004, 67);
INSERT INTO COMM VALUES(COMM_SEQ.NEXTVAL,'This is comment6',SYSDATE, 10002, 50);
INSERT INTO COMM VALUES(COMM_SEQ.NEXTVAL,'This is comment7',SYSDATE, 10002, 50);
INSERT INTO COMM VALUES(COMM_SEQ.NEXTVAL,'This is comment8',SYSDATE, 10001, 50);
------------------------------------------------------------------------------------
-----0526 업무별 사원들에게 업무부여하기 위한 테이블과 시퀀스 생성

create table todojob(
	jobnum NUMBER(11) constraint todojob_jobnum_pk primary key,
	jobtonum NUMBER(11),
	jobmemnum NUMBER(5),
	jobcont VARCHAR2(100),
	constraint todojob_jobtonum_fk foreign key(jobtonum) references todo(tonum) on delete cascade,
	constraint todojob_jobmemnum_fk foreign key(jobmemnum) references member(memnum) on delete set null
);

create sequence todojob_seq increment by 1 start with 1;

-- 0527 기존 messenger table 삭제 후 아래 messenger table 생성 
create table mesmaster(
  masnum number(10),
  masstdate date,
  masendate date,
  masreip varchar2(15),
  constraint mesmaster_masnum_pk primary key(masnum)
);

create sequence mesmaster_seq increment by 1 start with 1;  

----------------------------------------
create table mesentry(
  mesnum number(10),
  mesmember number(10),
  openmemberyn varchar2(10) default 'N',
  entstdate date,
  entendate date,
  mesreip varchar2 (15),
  mesendnum number (10), -- 보낸 사람 사번
  primary key(mesnum,mesmember)
);

create table mescontent(
	  conum number(10),
	  mesconum number(10), -- 방번호
	  meswriternum number(10),
	  mescont varchar2(200) constraint mescontent_mescont_nn not null,
	  constraint mescontent_conum_pk primary key(conum),
	  constraint mescontent_mesconum_fk foreign key(mesconum) references mesmaster(masnum)
);
  
create sequence mescontent_seq increment by 1 start with 1;

commit;