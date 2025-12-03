create database chuyen_doi_erd;

use chuyen_doi_erd;

create table phieu_xuat (
    so_px char(10),
    ngay_xuat date,
    primary key(so_px)
);

create table phieu_nhap (
    so_pn char(10),
    ngay_nhap date,
    primary key(so_pn)
);

create table vat_tu (
    ma_vtu char(10),
    ten_vtu varchar(50),
    primary key(ma_vtu)
);

create table nha_cc (
    ma_ncc char(10),
    ten_ncc varchar(50),
    dia_chi varchar(100),
    sdt varchar(15),
    primary key(ma_ncc)
);
 
create table don_dh (
    so_dh char(10),
    ngay_dh date,
    ma_ncc char(10),
    primary key(so_dh),
    foreign key (ma_ncc) references nha_cc(ma_ncc)
); 

-- PHIEUXUAT và VATTU
create table chi_tiet_phieu_xuat (
    so_px char(10),
    ma_vtu char(10),
    dg_xuat decimal(18, 2), 
    sl_xuat int,
    primary key (so_px, ma_vtu),
    foreign key (so_px) references phieu_xuat(so_px),
    foreign key (ma_vtu) references vat_tu(ma_vtu)
);

--  PHIEUNHAP và VATTU
create table chi_tiet_phieu_nhap (
    so_pn char(10),
    ma_vtu char(10),
    dg_nhap decimal(18, 2),
    sl_nhap int,            
    primary key (so_pn, ma_vtu),
    foreign key (so_pn) references phieu_nhap(so_pn),
    foreign key (ma_vtu) references vat_tu(ma_vtu)
);

--  VATTU và DONDH
create table chi_tiet_don_dh (
    ma_vtu char(10),
    so_dh char(10),
    primary key (ma_vtu, so_dh),
    foreign key (ma_vtu) references vat_tu(ma_vtu),
    foreign key (so_dh) references don_dh(so_dh)
);



