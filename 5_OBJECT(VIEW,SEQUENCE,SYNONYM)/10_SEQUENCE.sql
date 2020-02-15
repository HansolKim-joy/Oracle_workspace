-- ������(SEQUENCE) : �ڵ� ��ȣ �߻���
CREATE SEQUENCE SEQ_EMPID -- ������ �̸� ����
START WITH 300 -- ���� ����
INCREMENT BY 5 -- ���� ����
MAXVALUE 310 -- �ִ� ����
NOCYCLE -- ����Ŭ �� ���ڴ� ( NOCYCLE�� �⺻�� )
NOCACHE; -- �޸� �󿡼� �������� �ʰڴ�

SELECT * FROM USER_SEQUENCES;

-- SEQUENCE ���
-- ��������.CURRVAL : ���� ������ �������� ��
-- ��������.NEXTVAL : �������� ������Ű�ų� ���ʷ� �������� ����
--                   --------- => ��������.NEXTVAL = ��������.CURRVAL + INCREMENT�� ������ ��
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- sequence SEQ_EMPID.CURRVAL is not yet defined in this session
-- ���ʷ� ���� �� NEXTVAL�� ����� �ϴµ� CURRVAL�� ���� ����߱� ������ ���� �߻� 

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; 
-- sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- MAXVALUE�� 310���� ��������� ������ �̸� �Ѿ�� ������ ���� �߻�

SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 310
-- LAST NUMBER�� ���󰡴� ���� �ƴ϶� ���������� ȣ��� ������ NEXTVAL�� ���� ���� ���� 

-- CURRVAL / NEXTVAL ��� ���� �� �Ұ���
-- ��� ����
--      ���������� �ƴ� SELECT��
--      INSERT���� SELECT��
--      INSERT���� VALUES��
--      UPDATE���� SET��
-- ��� �Ұ���
--      VIEW�� SELECT��
--      DISTINCTŰ���尡 �ִ� SELECT��
--      GROUP BY, HAVING, ORDER BY ���� SELECT��
--      SELECT, UPDATE, DELETE���� ��������
--      CREATE TABLE, ALTER TABLE�� DEFAULT��

-- ���� ���ڰ� 300�̰� ���� ���� 1�̸� �ִ� ���ڰ� 10000�� ���ȯ �� ĳ�� ����� ���ϴ� SEQ_EID ������ ����
CREATE SEQUENCE SEQ_EID
START WITH 300
-- INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

COMMIT;

INSERT INTO EMPLOYEE 
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '666666-6666666', 'hong_gd@hk.or.kr', '01066666666', 'D2', 'J7', 's1',
        5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

SELECT * FROM EMPLOYEE;

-- SAL_LEVEL �� ���� ����
-- UPDATE EMPLOYEE
-- SET SAL_LEVEL = 'S1'
-- WHERE EMP_ID = 300;

CREATE TABLE TMP_EMPLOYEE(
    E_ID NUMBER DEFAULT SEQ_EID.NEXTVAL,
    E_NAME VARCHAR2(30)
);
-- column not allowed here
-- DEFAULT������ SEQUENCE ��� �Ұ����ϴٰ� ���� �߻�

ROLLBACK;

-- ������ ����
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;
-- START WITH ���� ���� �Ұ�

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 320
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 320
