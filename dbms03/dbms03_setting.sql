CREATE DATABASE db03
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_unicode_ci;

USE db03;

CREATE TABLE restaurants (
    id               INT             PRIMARY KEY AUTO_INCREMENT,  -- PK + 자동증가
    name             VARCHAR(50)     NOT NULL,                    -- 가게 이름 (필수)
    category         VARCHAR(20)     NOT NULL,                    -- 카테고리 (필수)
    address          VARCHAR(100),                                -- 주소 (선택)
    rating           DECIMAL(2,1)    DEFAULT 0.0,                -- 평점 (기본값 0.0)
    created_at       TIMESTAMP       DEFAULT CURRENT_TIMESTAMP   -- 등록일시 (자동)
);

CREATE TABLE customers (
    id               INT             PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(30)     NOT NULL,                    -- 이름 (필수)
    phone            VARCHAR(20)     UNIQUE NOT NULL,             -- 전화번호 (유일 + 필수)
    email            VARCHAR(100)    UNIQUE,                      -- 이메일 (유일, 선택)
    address          VARCHAR(100),                                -- 주소 (선택)
    joined_at        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP   -- 가입일시 (자동)
);

CREATE TABLE menus (
    id               INT             PRIMARY KEY AUTO_INCREMENT,
    restaurant_id    INT             NOT NULL,                    -- 어느 가게의 메뉴인지 (필수)
    menu_name        VARCHAR(50)     NOT NULL,                    -- 메뉴명 (필수)
    price            INT             NOT NULL CHECK (price > 0), -- 가격 (필수 + 양수 검증)
    menu_description VARCHAR(200),                                -- 설명 (선택)
    is_available     BOOLEAN         DEFAULT TRUE                 -- 판매 여부 (기본: 판매중)
);

INSERT INTO restaurants (name, category, address, rating) VALUES
-- 한식 (3건)
('부산명가갈비',   '한식', '부산시 동래구 동래로 102',      4.5),
('해운대순대국',   '한식', '부산시 해운대구 해운대로 234',   4.2),
('남포동비빔밥',   '한식', '부산시 중구 남포동 광복로 55',   4.7),
-- 치킨 (2건)
('해운대통닭',     '치킨', '부산시 해운대구 달맞이길 88',    4.4),
('서면바삭치킨',   '치킨', '부산시 부산진구 서면로 301',     3.9),
-- 피자 (2건)
('광안리피자랩',   '피자', '부산시 수영구 광안해변로 77',    4.1),
('사직피자하우스', '피자', '부산시 동래구 사직로 45',        3.8),
-- 중식 (2건)
('연산동짬뽕왕',   '중식', '부산시 연제구 연산로 66',        4.3),
('서면차이나팰리스','중식', '부산시 부산진구 중앙대로 189',   4.0),
-- 분식 (1건)
('광안리떡볶이집', '분식', '부산시 수영구 광안리해변로 12',  4.6);

INSERT INTO customers (name, phone, email, address) VALUES
('김민준', '010-1234-5678', 'minjun.kim@gmail.com',   '부산시 해운대구 우동 101'),
('이서연', '010-2345-6789', 'seoyeon.lee@naver.com',  '부산시 수영구 광안동 202'),
('박지훈', '010-3456-7890', 'jihoon.park@kakao.com',  '부산시 부산진구 전포동 303'),
('최수아', '010-4567-8901', NULL,                     '부산시 동래구 온천동 404'),   -- 이메일 없음
('정태영', '010-5678-9012', 'taeyoung.j@gmail.com',   '부산시 남구 대연동 505'),
('한유진', '010-6789-0123', NULL,                     '부산시 연제구 거제동 606'),   -- 이메일 없음
('오다은', '010-7890-1234', 'daeun.oh@naver.com',     '부산시 중구 남포동 707'),
('임재현', '010-8901-2345', 'jaehyun.lim@daum.net',   '부산시 사하구 다대동 808'),
('강보라', '010-9012-3456', 'bora.kang@gmail.com',    '부산시 북구 화명동 909'),
('윤성호', '010-0123-4567', NULL,                     '부산시 기장군 기장읍 10-1');  -- 이메일 없음

-- 1번 가게: 부산명가갈비 (한식)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(1, '갈비탕',     13000, '24시간 우려낸 진한 사골 베이스에 부드러운 갈비가 듬뿍'),
(1, '소갈비구이', 25000, '국내산 한우 소갈비를 숯불에 직접 구워드립니다'),
(1, '된장찌개',    9000, NULL);

-- 2번 가게: 해운대순대국 (한식)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(2, '순대국밥',    9000, '매콤하고 구수한 부산식 순대국밥'),
(2, '내장탕',     10000, NULL),
(2, '수육정식',   14000, '보쌈수육 + 국밥 + 반찬 세트');

-- 3번 가게: 남포동비빔밥 (한식)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(3, '돌솥비빔밥',  11000, '돌솥에 바삭하게 눌린 누룽지까지 즐길 수 있는 비빔밥'),
(3, '산채비빔밥',   9000, '각종 나물을 듬뿍 올린 건강한 비빔밥'),
(3, '육회비빔밥',  14000, NULL);

-- 4번 가게: 해운대통닭 (치킨)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(4, '후라이드치킨', 18000, '바삭한 황금빛 후라이드, 1마리 기준'),
(4, '양념치킨',    19000, '달콤매콤한 양념 소스 치킨'),
(4, '반반치킨',    20000, '후라이드 반 + 양념 반 구성');

-- 5번 가게: 서면바삭치킨 (치킨)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(5, '간장치킨',    19000, '달콤한 간장 소스로 버무린 인기 메뉴'),
(5, '파닭',        20000, NULL),
(5, '치킨무세트',   5000, '치킨 주문 시 추가 가능한 치킨무 세트');

-- 6번 가게: 광안리피자랩 (피자)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(6, '마르게리따피자', 18000, '토마토소스, 모짜렐라, 바질의 정통 이탈리안'),
(6, '불고기피자',   20000, '국내산 불고기와 각종 야채가 올라간 인기 피자'),
(6, '고구마무스피자',19000, NULL);

-- 7번 가게: 사직피자하우스 (피자)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(7, '콤비네이션피자', 22000, '페퍼로니, 피망, 올리브, 버섯이 가득'),
(7, '포테이토피자',  19000, '부드러운 크림소스 베이스의 감자 피자'),
(7, '치즈크러스트피자',23000, NULL);

-- 8번 가게: 연산동짬뽕왕 (중식)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(8, '짬뽕',        11000, '불맛 가득한 얼큰한 해물짬뽕'),
(8, '짜장면',       9000, '춘장을 오래 볶아 깊은 풍미의 정통 짜장면'),
(8, '탕수육',      18000, '바삭한 튀김에 새콤달콤 소스, 부먹/찍먹 선택 가능');

-- 9번 가게: 서면차이나팰리스 (중식)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(9, '마파두부',     12000, '얼얼하고 매콤한 사천식 마파두부'),
(9, '군만두',        8000, NULL),
(9, '볶음밥',       10000, '각종 재료를 넣어 센 불에 볶아낸 중화식 볶음밥');

-- 10번 가게: 광안리떡볶이집 (분식)
INSERT INTO menus (restaurant_id, menu_name, price, menu_description) VALUES
(10, '국물떡볶이',   7000, '쌀떡과 어묵이 들어간 부드러운 국물 떡볶이'),
(10, '라볶이',       8000, '떡볶이 + 라면 사리의 환상 조합'),
(10, '분식세트',    12000, '떡볶이 + 순대 + 튀김 3종 세트');

select * from restaurants;
select * from customers;
select * from menus;
