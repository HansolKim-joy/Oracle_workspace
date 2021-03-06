-- ORDER BY절 : SELECT한 컬럼을 가지고 정렬할 때 사용
-- ORDER BY 컬럼명|컬럼 별칭|컬럼나열순번 [ASC]|DESC
SELECT EMP_ID, EMP_NAME, SALARY 급여, DEPT_CODE
FROM EMPLOYEE
-- ORDER BY EMP_NAME; -- 오름차순
-- ORDER BY EMP_NAME ASC; -- 오름차순
-- ORDER BY EMP_NAME DESC; -- 내림차순
-- ORDER BY DEPT_CODE NULLS FIRST; -- NULL을 처음으로 두고 오름차순 정렬
-- ORDER BY 2; -- SELECT절에서 선택한 두번째 컬럼으로 오름차순 정리
ORDER BY 급여; -- 별칭을 지정해도 상관 없음

/* SELECT문에서 최대로 들어갈 수 있는 문장(구문) - 실행  순서
    5 : SELECT 
    1 : FROM  - 판을 먼저 깔아줌
    2 : WHERE 
    3 : GROUP BY 
    4 : HAVING 
    6 : ORDER BY 
*/

-- GROUP BY : 여러 개의 값을 묶어서 하나로 처리할 목적으로 사용 
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE; -- 결과 값의 개수가 다름

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE테이블에서 부서코드와 보너스를 받는 사원수를 조회하고 부서코드 순으로 정렬
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE테이블에서 부서 코드 별 그룹을 지정하여 부서코드, 그룹 별 급여의 합계, 그룹 별 급여의 평균
-- 인원수를 조회하고 부서 코드 순으로 정렬
SELECT DEPT_CODE, SUM(SALARY), AVG(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE테이블에서 직급코드, 보너스를 받는 사원수를 조회하여 직급코드 순으로 오름차순 정렬
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- COUNT(BONUS)가 0인 직급은 보고 싶지 않을 때 추가되는 조건문
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE테이블에서 성별과 성별 별 급여 평균, 급여 합계, 인원 수 조회하고 인원 수로 내림차순 정렬
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여') 성별, FLOOR(AVG(SALARY)) 평균, SUM(SALARY) 합계, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여')
ORDER BY 인원수 DESC;

-- EMPLOYEE테이블에서 부서 코드별로 같은 직급인 사원의 급여 합계 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE; -- 여러 컬럼을 함께 묶을 수 있음

-- HAVING : 그룹함수로 구해 올 그룹에 대해 조건을 설정할 때 사용
-- 부서코드와 급여 300만원 이상인 직원의 그룹별 평균(반올림) 급여 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

-- 부서코드와 급여 평균(반올림)이 300만원 이상인 그룹 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY)) >= 3000000;

-- 부서 별 그룹의 급여 합계 중 9백만원을 초과하는 부서 코드와 급여 합계(부서 코드 순으로 정렬)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY DEPT_CODE;

-- 집계함수(ROLLUP, CUBE) : 그룹 별 산출한 결과 값의 집계 계산
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY JOB_CODE;

-- ROLLUP 함수 : 그룹 별로 중간 집계 처리
-- 인자로 전달 받은 것 중에서 가장 먼저 지정한 인자에 대해 그룹 별 중간 집계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- CUBE 함수: 그룹 별로 중간 집계 처리
-- 인자로 전달 받은 것 모두에 대해 그룹 별 중간 집계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- GROUPING 함수
-- ROLLUP이나 CUBE에 의한 산출물이 인자로 전달받은 컬럼의 산출물이면 0 반환, 아니면 1 반환
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), 
        GROUPING(DEPT_CODE) 부서별그룹묶인상태,
        GROUPING(JOB_CODE) 직급별그룹묶인상태
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
        GROUPING(DEPT_CODE) 부서별그룹묶인상태,
        GROUPING(JOB_CODE) 직급별그룹묶인상태
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- 집합 연산자 : SELECT절에서의 컬럼이 동일해야 함 
-- UNION : 합집합, OR
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200 
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201;

-- DEPT_CODE가 D5이거나 급여가 300만원을 초과하는 직원의 사번, 이름, 부서코드, 급여 조회 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- UNION ALL : OR + AND, 합집합 + 교집합 --> 중복된 부분이 두번 포함
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- INTERSECT : 교집합, AND
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

-- MINUS : 차집합
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;

-- GROUPINGS SET : 그룹별로 처리된 여러 개의 SELECT문을 하나로 합칠 때 사용, UNION 결과와 동일 
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE 
GROUP BY DEPT_CODE, MANAGER_ID;

SELECT JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS(
                (DEPT_CODE, JOB_CODE, MANAGER_ID),
                (DEPT_CODE, MANAGER_ID),
                (JOB_CODE, MANAGER_ID))
ORDER BY DEPT_CODE;





















