create database delivery_service
	character set utf8mb4
	collate utf8mb4_unicode_ci;
    
use delivery_service;

show databases;

create table restaurants (
	id			INT,
    name		VARCHAR(50),
    category	VARCHAR(20)
);

CREATE TABLE customers (
    id       INT,
    name     VARCHAR(30),
    phone    VARCHAR(20),
    address  VARCHAR(100)
);

CREATE TABLE menus (
    id             INT,
    restaurant_id  INT,
    menu_name      VARCHAR(50),
    price          INT
);

show tables;
desc restaurants;

-- restaurants에 최소주문금액 컬럼 추가
ALTER TABLE restaurants
    ADD COLUMN min_order_amount INT DEFAULT 0;
    
-- name 컬럼을 VARCHAR(30)에서 VARCHAR(50)으로 확장
ALTER TABLE customers
    MODIFY COLUMN name VARCHAR(50) NOT NULL;

ALTER TABLE menus
	ADD COLUMN description VARCHAR(100);
ALTER TABLE menus
	RENAME COLUMN description TO menu_description;
    
-- 컬럼 제거
ALTER TABLE menus
    DROP COLUMN menu_description;