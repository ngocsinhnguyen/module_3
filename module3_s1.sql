create database module3_s1;

use module3_s1 ;


create table students(
	id int not null,
    name varchar(100),
    primary key (id)
);

create table teachers(
	id int not null,
    name varchar(100),
	age int check (age > 0) not null,
    country varchar(100),
    primary key (id)
);