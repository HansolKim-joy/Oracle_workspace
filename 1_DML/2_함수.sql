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

-- LPAD / RPAD : 주어진 컬럼에나 문자열에 임의의 문자열을 왼쪽 / 오른쪽에 덧붙여 길이 N의 문자열 반환
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- LTRIM / RTRIM / TRIM : 주어진 컬럼이나 문자열의 왼쪽 또는 오른쪽 또는 앞/뒤/양쪽에서 지정한 문자를 제거한 나머지 반환
SELECT LTRIM('   KH') FROM DUAL; -- 삭제할 문자열을 지정하지 않았을 경우 기본적으로 공백으로 인식(공백이 디폴트가 됨)
SELECT LTRIM('   KH', ' ') FROM DUAL; -- 위와 동일한 쿼리
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123KH','123') FROM DUAL;
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- ABC를 통으로 인식하지 않고 하나하나의 문자로 나눠서 인식
SELECT LTRIM('5781KH','0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KHACABACC','ABC') FROM DUAL;

-- TRIM 문법이 LTRIM / RTRIM과는 조금 다름! 잘 알아두기!!
SELECT TRIM('   KH   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM('123' FROM '123132KH123321') FROM DUAL; -- 한 글자만 제거 가능 해서 이건 오류 발생

SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- Z가 앞에
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- Z가 뒤에
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL; -- Z가 양쪽에

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치부터 지정 개수의 문자열을 잘라내 반환
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL;

-- EMPLOYEE테이블에서 이름, 이메일, @이후를 제외한 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@') - 1) 아이디
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, RTRIM(EMAIL, '@kh.or.kr') 아이디
FROM EMPLOYEE;

-- 주민등록번호에서 성별을 나타내는 부분만 잘라보기
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) 성별
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 직원들의 주민번호를 이용하여 사원 명, 생년, 생월, 생일 조회
SELECT EMP_NAME "사원 명", SUBSTR(EMP_NO,1,2) 생년, SUBSTR(EMP_NO,3,2) 생월, SUBSTR(EMP_NO,5,2) 생일
FROM EMPLOYEE;

-- LOWER / UPPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL;
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('welcome to my world') FROM DUAL;

-- CONCAT : 연결시켜주는 것 - 컬럼, 문자 상관없음
SELECT CONCAT('가나다라','ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL;


-- REPLACE : 지정한 문자열을 원하는 것으로 대체
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
SELECT REPLACE('서정호 학생의 별명은 군인일까요?','군인','에코') FROM DUAL;

-- EMPLOYEE테이블에서 이메일의 도메인을 gmail.com으로 변경하기
SELECT REPLACE(EMAIL, 'kh.or.kr','gmail.com') 
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 사원 명, 주민번호 조회
-- 단, 주민번호는 생년월일-성별 까지만 보이게 하고 나머지 값은 '*'로 바꾸기
-- EX. 0101114-2******

-- 1)
SELECT EMP_NAME, REPLACE(EMP_NO, SUBSTR(EMP_NO, 9) ,'******')
FROM EMPLOYEE;

-- 2)
SELECT EMP_NAME, CONCAT(SUBSTR(EMP_NO, 1, 8),'******')
FROM EMPLOYEE;

-- 3)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

-- 2. 숫자 관련 함수

-- ABS : 절대 값을 리턴해주는 함수
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : 나눈 나머지를 리턴해주는 함수
SELECT MOD(10,3) FROM DUAL; -- 1
SELECT MOD(-10,3) FROM DUAL; -- -1
SELECT MOD(10, -3) FROM DUAL; -- 1
SELECT MOD(10.9, 3) FROM DUAL; -- 1.9
SELECT MOD(-10.9, 3) FROM DUAL; -- -1.9

SELECT MOD(-10, -3) FROM DUAL; -- -1

-- ROUND : 반올림
SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.678, 0) FROM DUAL; -- 124
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46
SELECT ROUND(123.456, -2) FROM DUAL; -- 100

-- 번외
SELECT ROUND(-10.61) FROM DUAL; -- 11

-- FLOOR : 내림
SELECT FLOOR(123.456) FROM DUAL; 
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : 버림(절삭)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL : 올림
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

-- 3. 날짜 관련 함수
-- SYSDATE : 오늘 날짜 반환
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : 날짜와 날짜 사이의 개월 수 차이를 숫자로 리턴하는 함수
-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무 개월 수 조회
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;

-- ADD_MONTHS : 날짜에 숫자만큼의 개월 수를 더해 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL;

-- NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜를 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- 일 월 화 수 목 금 토
-- 1 2  3 4  5 6  7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '화진씨는 지금 무슨 생각을 하고 있을까?') FROM DUAL; -- 맨 앞에 '화'가 있어서 화요일로 인식하고 나옴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '연화씨도 자기 이름이 되는지 궁금하겠지?') FROM DUAL; -- 맨 앞글자만 인식하기 때문에 연화씨는 안나옴
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
-- 설정 값이 한국어이기 때문에 영어가 인식되지 않음

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'MON') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_ DAY : 해당 월에 마지막 날짜 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('19/12/01') FROM DUAL;

-- EXTRACT : 날짜에서 년, 월, 일 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜)
-- EXTRACT(MONTH FROM 날짜)
-- EXTRACT(DAY FROM 날짜)

-- EMPLOYEE테이블에서 사원의 이름, 입사 년, 입사 월, 입사 일 날짜
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) 입사년도, EXTRACT(MONTH FROM HIRE_DATE) "입사 월", EXTRACT(DAY FROM HIRE_DATE) "입사 일"
FROM EMPLOYEE;

--  4. 형 변환 함수
-- TO_CHAR(날짜[,포맷]) : 날짜형 데이터 -> 문자형 데이터
-- TO_CHAR(숫자[,포맷]) : 숫자형 데이터 -> 문자형 데이터 
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234,'99999') 엥 FROM DUAL;
SELECT TO_CHAR(1234, '99999') 엥 FROM DUAL; -- 5칸, 오른쪽 정렬, 빈칸 공백
SELECT REPLACE(TO_CHAR(1234, '99999'),' ','*') 엥 FROM DUAL;  
SELECT TO_CHAR(1234,'00000') 엥 FROM DUAL; -- 5칸, 오른쪽 정렬, 빈칸 0
SELECT TO_CHAR(1234, 'L99999') 엥 FROM DUAL; -- 원화 설정
SELECT TO_CHAR(1234, 'FML99999') 엥 FROM DUAL; -- 원화 설정, 칸에 맞춰 보임
SELECT TO_CHAR(1234, '$99999') 엥 FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99999') 엥 FROM DUAL;
SELECT TO_CHAR(1234, 'FM00,000') 엥 FROM DUAL;
SELECT TO_CHAR(1234, '9.9EEEE') 엥 FROM DUAL;
SELECT TO_CHAR(1234,'999') 엥 FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-FMDD DAY') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '분기' FROM DUAL; -- 뒤에 나오는 1은 분기를 의미
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" DAY') FROM DUAL;

-- 오늘 날짜 대해
-- 연도 출력
SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월 출력
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 일 출력
SELECT TO_CHAR(SYSDATE, 'DDD'), -- 이번 년 기준으로 보는 일수
        TO_CHAR(SYSDATE, 'DD'), -- 이번 달 기준으로 보는 일수
        TO_CHAR(SYSDATE, 'D') -- 이번 주 기준으로 보는 일수
FROM DUAL;

-- 분기, 요일 출력
SELECT TO_CHAR(SYSDATE, 'Q'), TO_CHAR(SYSDATE, 'DAY'), TO_CHAR(SYSDATE, 'DY') FROM DUAL;

-- TO_DATE : 문자나 숫자형 데이터 -> 날짜형 데이터
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL; -- 오라클의 기본 연도 형식이 두자리여서 두자리로만 나옴

-- 2010 01 01 ==> 2010, 1월
SELECT TO_CHAR(TO_DATE('20100101', 'YYYYMMDD'), 'YYYYY, MON') FROM DUAL; 

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM') FROM DUAL;


-- RR과 YY의 차이
-- 공통점 : 연도를 나타냄
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYYMMDD'), -- 두자리 연도에 현재 세기(21세기)에 맞춰서 넣어줌 
        TO_CHAR(TO_DATE('140918', 'YYMMDD'),'YYYYMMDD'),
        TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYYMMDD'), -- 두자리 연도가 50년 이상이면 이전 세기(20세기), 50년 미만이면 현재 세기(21세기) 적용
        TO_CHAR(TO_DATE('140918', 'RRMMDD'),'YYYYMMDD')
FROM DUAL;

-- TO_NUMBER : 문자형 데이터 -> 숫자형 데이터
SELECT TO_NUMBER('123456789') FROM DUAL;
SELECT '123' + '456' FROM DUAL; -- 기본적으로 오라클에서는 문자로 있는 숫자도 계산해서 나오게 해줌
SELECT '123' + '456A' FROM DUAL; -- 숫자안에 문자가 들어가 있는 경우에는 오라클이 숫자로 바꿀 수 없기 떄문에 할 수 없는 에러 발생
SELECT '1,000,000' + '550,000' FROM DUAL; -- ','도 문자로 인식되기 때문에 위에와 같은 에러 발생

SELECT TO_NUMBER('1,000,000','99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000','99,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL;

-- 5. NULL 처리 함수
-- NVL(컬럼 명, 컬럼 값이 NULL일 때 바꿀 값)

SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '없습니다')
FROM EMPLOYEE;

-- NVL2(컬럼 명, 바꿀 값1, 바꿀 값2) : 컬럼의 값의 NULL이 아니면 바꿀 값1로, NULL이면 바꿀 값2로 바꿈
-- EMPLOYEE테이블에서 보너스가 NULL인 직원은 0.5로, NULL이 아닌 직원은 0.7로 변경하여 조회
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

-- NULLIF(비교대상1, 비교대상 2) : 두 개의 값이 동일하면 NULL, 동일하지 않으면 비교대상1 리턴
SELECT NULLIF(123,123) FROM DUAL;
SELECT NULLIF(123,124) FROM DUAL;

SELECT NULLIF('엄마', '엄마') FROM DUAL;
SELECT NULLIF('엄마', '아빠') FROM DUAL; -- 문자도 가능

-- 6. 선택함수 : 여러 가지 경우 선택할 수 있는 기능 제공
-- DECODE(계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2...)
-- 비교하고자하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
SELECT EMP_ID, EMP_NAME, EMP_NO, 
       DECODE(SUBSTR(EMP_NO, 8, 1),1, '남자', 2, '여자') 성별
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO, 
       DECODE(SUBSTR(EMP_NO, 8, 1),1, '남자', '여자') 성별
FROM EMPLOYEE; -- 1이아니면 2라고 한다면 2를 굳이 써주지 않아도 여자로 나옴
-- 마지막 인자로 조건 값 없이 선택 값 을 작성하면 아무 것도 해당되지 않을 때 마지막에 작성한 선택값을 무조건 선택함

-- CASE WHEN 조건식 THEN 결과 값
--      WHEN 조건식 THEN 결과 값
--      ELSE 결과 값
-- END
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환(조건은 범위 가능)

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남'
            ELSE '여'
        END 성별
FROM EMPLOYEE;

-- 급여가 500만 초과 1등급, 350만 초과 2등급, 200만 초과 3등급, 나머지 4등급 처리
SELECT EMP_NAME, SALARY,
        CASE WHEN SALARY > 5000000 THEN '1등급'
            WHEN SALARY > 3500000 THEN '2등급'
            WHEN SALARY > 2000000 THEN '3등급'
            ELSE '4등급'
        END 등급
FROM EMPLOYEE;

-- 그룹함수 : 여러 행을 넣으면 한 개의 결과 반환
-- SUM(숫자가 기록된 컬럼) : 합계 리턴
-- EMPLOYEE테이블에서 전 사원의 급여 총합 조회
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 남자 사원의 급여 총합 조회
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- AVG(숫자가 기록된 컬럼) : 평균 리턴
-- EMPLOYEE테이블에서 전 사원의 급여 평균 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 전 사원의 BONUS 합계 조회
SELECT SUM(BONUS)
FROM EMPLOYEE;

SELECT AVG(BONUS), AVG(NVL(BONUS, 0))
FROM EMPLOYEE;
-- NULL값을 가진 행은 평균 계산에서 제외 되어 계산

-- MIN / MAC : 최소 / 최대 -- MIN OR MAX(여기는 문자, 숫자, 날짜 상관 없음)
-- EMPLOYEE테이블에서 가장 적은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT(*| 컬럼명) : 행의 개수 리턴
-- COUNT(DISTINCT 컬럼 명) : 중복을 제거한 행 개수 리턴
-- COUNT(*) : NULL을 포함한 전체 행 개수 리턴
-- COUNT(컬럼명) : NULL을 제외한 전체 행 개수 리턴
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;
