--Bài 1:
--Viết trigger DML:
➢ Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì
xuất thông báo “luong phải >15000’
create trigger trg_CheckLuong15000 
	on NHANVIEN
	for insert, update
as
	if (select LUONG from inserted)<15000
	begin
		print N'Lương < 15000'
		rollback tran
	end
➢ Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.
create trigger trg_CheckTuoi
	on NHANVIEN
	for insert
as
	declare @tuoi int;
	select @tuoi = DATEDIFF(YEAR, NGSINH, GETDATE())+1 from inserted
	if @tuoi < 18 or @tuoi > 65
	begin 
		print N'Tuổi của nhân viên không hợp lệ 18 <= tuổi <= 65'
		rollback transaction
	end
➢ Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM
create trigger trg_CheckDCHI
	on NHANVIEN
	for update
as
	if exists (select DCHI from inserted where DCHI like N'%HCM')
	begin
		print N'Không thể cập nhật nhân viên ở TP HCM'
		rollback tran
	end
--Bài 2:
➢ Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động
thêm mới nhân viên.
➢ Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động
cập nhật phần giới tính nhân viên
create trigger trg_SumSLNV
	on NHANVIEN
	after insert
as
	if (select top 1 PHAI from deleted != (select top 1 PHAI from inserted)
	begin
		declare @nam int, @nu int;
		select @nu = count(MANV) from NHANVIEN where PHAI=N'Nữ';
		select @nam = count(MANV) from NHANVIEN where PHAI=N'Nam';
		print N'Tổng số nhân viên là nữ: ' + cast(@nu as varchar)
		print N'Tổng số nhân viên là nam: ' + cast(@nam as varchar)
	end
➢ Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng
DEAN
create trigger trg_SLDA
	on DEAN
	after delete
as
	select MA_NVIEN, COUNT(MADA) as 'Tổng số đề án đã tham gia' from PHANCONG
	group by MA_NVIEN

--Bài 3:
➢ Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân
viên trong bảng nhân viên.
create trigger trg_delthannhan on NHANVIEN
instead of delete
as
begin
delete from THANNHAN where MA_NVIEN in(select manv from deleted)
delete from NHANVIEN where manv in(select manv from deleted)
end
insert into THANNHAN values ('031', 'Khang', 'Nam', '03-10-2017', 'con')
delete NHANVIEN where manv='031'

➢ Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA
là 1.
create trigger trg_newnhanvien on NHANVIEN
after insert 
as
begin
insert into PHANCONG values ((select manv from inserted), 1,2,20)
end
INSERT INTO NHANVIEN VALUES ('Nguyễn','Hoàng','Việt','031','12-03-1999','Phú Yên','Nam',60000,'003',1)
