--Bài 1:
➢ In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của
bạn.
create proc lab5_bai1_a @name nvarchar(20)
as
	begin
		print 'xin chào: ' + @name
	end
exec lab5_bai1_a 'Nguyễn Mạnh Hùng Vĩ'
go

➢ Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.
create proc lab5_bai1_b @so1 int, @so2 int
as
	begin
		declare @tong int = 0;
		set @tong = @so1 + @so2 
		print 'tong: ' + cast(@tong as varchar(10))
	end

exec lab5_bai1_b 7,8
go

➢ Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
create proc lab5_bai1_c @l int
as
	begin
		declare @tong int = 0, @i int = 0;
		while @i < @l
			begin
				set @tong = @tong + @i
				set @i = @i + 2
			end
		print 'tổng: ' + cast(@tong as varchar(10))
	end
exec lab5_bai1_c 15
go

➢ Nhập vào 2 số. In ra ước chung lớn nhất của chúng theo gợi ý dưới đây
create proc lab5_bai1_d @a int, @b int
as
	begin
		while (@a != @b)
			begin
				if(@a > @b)
					set @a = @a -@b
				else
					set @b = @b - @a
			end
			return @a
	end
declare @l int
exec @l = lab5_bai1_d 5,7
print @l
go

--Bài 2:
➢ Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
create proc lab5_bai2_a @MaNV varchar(20)
as
	begin
		select * from NHANVIEN where MANV = @MaNV
	end
exec lab5_bai2_a '003'
go

➢ Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó
select count(MANV), MADA, TENPHG from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
where MADA = 2
group by TENPHG,MADA

alter proc lab5_bai2_b @manv int
as
begin
		select count(MANV) as 'so luong', MADA, TENPHG from NHANVIEN
		inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
		inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
		where MADA = @manv
		group by TENPHG,MADA
end
exec lab5_bai2_b 10
go

➢ Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham
gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA
select count(MANV)as 'so luong', MADA, TENPHG from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
where MADA = 2 and DDIEM_DA = 'Nha Trang'
group by TENPHG,MADA
go

➢ Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là
@Trphg và các nhân viên này không có thân nhân.
select HONV, TENNV, TENPHG, NHANVIEN.MANV, THANNHAN.*
from NHANVIEN
inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
left outer join THANNHAN on THANNHAN.MA_NVIEN = NHANVIEN.MANV
where THANNHAN.MA_NVIEN is null and TRPHG = '008'

create proc lab5_bai2_d @MaTP varchar(10)
as
begin
	select HONV, TENNV, TENPHG, NHANVIEN.MANV, THANNHAN.*
	from NHANVIEN
	inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
	left outer join THANNHAN on THANNHAN.MA_NVIEN = NHANVIEN.MANV
	where THANNHAN.MA_NVIEN is null and TRPHG = @MaTP
end

exec lab5_bai2_d '008'
go

➢ Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có
mã @Mapb hay không
if exists (select * from NHANVIEN where MANV = '001' and PHG = '5')
print 'Nhan vien co trong phong ban'
else 
print 'Nhan vien khong co trong phong ban'

create proc lab5_bai2_e @MaNV varchar(10), @MaPB varchar(10)
as
begin
	if exists(select * from NHANVIEN where MANV = '001' and PHG=@MaPB)
	print 'Nhan vien:' + @MaNV +'co trong phong ban: '+@MaPB
else 
	print 'Nhan vien: '+ @MaNV+'khong co trong phong ban: '+@MaPB
end

exec lab5_bai2_e '001','5'
--Bài 3:
➢ Thêm phòng ban có tên CNTT vào csdl QLDA, các giá trị được thêm vào dưới dạng
tham số đầu vào, kiếm tra nếu trùng Maphg thì thông báo thêm thất bại.
insert into PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
values ('7','CNTT','008','2002-03-12')

create proc lab5_bai3_a
	@MaPB int, @TenPB nvarchar(20),
	@MaTP varchar(10), @NgayNhanChuc date
as
	begin
		if(exists(select * from PHONGBAN where MaPHG=@MaPB))
			print'Them that bai'
		else 
			begin
				insert into PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
				values (@MaPB,@TenPB,@MaTP,@NgayNhanChuc)
				print 'Them thanh cong'
		end
end

exec lab5_bai3_a '7','CNTT','008','2002-03-12'

➢ Cập nhật phòng ban có tên CNTT thành phòng IT.
create proc lab5_bai3_b
	@MaPB int, @TenPB nvarchar(20),
	@MaTP varchar(10), @NgayNhanChuc date
as
	begin
		if(exists(select * from PHONGBAN where MaPHG=@MaPB))
			update PHONGBAN set TENPHG =@TenPB, TRPHG=@MaTP,NG_NHANCHUC =@NgayNhanChuc
			where MAPHG = @MaPB
		else 
			begin
				insert into PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
				values (@MaPB,@TenPB,@MaTP,@NgayNhanChuc)
				print 'Them thanh cong'
		end
end

exec lab5_bai3_b '7','CNTT','008','2002-03-12'
➢ Thêm một nhân viên vào bảng NhanVien, tất cả giá trị đều truyền dưới dạng tham số đầu
vào với điều kiện:
select HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG from NHANVIEN
insert into NHANVIEN(HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
values('Nguyễn', 'Hoàng', 'Việt', '001', '1995-03-12', 'Phú Yên', 'Nam','30000', '004', '6')

create proc lab5_bai3_c
@HONV varchar(10), @TENLOT varchar(10), @TENNV varchar(10),
@MANV varchar(10), @NGSINH date, @DCHI varchar(50), @PHAI varchar(10),
@LUONG float, @MA_NQL varchar(10) = null, @PHG int
as
begin
	declare @age int
	set @age = YEAR(GETDATE()) - YEAR(@NGSINH)
	if @PHG = (select MaPHG from PHONGBAN where TENPHG ='CNTT')
		begin
			if @LUONG < 25000
				set @MA_NQL = '009'
			else set @MA_NQL= '005'

			if(@PHAI = 'Nam' and (@age >= 18 and @age <= 65))
				or (@PHAI = N'Nữ' and (@age >= 18 and @age <= 60))
				begin
					insert into NHANVIEN(HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
					values(@HONV, @TENLOT, @TENNV, @MANV, @NGSINH, @DCHI, @PHAI, @LUONG, @MA_NQL, @PHG)
				end
			else
				print 'khong thuoc do tuoi lao dong'
		end
	else
		print 'khong phai phong CNTT'
end
exec lab5_bai3_c 'Nguyễn', 'Hoàng', 'Việt', '001', '1995-03-12', 'Phú Yên', 'Nam','30000', '004', '6'
exec lab5_bai3_c 'Phạm', 'Minh', 'Tuấn', '003', '2002-07-28', 'TP HCM', 'Nam','25000', '005', '9'
exec lab5_bai3_c 'Nguyễn', 'Tường', 'Vi', '002', '1989-08-27', 'Phú Yên', 'Nữ','35000', '004', '6'