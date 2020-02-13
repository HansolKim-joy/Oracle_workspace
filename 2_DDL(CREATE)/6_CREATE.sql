-- CREATE : �����ͺ��̽� ��ü�� �����ϴ� ����
-- ���̺� �����
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20)
);

SELECT * FROM MEMBER; 

-- �÷��� �ּ��ޱ�
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� �̸�';

SELECT * FROM USER_TABLES;
-- USER_TABLE : ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��

SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : ���̺�, �� ���� �÷���� ���õ� �������� ��ȸ�� �� �ִ� DATA DICTIONARY(DD)
SELECT * 
FROM USER_TAB_COLUMNS 
WHERE TABLE_NAME = 'MEMBER';

DESC MEMBER;
-- DESC�� : ���̺� ���� ǥ��

-- ��������
-- ���̺� �ۼ� �� �� �÷��� ���� �� ��Ͽ� ���� �������� ����
-- ���� : ������ ���Ἲ ����
--       ������ ���Ἲ? �������� ��Ȯ��, �ϰ���, ��ȿ���� �����Ǵ� ��
--          => ������ �Է�, ����, ������ ���� ������ ������ �ڵ� �˻�
-- ���������� ���̺��� ó�� ���� �� �����ص� �ǰ� ���߿� ���̺��� ����� ���� �����ص� ��

-- NOT NULL : NULL���� ������� �ʵ��� �÷��������� ���� // �÷����������� ���� ���� 
CREATE TABLE USER_NOCONST( -- ���� ������ �ƹ��͵� �������� ���� ���̺�
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');
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

-- UNIQUE ���� ���� : �÷� �Է� ���� ���Ͽ� �ߺ��� �����ϴ� ��������
-- �÷� ����, ���̺� �������� ��� ���� ����

-- �ߺ� ������ ����
INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr'); -- UNIQUE ���� ���� ����


CREATE TABLE USER_UNIQUE2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID) -- ���̺� �������� �������� ����
);

INSERT INTO USER_UNIQUE2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE2
VALUES(1, NULL, 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr'); -- IS NULL ���� ���� ���� 

INSERT INTO USER_UNIQUE2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr'); -- UNIQUE ���� ���� ����

SELECT * FROM USER_UNIQUE2;

CREATE TABLE USER_UNIQUE3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID) -- ���� �� ���� ���̺� ������ UQNIQUE ���� ���� ���� // USER_ID�� USER_ID�� ������ ����
);

INSERT INTO USER_UNIQUE3
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES(2, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr'); -- �ߺ� �Ǿ��µ��� �� ��

INSERT INTO USER_UNIQUE3
VALUES(1, 'user02', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr'); -- �ߺ� �Ǿ��µ��� �� �� 

INSERT INTO USER_UNIQUE3
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr'); -- UNIQUE ���� ���� ����

-- ���� ���ǿ� �̸� ����
CREATE TABLE CONS_NAME(
    TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL,
    TEST_DATA2 VARCHAR2(20) CONSTRAINT UK_TEST_DATA2 NOT NULL,
    TEST_DATA3 VARCHAR2(30),
    CONSTRAINT UK_TEST_DATA3 UNIQUE(TEST_DATA3)
);

INSERT INTO CONS_NAME
VALUES('TEST1', 'TEST2', 'TEST3');

INSERT INTO CONS_NAME
VALUES('TEST1', 'TEST2', 'TEST3'); -- �������� �̸����� ������ ���� ���� Ȯ�� ����

-- PRIMARY KEY : NOT NULL + UNIQUE
-- �� ���� ������ �� �ִ� ���� �ĺ��� ����
-- �� ���̺� �� �ϳ��� ���� ����, �÷� ���� / ���̺� ���� �� �� ���� ����
-- �� �� �÷����� ������ �� �ְ� ���� �� �÷��� ��� ������ �� ����

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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'lee123@kh.or.kr'); -- UNIQUE ���� ���� ���� �߻� (PK�� ���ط� ������ ����)

INSERT INTO USER_PRIMARYKEY
VALUES(NULL, 'user03', 'pass03', '������', '��', '010-3333-4444', 'you123@kh.or.kr'); -- NOT NULL ���� ���� ���� �߻� 

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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'lee123@kh.or.kr'); -- ������ �����ϱ� ������ �ߺ� ���� �߻����� ����

INSERT INTO USER_PRIMARYKEY2
VALUES(2, 'user01', 'pass01', '������', '��', '010-3333-4444', 'you123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(NULL, 'user01', 'pass01', '�Ż��Ӵ�', '��', '010-4444-5555', 'shin123@kh.or.kr'); -- ������ �ߺ��� �ƴ����� NULL���� �Ұ���

-- FOREIGN KEY : ������ �ٸ� ���̺��� �����ϴ� ���� ����� �� ���� 
-- ���� �Ǵ� �� �ܿ��� NULL�� ��� ����

CREATE TABLE USER_GRADE( -- �����Ǵ� ���̺� 
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');

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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'lee123@kh.or.kr', 10); 

INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '������', '��', '010-3333-4444', 'you123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-4444-5555', 'AHN123@kh.or.kr', NULL);

SELECT * FROM USER_FOREIGNKEY;

INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '������', '��', '010-5555-6666', 'YOON123@kh.or.kr', 50); 
-- integrity constraint (KH.FK_GRADE_CODE) violated - parent key not found 
-- �����ϴ� USER_GRADE �÷����� �����ϰ� �ִ� ���� �ƴϱ⶧���� ���� �߻�

-- ���� �ɼ� : �θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����͸� � ������ ó���� ���� ���� ���� ����
DELETE FROM USER_GRADE
WHERE GRADE_CODE = 10;
-- integrity constraint (KH.FK_GRADE_CODE) violated - child record found
-- �ڽ��� 10���� ���� �ϰ� �ֱ� ������ ���� �� �� ���ٴ� ���� �߻�
-- ON DELETE RESTRICTED(���� ����)�� �⺻ �����Ǿ� ����
-- FOREIGN KEY�� �������� �÷����� ���ǰ� �ִ� ���� ��� �����ϴ� �÷��� ���� �������� ����

COMMIT;
-- COMMIT : ��� �۾��� ���������� ó���ϰڴٰ� Ȯ���ϴ� ��ɾ�
--          Ʈ������� ó�� ������ �����ͺ��̽��� �ݿ��ϱ� ���ؼ� ����� ������ ��� ���� ����
--          COMMIT �����ϸ�, �ϳ��� Ʈ����� ������ �����ϰ� ��
-- ROLLBACK : �۾� �� ������ �߻����� ��, Ʈ����� ó�� �������� �߻��� ��������� ����ϰ� Ʈ����� ���� ����

DELETE FROM USER_GRADE
WHERE GRADE_CODE = 20;

ROLLBACK;

SELECT * FROM USER_GRADE;


CREATE TABLE USER_GRADE2( -- �����Ǵ� ���̺� 
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE2 VALUES(30, 'Ư��ȸ��');

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
    -- ON DELETE SET NULL : �θ� Ű ���� �� �ڽ�Ű�� NULL�� ����
);

INSERT INTO USER_FOREIGNKEY2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'lee123@kh.or.kr', 10); 

INSERT INTO USER_FOREIGNKEY2
VALUES(3, 'user03', 'pass03', '������', '��', '010-3333-4444', 'you123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY2
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-4444-5555', 'AHN123@kh.or.kr', NULL);


COMMIT;

SELECT * FROM USER_GRADE2;
SELECT * FROM USER_FOREIGNKEY2;

DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10;

CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE3 VALUES(30, 'Ư��ȸ��');

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
    -- ON DELETE CASCADE : �θ� Ű ���� �� �ڽ� Ű�� �Բ� ���� // �� ��ü�� ��� ���� 
);

INSERT INTO USER_FOREIGNKEY3
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'lee123@kh.or.kr', 10); 

INSERT INTO USER_FOREIGNKEY3
VALUES(3, 'user03', 'pass03', '������', '��', '010-3333-4444', 'you123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY3
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-4444-5555', 'AHN123@kh.or.kr', NULL);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

-- CHECK ���� ���� : �÷��� ��ϵǴ� ���� ���� ���� (���ϴ� ��, �Լ��� ��� �Ұ���)
CREATE TABLE USER_CHECK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('��', '��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_CHECK
VALUES(2, 'user02', 'pass02', 'ȫ�浿', '����', '010-1111-2222', 'hong123@kh.or.kr');
-- check constraint (KH.SYS_C007117) violated
-- ���� ���� ���� ���� �־ ����� ����

CREATE TABLE USER_CHECK2(
    TEST_NUMBER NUMBER,
    CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
);

INSERT INTO USER_CHECK2 VALUES(10);
INSERT INTO USER_CHECK2 VALUES(-1);
-- check constraint (KH.CK_TEST_NUMBER) violated
-- ������ 0���� Ŀ�� �ϱ� ������ ������ ���� �� ���ٴ� ����

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


-- [�ǽ� ����]
-- ȸ�����Կ� ���̺� ����(USER_TEST)
-- �÷��� : USER_NO(ȸ����ȣ) - �⺻Ű(PK_USER_NO), // ���� ���ļ� ���� ���� - PK_UT_USER_NO 
--         USER_ID(ȸ�����̵�) - �ߺ�����(UK_USER_ID),
--         USER_PWD(ȸ����й�ȣ) - NULL�� ������(NN_USER_PWD),
--         PNO(�ֹε�Ϲ�ȣ) - �ߺ�����(UK_PNO), NULL ������(NN_PNO),
--         GENDER(����) - '��' Ȥ�� '��'�� �Է�(CK_GENDER),
--         PHONE(����ó),
--         ADDRESS(�ּ�),
--         STATUS(Ż�𿩺�) - NOT NULL(NN_STATUS), 'Y' Ȥ�� 'N'���� �Է�(CK_STATUS)
-- �� �÷��� �������ǿ� �̸� �ο��� ��
-- 5�� �̻� INSERT�� ��

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
    CONSTRAINT CK_GENDER CHECK(GENDER IN('��','��')),
    CONSTRAINT CK_STATUS CHECK(STATUS IN('Y','N'))
);

COMMENT ON COLUMN USER_TEST.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USER_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_TEST.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN USER_TEST.PNO IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN USER_TEST.GENDER IS '����';
COMMENT ON COLUMN USER_TEST.PHONE IS '����ó';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '�ּ�';
COMMENT ON COLUMN USER_TEST.STATUS IS 'Ż�𿩺�';

INSERT INTO USER_TEST VALUES(200, 'sun_di', 'sun_di123', '621225-1985634', '��', '010-9954-6325', '��⵵ ������ �꺻��', 'N');
INSERT INTO USER_TEST VALUES(201, 'song_jk', 'song_jk123', '631126-1548654', '��', '010-4568-6656', '��õ������ ������ ����1��', 'Y');
INSERT INTO USER_TEST VALUES(202, 'no_hc', 'no_hc123', '861015-1356452', '��', '010-6665-6263', '��⵵ ���� ������ ȸ����', 'N');
INSERT INTO USER_TEST VALUES(203, 'song_eh', 'song_eh123', '631010-2653546', '��', '010-7760-7879', '��õ������ ������ ������', 'N');
INSERT INTO USER_TEST VALUES(204, 'yoo_js', 'yoo_js123', '660508-1342154', '��', '010-9999-9129', '��⵵ ���ֽ� ������ ����2��', 'N');
INSERT INTO USER_TEST VALUES(205, 'jung_jh', 'jung_jh123', '770102-1357951', '��', '010-3665-4875', '����� ��õ�� ����7��', 'Y');


-- SUBQUERY�� �̿��� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYEE_COPY2;


-- ���� ���� �߰� 
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
ALTER TABLE USER_FOREIGNKEY4 ADD CHECK(GENDER IN ('��', '��'));
ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4;

-- NOT NULL�� ���� ���� �߰��� �ٸ�
ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL;

-- �̴� �ǽ�
-- DEPARTMENT���̺��� LOCATION_ID�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� LOCATION, ���� �÷��� LOCATION�� �⺻Ű
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;
