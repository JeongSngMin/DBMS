-- 문법: CONCAT(값1, 값2, ...)
SELECT CONCAT(name, ' (', category, ')') AS 가게정보
FROM restaurants
WHERE category IN ('치킨', '피자');

-- 문법: SUBSTRING(문자열, 시작위치, [길이])
SELECT
    name,
    SUBSTRING(name, 1, 3) AS 앞3글자,       -- 1번째부터 3글자
    SUBSTRING(name, 3) AS 3번째부터         -- 3번째부터 끝까지
FROM restaurants
WHERE category IN ('치킨', '피자');

SELECT
    '안녕'                AS 문자열,
    LENGTH('안녕')        AS LENGTH_결과,       -- 6
    CHAR_LENGTH('안녕')   AS CHAR_LENGTH_결과;  -- 2
    

-- REPLACE(문자열, 찾을값, 바꿀값)
SELECT
    address,
    REPLACE(address, '부산', '@부산') AS 골뱅이주소
FROM restaurants;
-- 부산시 해운대구 -> @부산시 해운대구
-- 특정 단어 제거: 빈 문자열('')로 치환
SELECT REPLACE(name, '구이', '') FROM menus WHERE menu_name LIKE '%구이%';

-- 문법: LPAD(문자열, 총자릿수, 채울문자)
SELECT
    id,
    LPAD(id, 5, '0') AS 주문번호
FROM menus;
-- RPAD(문자열, 총자릿수, 채울문자): 오른쪽 채우기 (좌우 반대)

-- 문법: UPPER(문자열), LOWER(문자열)

SELECT
    UPPER('chicken') AS 대문자,    -- 'CHICKEN'
    LOWER('CHICKEN') AS 소문자;    -- 'chicken'
    
-- 실무 활용: 대소문자 무관한 비교
SELECT * FROM restaurants WHERE LOWER(category) = 'chicken';

SELECT ROUND(4500/1000, 0);
SELECT CEIL(4500/1000);
SELECT FLOOR(4500/1000);
-- ROUND의 두 번째 인수
SELECT ROUND(1234.567, 2);    -- 1234.57
SELECT ROUND(1234.567, 0);    -- 1235
SELECT ROUND(1234.567, -2);   -- 1200 (십의 자리 기준 반올림)

-- 문법: MOD(피제수, 제수) or 피제수 % 제수

SELECT
    name,
    price,
    MOD(price, 1000) AS 천원미만나머지,
    price - MOD(price, 1000) AS 천원절사가격
FROM menus;

-- 문법: TRUNCATE(값, 소수점자리)

SELECT
    rating,
    TRUNCATE(rating, 0) AS TRUNCATE결과,  -- 4.8 -> 4 (그냥 자름)
    FLOOR(rating)       AS FLOOR결과      -- 4.8 -> 4 (양수에서는 동일)
FROM restaurants;

SELECT
    rating,
    TRUNCATE(rating, 0) AS TRUNCATE결과,  -- -4.8 -> -4 (그냥 자름)
    FLOOR(rating)       AS FLOOR결과      -- -4.8 -> -5 (무조건 내림)
FROM restaurants;

select truncate(111, -1);

SELECT
    created_at,
    DATE_FORMAT(created_at, '%Y년 %m월 %d일')  AS 한국형식,
    DATE_FORMAT(created_at, '%Y-%m-%d')         AS ISO형식,
    DATE_FORMAT(created_at, '%m/%d/%Y')         AS 미국형식
FROM customers;

-- 문법: DATEDIFF(날짜1, 날짜2) -> 날짜1 - 날짜2 (일 수)

-- 문법: DATEDIFF(날짜1, 날짜2) -> 날짜1 - 날짜2 (일 수)

SELECT
    customer_id,
    order_date,
    timestampdiff(NOW(), order_date) AS 주문후일수
FROM orders
where customer_id = 1
ORDER BY 주문후일수 DESC;

-- 문법: TIMESTAMPDIFF(단위, 시작날짜, 종료날짜)
SELECT TIMESTAMPDIFF(YEAR, '2026-08-01', '2028-10-12');
SELECT TIMESTAMPDIFF(MONTH, '2026-08-01', '2026-10-12');
SELECT TIMESTAMPDIFF(DAY, '2026-08-01', '2026-08-12');
SELECT TIMESTAMPDIFF(HOUR, '2026-08-01 10:00:00', '2026-08-02 11:00:00');
SELECT TIMESTAMPDIFF(MINUTE, '2026-08-01 10:00:00', '2026-08-02 11:00:00');
SELECT TIMESTAMPDIFF(SECOND, '2026-08-01', '2026-08-02');

-- 문법: DATE_ADD(날짜, INTERVAL 값 단위)
SELECT
    NOW()                               AS 현재,
    DATE_ADD(NOW(), INTERVAL 7 DAY)     AS 7일후,
    DATE_ADD(NOW(), INTERVAL 1 MONTH)   AS 1달후,
    DATE_SUB(NOW(), INTERVAL 1 MONTH)   AS 1달전,
    DATE_SUB(NOW(), INTERVAL 1 YEAR)    AS 1년전;
    
-- 실무 예시: 최근 500일 내 주문내역 조회
SELECT customer_id, order_date
FROM orders
WHERE order_date >= DATE_SUB(NOW(), INTERVAL 500 DAY);

SELECT
    order_date,
    YEAR(order_date)  AS 연도,
    MONTH(order_date) AS 월,
    DAY(order_date)   AS 일
FROM orders;

-- 문법: IFNULL(값, NULL일때 대체값)
SELECT
    name,
    IFNULL(email, '이메일 없음') AS 이메일
FROM customers;

-- 문법: IF(조건, 참일때_값, 거짓일때_값)

SELECT
    name,
    price,
    IF(price >= 10000, '고가', '저가') AS 가격분류
FROM menus;

-- 문법
-- CASE
--     WHEN 조건1 THEN 값1
--     WHEN 조건2 THEN 값2
--     ELSE 기본값
-- END

-- 예제 1
SELECT
    name,
    price,
    CASE
        WHEN price >= 15000 THEN '고가'
        WHEN price >= 8000  THEN '중가'
        ELSE                     '저가'
    END AS 가격대
FROM menus
ORDER BY price DESC;

-- 예제 2
SELECT
    name,
    rating,
    CASE
        WHEN rating >= 4.5 THEN '⭐⭐⭐ 최우수'
        WHEN rating >= 4.0 THEN '⭐⭐ 우수'
        WHEN rating >= 3.5 THEN '⭐ 보통'
        ELSE                    '개선 필요'
    END AS 등급
FROM restaurants
ORDER BY rating DESC;

-- 문법: SELECT DISTINCT 컬럼명 FROM 테이블;
-- 중복 포함: 한식, 한식, 치킨, 치킨, 치킨, 피자 ...
SELECT category FROM restaurants;
-- 중복 제거: 한식, 치킨, 피자, 중식, 분식
SELECT DISTINCT category FROM restaurants;
-- 카테고리가 같아도 가게 이름이 다르면 중복이 아님
SELECT DISTINCT category, name FROM restaurants;

-- 문법: 컬럼명 AS 별칭 (AS는 생략 가능하지만 쓰는 것이 명확)

-- 1. 컬럼 별칭
SELECT name AS 가게이름, rating AS 평점
FROM restaurants;

-- 2. 계산식 별칭
SELECT
    name,
    price,
    ROUND(price * 1.1, 0) AS VAT포함가격
FROM menus;

-- 3. 함수 결과 별칭
SELECT CONCAT(name, ' (', category, ')') AS 가게정보
FROM restaurants;

-- 잘못된 예: WHERE에서 별칭 사용 불가
SELECT ROUND(price * 1.1, 0) AS VAT포함가격 FROM menus WHERE VAT포함가격 > 10000;

-- 올바른 예
SELECT ROUND(price * 1.1, 0) AS VAT포함가격 FROM menus WHERE ROUND(price * 1.1, 0) > 10000;