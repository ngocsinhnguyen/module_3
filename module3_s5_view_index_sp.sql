create database demo;
use demo;

create table products (
    id int auto_increment primary key,
    product_code varchar(50) not null,
    product_name varchar(100) not null,
    product_price decimal(10,2) not null,
    product_amount int not null,
    product_description text,
    product_status varchar(20)
);

insert into products (product_code, product_name, product_price, product_amount, product_description, product_status)
values
('p001', 'laptop_dell', 1500.00, 10, 'laptop dell inspiron', 'available'),
('p002', 'iphone_15', 1200.00, 5, 'apple iphone 15 pro', 'available'),
('p003', 'samsung_galaxy_s24', 1100.00, 8, 'samsung flagship phone', 'available'),
('p004', 'macbook_air', 1800.00, 3, 'apple macbook air m2', 'out_of_stock');

-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
create unique index idx_product_code 
on products(product_code);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
create index idx_product_name_price 
on products(product_name, product_price);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * 
from products 
where product_code = 'p001';

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view v_products as
select product_code, product_name, product_price, product_status
from products;

-- Tiến hành sửa đổi view
alter view v_products as
select product_code, product_name, product_price, product_status, product_amount
from products;

-- Tiến hành xoá view
drop view v_products;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure get_all_products()
begin
    select * from products;
end //
delimiter ;

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure add_product(
    in p_code varchar(50),
    in p_name varchar(100),
    in p_price decimal(10,2),
    in p_amount int,
    in p_desc text,
    in p_status varchar(20)
)
begin
    insert into products(product_code, product_name, product_price, product_amount, product_description, product_status)
    values (p_code, p_name, p_price, p_amount, p_desc, p_status);
end //
delimiter ;

-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure update_product_by_id(
    in p_id int,
    in p_name varchar(100),
    in p_price decimal(10,2),
    in p_amount int,
    in p_desc text,
    in p_status varchar(20)
)
begin
    update products
    set product_name = p_name,
        product_price = p_price,
        product_amount = p_amount,
        product_description = p_desc,
        product_status = p_status
    where id = p_id;
end //
delimiter ;

-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure delete_product_by_id(in p_id int)
begin
    delete from products where id = p_id;
end //
delimiter ;
