1. Viết SP spTangLuong dùng để tăng lương lên 10% cho tất cả các nhân viên.
create proc spTangLuong
as
update NHANVIEN set LUONG=LUONG*1.1
go

exec spTangLuong
2. Thêm vào cột NgayNghiHuu (ngày nghỉ hưu) trong bảng NHANVIEN. Viết SP
spNghiHuu dùng để cập nhật ngày nghỉ hưu là ngày hiện tại cộng thêm 100 (ngày) cho những
nhân viên nam có tuổi từ 60 trở lên và nữ từ 55 trở lên.
alter table NHANVIEN
add NgayNghiHuu datetime

create proc spNghiHuu
@tuoi int, @phai nvarchar(3)
as
declare @tuoi int 
set @tuoi = (SELECT (YEAR(GETDATE()) - YEAR(NHANVIEN.NGSINH)) as 'Tuổi' from NHANVIEN
where @phai > 60 = N'Nam' AND @phai > 55 = N'Nữ'
update NHANVIEN set NgayNghiHuu=(YEAR(GETDATE())+100)  
3. Tạo SP spXemDeAn cho phép xem các đề án có địa điểm đề án được truyền vào khi
gọi thủ tục.
4. Tạo SP spCapNhatDeAn cho phép cập nhật lại địa điểm đề án với 2 tham số truyền
vào là diadiem_cu, diadiem_moi.
5. Viết SP spThemDeAn để thêm dữ liệu vào bảng DEAN với các tham số vào là các
trường của bảng DEAN.
6. Cập nhật SP spThemDeAn ở câu trên để thỏa mãn ràng buộc sau: kiểm tra mã đề án có
trùng với các mã đề án khác không. Nếu có thì thông báo lỗi “Mã đề án đã tồn tại, đề nghị chọn
mã đề án khác”. Sau đó, tiếp tục kiểm tra mã phòng ban. Nếu mã phòng ban không tồn tại
trong bảng PHONGBAN thì thông báo lỗi: “Mã phòng không tồn tại”. Thực thi thủ tục với 1
trường hợp đúng và 2 trường hợp sai để kiểm chứng.
7. Tạo SP spXoaDeAn cho phép xóa các đề án với tham số truyền vào là Mã đề án. Lưu ý
trước khi xóa cần kiểm tra mã đề án có tồn tại trong bảng PHANCONG hay không, nếu có thì
viết ra thông báo và không thực hiện việc xóa dữ liệu.
8. Cập nhật SP spXoaDeAn cho phép xóa các đề án với tham số truyền vào là Mã đề án.
Lưu ý trước khi xóa cần kiểm tra mã đề án có tồn tại trong bảng PHANCONG hay không, nếu
có thì thực hiện xóa tất cả các dữ liệu trong bảng PHANCONG có liên quan đến mã đề án cần
xóa, sau đó tiến hành xóa dữ liệu trong bảng DEAN.
9. Tạo SP spTongGioLamViec có tham số truyền vào là MaNV, tham số ra là tổng thời
gian (tính bằng giờ) làm việc ở tất cả các dự án của nhân viên đó.
10. Viết SP spTongTien để in ra màn hình tổng tiền phải trả cho nhân viên với tham số
truyền vào là mã nhân viên. (Tổng tiền phải trả cho nhân viên = lương + lương đề án; lương đề
án = 100000 đ x thời gian). Kết quả của thủ tục là dòng chữ: “Tổng tiền phải trả cho nhân viên
‘333’ là 1200000 đồng.
11. Viết SP spThemPhanCong để thêm dữ liệu vào bảng PHANCONG thỏa mãn yêu cầu
sau: ThoiGian phải là một số dương, MaDA phải tồn tại ở bảng DEAN và MaNV phải tồn tại
trong bảng NHANVIEN. Nếu không thỏa mãn phải thông báo lỗi tương ứng và không được
phép thêm dữ liệu.