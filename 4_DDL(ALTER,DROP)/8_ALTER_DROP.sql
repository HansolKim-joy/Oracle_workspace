-- ALTER : ��ü ���� ����

-- �÷� �߰�, ����, ����
SELECT * FROM DEPT_COPY;

-- �÷� �߰�
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));

-- �÷� �߰� �� DEFAULT�� ����
ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '�ѱ�');

-- �÷� ����
DESC DEPT_COPY;

-- �ڷ���, ũ��, DEFUALT�� ���� 
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY CNAME CHAR(20)
MODIFY LNAME DEFAULT '�̱�';
-- �̹� �� '�ѱ�'�� ������ �ʰ� �������� ���� ������ DEFAULT���� '�̱�'���� ��

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
-- cannot decrease column length because some value is too big
-- 10���� ���̱�� �̹� �����ϴ� �����Ͱ� 10���� ū �͵��� �ֱ� ������ �Ұ��� �ϴٴ� ����

-- �÷� ���� : �����Ͱ� ��ϵǾ� �־ ���� ����
--          �ѹ� ������ �÷��� ���� �Ұ���
--          ���̺��� �ּ� �Ѱ��� �÷��� ���� �ؾ��� : ��� �÷� ���� �Ұ��� 

-- ���̺� �� �� ����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPARTMENT;

-- ���̺� ����
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
-- ���̺��� �ϳ� ���� �÷��� ���� �� �� ���ٰ� �߻��ϴ� ����

SELECT * FROM DEPT_COPY2;

-- ���������� �����Ǿ� �ִ� �÷� ����
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
-- ���� ������ �������̱� ������ ������ �ȵȴٰ� �߻��ϴ� ����

-- �ذ� ��� : ���� ���ǰ� ���� ����
ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS;

-- ������ ���� �߻��� �ذ�
ALTER TABLE TB2
DROP COLUMN PK2;

ALTER TABLE TB2
DROP COLUMN PK2 CASCADE CONSTRAINTS;

SELECT * FROM TB2;

-- ���� ���� �߰�, ����
ALTER TABLE DEPT_COPY
DROP CONSTRAINT SYS_C007157;
-- NOT NULL�� ��� : MODIFY �̸� NULL;�� �ؼ� ���� ������ �����ϰ� NULL�� ��ü�Ѵ�

-- �÷�, ���� ����, ���̺� �̸� ����
-- �÷� �̸� ����
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- ���� ���� �̸� ���� 
ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007100 TO UF_UP_NN;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007101 TO UF_UN_PK;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007102 TO UF_UI_UK;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT FK_GRADE_CODE TO UF_GC_FK;

-- ���̺� �� ���� : RENAME TO ������ ���̺� ��
ALTER TABLE DEPT_COPY
RENAME TO DEPT_TEST;

-- ���̺� ����
DROP TABLE DEPT_TEST
-- ���� ���� �����ؼ� ������ : CASCADE CONSTRAINTS
;
