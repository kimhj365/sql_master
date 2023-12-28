create table product (
 product_code char(8) primary key, -- P2023-01
 product_name varchar2(100) not null,
 product_desc varchar2(300) not null,
 origin_price number not null,
 sale_price number,
 like_it number default 3, --��õ��
 image varchar2(30)
);
insert into product values('P2023-01', '���׸��� ��Ƽ����', '���׸���� �����Դϴ�.', 5000, 4500, 5, '���׸���.jpg');
insert into product values('P2023-02', '��ī�󱸾� �ƶ��ī', '��ī�󱸾ƻ� �����Դϴ�.', 5500, 4500, 2, '��ī�󱸾� ��ġ.jpg');
insert into product values('P2023-03', '����� ���佺', '������� �����Դϴ�.', 6000, 5000, 3, '��������佺.jpg');
insert into product values('P2023-04', '��Ƽ���Ǿ� ����ü��', '��Ƽ���Ǿƻ� �����Դϴ�.', 4000, 3500, 4, '��Ƽ���Ǿ� ����ü��.jpg');
insert into product values('P2023-05', '�ɳ� ��ũ�����', '�ɳĻ� �����Դϴ�.', 4500, 3000, 0, '�ɳ� ��ũ�����.jpg');
insert into product values('P2023-06', '�ڽ�Ÿ��ī ������', '�ڽ�Ÿ��ī�� �����Դϴ�.', 3000, 2500, 1, '�ڽ�Ÿ��ī ������.jpg');

ALTER TABLE product
MODIFY (image VARCHAR2(50));

SELECT * FROM product ORDER BY 1;