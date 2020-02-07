-- JOIN : 하나 이상의 테이블에서 데이터를 조회하기 위해 사용

-- 사번, 사원 명, 부서 코드, 부서 명 조회 
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; -- 이너조인(내부조인) : DEPT_CODE가 null인 사람이 있으면 조인되지 못함 // 오라클 구문

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);

-- 부서 명과 해당 부서의 지역 명 조회(DEPT_TITLE, LOCAL_NAME)
-- 오라클
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

-- ANSI
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- 외부 조인 (OUTER JOIN)
-- 두 테이블의 지정하는 컬럼 값이 일치 하지 않는 행도 조인에 포함 

-- LEFT [OUTER] JOIN : 왼쪽에 기술된 테이블의 컬럼 수를 기준으로 JOIN
-- 오라클
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 맞춰 주는 쪽 (여기서는 DEPARTMENT)에 (+)를 붙임

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--  LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- RIGHT [OUTER] JOIN : 오른쪽에 기술된 테이블의 컬럼 수를 기준으로 JOIN
-- 오라클
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- FULL [OUTER] JOIN : 합치기에 아용한 두 테이블이 가진 모든 행을 결과에 포함
-- 오라클 
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+); -- 양쪽에 (+)를 붙여줄 수 없음 // 다시말해서 FULL OUTER JOIN은 ANSI에서만 가능(오라클에서는 불가능)

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- CROSS JOIN
SELECT EMP_NAME
FROM EMPLOYEE; -- 23개 행

SELECT DEPT_TITLE
FROM DEPARTMENT; -- 9개 행

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
        CROSS JOIN DEPARTMENT; -- 207개 행 

-- 비등가 조인(NON EQUAL JOIN) // 컬럼 명이 같아도 USING을 사용하는 것이 아니라 ON 사용
-- '='(등호)를 사용하지 않는 조인문
-- 지정한 컬럼 값이 일치하는 경우가 아닌 값의 범위에 포함되는 행들을 연결하는 방식
SELECT EMP_NAME, SALARY, EMPLOYEE.SAL_LEVEL
FROM EMPLOYEE
    JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL); 

-- SELF JOIN == 셀프 조인 == 자체 조인
-- 같은 테이블 조인(자기 자신과 조인)

-- 오라클
SELECT E.EMP_ID, E.EMP_NAME 사원이름, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 관리자이름
FROM EMPLOYEE E, EMPLOYEE M
WHERE M.EMP_ID = E.MANAGER_ID;

-- ANSI
SELECT E.EMP_ID, E.EMP_NAME 사원이름, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 관리자이름
FROM EMPLOYEE E
    JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-- 다중 조인 : N개의 테이블을 조회할 때 사용
-- 사번, 사원 명, 부서 코드, 부서 명, 지역 명(LOCAL_NAME) 조회

-- 오라클 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID 
        AND LOCATION_ID = LOCAL_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 오류 발생 : 다중 JOIN에서 ANSI구문에서는 순서가 매우 중요!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 오류 정정 : 굳이 LOCATION을 JOIN문 첫번쨰에 쓰고 싶다면 FROM절에서 첫번쨰 컬럼 명과 일치하는 테이블을 설정해줘야 함
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN EMPLOYEE ON (DEPT_CODE = DEPT_ID);
    
-- 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- 오라클
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
        AND D.LOCATION_ID = L.LOCAL_CODE 
        AND E.DEPT_CODE = D.DEPT_ID
        AND LOCAL_NAME LIKE 'ASIA%'
        AND JOB_NAME = '대리';
        
-- ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE)
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%'
        AND JOB_NAME = '대리';




