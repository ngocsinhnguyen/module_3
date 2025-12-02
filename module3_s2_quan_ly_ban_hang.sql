create database s2_quan_ly_ban_hang;

use s2_quan_ly_ban_hang;


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