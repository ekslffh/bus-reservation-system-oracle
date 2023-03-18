-- 테이블 삭제
DROP TABLE WORK;
DROP TABLE RESERVATION;
DROP TABLE SEAT;
DROP TABLE DRIVE;
DROP TABLE ROUTE;
DROP TABLE BUS_TERMINAL;
DROP TABLE EMPLOYEE;
DROP TABLE MEMBER;
DROP TABLE BUS;
DROP TABLE BUS_GRADE;
DROP TABLE BUS_COMPANY;

-- 테이블 생성
--  사용자
CREATE TABLE "MEMBER" (
	"M_ID" VARCHAR2(20) NOT NULL,
	"M_PW" VARCHAR2(30) NOT NULL,
	"M_NAME" VARCHAR2(10) NOT NULL,
	"M_TELNO" VARCHAR2(11) NULL,
	"M_ADD" VARCHAR2(50) NOT NULL,
	"M_MILEAGE" NUMBER(6) DEFAULT '0'
);

--  사용자
ALTER TABLE "MEMBER"
	ADD CONSTRAINT "PK_MEMBER" --  사용자 기본키
	PRIMARY KEY (
	"M_ID" -- 아이디
	);

-- 터미널
CREATE TABLE "BUS_TERMINAL" (
	"T_NO" VARCHAR2(4) NOT NULL,
	"T_NAME" VARCHAR(30) NOT NULL,
	"T_LOC" VARCHAR2(15) NULL
);

-- 터미널
ALTER TABLE "BUS_TERMINAL"
	ADD CONSTRAINT "PK_BUS_TERMINAL" -- 터미널 기본키
	PRIMARY KEY (
	"T_NO" -- 터미널코드
	);

-- 버스
CREATE TABLE "BUS" (
	"B_CODE" VARCHAR2(6) NOT NULL,
	"C_CODE" VARCHAR2(6) NOT NULL,
	"B_NUM" NUMBER(2) NOT NULL,
	"G_CLASS" VARCHAR2(15) NULL
);

-- 버스
ALTER TABLE "BUS"
	ADD CONSTRAINT "PK_BUS" -- 버스 기본키
	PRIMARY KEY (
	"B_CODE" -- 버스코드
	);

-- 좌석
CREATE TABLE "SEAT" (
	"S_CODE" VARCHAR2(6) NOT NULL,
	"D_NUM" VARCHAR2(10) NOT NULL
);

-- 좌석
ALTER TABLE "SEAT"
	ADD CONSTRAINT "PK_SEAT" -- 좌석 기본키
	PRIMARY KEY (
	"S_CODE", -- 좌석코드
	"D_NUM"   -- 운행번호
	);

-- 버스등급
CREATE TABLE "BUS_GRADE" (
	"G_CLASS" VARCHAR2(15) NOT NULL,
	"G_PRICE" NUMBER(10) NOT NULL
);

-- 버스등급
ALTER TABLE "BUS_GRADE"
	ADD CONSTRAINT "PK_BUS_GRADE" -- 버스등급 기본키
	PRIMARY KEY (
	"G_CLASS" -- 등급명
	);

-- 버스회사관리
CREATE TABLE "BUS_COMPANY" (
	"C_CODE" VARCHAR2(6) NOT NULL,
	"C_NAME" VARCHAR2(20) NOT NULL,
	"C_ADDRESS" VARCHAR2(100) NOT NULL,
	"C_TELNO" VARCHAR2(15) NOT NULL
);

-- 버스회사관리
ALTER TABLE "BUS_COMPANY"
	ADD CONSTRAINT "PK_BUS_COMPANY" -- 버스회사관리 기본키
	PRIMARY KEY (
	"C_CODE" -- 회사코드
	);

-- 직원
CREATE TABLE "EMPLOYEE" (
	"E_ID" VARCHAR2(20) NOT NULL,
	"C_CODE" VARCHAR2(6) NOT NULL,
	"E_NAME" VARCHAR2(30) NOT NULL,
	"E_TELNO" VARCHAR2(11) NOT NULL
);

-- 직원
ALTER TABLE "EMPLOYEE"
	ADD CONSTRAINT "PK_EMPLOYEE" -- 직원 기본키
	PRIMARY KEY (
	"E_ID" -- 아이디
	);

-- 예매
CREATE TABLE "RESERVATION" (
	"R_NUM" VARCHAR2(15) NOT NULL,
	"M_ID" VARCHAR2(20) NOT NULL,
	"S_CODE" VARCHAR2(6) NULL,
	"D_NUM" VARCHAR2(10) NULL
);

-- 예매
ALTER TABLE "RESERVATION"
	ADD CONSTRAINT "PK_RESERVATION" -- 예매 기본키
	PRIMARY KEY (
	"R_NUM" -- 예매번호
	);

-- 운행
CREATE TABLE "DRIVE" (
	"D_NUM" VARCHAR2(10) NOT NULL,
	"D_DEPARTTIME" VARCHAR2(15) NOT NULL,
	"D_ARRIVETIME" VARCHAR2(15) NOT NULL,
	"B_CODE" VARCHAR2(6) NOT NULL,
	"R_CODE" VARCHAR2(6) NOT NULL
);

-- 운행
ALTER TABLE "DRIVE"
	ADD CONSTRAINT "PK_DRIVE" -- 운행 기본키
	PRIMARY KEY (
	"D_NUM" -- 운행번호
	);

-- 근무
CREATE TABLE "WORK" (
	"W_CODE" VARCHAR2(10) NOT NULL,
	"W_DATE" DATE NOT NULL,
	"E_ID" VARCHAR2(20) NOT NULL,
	"B_CODE" VARCHAR2(6) NOT NULL
);

-- 근무
ALTER TABLE "WORK"
	ADD CONSTRAINT "PK_WORK" -- 근무 기본키
	PRIMARY KEY (
	"W_CODE" -- 근무코드
	);

-- 일정
CREATE TABLE "ROUTE" (
	"R_CODE" VARCHAR2(6) NOT NULL,
	"R_DEPART" VARCHAR2(4) NOT NULL,
	"R_ARRIVE" VARCHAR2(4) NOT NULL,
	"R_DISTANCE" NUMBER(5) NULL,
	"R_DRIVETIME" NUMBER(3) NULL
);

-- 일정
ALTER TABLE "ROUTE"
	ADD CONSTRAINT "PK_ROUTE" -- 일정 기본키
	PRIMARY KEY (
	"R_CODE" -- 일정코드
	);

-- 버스
ALTER TABLE "BUS"
	ADD CONSTRAINT "FK_BUS_COMPANY_TO_BUS" -- 버스회사관리 -> 버스
	FOREIGN KEY (
	"C_CODE" -- 회사코드
	)
	REFERENCES "BUS_COMPANY" ( -- 버스회사관리
	"C_CODE" -- 회사코드
	);

-- 버스
ALTER TABLE "BUS"
	ADD CONSTRAINT "FK_BUS_GRADE_TO_BUS" -- 버스등급 -> 버스
	FOREIGN KEY (
	"G_CLASS" -- 등급명
	)
	REFERENCES "BUS_GRADE" ( -- 버스등급
	"G_CLASS" -- 등급명
	);

-- 좌석
ALTER TABLE "SEAT"
	ADD CONSTRAINT "FK_DRIVE_TO_SEAT" -- 운행 -> 좌석
	FOREIGN KEY (
	"D_NUM" -- 운행번호
	)
	REFERENCES "DRIVE" ( -- 운행
	"D_NUM" -- 운행번호
	);

-- 예매
ALTER TABLE "RESERVATION"
	ADD CONSTRAINT "FK_MEMBER_TO_RESERVATION" --  사용자 -> 예매
	FOREIGN KEY (
	"M_ID" -- 아이디
	)
	REFERENCES "MEMBER" ( --  사용자
	"M_ID" -- 아이디
	);

-- 예매
ALTER TABLE "RESERVATION"
	ADD CONSTRAINT "FK_SEAT_TO_RESERVATION" -- 좌석 -> 예매
	FOREIGN KEY (
	"S_CODE", -- 좌석코드
	"D_NUM"   -- 운행번호
	)
	REFERENCES "SEAT" ( -- 좌석
	"S_CODE", -- 좌석코드
	"D_NUM"   -- 운행번호
	);

-- 운행
ALTER TABLE "DRIVE"
	ADD CONSTRAINT "FK_BUS_TO_DRIVE" -- 버스 -> 운행
	FOREIGN KEY (
	"B_CODE" -- 버스코드
	)
	REFERENCES "BUS" ( -- 버스
	"B_CODE" -- 버스코드
	);

-- 운행
ALTER TABLE "DRIVE"
	ADD CONSTRAINT "FK_ROUTE_TO_DRIVE" -- 일정 -> 운행
	FOREIGN KEY (
	"R_CODE" -- 일정코드
	)
	REFERENCES "ROUTE" ( -- 일정
	"R_CODE" -- 일정코드
	);

-- 근무
ALTER TABLE "WORK"
	ADD CONSTRAINT "FK_EMPLOYEE_TO_WORK" -- 직원 -> 근무
	FOREIGN KEY (
	"E_ID" -- 아이디
	)
	REFERENCES "EMPLOYEE" ( -- 직원
	"E_ID" -- 아이디
	);

-- 근무
ALTER TABLE "WORK"
	ADD CONSTRAINT "FK_BUS_TO_WORK" -- 버스 -> 근무
	FOREIGN KEY (
	"B_CODE" -- 버스코드
	)
	REFERENCES "BUS" ( -- 버스
	"B_CODE" -- 버스코드
	);

-- 일정
ALTER TABLE "ROUTE"
	ADD CONSTRAINT "FK_BUS_TERMINAL_TO_ROUTE" -- 터미널 -> 일정
	FOREIGN KEY (
	"R_DEPART" -- 출발지
	)
	REFERENCES "BUS_TERMINAL" ( -- 터미널
	"T_NO" -- 터미널코드
	);

-- 일정
ALTER TABLE "ROUTE"
	ADD CONSTRAINT "FK_BUS_TERMINAL_TO_ROUTE2" -- 터미널 -> 일정2
	FOREIGN KEY (
	"R_ARRIVE" -- 도착지
	)
	REFERENCES "BUS_TERMINAL" ( -- 터미널
	"T_NO" -- 터미널코드
	);

--데이터 생성
-- 터미널 
INSERT INTO BUS_TERMINAL(T_NO, T_NAME, T_LOC) VALUES('SO', '서울역', '서울');
INSERT INTO BUS_TERMINAL(T_NO, T_NAME, T_LOC) VALUES('DJ', '대전역', '대전/충남');
INSERT INTO BUS_TERMINAL(T_NO, T_NAME, T_LOC) VALUES('DG', '대구역', '대구/경북');
INSERT INTO BUS_TERMINAL(T_NO, T_NAME, T_LOC) VALUES('BS', '부산역', '부산/경남');
SELECT * FROM BUS_TERMINAL;

-- 버스회사
INSERT INTO BUS_COMPANY(C_CODE, C_NAME, C_ADDRESS, C_TELNO) VALUES('KH4888', '금호', '서울 서초구 신반포로 194(반포동) 강남고속터미널', '1544-4888');
INSERT INTO BUS_COMPANY(C_CODE, C_NAME, C_ADDRESS, C_TELNO) VALUES('DB3613', '동부', '부산 남구 북항로 191', '051-630-3613');
INSERT INTO BUS_COMPANY(C_CODE, C_NAME, C_ADDRESS, C_TELNO) VALUES('DY3111', '동양', '서울특별시 서초구 신반포로 194 915호', '02-535-3111');
INSERT INTO BUS_COMPANY(C_CODE, C_NAME, C_ADDRESS, C_TELNO) VALUES('SH1580', '삼화', '인천광역시 중구 서해대로 418번길 70, 2층', '032-508-1580');
SELECT * FROM BUS_COMPANY;

-- 직원(기사)
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH1','KH4888','배소현','01035407484');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH2','KH4888','김은지','01015489871');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH3','KH4888','나성민','01035704846');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH4','KH4888','현성윤','01074446602');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH5','KH4888','배미숙','01077844423');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH6','KH4888','하재관','01045742054');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH7','KH4888','장승수','01034784546');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH8','KH4888','박소현','01098400153');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH9','KH4888','이병건','01021514866');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('KH10','KH4888','김연우','01025488469');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB1','DB3613','우도현','01045015449');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB2','DB3613','김예진','01033548745');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB3','DB3613','이병건','01065481512');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB4','DB3613','주호민','01030507784');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB5','DB3613','김예은','01044565585');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB6','DB3613','김형준','01064815682');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB7','DB3613','이현민','01045166623');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB8','DB3613','유송빈','01077049596');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB9','DB3613','박건태','01035485584');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DB10','DB3613','이민호','01011259961');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY1','DY3111','김지우','01094603512');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY2','DY3111','김래홍','01022458551');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY3','DY3111','김유주','01046632587');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY4','DY3111','조원진','01054120699');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY5','DY3111','황소희','01022548846');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY6','DY3111','박소윤','01044562223');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY7','DY3111','이강원','01012155466');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY8','DY3111','장민우','01094852544');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY9','DY3111','김재홍','01044355587');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('DY10','DY3111','김영효','01066568852');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH1','SH1580','황한샘','01065422540');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH2','SH1580','정지현','01002186651');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH3','SH1580','문영택','01054566682');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH4','SH1580','김예인','01021250054');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH5','SH1580','오혜민','01044582258');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH6','SH1580','박은수','01066922414');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH7','SH1580','정솔','01066522241');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH8','SH1580','이소리','01005440568');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH9','SH1580','유종선','01088185108');
INSERT INTO EMPLOYEE(E_ID, C_CODE, E_NAME, E_TELNO) VALUES('SH10','SH1580','김예진','01021250065');
SELECT * FROM EMPLOYEE;

-- 버스등급
INSERT INTO BUS_GRADE(G_CLASS, G_PRICE) VALUES('프리미엄', 20500);
INSERT INTO BUS_GRADE(G_CLASS, G_PRICE) VALUES('우등', 15800);
INSERT INTO BUS_GRADE(G_CLASS, G_PRICE) VALUES('일반', 10800);
SELECT * FROM BUS_GRADE;

-- 버스
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('KH1811', 'KH4888', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('KH3641', 'KH4888', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('KH3011', 'KH4888', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('KH2822', 'KH4888', 21, '프리미엄');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('KH3548', 'KH4888', 40, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('KH3599', 'KH4888', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('KH1120', 'KH4888', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('KH3338', 'KH4888', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DB5889', 'DB3613', 40, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DB3055', 'DB3613', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DB6698', 'DB3613', 20, '프리미엄');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DB2204', 'DB3613', 20, '프리미엄');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DB6980', 'DB3613', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DB1580', 'DB3613', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DB2004', 'DB3613', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DB0022', 'DB3613', 20, '프리미엄');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DY3054', 'DY3111', 40, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DY0054', 'DY3111', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DY3578', 'DY3111', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DY2100', 'DY3111', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DY0048', 'DY3111', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DY2574', 'DY3111', 40, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DY4689', 'DY3111', 40, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('DY4778', 'DY3111', 20, '프리미엄');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('SH3066', 'SH1580', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('SH3699', 'SH1580', 28, '우등');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('SH3004', 'SH1580', 20, '프리미엄');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('SH7966', 'SH1580', 20, '프리미엄');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('SH3369', 'SH1580', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('SH0039', 'SH1580', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('SH8419', 'SH1580', 30, '일반');
INSERT INTO BUS(B_CODE, C_CODE, B_NUM, G_CLASS) VALUES('SH3088', 'SH1580', 30, '일반');
SELECT * FROM BUS;

-- 좌석 : 좌석 예매 내용에 대한 테이블 생성

-- 엑셀표로 데이터 입력부분
-- 근무 : 버스 - 직원 매칭
SELECT * FROM WORK;
-- 노선 :  : 출발역, 도착역, 거리, 시간등의 정보입력 (고정값)
SELECT * FROM ROUTE;
-- 운행 : 거의 고정값으로 운행이 되고 필요시에 추가, 수정, 삭제 등의 작업 가능
SELECT * FROM DRIVE;
SELECT * FROM DRIVE WHERE R_CODE = 3;