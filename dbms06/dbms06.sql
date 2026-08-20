SELECT restaurant_id, SUM(total_price) AS 총매출
FROM orders
GROUP BY restaurant_id
ORDER BY 총매출 DESC;

SELECT
    o.id          AS 주문번호,
    r.name        AS 가게이름,
    r.category    AS 카테고리,
    o.total_price AS 주문금액
FROM orders AS o
    INNER JOIN restaurants AS r ON o.restaurant_id = r.id
ORDER BY o.id
LIMIT 5;

SELECT
    o.id          AS 주문번호,
    c.name        AS 고객이름,
    c.phone       AS 연락처,
    o.total_price AS 주문금액
FROM orders AS o
    INNER JOIN customers AS c ON o.customer_id = c.id
ORDER BY o.id
LIMIT 3;

SELECT
    o.id          AS 주문번호,
    c.name        AS 고객이름,
    r.name        AS 가게이름,
    o.total_price AS 주문금액,
    o.order_date  AS 주문일시
FROM orders AS o
    INNER JOIN restaurants AS r ON o.restaurant_id = r.id
    INNER JOIN customers   AS c ON o.customer_id   = c.id
ORDER BY o.order_date DESC
LIMIT 3;

-- 에러 쿼리: id가 어느 테이블 것인지 모름.
SELECT id, name FROM orders INNER JOIN customers ON orders.customer_id = customers.id;

SELECT orders.id, customers.name FROM orders INNER JOIN customers ON orders.customer_id = customers.id;
-- 테이블명이 길면 쿼리가 너무 길어짐.

SELECT o.id, c.name FROM orders AS o INNER JOIN customers AS c ON o.customer_id = c.id;
-- o, c처럼 짧은 별칭으로 깔끔하게 표현.

SELECT
    r.id,
    r.name,
    o.id AS order_id,
    o.order_date
FROM restaurants r
LEFT JOIN orders o
    ON r.id = o.restaurant_id
    AND o.order_date >= '2025-04-01'
    AND o.order_date <  '2025-05-01'
ORDER BY r.id;

SELECT
    r.id,
    r.name,
    r.category,
    r.address
FROM restaurants r
LEFT JOIN orders o
    ON r.id = o.restaurant_id
    AND o.order_date >= '2025-04-01'
    AND o.order_date <  '2025-05-01'
WHERE o.id IS NULL
ORDER BY r.id;

-- RIGHT JOIN 예시: 모든 가게 + 주문 건수 (없으면 0)
SELECT
    r.name               AS 가게이름,
    -- IFNULL(COUNT(o.id), 0) AS 주문건수
    COUNT(o.id) AS 주문건수
FROM orders AS o
    RIGHT JOIN restaurants AS r ON o.restaurant_id = r.id
GROUP BY r.id, r.name
ORDER BY 주문건수 DESC;

-- 위와 동일한 결과를 LEFT JOIN으로 표현:
SELECT
    r.name               AS 가게이름,
    IFNULL(COUNT(o.id), 0) AS 주문건수
FROM restaurants AS r
    LEFT JOIN orders AS o ON r.id = o.restaurant_id
GROUP BY r.id, r.name
ORDER BY 주문건수 DESC;

SELECT
    c.name AS 고객이름,
    m.name AS 메뉴이름
FROM customers AS c
    CROSS JOIN menus AS m
LIMIT 10;

SELECT
    r1.name     AS 가게A,
    r2.name     AS 가게B,
    r1.category AS 공통카테고리
FROM restaurants AS r1
    INNER JOIN restaurants AS r2
        ON  r1.category = r2.category   -- 같은 카테고리
        AND r1.id < r2.id               -- 중복 쌍 방지 (A-B와 B-A를 동시에 안 뽑기)
ORDER BY r1.category, r1.name;


-- 9. JOIN + GROUP BY
-- Step1. JOIN
SELECT o.id, r.name, o.total_price
FROM orders AS o
    INNER JOIN restaurants AS r ON o.restaurant_id = r.id
LIMIT 5;

-- Step2. GROUP BY 추가 (집계 기준 컬럼 결정)
SELECT r.name, SUM(o.total_price)
FROM orders AS o
    INNER JOIN restaurants AS r ON o.restaurant_id = r.id
GROUP BY r.id, r.name;

-- Step3. SELECT 컬럼을 보기 좋게 다듬고 별칭 추가
SELECT
    r.name             AS 가게이름,
    COUNT(o.id)        AS 주문건수,
    SUM(o.total_price) AS 총매출
FROM orders AS o
    INNER JOIN restaurants AS r ON o.restaurant_id = r.id
GROUP BY r.id, r.name;

-- Step4. HAVING, ORDER BY, LIMIT 추가
SELECT
    r.name             AS 가게이름,
    COUNT(o.id)        AS 주문건수,
    SUM(o.total_price) AS 총매출
FROM orders AS o
    INNER JOIN restaurants AS r ON o.restaurant_id = r.id
GROUP BY r.id, r.name
HAVING SUM(o.total_price) > 100000   -- 총매출 10만원 초과인 가게만
ORDER BY 총매출 DESC;

-- 가게 이름별 매출 랭킹
SELECT
    r.name        AS 가게이름,
    r.category    AS 카테고리,
    COUNT(o.id)   AS 주문건수,
    SUM(o.total_price) AS 총매출,
    ROUND(AVG(o.total_price), 0) AS 평균주문금액
FROM orders AS o
    INNER JOIN restaurants AS r ON o.restaurant_id = r.id
GROUP BY r.id, r.name, r.category
ORDER BY 총매출 DESC
LIMIT 3;