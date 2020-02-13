-- DML : ������ ���� ���
-- INSERT, UPDATE, DELETE

-- INSERT : ���ο� ���� �߰� �ϴ� ����(���̺� �� ���� ����)
-- INSERT INTO ���̺� ��(�÷� ��, ...)
-- VALUES (������, ...)
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL,
                SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
VALUES(900, '��ä��', '901123-1080503', 'jang_ch@kh.or.kr', '01055569512', 'D1', 'J7', 'S3',
        4300000, 0.2, '200', SYSDATE, NULL, DEFAULT);
        
SELECT * FROM EMPLOYEE;

ROLLBACK;

INSERT INTO EMPLOYEE
VALUES(900, '��ä��', '901123-1080503', 'jang_ch@kh.or.kr', '01055569512', 'D1', 'J7', 'S3',
        4300000, 0.2, '200', SYSDATE, NULL, DEFAULT);
        
COMMIT;

-- ���� INSERT���� �Ʒ� INSERT���� ������ :
--          �������� �÷� ���� ������ �ٲ� �� VALUES�ȿ� ���� ���� �� �÷� �� ���� ������ �ٲ�����
--          �Ʒ������� �̹� EMPLOYEE���̺��� ������ �÷� �� ������ ���� VALUES�� �÷� ���� �־�� �Ѵ�.

-- ���������� �̿��Ͽ� INSERT
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;

-- INSERT ALL : �� �� �̻��� ���̺� �� ���� ���� ����
-- ���������� ����ϴ� ���̺��� ������, �� ���������� �������� ���� �� ��� ���� 
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE 
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_DEPT_D1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;
    
SELECT * FROM EMP_MANAGER;

INSERT ALL
INTO EMP_DEPT_D1 VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

CREATE TABLE EMP_OLD -- 2000�� 1�� 1�� ������ �Ի��� ��� ����
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

CREATE TABLE EMP_NEW -- �� �Ŀ� �Ի��� ��� ����
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

COMMIT;

INSERT INTO EMP_OLD(
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE HIRE_DATE < '2000/01/01'
);

INSERT INTO EMP_NEW(
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE HIRE_DATE >= '2000/01/01'
);

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

ROLLBACK;

-- �������� �ٸ� �� ���
INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN 
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

-- �ٸ� ��� 
INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN 
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
ELSE
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

-- UPDATE : ���̺� ��ϵ� �÷��� ���� �����ϴ� ����(�� ���� ��ȭ X)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

-- WHERE�� ���� ������ ��ü�� �ٲ� => WHERE�� �� ì���
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��';

ROLLBACK;

-- UPDATE �ÿ��� �������� ����
-- ��� �� ����� ����� �η����ϴ� ���� ����� �޿��� ���ʽ��� ����� ����� �����ϰ� �������ֱ�� �ߴ�.
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('�����', '����');

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS
                FROM EMPLOYEE
                WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

ROLLBACK;

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '�����')
WHERE EMP_NAME IN ('����','���ö','������','������','�ϵ���');

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('����','���ö','������','������','�ϵ���');

-- EMP_SALARY���̺��� �ƽþ������� �ٹ��ϴ� ������ ���ʽ��� 0.3���� ����
-- �ƽþƿ� �ٹ��ϴ� ���� ��ȸ(���, �̸�, �޿�, ���ʽ�, ���� ��)
SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME
FROM EMP_SALARY
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                 FROM EMP_SALARY
                    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                WHERE LOCAL_NAME LIKE 'ASIA%');

-- ���� ������ �������� ���� ������ �����ϴ� ���� ���� �� ����.
UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID = 200;

-- DELETE : ���̺��� ���� �����ϴ� ����(�� ���� �پ��)
COMMIT;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '��ä��';

SELECT * FROM EMPLOYEE;

ROLLBACK;

SELECT * FROM EMPLOYEE;

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- integrity constraint (KH.SYS_C007160) violated - child record found
-- �ڽ����̺��� DEPARTMENT���̺��� �����ϰ� �ֱ� ������ ���� �� �� ���ٴ� ���� �߻�

-- ���� �� FOREIGN KEY ������������ �÷� ������ �Ұ����� ��� �������� ��Ȱ��ȭ ����
ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT SYS_C007160 CASCADE;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';

-- ���⿡���� D1�� ���� �Ǿ�����
SELECT * FROM DEPARTMENT;

-- ���⼭�� D1�� ���� �ִ� �������� �������
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

ROLLBACK;

ALTER TABLE EMPLOYEE
ENABLE CONSTRAINT SYS_C007160;

-- TRUNCATE : ���̺��� ��ü �� ������ ���
-- DELETE���� ����ӵ��� �� ������ ROLLBACK�� ���� ���� �Ұ���

SELECT * FROM EMP_SALARY;
COMMIT;

DELETE FROM EMP_SALARY;
-- 24�� �� ��(��) �����Ǿ����ϴ�.

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;
-- Table EMP_SALARY��(��) �߷Ƚ��ϴ�.
