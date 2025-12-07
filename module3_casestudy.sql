create database case_study;
use case_study;

create table vi_tri (
    id_vi_tri int primary key auto_increment,
    ten_vi_tri varchar(45)
);

create table trinh_do (
    id_trinh_do int primary key auto_increment,
    ten_trinh_do varchar(45)
);

create table bo_phan (
    id_bo_phan int primary key auto_increment,
    ten_bo_phan varchar(45)
);

create table nhan_vien (
    id_nhan_vien int primary key auto_increment,
    ho_ten varchar(45),
    id_vi_tri int,
    id_trinh_do int,
    id_bo_phan int,
    ngay_sinh date,
    so_cmtnd varchar(45),
    luong int,
    sdt varchar(45),
    email varchar(45),
    dia_chi varchar(100),
    foreign key (id_vi_tri) references vi_tri(id_vi_tri),
    foreign key (id_trinh_do) references trinh_do(id_trinh_do),
    foreign key (id_bo_phan) references bo_phan(id_bo_phan)
);

create table loai_khach (
    id_loai_khach int primary key auto_increment,
    ten_loai_khach varchar(45)
);

create table khach_hang (
    id_khach_hang int primary key auto_increment,
    id_loai_khach int,
    ho_ten varchar(45),
    ngay_sinh date,
    so_cmtnd varchar(45),
    sdt varchar(45),
    email varchar(45),
    dia_chi varchar(45),
    gioi_tinh varchar(10),
	foreign key  (id_loai_khach) references loai_khach(id_loai_khach)
);

create table kieu_thue (
    id_kieu_thue int primary key auto_increment,
    ten_kieu_thue varchar(45),
    gia int
);

create table loai_dich_vu (
    id_loai_dich_vu int primary key auto_increment,
    ten_loai_dich_vu varchar(45)
);

create table dich_vu (
    id_dich_vu int primary key auto_increment,
    ten_dich_vu varchar(100),
    dien_tich int,
    so_tang int,
    so_nguoi_toi_da int,
    chi_phi_thue int,
    id_kieu_thue int,
    id_loai_dich_vu int,
    trang_thai varchar(45),
    foreign key (id_kieu_thue) references kieu_thue(id_kieu_thue),
    foreign key (id_loai_dich_vu) references loai_dich_vu(id_loai_dich_vu)
);

create table dich_vu_di_kem (
    id_dich_vu_di_kem int primary key auto_increment,
    ten_dich_vu_di_kem varchar(100),
    gia int,
    don_vi varchar(45),
    trang_thai_kha_dung varchar(45)
);

create table hop_dong (
    id_hop_dong int primary key auto_increment,
    so_hop_dong varchar(45),
    id_nhan_vien int,
    id_khach_hang int,
    id_dich_vu int,
    ngay_lam_hop_dong date,
    ngay_ket_thuc date,
    tien_dat_coc int,
    tong_tien int,
    foreign key (id_nhan_vien) references nhan_vien(id_nhan_vien),
    foreign key (id_khach_hang) references khach_hang(id_khach_hang),
    foreign key (id_dich_vu) references dich_vu(id_dich_vu)
);

create table hop_dong_chi_tiet (
    id_hop_dong_chi_tiet int primary key auto_increment,
    id_hop_dong int,
    id_dich_vu_di_kem int,
    so_luong int,
	foreign key (id_hop_dong) references hop_dong(id_hop_dong),
    foreign key (id_dich_vu_di_kem) references dich_vu_di_kem(id_dich_vu_di_kem)
);

-- Bảng vị trí
INSERT INTO vi_tri (ten_vi_tri) VALUES
('Lễ Tân'),
('Phục Vụ'),
('Chuyên Viên'),
('Giám Sát'),
('Quản Lý'),
('Giám Đốc');

-- Bảng trình độ
INSERT INTO trinh_do (ten_trinh_do) VALUES
('Trung Cấp'),
('Cao Đẳng'),
('Đại Học'),
('Sau Đại Học');

-- Bảng bộ phận
INSERT INTO bo_phan (ten_bo_phan) VALUES
('Sale-Marketing'),
('Hành Chính'),
('Phục Vụ'),
('Quản Lý');

-- Bảng nhân viên (thiết kế để test các trường hợp)
INSERT INTO nhan_vien (ho_ten, id_vi_tri, id_trinh_do, id_bo_phan, ngay_sinh, so_cmtnd, luong, sdt, email, dia_chi) VALUES
('Hoàng Văn An', 1, 2, 1, '1995-03-15', '201234567', 8000000, '0905123456', 'hoanvan@gmail.com', 'Đà Nẵng'),
('Trần Thị Bình', 2, 1, 3, '1992-07-20', '201234568', 7000000, '0905123457', 'tranthib@gmail.com', 'Quảng Nam'),
('Khoa Minh Châu', 3, 3, 2, '1990-11-10', '201234569', 12000000, '0905123458', 'khoaminh@gmail.com', 'Đà Nẵng'),
('Hà Ngọc Dung', 4, 2, 4, '1988-05-25', '201234570', 15000000, '0905123459', 'hangoc@gmail.com', 'Huế'),
('Kiều Thị Em', 1, 1, 1, '1997-02-14', '201234571', 6000000, '0905123460', 'kieuthie@gmail.com', 'Đà Nẵng'),
('Nguyễn Văn Phúc', 2, 2, 3, '1994-08-30', '201234572', 7500000, '0905123461', 'nguyenphuc@gmail.com', 'Quảng Ngãi'),
('Lê Thị Giang', 1, 1, 1, '1996-12-05', '201234573', 6500000, '0905123462', 'lethigiang@gmail.com', 'Đà Nẵng'),
('Trương Quốc Khánh', 5, 4, 4, '1985-01-20', '201234574', 20000000, '0905123463', 'truongquockhanh@gmail.com', 'Đà Nẵng'),
('Huỳnh Kim Long', 3, 3, 2, '1991-09-18', '201234575', 11000000, '0905123464', 'huynhkimlong@gmail.com', 'Hội An'),
('Phan Văn Minh', 2, 2, 3, '1993-04-22', '201234576', 8500000, '0905123465', 'phanvanminh@gmail.com', 'Tam Kỳ');

-- Bảng loại khách
INSERT INTO loai_khach (ten_loai_khach) VALUES
('Diamond'),
('Platinium'),
('Gold'),
('Silver'),
('Member');

-- Bảng khách hàng (thiết kế đa dạng để test)
INSERT INTO khach_hang (id_loai_khach, ho_ten, ngay_sinh, so_cmtnd, sdt, email, dia_chi, gioi_tinh) VALUES
(1, 'Nguyễn Thị Hảo', '1985-06-15', '301234567', '0912345678', 'haont@gmail.com', 'Vinh', 'Nữ'),
(1, 'Trần Văn Bình', '1990-03-20', '301234568', '0912345679', 'binhvt@gmail.com', 'Quảng Ngãi', 'Nam'),
(2, 'Lê Thị Cẩm', '1995-08-10', '301234569', '0912345680', 'camlt@gmail.com', 'Đà Nẵng', 'Nữ'),
(3, 'Phạm Văn Dũng', '2005-12-25', '301234570', '0912345681', 'dungpv@gmail.com', 'Quảng Trị', 'Nam'),
(1, 'Hoàng Văn Anh', '1988-02-28', '301234571', '0912345682', 'anhhv@gmail.com', 'Hà Nội', 'Nam'),
(2, 'Võ Thị Lan', '1992-09-15', '301234572', '0912345683', 'lanvt@gmail.com', 'Hồ Chí Minh', 'Nữ'),
(2, 'Đặng Văn Kiên', '1987-04-18', '301234573', '0912345684', 'kiendv@gmail.com', 'Đà Nẵng', 'Nam'),
(3, 'Bùi Thị Mai', '1998-07-22', '301234574', '0912345685', 'maibt@gmail.com', 'Huế', 'Nữ'),
(4, 'Cao Văn Nam', '1980-11-30', '301234575', '0912345686', 'namcv@gmail.com', 'Đà Nẵng', 'Nam'),
(1, 'Nguyễn Thị Hảo', '1987-05-10', '301234576', '0912345687', 'haont2@gmail.com', 'Nghệ An', 'Nữ');

-- Bảng kiểu thuê
INSERT INTO kieu_thue (ten_kieu_thue, gia) VALUES
('Thuê theo năm', 0),
('Thuê theo tháng', 0),
('Thuê theo ngày', 0),
('Thuê theo giờ', 0);

-- Bảng loại dịch vụ
INSERT INTO loai_dich_vu (ten_loai_dich_vu) VALUES
('Villa'),
('House'),
('Room');

-- Bảng dịch vụ
INSERT INTO dich_vu (ten_dich_vu, dien_tich, so_tang, so_nguoi_toi_da, chi_phi_thue, id_kieu_thue, id_loai_dich_vu, trang_thai) VALUES
('Villa Beach Front', 500, 3, 10, 50000000, 1, 1, 'Đang hoạt động'),
('Villa Garden View', 400, 2, 8, 30000000, 2, 1, 'Đang hoạt động'),
('House Family', 300, 2, 6, 15000000, 3, 2, 'Đang hoạt động'),
('House City View', 250, 2, 5, 12000000, 3, 2, 'Đang hoạt động'),
('Room Ocean View', 80, 1, 3, 5000000, 3, 3, 'Đang hoạt động'),
('Room Standard', 50, 1, 2, 3000000, 3, 3, 'Đang hoạt động'),
('Villa Premium', 600, 3, 12, 60000000, 1, 1, 'Đang hoạt động');

-- Bảng dịch vụ đi kèm
INSERT INTO dich_vu_di_kem (ten_dich_vu_di_kem, gia, don_vi, trang_thai_kha_dung) VALUES
('Massage', 500000, 'Giờ', 'Có sẵn'),
('Karaoke', 300000, 'Giờ', 'Có sẵn'),
('Thức ăn', 150000, 'Phần', 'Có sẵn'),
('Nước uống', 50000, 'Chai', 'Có sẵn'),
('Thuê xe', 800000, 'Ngày', 'Có sẵn');

-- Bảng hợp đồng (thiết kế chi tiết cho tất cả yêu cầu)
INSERT INTO hop_dong (so_hop_dong, id_nhan_vien, id_khach_hang, id_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, tong_tien) VALUES
('HD001', 1, 9, 1, '2015-06-15', '2015-06-20', 5000000, 50000000),
('HD002', 2, 1, 2, '2018-03-10', '2018-03-15', 3000000, 30000000),
('HD003', 3, 2, 3, '2018-06-20', '2018-06-25', 2000000, 15000000),
('HD004', 4, 3, 4, '2018-09-05', '2018-09-10', 1500000, 12000000),
('HD005', 1, 4, 5, '2019-01-15', '2019-01-20', 500000, 5000000),
('HD006', 2, 5, 6, '2019-02-10', '2019-02-15', 300000, 3000000),
('HD007', 3, 1, 1, '2019-03-25', '2019-03-30', 5000000, 50000000),
('HD008', 4, 2, 2, '2019-04-15', '2019-04-20', 3000000, 30000000),
('HD009', 5, 5, 3, '2019-05-20', '2019-05-25', 2000000, 15000000),
('HD010', 1, 5, 4, '2019-06-10', '2019-06-15', 1500000, 12000000),
('HD011', 2, 1, 5, '2019-07-05', '2019-07-10', 500000, 5000000),
('HD012', 3, 5, 1, '2019-08-12', '2019-08-17', 5000000, 50000000),
('HD013', 4, 2, 2, '2019-10-15', '2019-10-20', 3000000, 30000000),
('HD014', 5, 1, 3, '2019-11-20', '2019-11-25', 2000000, 15000000),
('HD015', 1, 5, 4, '2019-12-10', '2019-12-15', 1500000, 12000000),
('HD016', 2, 6, 1, '2019-08-05', '2019-08-10', 5000000, 55000000),
('HD017', 3, 7, 2, '2019-09-15', '2019-09-20', 3000000, 35000000),
('HD018', 8, 1, 5, '2018-12-01', '2018-12-05', 500000, 5000000),
('HD019', 8, 2, 6, '2019-05-10', '2019-05-15', 300000, 3000000),
('HD020', 9, 3, 1, '2019-07-20', '2019-07-25', 5000000, 50000000);

-- Bảng hợp đồng chi tiết (thiết kế để test dịch vụ đi kèm)
INSERT INTO hop_dong_chi_tiet (id_hop_dong, id_dich_vu_di_kem, so_luong) VALUES
(1, 1, 2),
(1, 3, 5),
(2, 2, 3),
(2, 4, 10),
(3, 1, 1),
(3, 5, 2),
(4, 3, 8),
(5, 4, 15),
(7, 1, 5), 
(7, 3, 10),
(8, 1, 4), 
(8, 2, 2),
(9, 1, 3),
(9, 5, 1),
(10, 3, 6),
(11, 1, 2),
(12, 1, 5),
(12, 3, 8),
(13, 2, 1),
(14, 1, 4),
(14, 4, 12),
(15, 3, 7),
(16, 1, 3),
(16, 3, 15),
(17, 1, 2),
(17, 4, 20),
(18, 5, 1),
(19, 3, 5),
(20, 1, 6);

-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
select 
    nv.id_nhan_vien,
    nv.ho_ten,
    nv.ngay_sinh,
    nv.so_cmtnd,
    nv.sdt,
    nv.email,
    nv.dia_chi,
    nv.luong,
    vt.ten_vi_tri,
    td.ten_trinh_do,
    bp.ten_bo_phan
from nhan_vien nv
    join vi_tri vt on nv.id_vi_tri = vt.id_vi_tri
    join trinh_do td on nv.id_trinh_do = td.id_trinh_do
    join bo_phan bp on nv.id_bo_phan = bp.id_bo_phan
where (ho_ten like 'H%' or ho_ten like 'T%' or ho_ten like 'K%') and char_length(ho_ten) <= 15;

-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select
    kh.id_khach_hang,
    kh.ho_ten,
    kh.ngay_sinh,
    kh.so_cmtnd,
    kh.sdt,
    kh.email,
    kh.dia_chi,
    kh.gioi_tinh,
    lk.ten_loai_khach,
	timestampdiff(year, kh.ngay_sinh, CURDATE()) as tuoi
from khach_hang kh
join loai_khach lk on kh.id_loai_khach = lk.id_loai_khach
where timestampdiff(year, kh.ngay_sinh, curdate()) between 18 and 50 and (kh.dia_chi = 'Đà Nẵng' or kh.dia_chi = 'Quảng Trị');

-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
select 
    kh.id_khach_hang,
    kh.ho_ten,
    kh.ngay_sinh,
    kh.so_cmtnd,
    kh.sdt,
    kh.email,
    kh.dia_chi,
    kh.gioi_tinh,
    lk.ten_loai_khach,
    count(hd.id_hop_dong) as so_lan_dat_phong
from khach_hang kh
	join loai_khach lk on kh.id_loai_khach = lk.id_loai_khach
	join hop_dong hd on kh.id_khach_hang = hd.id_khach_hang
where lk.ten_loai_khach = 'Diamond'
group by kh.id_khach_hang
order by so_lan_dat_phong;

-- 5.	Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien (Với TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem) cho tất cả các Khách hàng đã từng đặt phỏng. (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
select 
    kh.id_khach_hang,
    kh.ho_ten,
    lk.ten_loai_khach,
    hd.id_hop_dong,
    dv.ten_dich_vu,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    ifnull(dv.chi_phi_thue + sum(ifnull(hdct.so_luong * dvdk.gia, 0)), 0) as tong_tien
from khach_hang kh
    left join loai_khach lk on kh.id_loai_khach = lk.id_loai_khach
    left join hop_dong hd on kh.id_khach_hang = hd.id_khach_hang
    left join dich_vu dv on hd.id_dich_vu = dv.id_dich_vu
    left join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
    left join dich_vu_di_kem dvdk on hdct.id_dich_vu_di_kem = dvdk.id_dich_vu_di_kem
group by 
    kh.id_khach_hang,
    kh.ho_ten,
    lk.ten_loai_khach,
    hd.id_hop_dong,
    dv.ten_dich_vu,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    dv.chi_phi_thue
order by kh.id_khach_hang, hd.id_hop_dong;

-- 6.	Hiển thị IDDichVu, TenDichVu, DienTich, ChiPhiThue, TenLoaiDichVu của tất cả các loại Dịch vụ chưa từng được Khách hàng thực hiện đặt từ quý 1 của năm 2019 (Quý 1 là tháng 1, 2, 3).
select 
    dv.id_dich_vu,
    dv.ten_dich_vu,
    dv.dien_tich,
    dv.chi_phi_thue,
    ldv.ten_loai_dich_vu
from dich_vu dv
    join loai_dich_vu ldv on dv.id_loai_dich_vu = ldv.id_loai_dich_vu
where dv.id_dich_vu not in (
	select  hd.id_dich_vu
	from hop_dong hd
	where year(hd.ngay_lam_hop_dong) = 2019
	and month(hd.ngay_lam_hop_dong) in (1, 2, 3)
    )
order by dv.id_dich_vu;

-- 7.	Hiển thị thông tin IDDichVu, TenDichVu, DienTich, SoNguoiToiDa, ChiPhiThue, TenLoaiDichVu của tất cả các loại dịch vụ đã từng được Khách hàng đặt phòng trong năm 2018 nhưng chưa từng được Khách hàng đặt phòng  trong năm 2019.
select 
    dv.id_dich_vu,
    dv.ten_dich_vu,
    dv.dien_tich,
    dv.so_nguoi_toi_da,
    dv.chi_phi_thue,
    ldv.ten_loai_dich_vu
from dich_vu dv
    join loai_dich_vu ldv on dv.id_loai_dich_vu = ldv.id_loai_dich_vu
where dv.id_dich_vu in (
	select hd.id_dich_vu
	from hop_dong hd
	where year(hd.ngay_lam_hop_dong) = 2018
    )
    and dv.id_dich_vu not in (
	select hd.id_dich_vu
	from hop_dong hd
	where year(hd.ngay_lam_hop_dong) = 2019
    )
order by dv.id_dich_vu;

-- 8.	Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoThenKhachHang không trùng nhau. (Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên)
	-- Cách 1
select distinct ho_ten
from khach_hang
order by ho_ten;
	-- Cách 2
select ho_ten
from khach_hang
group by ho_ten
order by ho_ten;

-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2019 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
select
    month(hd.ngay_lam_hop_dong) as thang,
    count(distinct hd.id_khach_hang) as so_luong_khach_hang,
    sum(hd.tong_tien) as doanh_thu
from hop_dong hd
where year(hd.ngay_lam_hop_dong) = 2019
group by month(hd.ngay_lam_hop_dong)
order by thang;

-- 10.	Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu Dịch vụ đi kèm. Kết quả hiển thị bao gồm IDHopDong, NgayLamHopDong, NgayKetthuc, TienDatCoc, SoLuongDichVuDiKem (được tính dựa trên việc count các IDHopDongChiTiet).
select 
    hd.id_hop_dong,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    hd.tien_dat_coc,
    count(hdct.id_hop_dong_chi_tiet) as so_luong_dich_vu_di_kem
from hop_dong hd
left join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
group by
    hd.id_hop_dong
order by hd.id_hop_dong;

-- 11.	Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có TenLoaiKhachHang là “Diamond” và có địa chỉ là “Vinh” hoặc “Quảng Ngãi”.
select 
    dvdk.id_dich_vu_di_kem,
    dvdk.ten_dich_vu_di_kem,
    dvdk.gia,
    dvdk.don_vi,
    kh.ho_ten as ten_khach_hang,
    kh.dia_chi,
    lk.ten_loai_khach
from dich_vu_di_kem dvdk
	join hop_dong_chi_tiet hdct on dvdk.id_dich_vu_di_kem = hdct.id_dich_vu_di_kem
	join hop_dong hd on hdct.id_hop_dong = hd.id_hop_dong
	join khach_hang kh on hd.id_khach_hang = kh.id_khach_hang
	join loai_khach lk on kh.id_loai_khach = lk.id_loai_khach
where lk.ten_loai_khach = 'Diamond'and (kh.dia_chi = 'Vinh' or kh.dia_chi = 'Quảng Ngãi')
group by 
    dvdk.id_dich_vu_di_kem,
    dvdk.ten_dich_vu_di_kem,
    dvdk.gia,
    dvdk.don_vi,
    kh.ho_ten,
    kh.dia_chi,
    lk.ten_loai_khach
order by dvdk.id_dich_vu_di_kem, kh.ho_ten;

-- 12.	Hiển thị thông tin IDHopDong, TenNhanVien, TenKhachHang, SoDienThoaiKhachHang, TenDichVu, SoLuongDichVuDikem (được tính dựa trên tổng Hợp đồng chi tiết), TienDatCoc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2019 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2019.
-- 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
-- 14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.
select
    hd.id_hop_dong,
    ldv.ten_loai_dich_vu,
    dvdk.ten_dich_vu_di_kem,
    count(hdct.id_dich_vu_di_kem) as so_lan_su_dung
from hop_dong_chi_tiet hdct
	join dich_vu_di_kem dvdk on hdct.id_dich_vu_di_kem = dvdk.id_dich_vu_di_kem
	join hop_dong hd on hdct.id_hop_dong = hd.id_hop_dong
	join dich_vu dv on hd.id_dich_vu = dv.id_dich_vu
	join loai_dich_vu ldv on dv.id_loai_dich_vu = ldv.id_loai_dich_vu
group by
    hdct.id_dich_vu_di_kem, 
    hd.id_hop_dong,
    ldv.ten_loai_dich_vu,
    dvdk.ten_dich_vu_di_kem
having count(hdct.id_dich_vu_di_kem) = 1;

-- 15.	Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai, DiaChi mới chỉ lập được tối đa 3 hợp đồng từ năm 2018 đến 2019.
select 
    nv.id_nhan_vien,
    nv.ho_ten,
    td.ten_trinh_do,
    bp.ten_bo_phan,
    nv.sdt,
    nv.dia_chi,
    count(hd.id_hop_dong) as so_hop_dong_tu_nam_2018_den_2019
from nhan_vien nv
join trinh_do td on nv.id_trinh_do = td.id_trinh_do
join bo_phan bp on nv.id_bo_phan = bp.id_bo_phan
left join hop_dong hd on nv.id_nhan_vien = hd.id_nhan_vien
    and year(hd.ngay_lam_hop_dong) between 2018 and 2019
group by 
    nv.id_nhan_vien,
    nv.ho_ten,
    td.ten_trinh_do,
    bp.ten_bo_phan,
    nv.sdt,
    nv.dia_chi
having count(hd.id_hop_dong) <= 3 
order by nv.id_nhan_vien;