-- ALTER : 객체 수정 구문

-- 컬럼 추가, 삭제, 수정
SELECT * FROM DEPT_COPY;

-- 컬럼 추가
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));

-- 컬럼 추가 시 DEFAULT값 지정
ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '한국');

-- 컬럼 수정
DESC DEPT_COPY;

-- 자료형, 크기, DEFUALT값 변경 
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY CNAME CHAR(20)
MODIFY LNAME DEFAULT '미국';
-- 이미 들어간 '한국'이 변하지 않고 이제부터 들어가는 값들의 DEFAULT값이 '미국'으로 들어감

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
-- cannot decrease column length because some value is too big
-- 10으로 줄이기는 이미 존재하는 데이터가 10보다 큰 것들이 있기 때문에 불가능 하다는 에러

-- 컬럼 삭제 : 데이터가 기록되어 있어도 삭제 가능
--          한번 삭제한 컬럼은 복구 불가능
--          테이블에는 최소 한개의 컬럼이 존재 해야함 : 모든 컬럼 삭제 불가능 

-- 테이블 잘 못 만듦
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPARTMENT;

-- 테이블 삭제
DROP TABLE DEPT_COPY2;


CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;
-- cannot drop all columns in a table
-- 테이블에서 하나 남은 컬럼은 삭제 할 수 없다고 발생하는 에러

SELECT * FROM DEPT_COPY2;

-- 제약조건이 설정되어 있는 컬럼 삭제
CREATE TABLE TB1(
    PK1 NUMBER PRIMARY KEY,
    COL1 NUMBER,
    CHECK(PK1 > 0 AND COL1 > 0)
);

CREATE TABLE TB2(
    PK2 NUMBER PRIMARY KEY,
    FK2 NUMBER REFERENCES TB1,
    COL2 NUMBER,
    CHECK(PK2 > 0 AND COL2 > 0)
);

ALTER TABLE TB2
DROP COLUMN FK2;

ALTER TABLE TB1
DROP COLUMN PK1;
-- column is referenced in a multi-column constraint
-- 제약 조건이 여러개이기 때문에 삭제가 안된다고 발생하는 에러

-- 해결 방법 : 제약 조건과 같이 삭제
ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS;

-- 동일한 문제 발생과 해결
ALTER TABLE TB2
DROP COLUMN PK2;

ALTER TABLE TB2
DROP COLUMN PK2 CASCADE CONSTRAINTS;

SELECT * FROM TB2;

-- 제약 조건 추가, 삭제
ALTER TABLE DEPT_COPY
DROP CONSTRAINT SYS_C007157;
-- NOT NULL의 경우 : MODIFY 이름 NULL;로 해서 제약 조건을 삭제하고 NULL로 대체한다

-- 컬럼, 제약 조건, 테이블 이름 변경
-- 컬럼 이름 변경
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 제약 조건 이름 변경 
ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007100 TO UF_UP_NN;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007101 TO UF_UN_PK;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007102 TO UF_UI_UK;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT FK_GRADE_CODE TO UF_GC_FK;

-- 테이블 명 변경 : RENAME TO 변경할 테이블 명
ALTER TABLE DEPT_COPY
RENAME TO DEPT_TEST;

-- 테이블 삭제
DROP TABLE DEPT_TEST
-- 제약 조건 포함해서 삭제시 : CASCADE CONSTRAINTS
;
