-- SUBQUERY (��������)
-- �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SQL��
-- ��������(��������)�� ���� ���� ������ �ϴ� ������

-- �������� ������
-- �μ��ڵ尡 ���ö ����� ���� �Ҽ��� ���� ��� ��ȸ
-- 1) ���ö ����� �μ� �ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 D9�� ��� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 1) + 2) : �μ��ڵ尡 ���ö ����� ���� �Ҽ��� ���� ��� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');
                    
-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸�, �����ڵ�, �޿� ��ȸ
-- 1) �� ������ ��� �޿�
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2) �޿��� ��� �޿� ���� ���� ����� ����, �̸�, �����ڵ�, �޿� ��ȸ 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522;

-- 1) + 2) : �޿��� ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
-- �������� ����
-- ���� �� �������� : ���������� ��ȸ ��� ���� ������ 1���� ��
-- ���� �� �������� : ���������� ��ȸ ��� ���� ������ ���� ���� ��
-- ���� �� �������� : �������� SELECT���� ������ �׸� ���� ���� ���� ��
-- ���� �� ���� �� �������� : ��ȸ ��� �� ���� �� ���� ���� ���� ��
-- ���������� ������ ���� �������� �տ� �ٴ� �����ڰ� �޶��� 

-- 1. ���� �� �������� : ���������� ��ȸ ��� ���� ������ 1���� ��
-- �Ϲ������� ���� �� �������� �տ��� �Ϲ� ������ ���
-- <, >, <=, >=, =, !=, <>, ^=

-- ���ö ����� �޿����� ���� �޴� ������ ���, �̸�, �μ��ڵ�, �����ڵ�, �޿� ��ȸ 
-- 1) ���ö ����� �޿�
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) ���ö ����� �޿����� �޿��� ���� �޴� ������ ���, �̸�, �μ��ڵ�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3700000;

-- 1) + 2) : ���ö ����� �޿����� �޿��� ���� �޴� ������ ���, �̸�, �μ��ڵ�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE 
                WHERE EMP_NAME = '���ö');

-- ���� ���� �޿��� �޴� ������ ���, �̸�, �����ڵ�, �μ��ڵ�, �޿�, �Խ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

-- �� ������ �޿� ��պ��� ���� �޿��� �޴� ������ �̸�, �����ڵ�, �μ��ڵ�, �޿� ��ȸ(�����ڵ� ������ ����)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- ���������� SELECT, WHERE, HAVING, FROM�������� ��� ����
-- �μ� �� �޿� �հ� �� ���� ū �μ��� �μ� ��, �޿� �հ� ��ȸ
-- 1) �޿� �հ� �� ���� ū ��
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) �޿� �հ谡 17700000�� �μ� ��, �޿� �հ�
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = 17700000;

-- 1) + 2)
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);

-- 2. ���� �� �������� : ���������� ��ȸ ��� ���� ������ ���� ���� ��
-- ���� �� �������� �տ��� �Ϲ� �� ������ ��� �Ұ�
-- IN / NOT IN : ���� ���� ��� �� �߿��� �� ���� ��ġ�ϴ� ���� ������ / ���ٸ� => ���� ã�Ƽ� ��ȯ
-- > ANY, < ANY : ���� ���� ��� �� �߿��� �� ���ٷ� ū / ���� ���� �ִٸ�
--                ���� ���� ������ ū�� / ���� ū ������ ������
-- > ALL, < ALL : ��� ������ ū / ���� ���� �ִٸ�
--                ���� ū ������ ū�� / ���� ���� ������ ������
-- EXISTS / NOT EXISTS : ���� �����ϴ��� / �������� �ʴ��� => TRUE / FALSE�� ��ȯ

-- �μ� ���� �ְ� �޿��� �޴� ������ �̸�, ���� �ڵ�, �μ��ڵ�, �޿� ��ȸ
-- 1) �μ� �� �ְ� �޿�
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) ���� ���� ����
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                FROM EMPLOYEE
                GROUP BY DEPT_CODE)
ORDER BY DEPT_CODE;

-- �����ڿ� �Ϲ� ������ �ش��ϴ� ��� ���� ���� ��ȸ
-- ���, �̸�, �μ� ��, ����, ����(������/����)
-- 1) �����ڿ� �ش��ϴ� ��� ���� ��ȸ
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2) ���, �̸�, �μ� ��, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE);

-- 3) �����ڿ� �ش��ϴ� ������ ���� ���� 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL);

-- 4) �����ڿ� �ش����� �ʴ� ������ ���� ���� ȣ��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '����' ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                    FROM EMPLOYEE
                    WHERE MANAGER_ID IS NOT NULL);
 
-- 5) ������ + ���� ��ġ�� 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '����' ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL);

-- SELECT�������� �������� ��� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
        CASE WHEN EMP_ID IN (SELECT DISTINCT(MANAGER_ID)
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '������'
            ELSE '����'
        END ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE);

-- �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ������ ���, �̸�, ����, �޿� ��ȸ
-- 1) �븮 ���� ������ ���, �̸�, ����, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮';

-- 2) ���� ���� ������ �޿�
SELECT SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 3) 1) + 2) 
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
        AND SALARY > ANY(SELECT SALARY
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '����');

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
        AND SALARY > (SELECT MIN(SALARY)
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '����');

-- ���� ������ �޿��� ���� ū ������ ���� �޴� ���� ������ ���� ��ȸ
-- ���, �̸�, ����, �޿� ��ȸ
-- 1) ���� ������ ���, �̸�, ����, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 2) ���� ���� ������ �޿�
SELECT SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

--3) 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
        AND SALARY > ALL (SELECT SALARY
                            FROM EMPLOYEE
                                JOIN JOB USING(JOB_CODE)
                            WHERE JOB_NAME = '����');

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
        AND SALARY > (SELECT MAX(SALARY)
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '����');

-- 3. ���� �� �������� : �������� SELECT���� ������ �׸� ���� ���� ���� ��

-- ����� �������� ���� �μ�, ���� ���޿� �ش��ϴ� ����� �̸�, ���� �ڵ�, �μ� �ڵ�, �Ի��� ��ȸ
-- 1) ����� ������
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2;

-- 2) ����� �������� ���� �μ�, ���� ����
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y') -- �����μ�
    AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y') -- ���� ����
    AND EMP_NAME != (SELECT EMP_NAME
                    FROM EMPLOYEE
                    WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y'); -- �ߺ� �̸� ���� 

-- 3) ���߿��� �����Ͽ� �غ���
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
        AND EMP_NAME != (SELECT EMP_NAME
                        FROM EMPLOYEE
                        WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y');

-- 4. ���� �� ���� �� �������� : ��ȸ ��� �� ���� �� ���� ���� ���� ��

-- �ڱ� ������ ��� �޿��� �ް� �ִ� ������ ���, �̸�, ���� �ڵ�, �޿� ��ȸ
-- ��, �޿��� �޿� ����� ���� ������ ��� -- TRUNC(�÷� ��, -5)

-- 1) ���� �� ��� �޿�
SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 2) �ڱ� ������ ��� �޿��� �ް� �ִ� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY),-5)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

-- �ζ��� �� (INLINE VIEW) : FROM������ ���������� ����� ��
-- ���������� ���� ���(RESULT SET)�� ���̺� ��� ���

-- �� ���� �� �޿��� ���� ���� 5���� ����, �̸�, �޿� ��ȸ
-- ROWNUM : ���� ���� �� ������� ��ȣ�� �Ű� �ִ� ��
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC; -- �޿� ���� ��� 5�� : ������, ������, ������, ���ȥ, ���ö

-- Ʋ�� ���� �ذ��� : ROWNUM�� ORDER BY �ϱ� ���� �ο��Ǵ� ��ȣ�̱� ������ �̷��� �ϸ� ó���� �̾ƿö��� 5�������� ������ ����
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- �´� ���� �ذ���
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT * 
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- �޿� ��� 3�� �ȿ� ��� �μ��� �μ� �ڵ�� �μ� ��, ��� �޿� ��ȸ
SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE, DEPT_TITLE
ORDER BY AVG(SALARY) DESC;

SELECT DEPT_CODE, DEPT_TITLE, ��ձ޿�
FROM (SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) ��ձ޿�
        FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        GROUP BY DEPT_CODE, DEPT_TITLE
        ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

-- WITH : ���� ������ �̸��� �ٿ��ְ� ��� �� �̸����� ����ϰ� ��
-- �ζ��� ��� ���� ���������� �ַ� ��� // FROM������ ���ȴٴ� ���� �ƴ�
-- ���� ���� ������ ������ ���� ��� �ߺ� �ۼ� ����, ����ӵ��� ������

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC);
        
WITH TOPN_SAL AS (SELECT EMP_NAME, SALARY
                    FROM EMPLOYEE
                    ORDER BY SALARY DESC)

SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;

-- RANK() OVER / DENSE_RANK() OVER 
-- RANK() OVER : ������ ���� ������ ����� ������ �ο� �� ��ŭ �ǳ� �ٰ� ����
SELECT RANK() OVER(ORDER BY SALARY DESC) ����, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DENSE_RANK() OVER : �ߺ��Ǵ� ���� ������ ����� �ٷ� ���� ����� ó��
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) ����, EMP_NAME, SALARY
FROM EMPLOYEE;
