-- 함수(FUNCTION) : 컬럼의 값을 읽어서 계산한 결과를 리턴
-- 단일 행 함수(SINGLE ROW FUNCTION)
--      N개의 값을 넣어서 N개의 결과 리턴
-- 그룹 함수(GROUP FUNCTION)
--      N개의 값을 넣어서 한 개의 결과 리턴
-- SELECT절에 단일 행 함수와 그룹 함수를 함께 사용 못 함 : 결과 행의 개수가 다르기 때문

-- 함수를 사용할 수 있는 위치
-- SELECT절, WHERE절, GROUP BY절, HAVING절, ORDER BY절

-- 단일 행 함수
-- 1. 문자 관련 함수

-- LENGTH / LENGTHB
-- LENGTH(컬럼 명 또는 '문자열' 가능) : 글자 수 반환
-- LENGTHB(컬럼 명 또는 '문자열' 가능) : 글자의 바이트 사이즈 반환
SELECT LENGTH('오라클'), LENGTHB('오라클') -- 오라클에서 한글은 3BYTE
FROM DUAL; -- 가상 테이블 

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : 해당 문자열의 위치 (오라클은 제로 인덱스 기반이 아님) 
SELECT INSTR('AABAACAABBABA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 1번째부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- -1번째(끝)부터 읽기 시작해서 처음으로 나오는 B의 위치(는 앞에서 부터 셈) 반환
SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 1번째부터 읽기 시작해서 두 번째로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; 
SELECT INSTR('AABAACAABBAA', 'C', 1, 2) FROM DUAL;

-- EMPLOYEE테이블에서 이메일의 @ 위치 반환
SELECT EMAIL, INSTR(EMAIL, '@') 
FROM EMPLOYEE;

-- 2. 숫자 관련 함수
-- 3. 날짜 관련 함수