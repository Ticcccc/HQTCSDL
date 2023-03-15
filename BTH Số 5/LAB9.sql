1. Tạo trigger trên bảng NHANVIEN cho thao tác UPDATE. Khi có thao tác cập nhật dữ
liệu xảy ra trên cột TenNV, thông báo cho người dùng “Không được phép cập nhật” và hủy
thao tác.
2. Thêm cột TongGio vào trong bảng NHANVIEN. Viết trigger cho các thao tác
INSERT, UPDATE, DELETE trên bảng PHANCONG. Khi có mẩu tin được thêm vào, cập
nhật hay xóa thì TongGio được tính lại tương ứng cho nhân viên được phân công.
Lưu ý:
- Ban đầu, TongGio = 0
- TongGio là tổng thời gian phân công tham gia vào các dự án cho các nhân viên.
3. Tạo các trigger để kiểm tra ràng buộc liên thuộc tính giữa NgSinh và NgayBatDau trên
bảng NHANVIEN.
Trong đó: YEAR(NgayBatDau) - YEAR(NgSinh) &gt;= 18
4. Tạo trigger để kiểm tra ràng buộc trên bảng THANNHAN sao cho số lượng thân nhân
của một nhân viên không quá 05 người.
5. Tạo trigger cho thao tác xóa trên bảng DEAN để đảm bảo nguyên tắc: Mã đề án sẽ
không thể được xóa khi còn mẩu tin chứa mã đề án đó trên bảng PHANCONG.
6. Tạo trigger trên bảng PHONGBAN cho thao tác UPDATE. Khi có thao tác cập nhật dữ
liệu xảy ra trên cột MaPhong, tất cả dữ liệu trên các bảng có liên quan cũng phải thay đổi theo.