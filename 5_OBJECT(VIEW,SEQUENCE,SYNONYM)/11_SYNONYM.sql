-- ���Ǿ�(SYNONYM) : �ٸ� DB�� ���� ��ü�� ���� ���� Ȥ�� ���Ӹ�
-- ���Ǿ ����Ͽ� �����ϰ� ������ �� �ֵ��� ��

-- ����� ���Ǿ� : ��ü�� ���� ���� ������ �ο� ���� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ��� ����
CREATE SYNONYM EMP FOR EMPLOYEE;
-- insufficient privileges

GRANT CREATE SYNONYM TO KH; -- (SYSTEM ����)

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;

-- ���� ���Ǿ� : ��� ������ �ִ� �����(DBA)�� ������ ���Ǿ�
--            ��� ����ڰ� ����� �� ����

SELECT * FROM EMPLOYEE; -- ������ �������δ� �̷��� �ϸ� ������ ����
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM EMP; -- KH���� ������ �ο��߱� ������ �̷��� �ϸ� ������ ����
SELECT * FROM KH.EMP; -- KH���� ��������Ǿ ����, ������ �ο��߱� ������ ����

SELECT * FROM KH.DEPARTMENT;

CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;

SELECT * FROM DEPT;

-- ���Ǿ� ����
DROP SYNONYM EMP;
SELECT * FROM EMP; -- �����Ǿ��� ������ ������ ����

DROP PUBLIC SYNONYM DEPT; -- ������ �������� ���� ����
SELECT * FROM DEPT; -- �����Ǿ��� ������ ������ ����
