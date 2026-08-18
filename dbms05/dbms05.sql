-- orders 전체 행 수 (NULL 여부 무관)
SELECT COUNT(*) FROM orders;

-- COUNT(*)와 COUNT(컬럼명)의 차이
SELECT COUNT(*) AS 전체고객수, COUNT(email) AS 이메일등록수
FROM customers;

-- 전체 총 매출, 총 배달료
SELECT SUM(total_price) AS 총매출, SUM(delivery_fee) AS 총배달료 FROM orders;

-- 평균 주문금액 (소수점 포함)
SELECT AVG(total_price) AS 평균주문금액 FROM orders;

-- 가장 비싼 주문과 가장 저렴한 주문
SELECT MAX(total_price) AS 최고주문금액, MIN(total_price) AS 최저주문금액
FROM orders;

-- 가장 최근 주문일과 가장 오래된 주문일
SELECT MAX(order_date) AS 최근주문일, MIN(order_date) AS 첫주문일
FROM orders;

SELECT COUNT(*) AS 주문수 FROM orders;

SELECT restaurant_id, COUNT(*) AS 주문수
FROM orders
GROUP BY restaurant_id
ORDER BY restaurant_id;

SELECT
  restaurant_id,
  SUM(total_price) AS 총매출
FROM orders
GROUP BY restaurant_id
ORDER BY 총매출 DESC;

-- 틀린 코드: order_date는 GROUP BY에도 없고, 집계함수로 감싸지도 않았음
SELECT restaurant_id, order_date, COUNT(*)
FROM orders
GROUP BY restaurant_id;

-- restaurant_id만 GROUP BY에 있으므로 SELECT에도 그것만 (+ 집계함수)
SELECT restaurant_id, COUNT(*) AS 주문수, SUM(total_price) AS 총매출
FROM orders
GROUP BY restaurant_id
ORDER BY restaurant_id;

SELECT restaurant_id, COUNT(*) AS 주문수
FROM orders
GROUP BY restaurant_id
HAVING 주문수 >= 5
ORDER BY restaurant_id;

-- 오류: HAVING에서 그룹화 전 각 주문 행이 가진 값이 있으면 오류
SELECT restaurant_id, COUNT(*) AS 주문수
FROM orders
GROUP BY restaurant_id
HAVING delivery_fee = 2000 AND 주문수 >= 5;

SELECT restaurant_id, COUNT(*) AS 주문수
FROM orders
WHERE delivery_fee = 2000
GROUP BY restaurant_id
HAVING 주문수 >= 5;

SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS 월,
  COUNT(*) AS 주문수
FROM orders
GROUP BY 월
ORDER BY 월;

SELECT
  DATE_FORMAT(order_date, '%Y-%m')  AS 월,
  COUNT(*)                          AS 주문수,
  SUM(total_price)                  AS 총매출,
  ROUND(AVG(total_price))           AS 평균주문금액
FROM orders
GROUP BY 월
ORDER BY 월;

SELECT
  DATE_FORMAT(order_date, '%Y-%m') AS 월,
  restaurant_id,
  COUNT(*)         AS 주문수,
  SUM(total_price) AS 매출
FROM orders
GROUP BY 월, restaurant_id
ORDER BY 월, 매출 DESC;