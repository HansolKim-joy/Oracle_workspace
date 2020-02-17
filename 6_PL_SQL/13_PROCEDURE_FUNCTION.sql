-- ���ν���(PROCEDURE) : PL/SQL���� �����ϴ� ��ü
-- Ư�� ������ ó���ϱ⸸ �ϰ� ��� ���� ��ȯ������ ����

-- EMPLOYEE���̺��� ������ EMP_DUP���̺� ����
CREATE TABLE EMP_DUP
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_DUP;

-- ȣ�� �� EMP_DUP���̺� �ִ� ��� �����͸� �����ϴ� DEL_ALL_EMP���ν��� ����
CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
    COMMIT;
END;
/
-- Procedure DEL_ALL_EMP��(��) �����ϵǾ����ϴ�.

SELECT * FROM EMP_DUP;
-- ����� �ֱ⸸ �ϰ� ȣ�� ���� �ʾƼ� ������� �ʾ���

EXECUTE DEL_ALL_EMP;
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT * FROM EMP_DUP;

SELECT * FROM USER_SOURCE;
-- ���ν��� ������ DD(DATA DICTIONARY)

COMMIT;

-- V_EMP_ID �Ű������� �ִ� ���ν���
CREATE OR REPLACE PROCEDURE DEL_EMP_ID(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
IS
BEGIN
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/

EXEC DEL_EMP_ID('&���');

SELECT * FROM EMPLOYEE;

ROLLBACK;

-- IN/OUT �Ű����� �ִ� ���ν���
-- IN �Ű����� : ���ν��� ���ο��� ���� ����
-- OUT �Ű����� : ���ν��� �ܺ�(ȣ���)���� ���� ����

-- ����ڰ� �Է��� ������� ����� �̸�, �޿�, ���ʽ� ��ȸ�ϴ� SELECT_EMP_ID ���ν��� ����
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS,0)
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/

-- ���ε� ����(VARIABLE OR VAR)
-- SQL���� ������ �� SQL�� ��� ���� ������ �� �ִ� ��� ����
-- ���ν������� ���� �Ű������� �ۿ��� ����� �Ű������� �����ϴ� ����
VARIABLE VAR_EMP_NAME VARCHAR2(30);
VAR VAR_SALARY NUMBER;
VAR VAR_BONUS NUMBER;

PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;

EXEC SELECT_EMP_ID('&���', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);

SET AUTOPRINT ON;

-- FUNCTION : ���ν����� ��� �뵵�� ���� ��������� �������� �ǵ������� �� ����(RETURN)
/*
    CREATE OR REPLACE FUNCTION �Լ��� (�Ű�����1 �Ű�����Ÿ��, .....)
    RETURN ������Ÿ��
    IS [AS]
        �����
    BEGIN
        �����
        RETURN ��ȯ��;
    [EXCEPTION 
        ����ó����]
    END [�Լ���];
    /
*/

-- ����� �Է¹޾� �ش� ����� ������ ����ϰ� �����ϴ� �Լ� ���� (BONUS_CALC)
CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
    CALC_SAL NUMBER;
BEGIN
    SELECT SALARY, NVL(BONUS,0)
    INTO V_SAL, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;
    
    RETURN CALC_SAL;
END;
/

VAR VAR_CALC NUMBER;

EXEC :VAR_CALC := BONUS_CALC('&���');
