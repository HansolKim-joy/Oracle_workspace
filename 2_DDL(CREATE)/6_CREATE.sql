-- CREATE : 데이터베이스 객체를 생성하는 구문
-- 테이블 만들기
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20)
);

SELECT * FROM MEMBER; 

-- 컬럼에 주석달기
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원 이름';

SELECT * FROM USER_TABLES;
-- USER_TABLE : 사용자가 작성한 테이블을 확인하는 뷰

SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 테이블, 뷰 등의 컬럼들과 관련된 정보들을 조회할 수 있는 DATA DICTIONARY(DD)
SELECT * 
FROM USER_TAB_COLUMNS 
WHERE TABLE_NAME = 'MEMBER';

DESC MEMBER;
-- DESC문 : 테이블 구조 표시

-- 제약조건
-- 테이블 작성 시 각 컬럼에 대해 값 기록에 대한 제약조건 설정
-- 목적 : 데이터 무결성 보장
--       데이터 무결성? 데이터의 정확성, 일관성, 유효성이 유지되는 것
--          => 데이터 입력, 수정, 삭제에 대해 문제가 없는지 자동 검사
-- 제약조건은 테이블을 처음 만들 때 지정해도 되고 나중에 테이블을 만들고 나서 지정해도 됨

-- NOT NULL : NULL값을 허용하지 않도록 컬럼레벨에서 제한 // 컬럼레벨에서만 제한 가능 
CREATE TABLE USER_NOCONST( -- 제약 조건을 아무것도 설정하지 않은 테이블
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr');
INSERT INTO USER_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, '010-1111-2222', 'hong123@kh.or.kr');

CREATE TABLE USER_NOTNULL(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

-- UNIQUE 제약 조건 : 컬럼 입력 값에 대하여 중복을 제한하는 제약조건
-- 컬럼 레벨, 테이블 레벨에서 모두 설정 가능

-- 중복 데이터 삽입
INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr');

SELECT * FROM USER_NOCONST;

CREATE TABLE USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr'); -- UNIQUE 제약 조건 위배


CREATE TABLE USER_UNIQUE2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID) -- 테이블 레벨에서 제약조건 설정
);

INSERT INTO USER_UNIQUE2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE2
VALUES(1, NULL, 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr'); -- IS NULL 제약 조건 위배 

INSERT INTO USER_UNIQUE2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr'); -- UNIQUE 제약 조건 위배

SELECT * FROM USER_UNIQUE2;

CREATE TABLE USER_UNIQUE3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID) -- 여러 개 같이 테이블 레벨로 UQNIQUE 제약 지정 가능 // USER_ID와 USER_ID가 쌍으로 묶임
);

INSERT INTO USER_UNIQUE3
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES(2, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr'); -- 중복 되었는데도 잘 들어감

INSERT INTO USER_UNIQUE3
VALUES(1, 'user02', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr'); -- 중복 되었는데도 잘 들어감 

INSERT INTO USER_UNIQUE3
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr'); -- UNIQUE 제약 조건 위배

-- 제약 조건에 이름 설정
CREATE TABLE CONS_NAME(
    TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL,
    TEST_DATA2 VARCHAR2(20) CONSTRAINT UK_TEST_DATA2 NOT NULL,
    TEST_DATA3 VARCHAR2(30),
    CONSTRAINT UK_TEST_DATA3 UNIQUE(TEST_DATA3)
);

INSERT INTO CONS_NAME
VALUES('TEST1', 'TEST2', 'TEST3');

INSERT INTO CONS_NAME
VALUES('TEST1', 'TEST2', 'TEST3'); -- 제약조건 이름으로 오류에 대한 내용 확인 가능

-- PRIMARY KEY : NOT NULL + UNIQUE
-- 한 행을 구분할 수 있는 고유 식별자 역할
-- 한 테이블 당 하나만 설정 가능, 컬럼 레벨 / 테이블 레벨 둘 다 설정 가능
-- 한 개 컬럼에만 설정할 수 있고 여러 개 컬럼을 묶어서 설정할 수 있음

CREATE TABLE USER_PRIMARYKEY(
    USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '이순신', '남', '010-2222-3333', 'lee123@kh.or.kr'); -- UNIQUE 제안 조건 문제 발생 (PK에 대해로 나오지 않음)

INSERT INTO USER_PRIMARYKEY
VALUES(NULL, 'user03', 'pass03', '유관순', '여', '010-3333-4444', 'you123@kh.or.kr'); -- NOT NULL 제약 조건 문제 발생 

CREATE TABLE USER_PRIMARYKEY2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT PK_USERNO_USERID PRIMARY KEY (USER_NO, USER_ID)
);

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '이순신', '남', '010-2222-3333', 'lee123@kh.or.kr'); -- 쌍으로 인지하기 때문에 중복 문제 발생하지 않음

INSERT INTO USER_PRIMARYKEY2
VALUES(2, 'user01', 'pass01', '유관순', '여', '010-3333-4444', 'you123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(NULL, 'user01', 'pass01', '신사임당', '여', '010-4444-5555', 'shin123@kh.or.kr'); -- 쌍으로 중복은 아니지만 NULL값은 불가능

-- FOREIGN KEY : 참조된 다른 테이블이 제공하는 값만 사용할 수 있음 
-- 제공 되는 값 외에는 NULL만 사용 가능

CREATE TABLE USER_GRADE( -- 참조되는 테이블 
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '일반회원');
INSERT INTO USER_GRADE VALUES(20, '우수회원');
INSERT INTO USER_GRADE VALUES(30, '특별회원');

CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
);

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '이순신', '남', '010-2222-3333', 'lee123@kh.or.kr', 10); 

INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '유관순', '여', '010-3333-4444', 'you123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '안중근', '남', '010-4444-5555', 'AHN123@kh.or.kr', NULL);

SELECT * FROM USER_FOREIGNKEY;

INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '윤봉길', '남', '010-5555-6666', 'YOON123@kh.or.kr', 50); 
-- integrity constraint (KH.FK_GRADE_CODE) violated - parent key not found 
-- 참조하는 USER_GRADE 컬럼에서 제공하고 있는 값이 아니기때문에 에러 발생

-- 삭제 옵션 : 부모 테이블의 데이터 삭제 시 자식 테이블의 데이터를 어떤 식으로 처리할 지에 대한 내용 설정
DELETE FROM USER_GRADE
WHERE GRADE_CODE = 10;
-- integrity constraint (KH.FK_GRADE_CODE) violated - child record found
-- 자식이 10번을 참조 하고 있기 때문에 삭제 할 수 없다는 에러 발생
-- ON DELETE RESTRICTED(삭제 제한)로 기본 지정되어 있음
-- FOREIGN KEY로 지정도니 컬럼에서 사용되고 있는 값일 경우 제공하는 컬럼의 값은 삭제하지 못함

COMMIT;
-- COMMIT : 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어
--          트랜잭션의 처리 과정을 데이터베이스에 반영하기 위해서 변경된 내용을 모두 영구 저장
--          COMMIT 수행하면, 하나의 트랜잭션 과정을 종료하게 됨
-- ROLLBACK : 작업 중 문제가 발생했을 때, 트랜잭션 처리 과정에서 발생한 변경사항을 취소하고 트랜잭션 과정 종료

DELETE FROM USER_GRADE
WHERE GRADE_CODE = 20;

ROLLBACK;

SELECT * FROM USER_GRADE;


CREATE TABLE USER_GRADE2( -- 참조되는 테이블 
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10, '일반회원');
INSERT INTO USER_GRADE2 VALUES(20, '우수회원');
INSERT INTO USER_GRADE2 VALUES(30, '특별회원');

CREATE TABLE USER_FOREIGNKEY2( 
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
    -- ON DELETE SET NULL : 부모 키 삭제 시 자식키를 NULL로 변경
);

INSERT INTO USER_FOREIGNKEY2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(2, 'user02', 'pass02', '이순신', '남', '010-2222-3333', 'lee123@kh.or.kr', 10); 

INSERT INTO USER_FOREIGNKEY2
VALUES(3, 'user03', 'pass03', '유관순', '여', '010-3333-4444', 'you123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY2
VALUES(4, 'user04', 'pass04', '안중근', '남', '010-4444-5555', 'AHN123@kh.or.kr', NULL);


COMMIT;

SELECT * FROM USER_GRADE2;
SELECT * FROM USER_FOREIGNKEY2;

DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10;

CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10, '일반회원');
INSERT INTO USER_GRADE3 VALUES(20, '우수회원');
INSERT INTO USER_GRADE3 VALUES(30, '특별회원');

CREATE TABLE USER_FOREIGNKEY3( 
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
    -- ON DELETE CASCADE : 부모 키 삭제 시 자식 키도 함께 삭제 // 행 전체가 모두 삭제 
);

INSERT INTO USER_FOREIGNKEY3
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(2, 'user02', 'pass02', '이순신', '남', '010-2222-3333', 'lee123@kh.or.kr', 10); 

INSERT INTO USER_FOREIGNKEY3
VALUES(3, 'user03', 'pass03', '유관순', '여', '010-3333-4444', 'you123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY3
VALUES(4, 'user04', 'pass04', '안중근', '남', '010-4444-5555', 'AHN123@kh.or.kr', NULL);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

-- CHECK 제약 조건 : 컬럼에 기록되는 값에 조건 설정 (변하는 값, 함수는 사용 불가능)
CREATE TABLE USER_CHECK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('남', '여')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_CHECK
VALUES(2, 'user02', 'pass02', '홍길동', '남자', '010-1111-2222', 'hong123@kh.or.kr');
-- check constraint (KH.SYS_C007117) violated
-- 제한 범위 외의 것을 넣어서 생기는 에러

CREATE TABLE USER_CHECK2(
    TEST_NUMBER NUMBER,
    CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
);

INSERT INTO USER_CHECK2 VALUES(10);
INSERT INTO USER_CHECK2 VALUES(-1);
-- check constraint (KH.CK_TEST_NUMBER) violated
-- 범위가 0보다 커야 하기 때문에 음수를 넣을 수 없다는 에러

CREATE TABLE USER_CHECK3(
    C_NAME VARCHAR2(15 CHAR),
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CONSTRAINT TBCH_NAME_PK PRIMARY KEY(C_NAME),
    CONSTRAINT TBCH_PRICE_CK CHECK(C_PRICE >= 1 AND C_PRICE <= 99999),
    CONSTRAINT TBCH_LEVEL_CK CHECK(C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    CONSTRAINT TBCH_DATE_CK CHECK(C_DATE >= TO_DATE('2016/01/01', 'YYYY/MM/DD'))
);


-- [실습 문제]
-- 회원가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호) - 기본키(PK_USER_NO), // 위에 겹쳐서 내가 변경 - PK_UT_USER_NO 
--         USER_ID(회원아이디) - 중복금지(UK_USER_ID),
--         USER_PWD(회원비밀번호) - NULL값 허용안함(NN_USER_PWD),
--         PNO(주민등록번호) - 중복금지(UK_PNO), NULL 허용안함(NN_PNO),
--         GENDER(성별) - '남' 혹은 '여'로 입력(CK_GENDER),
--         PHONE(연락처),
--         ADDRESS(주소),
--         STATUS(탈퇴여부) - NOT NULL(NN_STATUS), 'Y' 혹은 'N'으로 입력(CK_STATUS)
-- 각 컬럼의 제약조건에 이름 부여할 것
-- 5명 이상 INSERT할 것

CREATE TABLE USER_TEST(
    USER_NO NUMBER,
    USER_ID VARCHAR2(30), 
    USER_PWD VARCHAR2(30) CONSTRAINT NN_USER_PWD NOT NULL,
    PNO VARCHAR2(20) CONSTRAINT NN_PNO NOT NULL,
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(50),
    STATUS VARCHAR2(10) CONSTRAINT NN_STATUS NOT NULL,
    CONSTRAINT PK_UT_USER_NO PRIMARY KEY(USER_NO),
    CONSTRAINT UK_USER_ID UNIQUE(USER_ID),
    CONSTRAINT UK_PNO UNIQUE(PNO),
    CONSTRAINT CK_GENDER CHECK(GENDER IN('남','여')),
    CONSTRAINT CK_STATUS CHECK(STATUS IN('Y','N'))
);

COMMENT ON COLUMN USER_TEST.USER_NO IS '회원번호';
COMMENT ON COLUMN USER_TEST.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_TEST.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN USER_TEST.PNO IS '주민등록번호';
COMMENT ON COLUMN USER_TEST.GENDER IS '성별';
COMMENT ON COLUMN USER_TEST.PHONE IS '연락처';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '주소';
COMMENT ON COLUMN USER_TEST.STATUS IS '탈퇴여부';

INSERT INTO USER_TEST VALUES(200, 'sun_di', 'sun_di123', '621225-1985634', '남', '010-9954-6325', '경기도 군포시 산본동', 'N');
INSERT INTO USER_TEST VALUES(201, 'song_jk', 'song_jk123', '631126-1548654', '남', '010-4568-6656', '인천광역시 남동구 구월1동', 'Y');
INSERT INTO USER_TEST VALUES(202, 'no_hc', 'no_hc123', '861015-1356452', '남', '010-6665-6263', '경기도 양평군 양평읍 회현리', 'N');
INSERT INTO USER_TEST VALUES(203, 'song_eh', 'song_eh123', '631010-2653546', '여', '010-7760-7879', '인천광역시 남동구 논현동', 'N');
INSERT INTO USER_TEST VALUES(204, 'yoo_js', 'yoo_js123', '660508-1342154', '남', '010-9999-9129', '경기도 파주시 적성면 장현2리', 'N');
INSERT INTO USER_TEST VALUES(205, 'jung_jh', 'jung_jh123', '770102-1357951', '남', '010-3665-4875', '서울시 양천구 신정7동', 'Y');


-- SUBQUERY를 이용한 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYEE_COPY2;


-- 제약 조건 추가 
CREATE TABLE USER_GRADE4(
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(30)
);

ALTER TABLE USER_GRADE4 ADD PRIMARY KEY(GRADE_CODE);

CREATE TABLE USER_FOREIGNKEY4(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20), -- UNIQUE
  USER_PWD VARCHAR2(30), -- NOT NULL
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10), -- CHECK
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER -- FOREIGN KEY
);

ALTER TABLE USER_FOREIGNKEY4 ADD UNIQUE(USER_ID);
ALTER TABLE USER_FOREIGNKEY4 ADD CHECK(GENDER IN ('남', '여'));
ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4;

-- NOT NULL은 제약 조건 추가가 다름
ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL;

-- 미니 실습
-- DEPARTMENT테이블의 LOCATION_ID에 외래키 제약조건 추가
-- 참조 테이블은 LOCATION, 참조 컬럼은 LOCATION의 기본키
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;
