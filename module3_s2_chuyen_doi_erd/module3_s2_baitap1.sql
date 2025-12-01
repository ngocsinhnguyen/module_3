create database chuyen_doi_ERD;

use chuyen_doi_ERD;

create table PHIEUXUAT (
    SoPX char(10),
    NgayXuat date,
    primary key(SoPX)
);

create table PHIEUNHAP (
    SoPN char(10),
    NgayNhap date,
    primary key(SoPN)
);

create table VATTU (
    MaVTU char(10),
    TenVTU varchar(50),
    primary key(MaVTU)
);

create table NHACC (
    MaNCC char(10),
    TenNCC varchar(50),
    DiaChi varchar(100),
    SDT varchar(15),
    primary key(MaNCC)
);
 
create table DONDH (
    SoDH char(10),
    NgayDH date,
    MaNCC char(10),
    primary key(SoDH),
    foreign key (MaNCC) references NHACC(MaNCC)
); 

-- PHIEUXUAT và VATTU
create table CHITIET_PHIEUXUAT (
    SoPX char(10),
    MaVTU char(10),
    DGXuat decimal(18, 2), 
    SLXuat int,
    primary key (SoPX, MaVTU),
    foreign key (SoPX) references PHIEUXUAT(SoPX),
    foreign key (MaVTU) references VATTU(MaVTU)
);

--  PHIEUNHAP và VATTU
create table CHITIET_PHIEUNHAP (
    SoPN char(10),
    MaVTU char(10),
    DGNhap decimal(18, 2),
    SLNhap int,            
    primary key (SoPN, MaVTU),
    foreign key (SoPN) references PHIEUNHAP(SoPN),
    foreign key (MaVTU) references VATTU(MaVTU)
);

--  VATTU và DONDH
create table CHITIET_DONDH (
    MaVTU char(10),
    SoDH char(10),
    primary key (MaVTU, SoDH),
    foreign key (MaVTU) references VATTU(MaVTU),
    foreign key (SoDH) references DONDH(SoDH)
);


