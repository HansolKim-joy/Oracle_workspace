-- 동의어(SYNONYM) : 다른 DB가 가진 객체에 대한 별명 혹은 줄임말
-- 동의어를 사용하여 간단하게 접근할 수 있도록 함

-- 비공개 동의어 : 객체에 대한 접근 권한을 부여 받은 사용자가 정의한 동의어로 해당 사용자만 사용 가능
CREATE SYNONYM EMP FOR EMPLOYEE;
-- insufficient privileges

GRANT CREATE SYNONYM TO KH; -- (SYSTEM 계정)

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;

-- 공개 동의어 : 모든 권한을 주는 사용자(DBA)가 정의한 동의어
--            모든 사용자가 사용할 수 있음

SELECT * FROM EMPLOYEE; -- 관리자 계정으로는 이렇게 하면 나오지 않음
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM EMP; -- KH에만 권한을 부여했기 때문에 이렇게 하면 나오지 않음
SELECT * FROM KH.EMP; -- KH에는 비공개동의어를 설정, 권한을 부여했기 때문에 나옴

SELECT * FROM KH.DEPARTMENT;

CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;

SELECT * FROM DEPT;

-- 동의어 삭제
DROP SYNONYM EMP;
SELECT * FROM EMP; -- 삭제되었기 때문에 나오지 않음

DROP PUBLIC SYNONYM DEPT; -- 관리자 계정에서 삭제 가능
SELECT * FROM DEPT; -- 삭제되었기 때문에 나오지 않음
