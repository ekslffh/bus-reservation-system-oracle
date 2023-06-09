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

-- 새 테이블
CREATE TABLE "TABLE2" (
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