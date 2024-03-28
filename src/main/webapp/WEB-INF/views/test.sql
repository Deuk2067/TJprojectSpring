*main
CREATE TABLE "MAIN" (
	"IDX" NUMBER(*,0) NOT NULL ENABLE, 
	"SUBJECT" VARCHAR2(100 BYTE), 
	"CONTENT" VARCHAR2(2000 BYTE), 
	"HIT" NUMBER(*,0) DEFAULT 0, 
	"GOOD" NUMBER(*,0) DEFAULT 0, 
	"WRITEDATE" TIMESTAMP (6) DEFAULT sysdate, 
	"GUP" NUMBER(*,0), 
	"CATEGORY" VARCHAR2(20 BYTE), 
	"ID" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "MAIN_PK" PRIMARY KEY ("IDX")
);

*maincomment
CREATE TABLE "MAINCOMMENT" (
	"IDX" NUMBER(*,0) NOT NULL ENABLE, 
	"NAME" VARCHAR2(20 BYTE), 
	"CONTENT" VARCHAR2(2000 BYTE), 
	"WRITEDATE" TIMESTAMP (6) DEFAULT sysdate, 
	"GUP" NUMBER(*,0), 
	 CONSTRAINT "MAINCOMMENT_PK" PRIMARY KEY ("IDX")
);

*register
CREATE TABLE "REGISTER" (
    "IDX" NUMBER(*,0) NOT NULL ENABLE, 
	"ID" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"PW" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"NAME" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"NICK" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "REGISTER_PK" PRIMARY KEY ("IDX")
);



*임시용 코드
DELETE FROM register;
DROP SEQUENCE register_idx_seq;
CREATE SEQUENCE register_idx_seq;

INSERT INTO register (idx, id, pw, name, nick, email) VALUES (register_idx_seq.nextval, 'hong', '1111', '홍길동', 'gildong', 'a@a.com');
INSERT INTO register (idx, id, pw, name, nick, email) VALUES (register_idx_seq.nextval, 'lim', '2222', '임꺽정', 'kkeokjeong', 'b@b.com');
INSERT INTO register (idx, id, pw, name, nick, email) VALUES (register_idx_seq.nextval, 'jang', '3333', '장길산', 'gilsan', 'c@c.com');
INSERT INTO register (idx, id, pw, name, nick, email) VALUES (register_idx_seq.nextval, 'ill', '4444', '일지매', 'jimae', 'd@d.com');

select * from register;


DELETE FROM main;
DROP SEQUENCE main_idx_seq;
CREATE SEQUENCE main_idx_seq;
commit;

INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '1등', '1등으로 적은 글의 내용입니다.', main_idx_seq.currval, '공포', 'hong');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '2등', '2등으로 적은 글의 내용입니다.', main_idx_seq.currval, '스릴러', 'lim');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '3등', '3등으로 적은 글의 내용입니다.', main_idx_seq.currval, '미스터리', 'jang');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '4등', '4등으로 적은 글의 내용입니다.', main_idx_seq.currval, '순정', 'ill');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '5등', '5등으로 적은 글의 내용입니다.', main_idx_seq.currval, '코미디', 'kim');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '6등', '6등으로 적은 글의 내용입니다.', main_idx_seq.currval, '역사', 'lee');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '7등', '7등으로 적은 글의 내용입니다.', main_idx_seq.currval, '판타지', 'bae');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '8등', '8등으로 적은 글의 내용입니다.', main_idx_seq.currval, '무협', 'kang');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '1234', '1등으로 적은 글의 내용입니다.', main_idx_seq.currval, '스릴러', 'hong');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '5678', '2등으로 적은 글의 내용입니다.', main_idx_seq.currval, '미스터리', 'lim');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '9012', '3등으로 적은 글의 내용입니다.', main_idx_seq.currval, '미스터리', 'jang');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '2345', '4등으로 적은 글의 내용입니다.', main_idx_seq.currval, '판타지', 'ill');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '6789', '5등으로 적은 글의 내용입니다.', main_idx_seq.currval, '코미디', 'kim');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '0123', '6등으로 적은 글의 내용입니다.', main_idx_seq.currval, '공포', 'lee');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '1357', '7등으로 적은 글의 내용입니다.', main_idx_seq.currval, '판타지', 'bae');
INSERT INTO main (idx, subject, content, gup, category, id) VALUES (main_idx_seq.nextval, '2468', '8등으로 적은 글의 내용입니다.', main_idx_seq.currval, '공포', 'kang');

DELETE FROM maincomment;
DROP SEQUENCE maincomment_idx_seq;
CREATE SEQUENCE maincomment_idx_seq;
commit;

INSERT INTO maincomment (idx, name, content, gup) VALUES (maincomment_idx_seq.nextval, 'hong', '축하합니다1', main_idx_seq.currval);
INSERT INTO maincomment (idx, name, content, gup) VALUES (maincomment_idx_seq.nextval, 'lim', '축하합니다2', main_idx_seq.currval);
INSERT INTO maincomment (idx, name, content, gup) VALUES (maincomment_idx_seq.nextval, 'jang', '축하합니다3', main_idx_seq.currval);
INSERT INTO maincomment (idx, name, content, gup) VALUES (maincomment_idx_seq.nextval, 'ill', '축하합니다4', main_idx_seq.currval);


select * from maincomment where gup = 1 order by idx asc;
select * from main;
select count(*) from main;
select * from main order by hit desc;
select * from maincomment;
select * from maincomment where idx = 6;
select * from maincomment order by idx desc;
commit;

