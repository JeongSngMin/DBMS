-- 허술한 테이블
CREATE TABLE restaurants_v1 (
    id       INT,
    name     VARCHAR(100),
    category VARCHAR(50)
);

-- 이상한 데이터 마구 넣기
INSERT INTO restaurants_v1 VALUES (NULL, '테스트가게', '한식');  -- id가 NULL?
INSERT INTO restaurants_v1 VALUES (1, '부산맛집A', '한식');
INSERT INTO restaurants_v1 VALUES (1, '부산맛집B', '치킨');  -- id 1이 또?!
INSERT INTO restaurants_v1 VALUES (2, NULL, '피자');  -- 이름 없는 가게?
INSERT INTO restaurants_v1 VALUES (NULL, NULL, NULL);   -- 전부 비어있다?

SELECT * FROM restaurants_v1;

CREATE TABLE test_pk (
    id   INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_pk VALUES (1, '가게A');    -- 성공
INSERT INTO test_pk VALUES (1, '가게B');    -- 에러! id 1 중복
INSERT INTO test_pk VALUES (NULL, '가게C'); -- 에러! PK는 NULL 불가

CREATE TABLE test_pk2 (
    id   INT,
    name VARCHAR(50),
    phone VARCHAR(100),
    primary key(id, name)
);

INSERT INTO test_pk2 VALUES (1, '가게A', '010-0000-0000');    -- 성공
INSERT INTO test_pk2 VALUES (1, '가게B', '010-1111-1111');    -- 성공
INSERT INTO test_pk2 VALUES (1, '가게B', '010-2222-2222');    -- 에러! (id, name) 중복
INSERT INTO test_pk2 VALUES (NULL, '가게C', '010-3333-3333'); -- 에러! 복합PK는 모두 not null
INSERT INTO test_pk2 VALUES (NULL, NULL, '010-3333-3333'); -- 에러! PK는 NULL 불가

CREATE TABLE test_ai (
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

INSERT INTO test_ai (name) VALUES ('가게A');  -- id 자동: 1
INSERT INTO test_ai (name) VALUES ('가게B');  -- id 자동: 2
INSERT INTO test_ai (name) VALUES ('가게C');  -- id 자동: 3

SELECT * FROM test_ai;

DELETE FROM test_ai WHERE id = 3;
INSERT INTO test_ai (name) VALUES ('가게D');

CREATE TABLE test_nn (
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,       -- 필수
    memo VARCHAR(100)                -- 선택 (NULL 허용)
);

INSERT INTO test_nn (name, memo) VALUES ('부산명가', '맛있음');  -- 성공
INSERT INTO test_nn (name) VALUES ('해운대통닭');                 -- 성공 (memo는 선택)
INSERT INTO test_nn (memo) VALUES ('설명만');                    -- 에러! name은 필수

CREATE TABLE test_uq (
    id    INT PRIMARY KEY AUTO_INCREMENT,
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE           -- NULL은 여러 개 가능
);

INSERT INTO test_uq (phone, email) VALUES ('010-1111-2222', 'a@test.com');  -- 성공
INSERT INTO test_uq (phone, email) VALUES ('010-3333-4444', NULL);          -- 성공 (NULL)
INSERT INTO test_uq (phone, email) VALUES ('010-5555-6666', NULL);          -- 성공 (NULL 중복 허용)
INSERT INTO test_uq (phone, email) VALUES ('010-1111-2222', 'b@test.com');  -- 에러! phone 중복

CREATE TABLE test_def (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(50) NOT NULL,
    rating     DECIMAL(2,1) DEFAULT 0.0,
    is_open    BOOLEAN      DEFAULT TRUE,
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- rating, is_open, created_at을 명시하지 않아도 기본값이 들어갑니다
INSERT INTO test_def (name) VALUES ('새로운 가게');

SELECT * FROM test_def;

CREATE TABLE test_chk (
    id    INT PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(50) NOT NULL,
    price INT NOT NULL CHECK (price > 0)
);

INSERT INTO test_chk (name, price) VALUES ('갈비탕', 13000);    -- 성공
INSERT INTO test_chk (name, price) VALUES ('공짜음식', 0);       -- 에러! 0은 > 0 불만족
INSERT INTO test_chk (name, price) VALUES ('마이너스', -5000);   -- 에러! 음수

-- 참조하는 테이블부터 먼저 삭제
DROP TABLE IF EXISTS menus;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id               INT          PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(50)  NOT NULL,
    category         VARCHAR(20)  NOT NULL,
    address          VARCHAR(100),
    rating           DECIMAL(2,1) DEFAULT 0.0,
    created_at       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers (
    id               INT          PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(30)  NOT NULL,
    phone            VARCHAR(20)  UNIQUE NOT NULL,
    email            VARCHAR(100) UNIQUE,
    address          VARCHAR(100),
    joined_at        TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menus (
    id               INT          PRIMARY KEY AUTO_INCREMENT,
    restaurant_id    INT          NOT NULL,
    menu_name        VARCHAR(50)  NOT NULL,
    price            INT          NOT NULL CHECK (price > 0),
    menu_description VARCHAR(200),
    is_available     BOOLEAN      DEFAULT TRUE
);