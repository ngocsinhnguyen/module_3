create database module3;

use module3 ;

create table students(
	id int not null,
    students_name varchar(100),
    age int check (age > 0) not null,
	country varchar(100),
    primary key (id)
);

create table teachers(
	id int not null,
    teachers_name varchar(100),
	age int check (age > 0) not null,
    country varchar(100),
    primary key (id)
);

create table class(
	id int not null,
    class_name varchar(100),
    primary key(id)
);