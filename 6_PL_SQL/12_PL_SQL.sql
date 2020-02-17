-- PL / SQL (Procedural Language extension to SQL)
-- ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
-- SQL���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE)���� �����Ͽ� SQL���� ����

-- PL / SQL ����
--      ����� : DECLARE�� ����
--             ������ ��� ����
--      ����� : BIGIN���� ����
--             ���� ���
--      ���� ó���� : EXCEPTION
--                 ���� ��Ȳ �߻� �� �ذ��ϱ� ���� ���� ���

/*
    System.out.println("Hello World");
*/

SET SERVEROUTPUT ON;
-- �⺻ ���� SERVER ON�ϰ� �����ϱ�

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
-- ȯ�� ���� ������ �ʿ��� => SET SERVEROUTPUT ON;

-- Ÿ�� ���� ����
-- ������ ���� �� �ʱ�ȭ, ���� �� ���
DECLARE -- �����
    EMP_ID NUMBER;              -- NUMBERŸ���� ���� EMP_ID ����  => JAVA : int empId;
    EMP_NAME VARCHAR2(30);      -- VARCHAR2Ÿ�� ���� EMP_NAME ����  => JAVA : String empName;
    
    PI CONSTANT NUMBER := 3.14; -- NUMBERŸ���� ��� ���� => JAVA : final double PI = 3.14;
    -- ���� �� ���� ������ :=
BEGIN -- �����
    EMP_ID := 888;              -- EMP_ID������ 888�� �� �ʱ�ȭ
    EMP_NAME := '���峲';         -- EMP_NAME������ ���峲���� �� �ʱ�ȭ 
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

-- ���۷��� ������ ����� �ʱ�ȭ, ���� �� ���
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;        -- ���� EMP_ID�� Ÿ���� EMPLOYEE���̺��� EMP_ID�÷� Ÿ������ ����
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;    -- ���� EMP_NAME�� Ÿ���� EMPLOYEE���̺��� EMP_NAME�÷� Ÿ������ ����
BEGIN
    SELECT EMP_ID, EMP_NAME             -- FROM������ ������ EMPLOYEE���̺��� �÷� �̸�
    INTO EMP_ID, EMP_NAME               -- ����ο��� ������ ���� �̸�
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';           -- ����ڿ��� ��ü ������ �Է��ϴ� �� : & '��ü������ �޾ƶ� ��� ��ɾ��̰� EMP_ID�� ������
                                        --                             ex) '&���' => ����� ���� �� �Է� :
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/


-- ���۷��� ������ EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY�� �����ϰ�
-- EMPLOYEE ���̺��� ���, �̸�, �����ڵ�, �μ��ڵ�, �޿��� ��ȸ�ϰ�
-- ������ ���۷��� ������ ��� ����Ͻÿ�
-- ��, �Է¹��� �̸��� ��ġ�ϴ� ������ ������ ��ȸ�ϼ���.
DECLARE 
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/

-- �� �࿡ ���� ROWTYPE������ ����� �ʱ�ȭ
DECLARE
    E EMPLOYEE%ROWTYPE; -- E��� �ϴ� ������ EMPLOYEE���̺� �ִ� �� ���� ���� ���ڴٴ� �ǹ�
    -- %ROWTYPE : ���̺� �Ǵ� ���� �÷� ������ ��, ũ��, �Ӽ� ����
BEGIN
    SELECT * 
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    -- ���, �̸�, �ֹι�ȣ, �޿�
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

-- ���ù�(���ǹ�)
-- IF ~ THEN ~ END IF (���� IF��)
-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �޿�, ���ʽ��� ���
-- ��, ���ʽ��� �Է¹��� �ʴ� ����� ���ʽ��� ��� ��, '���ʽ��� ���޹��� �ʴ� ����Դϴ�' ���
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
        DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS * 100 || '%');
END;
/

-- IF ~ THEN ~ ELSE ~ END IF (IF ~ ELSE��)
--  EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �μ���, �Ҽ� ����Ͻÿ�
-- TEAM������ ����� �Ҽ��� 'KO'�� ����� '������', �ƴ� ����� '�ؿ���'���� ����
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&���';
    
    IF(NATIONAL_CODE = 'KO')
        THEN TEAM := '������';
    ELSE 
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ��� : ' || TEAM);
    
END;
/

-- IF ~ THEN ~ ELSIF ~ ELSE ~ END IF (IF ~ ELSE IF ~ ELSE��)
-- CASE ~ WHEN THEN ~ END (SWITCH ~ CASE��)

-- ����� ������ ���ϴ� PL / SQL �� �ۼ�
-- ���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���
-- �޿�, �̸�, ���ʽ��� ���Ե� ����(��ȭ �ڸ��� ���б���)
DECLARE 
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    TOTALSALARY NUMBER;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, SALARY*(1+NVL(BONUS,0)) * 12
    INTO EMP_ID, EMP_NAME, SALARY, TOTALSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('���� : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('���� : ' || TO_CHAR(TOTALSALARY,'FML999,999,999'));
END;
/

DECLARE 
    VEMP EMPLOYEE%ROWTYPE;
    TOTALSALARY NUMBER;
BEGIN
    SELECT *
    INTO VEMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    IF(VEMP.BONUS IS NULL)
        THEN TOTALSALARY := VEMP.SALARY * 12;
    ELSE
        TOTALSALARY := VEMP.SALARY * (1+ VEMP.BONUS) * 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY || ' ' || VEMP.EMP_NAME || ' ' || TO_CHAR(TOTALSALARY, 'FML999,999,999'));
END;
/

-- IF ~ THEN ~ ELSIF ~ ELSE ~ END IF (IF ~ ELSE IF ~ ELSE��)
-- ������ �Է¹޾� SCORE������ �����ϰ�
-- 90�� �̻��� 'A', 80�� �̻��� 'B', 70�� �̻��� 'C'
-- 60�� �̻��� 'D', 60�� �̸��� 'F'�� ����ó���Ͽ�
-- GRADE������ ����
-- ��� ��� : ����� ������ 90���̰�, ������ A�����Դϴ�.
DECLARE
    SCORE INT; -- NUMBER(38)�� ���� Ÿ��
    GRADE VARCHAR2(2);
BEGIN
    SCORE := '&����';
    
    IF(SCORE >= 90) THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;

    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������ ' || GRADE || '�����Դϴ�.');
END;
/

-- CASE ~ WHEN ~ THEN ~ END (SWITCH ~ CASE��)
-- ��� ��ȣ�� �Է��Ͽ� �ش� ����� ���, �̸�, �μ��� ���

-- IF ~ ELSIF ~ END IF ���
DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    IF EMP.DEPT_CODE = 'D1' THEN DNAME := '�λ������';
    ELSIF EMP.DEPT_CODE = 'D2' THEN DNAME := 'ȸ�������';
    ELSIF EMP.DEPT_CODE = 'D3' THEN DNAME := '�����ú�';
    ELSIF EMP.DEPT_CODE = 'D4' THEN DNAME := '����������';
    ELSIF EMP.DEPT_CODE = 'D5' THEN DNAME := '�ؿܿ���1��';
    ELSIF EMP.DEPT_CODE = 'D6' THEN DNAME := '�ؿܿ���2��';
    ELSIF EMP.DEPT_CODE = 'D7' THEN DNAME := '�ؿܿ���3��';
    ELSIF EMP.DEPT_CODE = 'D8' THEN DNAME := '���������';
    ELSIF EMP.DEPT_CODE = 'D9' THEN DNAME := '�ѹ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� �̸� �μ���');
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ������'
                WHEN 'D2' THEN 'ȸ�������'
                WHEN 'D3' THEN '�����ú�'
                WHEN 'D4' THEN '����������'
                WHEN 'D5' THEN '�ؿܿ���1��'
                WHEN 'D6' THEN '�ؿܿ���2��'
                WHEN 'D7' THEN '�ؿܿ���3��'
                WHEN 'D8' THEN '���������'
                WHEN 'D9' THEN '�ѹ���'
             END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || ' ' || EMP.EMP_NAME || ' ' || DNAME);
END;
/

-- �ݺ���
-- BASIC LOOP : ���ο� ó������ �ۼ��ϰ� �������� LOOP�� ��� ���� ���
/*
    LOOP��
        ó����
        ���ǹ�
    END LOOP;

    ���ǹ�
        1) IF ���ǽ� THEN EXIT; END IF;
        2) EXIT WHEN ���ǽ�;

*/

-- 1 ~ 5���� ���������� ���
DECLARE 
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        
--        IF N > 5 THEN EXIT;
--        END IF;
        
        EXIT WHEN N > 5; -- �� ����� �� ���� �����
    END LOOP;
END;
/

-- FOR LOOP
/*
    FOR �ε��� IN (REVERSE) �ʱⰪ..������
    LOOP
        ó����
    END LOOP;
*/

BEGIN
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

BEGIN
    FOR N IN REVERSE 1..5
        LOOP DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- �ݺ����� �̿��� ������ ����
CREATE TABLE TEST1(
    BUNHO NUMBER(3),
    NALJJA DATE
);

BEGIN
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST1 VALUES(I, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST1;

-- ��ø �ݺ��� 
-- ������ ¦���� ����ϱ�
BEGIN
    FOR N IN 2..9
    LOOP
        IF MOD(N, 2) = 0
        THEN 
            FOR M IN 1..9
            LOOP
                DBMS_OUTPUT.PUT_LINE(N || ' * ' || M || ' = ' || N*M);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
END;
/

-- WHILE LOOP
/*
    WHILE ����
    LOOP
        ó����
    END LOOP;
*/

DECLARE
    N NUMBER := 1;
BEGIN
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
    END LOOP;
END;
/

-- WHILE������ ������ ¦���� ��� 
DECLARE
    RESULT NUMBER;
    DAN NUMBER := 2;
    SU NUMBER;
BEGIN
    WHILE DAN <= 9
    LOOP
        SU := 1;
        IF MOD(DAN,2) = 0
        THEN   
            WHILE SU <= 9
            LOOP
                RESULT := DAN * SU;
                DBMS_OUTPUT.PUT_LINE(DAN || '*' || SU || '=' || RESULT);
                SU := SU + 1;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
        DAN := DAN + 1;
    END LOOP;
END;
/

-- ���̺� Ÿ�� : ���̺� �������� �Ǿ��ִ� Ÿ��
-- ���̺� : Ű�� ���� ������ �̷���� �÷���
-- �ϳ��� ���̺� �� ���� �÷� ������ ����
/*
    TYPE ���̺�� IS TABLE OF ������Ÿ��
    INDEX BY BYNARY_INTEGER;
*/

DECLARE
    -- ���̺� Ÿ�� ����
    TYPE EMP_ID_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_ID%TYPE
    INDEX BY BINARY_INTEGER;
    -- EMPLOYEE.EMP_ID Ÿ���� �����͸� ������ �� �ִ� ���̺� Ÿ�� EMP_ID_TABLE_TYPE ����
    TYPE EMP_NAME_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_NAME%TYPE
    INDEX BY BINARY_INTEGER;
    -- EMPLOYEE.EMP_NAME Ÿ���� �����͸� ������ �� �ִ� ���̺� Ÿ�� EMP_NAME_TABLE_TYPE ����
    
    -- ���� ���� : EMP_ID NUMBER ��� �ϴ� �Ͱ� ���� �� => �̸��� ������ ��!
    -- ���̺� Ÿ�� EMP_ID_TABLE_TYPE ���� EMP_ID_TABLE ����
    EMP_ID_TABLE EMP_ID_TABLE_TYPE;
    
    -- ���̺� Ÿ�� EMP_NAME_TABLE_TYPE ���� EMP_NAME_TABLE ����
    EMP_NAME_TABLE EMP_NAME_TABLE_TYPE;
    
    I BINARY_INTEGER := 0;
BEGIN
    FOR K IN (SELECT EMP_ID, EMP_NAME FROM EMPLOYEE)
    -- K�� SELECT�ؿ� �� �ϳ��ϳ��� ��
    LOOP
        I := I + 1;
        
        EMP_ID_TABLE(I) := K.EMP_ID;
        EMP_NAME_TABLE(I) := K.EMP_NAME;
    END LOOP;
    
    FOR J IN 1..I
    LOOP
        DBMS_OUTPUT.PUT_LINE('EMP_ID : '|| EMP_ID_TABLE(J) || ', EMP_NAME : ' || EMP_NAME_TABLE(J));
    END LOOP;
END;
/

-- ���ڵ� Ÿ��
-- ���� �ٸ� ������ �����͸� �� �ٷ� ������ ����
-- ���̺� Ÿ���� ��� �� Ÿ�Ը� �� �� �ִٸ� ���ڵ� Ÿ���� ��� ���� ���� ���� Ÿ���� �� �� ����
/*
    TYPE ���ڵ�� IS RECORD (
        �ʵ�� �ʵ�Ÿ�� [[NOT NULL] := DEFAULT ��],
        �ʵ�� �ʵ�Ÿ�� [[NOT NULL] := DEFAULT ��],
        ...
    );
*/

DECLARE
    TYPE EMP_RECORD_TYPE IS RECORD(
        EMP_ID EMPLOYEE.EMP_ID%TYPE,
        EMP_NAME EMPLOYEE.EMP_NAME%TYPE,
        DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE,
        JOB_NAME JOB.JOB_NAME%TYPE
    );
    
    EMP_RECORD EMP_RECORD_TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO EMP_RECORD
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN JOB USING(JOB_CODE)
    WHERE EMP_NAME = '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_RECORD.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_RECORD.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || EMP_RECORD.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('���� : ' || EMP_RECORD.JOB_NAME);
END;
/

-- ����ó��
-- EXCEPTION���� ���� ��Ȳ �߻� �� �ذ��ϱ� ���� ���� ���
-- ����Ŭ���� �̸� ������ ���ܿ� ���ؼ� ����ó���� �� ���� �ְ� ����� ���� ���ܿ� ���ؼ� ����ó���� �� ���� ����

-- �̸� ���ǵ� ������ ����
-- NO_DATA_FOUND        : SELECT���� �ƹ��� ������ ���� ��ȯ���� ���� ��
-- DUP_VAL_ON_INDEX     : UNIQUE������ ���� �÷��� �ߺ��� �����Ͱ� ���� ��
-- ZERO_DIVIDE          : 0���� ���� ��
-- ���� ����

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&���'
    WHERE EMP_ID = 200;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/
-- unique constraint (KH.EMPLOYEE_PK) violated 

SELECT * FROM EMPLOYEE;

DECLARE
    NAME VARCHAR2(30);
BEGIN 
    SELECT EMP_NAME
    INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID = 5;
    -- no data foundno data found
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('��ȸ����� �����ϴ�.');
END;
/
