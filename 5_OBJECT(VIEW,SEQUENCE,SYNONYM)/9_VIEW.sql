-- VIEW(��)
-- SELECT ���� ���� ��� ȭ���� ������ ��ü, ������ ���� ���̺�
-- ���� �����͸� �����ϰ� ���� ������ ���̺� ����ϴ� �Ͱ� �����ϰ� ��� ����
-- [ǥ����]
-- CREATE [OR REPLACE] VIEW ���̸� AS ��������
-- OR REPLACE : �� ���� �� ���� �̸��� �䰡 ������ �����Ѵٸ� �ش� �並 ���Ӱ� ����
-- OR REPLACE�� ������� �ʰ� �並 ���� �� ���� �̸��� �� �� ���� �� �̹� �ٸ� ��ü�� ������� �̸��̶�� ���� �߻�

-- ���, �̸�, �μ� ��, �ٹ� ������ ��ȸ�ϰ� �� ����� V_EMPLOYEE��� �並 �����Ͽ� ����
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        LEFT JOIN NATIONAL USING(NATIONAL_CODE);
-- insufficient privileges 
-- ������� ���� �����̶�� ���� �߻�

-- SYSTEM �������� ���� �ֱ�
GRANT CREATE VIEW TO KH;

SELECT * FROM V_EMPLOYEE;

COMMIT;

-- ��� 205���� ����� ���� �˻�
SELECT *
FROM EMPLOYEE
WHERE EMP_ID = '205';

-- EMPLOYEE���̺��� ��� 205���� ����� �̸��� '���߾�'���� ����
UPDATE EMPLOYEE
SET EMP_NAME = '���߾�'
WHERE EMP_ID = '205';

SELECT * FROM V_EMPLOYEE
WHERE EMP_ID = '205';
-- ���̽����̺�(�� ���̺�)�� ������ ����Ǹ� VIEW�� �����

ROLLBACK;

-- ������ �� �÷��� ��Ī �ο�
-- ���������� SELECT���� �Լ��� ���� ��� �ݵ�� ��Ī ����(�� �������� �ȿ� ���� ����� ���� ����)
-- ��Ī ����� ��� : �� ��(��Ī,...) OR ���� ��Ī ���� ��Ĵ�ε� ��� ����
CREATE OR REPLACE VIEW V_EMP_JOB(���, �̸�, ����, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);

SELECT * FROM V_EMP_JOB;

-- ������ �並 �̿��� DML�� ��� ����
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;

-- �信 INSERT ���
INSERT INTO V_JOB 
VALUES ('J8', '����');

SELECT * FROM V_JOB;
SELECT * FROM JOB;
-- �信�� ��û�� DML������ ���̽� ���̺� ������

-- �信 UPDATE ���
UPDATE V_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';

-- �信 DELETE ���
DELETE FROM V_JOB
WHERE JOB_CODE = 'J8';

COMMIT;

-- DML ��ɾ�� ������ �Ұ����� ���
-- 1) �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
-- 2) �信 ���Ե��� ���� �÷� �߿� ���̽��� �Ǵ� ���̺� �÷��� NOT NULL ���������� ������ ���
-- 3) ���ǥ�������� ���ǵ� ���
-- 4) �׷��Լ��� GROUP BY���� ������ ���
-- 5) DISTINCT�� ������ ���
-- 6) JOIN�� �̿��� ���� ���̺��� ������ ���

-- 1) �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW V_JOB2
AS SELECT JOB_CODE
    FROM JOB;
    
SELECT * FROM V_JOB2;  
SELECT * FROM JOB;

INSERT INTO V_JOB2 VALUES('J8','����');
-- too many values

UPDATE V_JOB2
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';
-- "JOB_NAME": invalid identifier

DELETE FROM V_JOB2
WHERE JOB_NAME = '���';
-- "JOB_NAME": invalid identifier

-- 2) �信 ���Ե��� ���� �÷� �߿� ���̽��� �Ǵ� ���̺� �÷��� NOT NULL ���������� ������ ���
-- : INSERT������ ���� �߻�
-- JOB_NAME�� ���� �� v_JOB3 ����
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME 
    FROM JOB;

INSERT INTO V_JOB3 VALUES('����');
-- cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- �� ���̺��� INSERT�ϸ� ���̽����̺��� ���µ� JOB_NAME = '����'�� JOB_CODE�� NULL�� ���ٵ�
-- ���̽����̺� JOB_CODE�� NOT NULL ���������� �ֱ� ������ ���� ���ǿ� ���� �߰� �� �� ���ٴ� �ǹ�

INSERT INTO JOB VALUES('J8','����');

SELECT * FROM JOB;
SELECT * FROM V_JOB3;

UPDATE V_JOB3
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '����';

DELETE FROM V_JOB3
WHERE JOB_NAME = '�˹�';

-- 3) ���ǥ�������� ���ǵ� ���
-- ���, ��� ��, �޿�, ���ʽ��� ���Ե� �������� �̷���� EMP_SAL �� ����
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + (SALARY * NVL(BONUS,0))) * 12 ����
    FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL VALUES (800, '������', 3000000, 36000000);
-- virtual column not allowed here
-- ������ SALARY�� BONUS�� �Լ��� ������µ� ���� ���ؼ� ������ �� ���ٰ� ������ ����

UPDATE EMP_SAL
SET ���� = 8000000
WHERE EMP_ID = 200;
-- virtual column not allowed here
-- INSERT�� ���� ���� �߻�

COMMIT;

DELETE FROM EMP_SAL
WHERE ���� = 124800000;
-- ��� �� �ʿ� ���� ��ġ�� �͸� �����ϴ� ���̱� ������ DELETE�� �����

SELECT * FROM EMP_SAL;
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 4) �׷��Լ��� GROUP BY���� ������ ���
-- �μ� �ڵ�, �μ� �ڵ� �� �޿� �հ�, �μ� �ڵ� �� �޿� ����� ������ �ִ� V_GROUPDEPT �� ����
--              (�հ�)            (���)
CREATE OR REPLACE VIEW V_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) �հ�, AVG(SALARY) ���
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT VALUES('D10', 6000000, 4000000);
-- virtual column not allowed here
-- �׷� �Լ��� �Լ��� ��� �� ���̾ ���� �����ؼ� ���� �� ���ٰ� ������ ����

UPDATE V_GROUPDEPT
SET DEPT_CODE = 'D10'
WHERE DEPT_CODE = 'D1';
-- data manipulation operation not legal on this view
-- �Լ��� ��� ����� �� �޶����� ������ �ȵȴٰ� �ߴ� ���� 

DELETE FROM V_GROUPDEPT
WHERE DEPT_CODE = 'D1';
-- data manipulation operation not legal on this view

-- 5) DISTINCT�� ������ ���
CREATE OR REPLACE VIEW V_DT_EMP
AS SELECT DISTINCT JOB_CODE
    FROM EMPLOYEE;

SELECT * FROM V_DT_EMP;

INSERT INTO V_DT_EMP VALUES('J9');
-- data manipulation operation not legal on this view
-- EMPLOYEE���� �̾ƿ� �����̱� ������ INSERT���� ����

UPDATE V_DT_EMP
SET JOB_CODE = 'J9'
WHERE JOB_CODE = 'J7';
-- data manipulation operation not legal on this view

DELETE FROM V_DT_EMP
WHERE JOB_CODE = 'J1';
-- data manipulation operation not legal on this view

-- 6) JOIN�� �̿��� ���� ���̺��� ������ ���
-- ���, ��� ��, �μ� �� ������ ������ �ִ� V_JOINEMP �� ����
CREATE OR REPLACE VIEW V_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP VALUES(888, '������','�λ������');
-- cannot modify more than one base table through a join view
-- JOIN�� �������� �ȵȴٴ� ���� �߻�

UPDATE V_JOINEMP
SET DEPT_TITLE = '�λ������'
WHERE EMP_ID = 219;
-- cannot modify a column which maps to a non key-preserved table

COMMIT;

DELETE FROM V_JOINEMP
WHERE EMP_ID = 219;
-- EMP_ID�� ���� ���� �߱� ������ ���� ����

SELECT * FROM V_JOINEMP;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

ROLLBACK;

SELECT * FROM USER_VIEWS;
-- ���� �信�� ����� ���� �ƴϰ� �ؽ�Ʈ�� ����� ���� ������ �� (�ؽ�Ʈ �����̾���)

-- VIEW �ɼ�
-- VIEW ���� ǥ���
-- CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸� [(alias[, alias]]
-- AS SUBQUERY
-- [WITH CHECK OPTION]
-- [WITH READ ONLY];

-- 1) OR REPLACE �ɼ� : ������ ������ �� �̸��� �����ϴ� ��� �����, �������� ������ ���� ����
-- 2) FORCE / NOFORCE �ɼ�
--      FORCE : ���������� ���� ���̺��� �������� �ʾƵ� �� ����
--      NOFORCE : ���������� ���� ���̺��� �����ؾ߸� �� ����(�⺻ ��)
-- 3) WITH CHECK OPTION �ɼ� : �ɼ��� ������ �÷��� ���� ���� �Ұ����ϰ� ��
-- 4) WITH READ ONLY �ɼ� : �信 ���� ��ȸ�� ����

-- 1) OR REPLACE �ɼ� : ������ ������ �� �̸��� �����ϴ� ��� �����, �������� ������ ���� ����
-- �ֹι�ȣ�� ��� �� ������ ������ �ִ� V_EMP1 �� ����
CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
    FROM EMPLOYEE;
    
SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME, SALARY
    FROM EMPLOYEE;

CREATE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
    FROM EMPLOYEE;
-- name is already used by an existing object
-- OR REPACE�� �Է����� ������ ���� �̸��� �䰡 ����� ���� �ʴ´�.

-- 2) FORCE / NOFORCE �ɼ�
-- FORCE
CREATE OR REPLACE /* NOFORCE */ VIEW V_EMP2 -- �⺻������ NOFORCE�� �Ǿ��ְ� �����ϸ� �⺻������ �����
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
-- table or view does not exist
-- TT��� ���̺��� �������� �ʱ� ������ �߻��ϴ� ����

CREATE OR REPLACE FORCE VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM V_EMP2;
-- view "KH.V_EMP2" has errors
-- ������ �ϰ� �� �� �ִ� ���� �ƹ��͵� ���� 

SELECT * FROM USER_VIEWS;

-- 3) WITH CHECK OPTION
CREATE OR REPLACE VIEW V_EMP3
AS SELECT * 
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D9' WITH CHECK OPTION;

SELECT * FROM V_EMP3;

UPDATE V_EMP3
SET DEPT_CODE = 'D1'
WHERE EMP_ID = 200;
-- view WITH CHECK OPTION where-clause violation
-- DEPT_CODE�� WITH CHECK OPTION�� �����鼭 ���� ���� �Ұ����ϰ� �ߴµ� �̿� ����Ǳ� ������ �� �� ���ٴ� ���� �߻�

COMMIT;

UPDATE V_EMP3
SET EMP_NAME = '������'
WHERE EMP_ID = 200;
-- EMP_NAME���� WITH CHECK OPTION�� �־����� �ʾұ� ������ �������� UPDATE ����

ROLLBACK;

-- WITH READ ONLY
CREATE OR REPLACE VIEW V_DEPT
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

DELETE FROM V_DEPT;
-- cannot perform a DML operation on a read-only view
-- WITH READ ONLY�� ������ �信���� ��ȸ ���� ��� ����� ������ �� ���ٴ� ���� �߻�
