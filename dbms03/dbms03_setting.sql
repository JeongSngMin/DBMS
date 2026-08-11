CREATE DATABASE db03
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_unicode_ci;

USE db03;

CREATE TABLE customers (
    id          INT           NOT NULL AUTO_INCREMENT,
    name        VARCHAR(20)   NOT NULL,
    phone       VARCHAR(15)   NOT NULL,
    address     VARCHAR(100),
    email       VARCHAR(60),               
    created_at  DATETIME      DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE restaurants (
    id          INT           NOT NULL AUTO_INCREMENT,
    name        VARCHAR(40)   NOT NULL,
    category    VARCHAR(20)   NOT NULL,
    address     VARCHAR(100),
    rating      DECIMAL(2,1)  DEFAULT 4.0,
    PRIMARY KEY (id)
);

CREATE TABLE menus (
    id              INT         NOT NULL AUTO_INCREMENT,
    restaurant_id   INT         NOT NULL,
    name            VARCHAR(40) NOT NULL,
    price           INT         NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE orders (
    id              INT      NOT NULL AUTO_INCREMENT,
    customer_id     INT      NOT NULL,
    restaurant_id   INT      NOT NULL,
    menu_id         INT      NOT NULL,
    quantity        INT      DEFAULT 1,
    total_price     INT      NOT NULL,
    order_date      DATETIME,
    delivery_fee    INT      DEFAULT 3000,
    PRIMARY KEY (id)
);

INSERT INTO customers (name, phone, address, email) VALUES
('김민준', '010-1234-5678', '부산시 해운대구 우동 101',   'minjun@email.com'),
('이서연', '010-2345-6789', '부산시 수영구 광안동 202',   'seoyeon@email.com'),
('박지호', '010-3456-7890', '부산시 남구 대연동 303',     NULL),
('최수아', '010-4567-8901', '부산시 동래구 온천동 404',   'sua@email.com'),
('정우진', '010-5678-9012', '부산시 부산진구 전포동 505', 'woojin@email.com'),
('강하은', '010-6789-0123', '부산시 연제구 거제동 606',   NULL),
('조현서', '010-7890-1234', '부산시 사하구 하단동 707',   'hyunseo@email.com'),
('윤도윤', '010-8901-2345', '부산시 북구 구포동 808',     'doyoon@email.com'),
('임지아', '010-9012-3456', '부산시 강서구 명지동 909',   NULL),
('한준서', '010-0123-4567', '부산시 기장군 일광읍 010',   'junser@email.com');

INSERT INTO restaurants (name, category, address, rating) VALUES
('해운대 치킨집',   '치킨',       '부산시 해운대구 우동 1번길',     4.5),  -- id: 1
('광안리 피자',     '피자',       '부산시 수영구 광안해변로 2',     4.2),  -- id: 2
('남포 짜장면',     '중식',       '부산시 중구 남포동 3번길',       4.0),  -- id: 3
('서면 삼겹살',     '한식',       '부산시 부산진구 서면로 4',       4.7),  -- id: 4
('동래 분식',       '분식',       '부산시 동래구 온천천로 5',       3.9),  -- id: 5
('기장 회덮밥',     '일식',       '부산시 기장군 기장읍 6번길',     4.6),  -- id: 6
('해운대 버거',     '패스트푸드', '부산시 해운대구 해운대로 7',     4.1),  -- id: 7
('수영 돈까스',     '일식',       '부산시 수영구 수영로 8',         4.3),  -- id: 8
('부산진 국밥',     '한식',       '부산시 부산진구 가야대로 9',     4.4),  -- id: 9
('사직 떡볶이',     '분식',       '부산시 동래구 사직로 10',        3.8);  -- id: 10

INSERT INTO menus (restaurant_id, name, price) VALUES
-- 1. 해운대 치킨집
(1, '후라이드 치킨',   16000),  -- id:  1
(1, '양념 치킨',       17000),  -- id:  2
(1, '간장 치킨',       18000),  -- id:  3
-- 2. 광안리 피자
(2, '불고기 피자',     22000),  -- id:  4
(2, '콤비네이션 피자', 23000),  -- id:  5
-- 3. 남포 짜장면
(3, '짜장면',           6000),  -- id:  6
(3, '짬뽕',             7000),  -- id:  7
(3, '탕수육',          18000),  -- id:  8
-- 4. 서면 삼겹살
(4, '삼겹살 2인분',    28000),  -- id:  9
(4, '항정살 2인분',    33000),  -- id: 10
-- 5. 동래 분식
(5, '떡볶이',           5000),  -- id: 11
(5, '순대',             4500),  -- id: 12
(5, '튀김 세트',        6000),  -- id: 13
-- 6. 기장 회덮밥
(6, '연어 회덮밥',     15000),  -- id: 14
(6, '참치 회덮밥',     13000),  -- id: 15
-- 7. 해운대 버거
(7, '스모크 버거',     10000),  -- id: 16
(7, '치즈 버거',        9000),  -- id: 17
-- 8. 수영 돈까스
(8, '치즈 돈까스',     12000),  -- id: 18
(8, '로스 돈까스',     10000),  -- id: 19
-- 9. 부산진 국밥
(9, '돼지 국밥',        9000),  -- id: 20
(9, '내장 국밥',        9500),  -- id: 21
-- 10. 사직 떡볶이
(10, '매운 떡볶이',     5500),  -- id: 22
(10, '치즈 떡볶이',     6500);  -- id: 23