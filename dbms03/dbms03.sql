-- 단건 INSERT (컬럼명 명시)
INSERT INTO menus (restaurant_id, name, price)
VALUES (1, '양념반후라이드반', 22000);

-- 단건 INSERT (컬럼명 생략)
INSERT INTO menus
VALUES (NULL, 2, '불고기피자', 18000);

-- 다건 INSERT    
INSERT INTO menus (restaurant_id, name, price)
VALUES
    (4, '비빔냉면',    9000),
    (5, '탕수육 (소)', 15000),
    (6, '김치찌개 정식', 8500),
    (7, '마라탕 (소)',  12000),
    (8, '순대국밥',     7000),  
    (9, '스파게티 세트', 13000);
    
select * from restaurants;
SELECT name, category, rating FROM restaurants;

-- 가격 8000원 이상, 15000원 이하 (경계값 포함)
SELECT name, price FROM menus
WHERE price BETWEEN 8000 AND 15000;

-- 치킨, 피자, 분식 중 하나인 가게
SELECT name, category FROM restaurants
WHERE category IN ('치킨', '피자', '분식');

-- 어디든 치킨이 들어가면
SELECT name FROM menus
WHERE name LIKE '%치킨%';

-- 치킨이 앞에 들어가면
SELECT name FROM menus
WHERE name LIKE '치킨%';

-- 치킨이 뒤에 들어가면
SELECT name FROM menus
WHERE name LIKE '%치킨';

-- 치킨 + 1글자
SELECT name FROM menus
WHERE name LIKE '치킨_';

-- ~~~치킨 + 1글자
SELECT name FROM menus
WHERE name LIKE '%치킨_';

-- email 없는 고객
SELECT * FROM customers
WHERE email IS NULL;

-- email 있는 고객
SELECT * FROM customers
WHERE email IS NOT NULL;

-- 의도와 다를 수 있는 쿼리 (AND가 먼저)
SELECT * from restaurants
WHERE category = '치킨' OR category = '피자' AND rating >= 4.0;
-- 실제 계산: category = '치킨' OR (category = '피자' AND rating >= 4.0)

-- 괄호로 의도를 명확히
SELECT * from restaurants
WHERE (category = '치킨' OR category = '피자') AND rating >= 4.0;

-- 평점 높은 순 (내림차순)
SELECT name, rating FROM restaurants ORDER BY rating DESC;

-- 가격 낮은 순 (오름차순, 생략 가능)
SELECT name, price FROM menus ORDER BY price ASC;
SELECT name, price FROM menus ORDER BY price;

-- 카테고리 오름차순 → 같은 카테고리 안에서는 평점 내림차순
SELECT name, category, rating FROM restaurants
ORDER BY category ASC, rating DESC;

-- 상위 N개만
SELECT name, rating FROM restaurants
ORDER BY rating DESC
LIMIT 3;

-- N개를 건너뛰고 M개 가져오기 (페이지네이션)
SELECT name, price FROM menus
ORDER BY id
LIMIT 5 OFFSET 10;   -- 11번째부터 5개

-- id가 1인 가게의 평점 수정
UPDATE restaurants
SET rating = 4.5
WHERE id = 1;

-- 1번 가게 메뉴 가격 10% 인상
UPDATE menus
SET price = price * 1.1
WHERE restaurant_id = 1;

-- 특정 고객 데이터 삭제
DELETE FROM customers
WHERE id = 5;

-- 에러: WHERE는 SELECT보다 먼저 실행되므로 별칭을 인식 못 함
SELECT price * 1.1 AS new_price FROM menus WHERE new_price > 10000;

-- 올바른 방법: 원래 컬럼명이나 식을 그대로 사용
SELECT price * 1.1 AS new_price FROM menus WHERE price * 1.1 > 10000;