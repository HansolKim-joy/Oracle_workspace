-- �Լ�(FUNCTION) : �÷��� ���� �о ����� ����� ����
-- ���� �� �Լ�(SINGLE ROW FUNCTION)
--      N���� ���� �־ N���� ��� ����
-- �׷� �Լ�(GROUP FUNCTION)
--      N���� ���� �־ �� ���� ��� ����
-- SELECT���� ���� �� �Լ��� �׷� �Լ��� �Բ� ��� �� �� : ��� ���� ������ �ٸ��� ����

-- �Լ��� ����� �� �ִ� ��ġ
-- SELECT��, WHERE��, GROUP BY��, HAVING��, ORDER BY��

-- ���� �� �Լ�
-- 1. ���� ���� �Լ�

-- LENGTH / LENGTHB
-- LENGTH(�÷� �� �Ǵ� '���ڿ�' ����) : ���� �� ��ȯ
-- LENGTHB(�÷� �� �Ǵ� '���ڿ�' ����) : ������ ����Ʈ ������ ��ȯ
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ') -- ����Ŭ���� �ѱ��� 3BYTE
FROM DUAL; -- ���� ���̺� 

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ��ġ (����Ŭ�� ���� �ε��� ����� �ƴ�) 
SELECT INSTR('AABAACAABBABA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 1��°���� �б� �����ؼ� ó������ ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- -1��°(��)���� �б� �����ؼ� ó������ ������ B�� ��ġ(�� �տ��� ���� ��) ��ȯ
SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 1��°���� �б� �����ؼ� �� ��°�� ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'C', 1, 2) FROM DUAL;

-- EMPLOYEE���̺��� �̸����� @ ��ġ ��ȯ
SELECT EMAIL, INSTR(EMAIL, '@') 
FROM EMPLOYEE;

-- 2. ���� ���� �Լ�
-- 3. ��¥ ���� �Լ�