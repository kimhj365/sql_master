create table product (
 product_code char(8) primary key, -- P2023-01
 product_name varchar2(100) not null,
 product_desc varchar2(300) not null,
 origin_price number not null,
 sale_price number,
 like_it number default 3, --추천수
 image varchar2(30)
);
insert into product values('P2023-01', '과테말라 안티구아', '과테말라산 원두입니다.', 5000, 4500, 5, '과테말라.jpg');
insert into product values('P2023-02', '니카라구아 아라비카', '니카라구아산 원두입니다.', 5500, 4500, 2, '니카라구아 더치.jpg');
insert into product values('P2023-03', '브라질 산토스', '브라질산 원두입니다.', 6000, 5000, 3, '브라질산토스.jpg');
insert into product values('P2023-04', '에티오피아 예가체프', '에티오피아산 원두입니다.', 4000, 3500, 4, '에티오피아 예가체프.jpg');
insert into product values('P2023-05', '케냐 오크라톡신', '케냐산 원두입니다.', 4500, 3000, 0, '케냐 오크라톡신.jpg');
insert into product values('P2023-06', '코스타리카 따라주', '코스타리카산 원두입니다.', 3000, 2500, 1, '코스타리카 따라주.jpg');

ALTER TABLE product
MODIFY (image VARCHAR2(50));

SELECT * FROM product ORDER BY 1;