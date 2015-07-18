DROP TABLE TODOJOB;
DROP TABLE TODO;
DROP TABLE mail;
DROP TABLE COMM;
DROP TABLE BOARD;
DROP TABLE BNAME;
DROP TABLE CALENDAR;
DROP TABLE LOGIN;
DROP TABLE MESCONTENT;
DROP TABLE MESENTRY;
DROP TABLE MESMASTER;
DROP TABLE administrator;
DROP TABLE pay;
DROP TABLE payhistory;
DROP TABLE signstep;
DROP TABLE signature;
DROP TABLE signform;
DROP TABLE commission;
drop table zzim;
DROP TABLE product;
DROP TABLE SNS;
DROP TABLE MEMBER;
DROP TABLE DEPT;
DROP SEQUENCE TODO_SEQ;
DROP SEQUENCE zzim_SEQ;
DROP SEQUENCE todojob_seq;
DROP SEQUENCE SNS_SEQ;
DROP SEQUENCE MESCONTENT_SEQ;
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE MAIL_SEQ;
DROP SEQUENCE LOGIN_SEQ;
DROP SEQUENCE COMM_SEQ;
DROP SEQUENCE CALENDAR_SEQ;
DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE BNAME_SEQ;
DROP SEQUENCE MESMASTER_seq;
DROP SEQUENCE signform_seq;
DROP sequence commission_seq;
DROP SEQUENCE product_seq;
DROP SEQUENCE signature_seq;
DROP SEQUENCE signstep_seq;

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
    memprofile VARCHAR2(100),-- 사원사진 nn
    memjob VARCHAR2(20) DEFAULT '일반',
    memauth NUMBER(1), -- 사원권한
    memmail VARCHAR2(50)  CONSTRAINT member_meminmail_nn NOT NULL, -- 사원 외부 메일 uq
    meminmail VARCHAR2(50),
    memmgr NUMBER(5), -- 사원상급자 fk
    memdept NUMBER(3), -- 부서 번호 fk
    memhire DATE, -- 입사 날짜
    memresign DATE, -- 퇴사 날짜
    membirth VARCHAR2(20), -- 생년월일
    memsignimg VARCHAR2(30), -- 서명 그림파일
    CONSTRAINT member_memnum_pk PRIMARY KEY(memnum),
    CONSTRAINT member_meminmail_uq UNIQUE(meminmail),
    CONSTRAINT member_memmgr_fk FOREIGN KEY(memmgr) REFERENCES member(memnum),
    CONSTRAINT member_memdept_fk FOREIGN KEY(memdept) REFERENCES dept(denum)
);

create sequence member_seq increment by 1 start with 10000;
insert into member values
(1, 'sumware', '판교', '1004', 'sumware.jpg', 'sumware', 1,'sumware@naver.com','sumware', null, 100,SYSDATE,NULL,NULL,null);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'김명준', '서울','1004','kmj.jpg','대표이사',1,'kmj85skier@naver.com','mjkim',1,100,SYSDATE,NULL,NULL,null);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'김주상', '경기','1004','kjs.jpg','이사',2,'kjs@naver.com','jskim',10000,100,SYSDATE,NULL,NULL,null);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'홍명표', '성남','1004','hmp.jpg','부장',3,'hmp@naver.com','mphong',10001,100,SYSDATE,NULL,NULL,null);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'김성호', '대구','1004','ksh.jpg','팀장',4,'ksh@naver.com','shkim',10002,100,SYSDATE,NULL,NULL,null);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'모하람', '대전','1004','mhr.jpg','사원',5,'mhr@naver.com','hrmo',10000,200,SYSDATE,NULL,NULL,null);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'김영은', '부산','1004','kye.jpg','사원',5,'kye@naver.com','yekim',10000,300,SYSDATE,NULL,NULL,null);
INSERT INTO MEMBER VALUES
(member_seq.nextVal,'안지영', '목성','1004','ajy.jpg','사원',5,'ajy@naver.com','jyan',10003,100,SYSDATE,NULL,NULL,null);

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

create table bname(
 bname varchar2(30),
 bgnum number(4),
 bdeptno number(3),
 constraint bname_bgnum_pk primary key(bgnum),
 constraint bname_bdeptno_fk foreign key(bdeptno) references dept(denum)
);
INSERT INTO BNAME VALUES('테스트게시판',1,100);

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
    constraint board_bdeptno_fk foreign key(bdeptno) references dept(denum),
    constraint board_bgnum_fk foreign key(bgnum) references bname(bgnum) on delete cascade
);
--0529 테이블 추가


INSERT INTO bname VALUES('공지사항',0,100);


create sequence bname_seq increment by 1 start with 1;
INSERT INTO BOARD VALUES(0,'test','This is testContent','img.jpg',10000,SYSDATE,0,1,100);
INSERT INTO BOARD VALUES(1,'test','This is testContent','img.jpg',10002,SYSDATE,0,1,100);
INSERT INTO BOARD VALUES(2,'test','This is testContent','img.jpg',10003,SYSDATE,0,1,200);
INSERT INTO BOARD VALUES(3,'test','This is testContent','img.jpg',10005,SYSDATE,0,1,200);
INSERT INTO BOARD VALUES(4,'test','This is testContent','img.jpg',10002,SYSDATE,0,1,300);
INSERT INTO BOARD VALUES(5,'test','This is testContent','img.jpg',10003,SYSDATE,0,1,300);
INSERT INTO BOARD VALUES(6,'test','This is testContent','img.jpg',10004,SYSDATE,0,1,400);
CREATE SEQUENCE board_seq INCREMENT BY 1 START WITH 7;

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
    mailread varchar2(1) default 'N', -- 메일 읽었는지 여부 확인
    CONSTRAINT mail_mailnum_pk PRIMARY KEY(mailnum),
    CONSTRAINT mail_mailmem_fk
    FOREIGN KEY(mailmem) REFERENCES member(memnum) on delete set null,
    CONSTRAINT mail_mailreceiver_fk
    FOREIGN KEY(mailreceiver) REFERENCES member(meminmail) on delete set null
);
create sequence mail_seq increment by 1 start with 1;

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
--2015년 memprofile 사이즈 변경

-- 0703 메일 테이블 컬럼 추가
-- 메일 읽었는지 여부 확인
-- alter table mail add(mailread varchar2(1) default 'N');

-------------------------------------------------------------------------------
-- 150706
-- DB 에 추가될 테이블 : pay(pmem, pyearly,pcomm,psalary), admin(),complete, sign(),
--      signform(sfname,sfnum,sform),
--   변경될 테이블 : member ( 칼럼추가:memhire, membirth, memresign,signimg,)

create table pay(
 pmem NUMBER(5), -- member 테이블의 사번을 참조 하고, pk 이다.
 pyearly NUMBER(2), -- 년차
 psalary NUMBER(10), -- 연봉
 CONSTRAINT pay_pmem_pk PRIMARY KEY(pmem),
 CONSTRAINT pay_pmem_fk FOREIGN KEY(pmem) REFERENCES member(memnum) ON DELETE CASCADE
);

CREATE TABLE payhistory(
	hisdate DATE, -- 급여지급 날짜
    hisamount NUMBER(11), -- 지급 금액
    hismem NUMBER(5), -- 지급 대상(사번 fk)
    hisnum NUMBER(10), -- 지급 고유 번호 pk 지급월(yymm)형태로 저장
    CONSTRAINT payhistory_hisnum_pk PRIMARY KEY(hisnum),
    CONSTRAINT payhistory_hismem_fk FOREIGN KEY(hismem) REFERENCES MEMBER(memnum)
);

CREATE TABLE commission(
    comdetail VARCHAR2(50), -- 커미션 내역
    comamount number(9), -- 커미션 금액
    comdate date, -- 지급받은 날짜 (년월로 구분)
    comnum number(9), -- 고유번호
    commem number(5), -- 지급받은 사원번호
    CONSTRAINT commission_commem_fk FOREIGN KEY(commem) REFERENCES MEMBER(memnum),
    CONSTRAINT commission_comnum_pk PRIMARY KEY(comnum)
);
create sequence commission_seq increment by 1 start with 1;

create table administrator(
 anum number, -- pk
 amem NUMBER, -- 사번과 연결
 CONSTRAINT admin_anum_pk PRIMARY KEY(anum),
 CONSTRAINT admin_amem_fk FOREIGN KEY(amem) REFERENCES member(memnum) ON DELETE cascade
);

create table signform(
 sfname varchar2(20), -- 문서의 이름
 sfnum number, -- 문서종류 번호 pk
 sform CLOB, -- 문서의 형태들이 태그 형태로 저장되는 칼럼.
 CONSTRAINT signform_sfnum_pk PRIMARY KEY(sfnum)
);
CREATE SEQUENCE signform_seq INCREMENT BY 1 START WITH 1; 

create table signature(
 snum number, -- 기안고유 번호 pk
 formnum number, -- 문서종류 번호 fk
 sgwriter number(5),--작성자
 finalmemnum number, -- 최종 결재자의 사번 fk
 nowmemnum number, -- 현재 결재자의 사번 fk
 stitle varchar2(40),
 scont clob,
 sreason clob,
 startdate date,
 enddate DATE,
 CONSTRAINT SIGN_snum_pk PRIMARY KEY(snum),
 CONSTRAINT sign_formnum_fk FOREIGN KEY(formnum) REFERENCES signform(sfnum) ON DELETE CASCADE,
 CONSTRAINT sign_finalmemnum_fk FOREIGN KEY(finalmemnum) REFERENCES member(memnum) ON DELETE CASCADE,
 CONSTRAINT sign_nowmemnum_fk FOREIGN KEY(nowmemnum) REFERENCES member(memnum) ON DELETE CASCADE,
 CONSTRAINT sign_sgwriter_fk FOREIGN KEY(sgwriter) REFERENCES member(memnum) ON delete set null
);
CREATE SEQUENCE signature_seq INCREMENT BY 1 START WITH 1; -- snum 사용

create table signstep(
 stepnum number, -- 결재 고유번호 pk
 stepsnum number, -- 문서 고유번호 fk
 stepmemnum NUMBER(5), -- 결재자들의 사번 fk
 stepconfirm varchar2(1), -- 결재 상태
 CONSTRAINT signstep_stepnum_pk PRIMARY KEY(stepnum),
 CONSTRAINT signstep_stepsnum_fk FOREIGN KEY(stepsnum) REFERENCES signature(snum) ON DELETE CASCADE,
 CONSTRAINT signstep_stepmemnum_fk FOREIGN KEY(stepmemnum) REFERENCES member(memnum) ON DELETE CASCADE
);
CREATE SEQUENCE signstep_seq INCREMENT BY 1 START WITH 1;

CREATE TABLE product(
	product VARCHAR2(100) CONSTRAINT product_product_nn NOT null, -- 상품명(글제목)
    proimg VARCHAR2(50), -- 상품 이미지
    prowriter NUMBER(5), -- 상품 게시자 fk member(memnum)
    price NUMBER(8) CONSTRAINT product_price_nn NOT NULL, -- 상품 금액
    procount NUMBER(3),-- 경매에 참여한 사람 수
    pronum NUMBER(5), -- 경매번호 pk
    zzim VARCHAR2(1) DEFAULT 'n', -- 찜한목록이면 y 아니면 n 
    CONSTRAINT product_pronum_pk PRIMARY KEY(pronum),
    CONSTRAINT product_prowriter_fk FOREIGN KEY(prowriter) REFERENCES MEMBER(memnum) 
);
CREATE SEQUENCE product_seq INCREMENT BY 1 START WITH 1;

--0709 추가
alter table signature add(sgdept number(3));
alter table signature add(CONSTRAINT signature_sgdept_fk foreign key(sgdept) REFERENCES dept(denum) on delete set null);

 COMMIT;

CREATE TABLE bidder( -- 가격제시자, 입찰자 테이블
	bidnum number, -- pk 입찰 번호 !!! 고유 번호
    bidmem NUMBER(5), -- 입찰자의 사번 !
    bidpronum number(5), -- fk 상품번호 참조. product(pronum)
    bidprice NUMBER(8), -- 입찰자가 제시한 가격!
    CONSTRAINT bidder_bidnum_pk PRIMARY KEY(bidnum),
    CONSTRAINT bidder_bidnum_fk FOREIGN KEY(bidpronum) 
    REFERENCES PRODUCT(pronum) ON DELETE CASCADE, 
    CONSTRAINT bidder_bidmem_fk FOREIGN KEY(bidmem)
    REFERENCES MEMBER(memnum)	    
);
CREATE SEQUENCE bidder_seq INCREMENT BY 1 START WITH 1;

ALTER TABLE PRODUCT ADD(startdate DATE, enddate date);
alter table product add(procont varchar(800));

CREATE TABLE zzim(
	zzimnum number, -- pk
	zdeptno NUMBER(5), -- 품목을 찜한 사번의 사번. fk member(memnum)
    zproduct NUMBER(5), -- 상품번호. fk product(pronum)
    soldout VARCHAR2(1) DEFAULT 'n',
    CONSTRAINT zzim_zzimnum_pk PRIMARY KEY(zzimnum),
    CONSTRAINT zzim_zdeptno_fk FOREIGN KEY(zdeptno)
    REFERENCES MEMBER(memnum) ON DELETE CASCADE,
    CONSTRAINT zzim_zproduct_fk FOREIGN KEY(zproduct) 
    REFERENCES PRODUCT(pronum) ON DELETE cascade
);
CREATE SEQUENCE zzim_seq INCREMENT BY 1 START WITH 1;

COMMIT;

--0710 추가
alter table signature add(sgreturn number(5));
alter table signature add( constraint signature_sgreturn_fk foreign key(sgreturn) references member(memnum) on delete set null);
alter table signature add(sgreturncomm varchar2(300));
alter table signature add (sdate varchar2(50),splace varchar2(50),sps varchar2(200));
COMMIT;

--0718 pay테이블에 기본 사원들 정보 추가
insert into pay values(10000,2,7000);
insert into pay values(10001,2,7000);
insert into pay values(10002,2,7000);
insert into pay values(10003,2,7000);
insert into pay values(10004,2,7000);
insert into pay values(10005,2,7000);
insert into pay values(10006,2,7000);
commit;


