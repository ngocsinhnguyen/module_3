create database s2_quan_ly_ban_hang;

use s2_quan_ly_ban_hang;


create table Customer (
    cID int,
    cName varchar(100) not null,
    cAge int check (cAge > 0),
    primary key(cID)
);

create table Product (
    pID int,
    pName varchar(100) not null,
    pPrice decimal(10, 2) not null check (pPrice >= 0),
    primary key(pID)
);

create table `Order` ( 
    oID int , 
    cID int not null, 
    oDate date not null, 
    oTotalPrice decimal(10, 2),
    foreign key (cID) references Customer(cID),
    primary key(oID)
);

create table OrderDetail (
    oID int,
    pID int, 
    odQTY int not null check (odQTY > 0) , 
    primary key (oID, pID), 
    foreign key (oID) references `Order`(oID), 
    foreign key (pID) references Product(pID)
);