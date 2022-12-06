Bài 1:
Viết các hàm:
➢ Nhập vào MaNV cho biết tuổi của nhân viên này.
CREATE FUNCTION FN_Tuoi(@MaNV nvarchar(9))
RETURNS int
AS
Begin
	Return (Select DATEDIFF(year, NGSINH, GETDATE()) + 1 from NHANVIEN where MANV=@MaNV)
End
--Gói chạy:
select [dbo].[FN_Tuoi]('005')
select * from NHANVIEN
➢ Nhập vào Manv cho biết số lượng đề án nhân viên này đã tham gia
CREATE FUNCTION FN_TongSoDA(@MANV nvarchar(9))
RETURNS int
AS
BEGIN
	RETURN (SELECT count(MADA) from PHANCONG where MA_NVIEN = @MANV)
END
--Gói chạy
SELECT [dbo].[FN_TongSoDA]('005')
SELECT * FROM PHANCONG
➢ Truyền tham số vào phái nam hoặc nữ, xuất số lượng nhân viên theo phái
CREATE FUNCTION FN_DemNV(@phai nvarchar(3))
RETURNS int
AS
BEGIN
	RETURN (SELECT count(MANV) from NHANVIEN where PHAI=@phai)
END
--Gói chạy
SELECT [dbo].[FN_DemNV](N'Nữ')
➢ Truyền tham số đầu vào là tên phòng, tính mức lương trung bình của phòng đó, Cho biết
họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình
của phòng đó.
CREATE FUNCTION FN_LuongTB(@TenPhong nvarchar(30))
RETURNS int
AS
BEGIN
	RETURN (SELECT AVG(b.luong) from PHONGBAN a
			inner join NHANVIEN b on a.MAPHG=b.PHG
			WHERE TENPHG LIKE '%'+@TenPhong+'%')
END
--Gói chạy
SELECT HONV, TENLOT, TENNV from NHANVIEN a inner join PHONGBAN b on a.PHG=b.MAPHG
	where LUONG > [dbo].[FN_LuongTB](N'Quản lý') and TENPHG like N'Quản lý%'
SELECT * FROM PHONGBAN
➢ Tryền tham số đầu vào là Mã Phòng, cho biết tên phòng ban, họ tên người trưởng phòng
và số lượng đề án mà phòng ban đó chủ trì.
CREATE FUNCTION FN_ThongTinPhongDA(@maphg int)
RETURNS @List Table (TenPhong nvarchar(15), TenTruongPhong nvarchar(30), SoLuongDA int)
AS
BEGIN
	insert into @List
		select a.TENPHG, b.HONV+' '+b.TENLOT+' '+b.TENNV,
		(select count(c.MADA) from DEAN c where c.PHONG=a.MAPHG)
		from PHONGBAN a inner join NHANVIEN b on a.MAPH=b.PHG
	return
END
--Gói chạy
select * from [dbo].[FN_ThongTinPhongDA](1)
Bài 2:
Tạo các view:
➢ Hiển thị thông tin HoNV,TenNV,TenPHG, DiaDiemPhg.
CREATE VIEW ThongTin1
AS
	select HONV,TENNV,TENPHG,DIADIEM from NHANVIEN
	inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
	inner join DIADIEM_PHG on DIADIEM_PHG.MAPHG=PHONGBAN.MAPHG
➢ Hiển thị thông tin TenNv, Lương, Tuổi.
CREATE VIEW ThongTin2
AS
	select TENNV, LUONG, DATEDIFF(year, NGSINH, GETDATE()) + 1 as 'Tuổi' from NHANVIEN
➢ Hiển thị tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất
CREATE VIEW PhongBanDongNhat
AS
	select a.TENPHG,
	b.HONV+' '+b.TENLOT+' '+b.TENNV as 'TenTruongPhong'
	from PHONGBAN a inner join NHANVIEN b on a.TRPHG=b.MANV
	where a.MAPHG in (select PHG from NHANVIEN
						group by PHG
						having count(MANV) =
							(select top 1 count(MANV) as NVCount from NHANVIEN
								group by PHG
								order by NVCount desc)
						)