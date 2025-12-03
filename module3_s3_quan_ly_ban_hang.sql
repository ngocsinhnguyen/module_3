create database s3_quan_ly_ban_hang;

use s3_quan_ly_ban_hang;

create table customer (
    c_id int,
    c_name varchar(100) not null,
    c_age int check (c_age > 0),
    primary key(c_id)
);

create table product (
    p_id int,
    p_name varchar(100) not null,
    p_price decimal(10, 2) not null check (p_price >= 0),
    primary key(p_id)
);

create table `order` ( 
    o_id int , 
    c_id int not null, 
    o_date date not null, 
    o_total_price decimal(10, 2),
    foreign key (c_id) references customer(c_id),
    primary key(o_id)
);

create table order_detail (
    o_id int,
    p_id int, 
    od_q_t_y int not null check (od_q_t_y > 0) , 
    primary key (o_id, p_id), 
    foreign key (o_id) references `order`(o_id), 
    foreign key (p_id) references product(p_id)
);

insert into customer (c_id, c_name, c_age) values
(1, 'minh quan', 10),
(2, 'ngoc oanh', 20),
(3, 'hong ha', 50);

insert into product (p_id, p_name, p_price) values
(1, 'may giat', 3),
(2, 'tu lanh', 5),
(3, 'dieu hoa', 7),
(4, 'quat', 1),
(5, 'bep dien', 2);

insert into `order` (o_id, c_id, o_date, o_total_price) values
(1, 1, '2006-03-21', null),
(2, 2, '2006-03-23', null),
(3, 1, '2006-03-16', null);

insert into order_detail (o_id, p_id, od_q_t_y) values
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(3, 3, 3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select 
    o_id, 
    o_date, 
    o_total_price 
from 
    `order`;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select distinct
    c.c_id as 'ma_khach_hang',
    c.c_name as 'ten_khach_hang',
    o.o_id as 'ma_hoa_don',
    p.p_name as 'ten_san_pham_da_mua'
from
    customer c
join
    `order` o on c.c_id = o.c_id
join
    order_detail od on o.o_id = od.o_id
join
    product p on od.p_id = p.p_id
order by 
    c.c_id, p.p_name;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select
    c.c_name as 'khach_hang_khong_mua_hang'
from
    customer c
left join
    `order` o on c.c_id = o.c_id
where
    o.o_id is null;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
select
    o.o_id as 'ma_hoa_don',
    o.o_date as 'ngay_ban',
    sum(od.od_q_t_y * p.p_price) as 'tong_gia_tri_hoa_don'
from
    `order` o
join
    order_detail od on o.o_id = od.o_id
join
    product p on od.p_id = p.p_id
group by
    o.o_id, o.o_date
order by
    o.o_id;
