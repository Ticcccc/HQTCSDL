--LAB4:
Bài 1:
➢Viết chương trình xem xét có tăng lương cho nhân viên hay không. Hiển thị cột thứ 1 là TenNV, cột thứ 2 nhận giá trị
o “TangLuong” nếu lương hiện tại của nhân viên nhở hơn trung bình lương trong
phòng mà nhân viên đó đang làm việc.
o “KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương
trong phòng mà nhân viên đó đang làm việc.
SELECT IIF(LUONG>=LTB,'Không tăng lương','Tăng lương')
AS THUONG, TENNV, LUONG, LTB
FROM
(SELECT TENNV,LUONG,LTB FROM NHANVIEN,
(SELECT PHG,AVG(LUONG) AS 'LTB' FROM NHANVIEN GROUP BY PHG) AS TEMP
WHERE NHANVIEN.PHG=TEMP.PHG) AS ABC
➢Viết chương trình phân loại nhân viên dựa vào mức lương.
o Nếu lương nhân viên nhỏ hơn trung bình lương mà nhân viên đó đang làm việc thì xếp loại “nhanvien”, ngược lại xếp loại “truongphong”
SELECT IIF(LUONG<=LTB,'NhanVien','TruongPhong')
AS PL,TENNV,LUONG,LTB
FROM 
(SELECT TENNV,LUONG,LTB FROM NHANVIEN,
(SELECT PHG,AVG(LUONG) AS 'LTB' FROM NHANVIEN GROUP BY PHG) AS TEMP
WHERE NHANVIEN.PHG=TEMP.PHG) AS ABC
➢Viết chương trình hiển thị TenNV như hình bên dưới, tùy vào cột phái của nhân viên
SELECT TENNV = CASE PHAI
WHEN 'nam' then 'Mr. '+[TENNV]
WHEN N'Nữ' then 'Ms. '+[TENNV]
END
FROM NHANVIEN
➢Viết chương trình tính thuế mà nhân viên phải đóng theo công thức:
o 0<luong<25000 thì đóng 10% tiền lương
o 25000<luong<30000 thì đóng 12% tiền lương
o 30000<luong<40000 thì đóng 15% tiền lương
o 40000<luong<50000 thì đóng 20% tiền lương
o Luong>50000 đóng 25% tiền lương
SELECT TENNV,LUONG,THUE=CASE
WHEN LUONG BETWEEN 0 AND 25000 THEN LUONG*0.1
WHEN LUONG BETWEEN 25000 AND 30000 THEN LUONG*0.12
WHEN LUONG BETWEEN 30000 AND 40000 THEN LUONG*0.15
WHEN LUONG BETWEEN 40000 AND 50000 THEN LUONG*0.2
ELSE LUONG*0.25
END 
FROM NHANVIEN
--Bài 2:
➢Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
declare @dem int=2
while @dem<(select count(MANV) from NHANVIEN)
	begin
		select HONV,TENLOT,TENNV,MANV from NHANVIEN WHERE CAST(MANV as int)=@dem
		set @dem=@dem+2
	end
➢Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn nhưng không tính nhân viên có MaNV là 4.
declare @dem int=2
while @dem<(select count(MANV) from NHANVIEN)
	begin
		if @dem=4
		begin
			set @dem=@dem+2
			continue
		end
		if @dem%2=0
			select HONV,TENLOT,TENNV,MANV from NHANVIEN WHERE CAST(MANV as int)=@dem
			set @dem=@dem+2
	end
--Bài 3:
➢ Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan theo 2 bước
o Nhận thông báo “ thêm dư lieu thành cong” từ khối Try
o Chèn sai kiểu dữ liệu cột MaPHG để nhận thông báo lỗi “Them dư lieu that bai”
từ khối Catch
SELECT * FROM PHONGBAN
BEGIN TRY
	INSERT INTO PHONGBAN(TENPHG,MAPHG,TRPHG,NG_NHANCHUC)
	VALUES(N'MARKETING', 7, '009', '2022-11-23')
	PRINT N'Thêm dữ liệu thành công'
END TRY
BEGIN CATCH
	PRINT N'Thêm dữ liệu thất bại'
END CATCH
➢ Viết chương trình khai báo biến @chia, thực hiện phép chia @chia cho số 0 và dùng RAISERROR để thông báo lỗi.
BEGIN TRY
	declare @chia int;
	set @chia = 55 / 0;
END TRY
BEGIN CATCH
	declare @ErrorMessage nvarchar(2048), @ErrorSeverity int, @ErrorState int;
	select @ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
	RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
--Bài 4: GV cho thêm
➢ Viết chương trình tính tổng các số chẵn từ 1 tới 10.
DECLARE @TONG int=0, @DEM int=1
WHILE(@DEM<=10)
BEGIN
	SET @TONG = @TONG+@DEM
	SET @DEM = @DEM+1
END
PRINT @TONG
➢ Viết chương trình tính tổng các số chẵn từ 1 tới 10 nhưng bỏ số 4.
DECLARE @TONG int=0, @DEM int=1
WHILE(@DEM<=10)
BEGIN
	IF @DEM=4
		BEGIN
			SET @DEM=@DEM+1
			CONTINUE
		END	
	IF @DEM!=4
		SET @TONG = @TONG+@DEM
		SET @DEM = @DEM+1
END
PRINT @TONG