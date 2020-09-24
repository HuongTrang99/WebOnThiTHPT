
create database WebOnThiTHPT
ON PRIMARY 
(
	size = 40Mb,
	filegrowth = 10%,
	maxsize = 50Mb,
	filename = 'D:\WebOnThiTHPT\WebOnThiTHPT.mdf',
	name = WebOnThiTHPT
)
LOG ON
(
	size = 10Mb,
	filegrowth=10%,
	maxsize = 15Mb,
	filename = 'D:\WebOnThiTHPT\WebOnThiTHPT.ldf',
	name = WebOnThiTHPT_log
)
go

use WebOnThiTHPT
go

            --1//-------------
 create table QuanTriVien
 (
	MaQuanTriVien char (15),
	HoTen nvarchar (100),
	NgaySinh date,
	DiaChi nvarchar (100),
	SoDienThoai int,
	Email varchar (100),
	primary key (MaQuanTriVien)
 )
 go

             --2//-------------
 create table NhomQuyen
 (
	MaNhomQuyen char (15),
	TenNhomQuyen nvarchar (100),
	primary key (MaNhomQuyen)
 )
 go

              --3//-------------
 create table Quyen
 (
	MaQuyen char (15),
	MaNhomQuyen char (15),
	TenQuyen nvarchar (100),
	primary key (MaQuyen),
	constraint q_MaNhomQuyen_fk FOREIGN KEY (MaNhomQuyen)
		 REFERENCES NhomQuyen (MaNhomQuyen)
 )
 go

               --4//-------------
 create table PhanQuyen
 (
	MaQuanTriVien char (15),
	MaQuyen char (15),
	ThoiGianNhanQuyen datetime,
	ThoiGianRoiQuyen datetime,
	constraint pq_MaQuyen_fk FOREIGN KEY (MaQuyen)
		 REFERENCES Quyen (MaQuyen),
	constraint pq_MaQuanTriVien_fk FOREIGN KEY (MaQuanTriVien)
		 REFERENCES QuanTriVien (MaQuanTriVien)
 )
 go

                --5//-------------
 create table Administration
 (
	TaiKhoan char (30),
	MatKhau varchar (30),
	MaQuanTriVien char (15),
	NgayDangKy date,
	constraint ad_MaQuanTriVien_fk FOREIGN KEY (MaQuanTriVien)
		 REFERENCES QuanTriVien (MaQuanTriVien)
 )
 go

--6//-------------
 create table DanhMuc
 (
	MaDanhMuc char(15),
	TenDanhMuc nvarchar(100),
	primary key (MaDanhMuc)
 )
 go

 --7//-------------
 create table ChiTietDanhMuc
 (
	MaChiTietDanhMuc char (15),
	MaDanhMuc char(15),
	TenChiTietDanhMuc nvarchar(100),
	primary key (MaChiTietDanhMuc),
	constraint ctdm_MaDanhMuc_fk FOREIGN KEY (MaDanhMuc)
		 REFERENCES DanhMuc (MaDanhMuc)
 )
 go

  --8//-------------
 create table KhoiLop
 (
	MaKhoiLop char (15),
	MaDanhMuc char (15),
	TenKhoiLop nvarchar(100),
	primary key (MaKhoiLop),
	constraint kl_MaDanhMuc_fk FOREIGN KEY (MaDanhMuc)
		 REFERENCES DanhMuc (MaDanhMuc)
 )
 go

  --9//-------------
 create table MonHoc
 (
	MaMonHoc char (15),
	MaKhoiLop char (15),
	MaDanhMuc char (15),
	TenMonHoc nvarchar (100),
	SoLuongKhoaHoc int,
	SoLuongGiangVien int,
	primary key (MaMonHoc),
	constraint mh_MaKhoiLop_fk FOREIGN KEY (MaKhoiLop)
		 REFERENCES KhoiLop (MaKhoiLop),
	constraint mh_MaDanhMuc_fk FOREIGN KEY (MaDanhMuc)
		 REFERENCES DanhMuc (MaDanhMuc)
 )
 go

  --10//-------------
 create table KhoaHoc
 (
	MaKhoaHoc char (15),
	MaMonHoc char(15),
	MaDanhMuc char (15),
	MaQuanTriVien char (15),
	TenKhoaHoc nvarchar(100),
	SoBaiGiang int,
	primary key (MaKhoaHoc),
	constraint kh_MaMonHoc_fk FOREIGN KEY (MaMonHoc)
		 REFERENCES MonHoc (MaMonHoc),
	constraint kh_MaQuanTriVien_fk FOREIGN KEY (MaQuanTriVien)
		 REFERENCES QuanTriVien (MaQuanTriVien),
	constraint kh_MaDanhMuc_fk FOREIGN KEY (MaDanhMuc)
		 REFERENCES DanhMuc (MaDanhMuc)
 )
 go


   --11//-------------
 create table GiangVien
 (
	MaGiangVien char (15),
	MaQuanTriVien char (15),
	TenGiangVien nvarchar (100),
	GioiTinh nvarchar (10),
	NgaySinh date,
	DiaChi nvarchar (100),
	SoDienThoai int,
	ThoiGianVaoHeThong date,
	primary key (MaGiangVien),
	constraint gv_MaQuanTriVien_fk FOREIGN KEY (MaQuanTriVien)
		 REFERENCES QuanTriVien (MaQuanTriVien)
 )
 go

	--12//-------------
 create table TKGiangVien
 (
	TaiKhoan char (30),
	MatKhau varchar (30),
	NgayDangKy date,
	MaGiangVien char (15),
	primary key (TaiKhoan),
	constraint tkgv_MaGiangVien_fk FOREIGN KEY (MaGiangVien)
		 REFERENCES GiangVien (MaGiangVien)
)
go


   --13//-------------
 create table LopHoc
 (
	MaLopHoc char (15),
	MaKhoaHoc char (15),
	MaGiangVien char(15),
	MaQuanTriVien char (15),
	TenLopHoc nvarchar(100),
	SoLuongHocVien int,
	NgayKhaiGiang Date,
	NgayKetThuc Date,
	LichHoc DateTime,
	primary key (MaLopHoc),
	constraint lh_MaKhoaHoc_fk FOREIGN KEY (MaKhoaHoc)
		 REFERENCES KhoaHoc (MaKhoaHoc),
	constraint lh_MaGiangVien_fk FOREIGN KEY (MaGiangVien)
		 REFERENCES GiangVien (MaGiangVien),
	constraint lh_MaQuanTriVien_fk FOREIGN KEY (MaQuanTriVien)
		 REFERENCES QuanTriVien (MaQuanTriVien)
 )
 go

    --14//-------------
 create table BaiHoc
 (
	MaBaiHoc char (15),
	MaLopHoc char (15),
	TenBaiHoc nvarchar (100),
	Video nvarchar (400),
	NgayDang DateTime,
	primary key (MaBaiHoc),
	constraint bh_MaLopHoc_fk FOREIGN KEY (MaLopHoc)
		 REFERENCES LopHoc (MaLopHoc)
 )
 go

     --15//-------------
 create table HocVien
 (
	MaHocVien char (15),
	MaLopHoc char (15),
	MaQuanTriVien char (15),
	HoTen nvarchar (100),
	NgaySinh date,
	DiaChi nvarchar (100),
	SoDienThoai int,
	Email varchar,
	ThoiGianDangKy date,
	primary key (MaHocVien),
	constraint hv_MaLopHoc_fk FOREIGN KEY (MaLopHoc)
		 REFERENCES LopHoc (MaLopHoc),
	constraint hv_MaQuanTriVien_fk FOREIGN KEY (MaQuanTriVien)
		 REFERENCES QuanTriVien (MaQuanTriVien)
 )
 go		

   --16//-------------
 create table TaiKhoan
 (
	UserName char (30),
	Pass varchar(15),
	MaHocVien char (15),
	SoDu money,
	primary key (UserName),
	constraint tk_MaHocVien_fk FOREIGN KEY (MaHocVien)
		 REFERENCES HocVien (MaHocVien)
 )
 go

    --17//-------------
 create table PhienGiaoDich
 (
	MaPhien char (15),
	MaHocVien char (15),
	MaKhoaHoc char (15),
	HinhThucThanhToan nvarchar (50),
	SoTien money,
	primary key (MaPhien),
	constraint pgd_MaHocVien_fk FOREIGN KEY (MaHocVien)
		 REFERENCES HocVien (MaHocVien)
 )
 go

     --18//-------------
 create table BinhLuan
 (
	MaBinhLuan char (15),
	MaBaiHoc char (15),
	MaHocVien char (15),
	NoiDung nvarchar (100),
	ThoiGianDang datetime,
	primary key (MaBinhLuan),
	constraint bl_MaBaiHoc_fk FOREIGN KEY (MaBaiHoc)
		 REFERENCES BaiHoc (MaBaiHoc),
	constraint bl_MaHocVien_fk FOREIGN KEY (MaHocVien)
		 REFERENCES HocVien (MaHocVien)
 )
 go

     --19//-------------
 create table Feedback
 (
	MaFeedback char (15),
	MaKhoaHoc char (15),
	MaHocVien char (15),
	NoiDung nvarchar (100),
	ThoiGianDang datetime,
	primary key (MaFeedback),
	constraint fb_MaKhoaHoc_fk FOREIGN KEY (MaKhoaHoc)
		 REFERENCES KhoaHoc (MaKhoaHoc),
	constraint fb_MaHocVien_fk FOREIGN KEY (MaHocVien)
		 REFERENCES HocVien (MaHocVien)
 )
 go

       --20//-------------
 create table LoaiDeThi
 (
	MaLoaiDeThi char (15),
	TenLoaiDeThi nvarchar (100),
	MaMonHoc char (15),
	primary key (MaLoaiDeThi),
	constraint ldt_MaMonHoc_fk FOREIGN KEY (MaMonHoc)
		 REFERENCES MonHoc (MaMonHoc)
 )
 go


      --21//-------------
 create table DeThi
 (
	MaDeThi char (15),
	MaMonHoc char (15),
	MaLoaiDeThi char (15),
	MaGiangVien char (15),
	TenDeThi nvarchar (100),
	SoLuongBaiNop int,
	ThoiGianLamBai int,
	SoCauHoi int,
	ThoiGianDang datetime,
	primary key (MaDeThi),
	constraint dt_MaMonHoc_fk FOREIGN KEY (MaMonHoc)
		 REFERENCES MonHoc (MaMonHoc),
	constraint dt_MaLoaiDeThi_fk FOREIGN KEY (MaLoaiDeThi)
		 REFERENCES LoaiDeThi (MaLoaiDeThi),
	constraint dt_MaGiangVien_fk FOREIGN KEY (MaGiangVien)
		 REFERENCES GiangVien (MaGiangVien)
 )
 go



       --22//-------------
 create table CauHoi
 (
	MaCauHoi char (15),
	MaDeThi char (15),
	TenCauHoi nvarchar (100),
	NoiDung nvarchar (100),
	primary key (MaCauHoi),
	constraint ch_MaDeThi_fk FOREIGN KEY (MaDeThi)
		 REFERENCES DeThi (MaDeThi)
 )
 go

         --23//-------------
 create table CauTraLoi
 (
	MaCauTraLoi char (15),
	MaCauHoi char (15),
	NoiDung nvarchar (100),
	primary key (MaCauTraLoi),
	constraint ctl_MaCauHoi_fk FOREIGN KEY (MaCauHoi)
		 REFERENCES CauHoi (MaCauHoi)
 )
 go

          --24//-------------
 create table DapAn
 (
	MaDapAn char (15),
	MaCauHoi char (15),
	MaCauTraLoi char (15),
	primary key (MaDapAn),
	constraint da_MaCauHoi_fk FOREIGN KEY (MaCauHoi)
		 REFERENCES CauHoi (MaCauHoi),
	constraint da_MaCauTraLoi_fk FOREIGN KEY (MaCauTraLoi)
		 REFERENCES CauTraLoi (MaCauTraLoi)
 )
 go

           --25//-------------
 create table NopBai
 (
	MaBaiNop char (15),
	MaHocVien char (15),
	TongDiem int,
	ThoiGianLamBai int,
	ThoiDiemNop datetime,
	primary key (MaBaiNop),
	constraint nb_MaHocVien_fk FOREIGN KEY (MaHocVien)
		 REFERENCES HocVien (MaHocVien)
 )
 go

