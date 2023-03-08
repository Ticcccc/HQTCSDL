1. Tạo view có tên vwNhanVienNam dùng để liệt kê thông tin mã nhân viên, họ, tên lót,
tên, ngày tháng năm sinh, mã phòng của các nhân viên nam. Sau đó sử dụng câu lệnh SELECT
để xem dữ liệu hiển thị trong view này.
create view vwNhanVienNam as
select MANV, HONV, TENLOT, TENNV, NGSINH, PHG from NHANVIEN
where PHAI=N'Nam'

select * from vwNhanVienNam

select * from NHANVIEN
2. Tạo view có tên vwNhanVienPhong5 dùng để liệt kê thông tin mã nhân viên, họ, tên
lót, tên, tuổi, lương của các nhân viên làm việc ở phòng số 5. Sau đó sử dụng câu lệnh
SELECT để xem dữ liệu hiển thị trong view này.
create view vwNhanVienPhong5 as
select MANV, HONV, TENLOT, TENNV, YEAR(GETDATE())-YEAR(NGSINH) as 'Tuổi', LUONG from NHANVIEN
where PHG='5'

select * from vwNhanVienPhong5

select * from NHANVIEN
3. Tạo view có tên vwThanNhanNVNu dùng để liệt kê các nhân viên nữ (mã nhân viên,
tên nhân viên) cùng với tên những người thân của họ.
create view vwThanNhanNVNu as
select MANV, (HONV+' '+TENLOT+' '+TENNV) as 'Họ tên', TENTN from NHANVIEN, THANNHAN
where NHANVIEN.MANV=THANNHAN.MA_NVIEN AND NHANVIEN.PHAI=N'Nữ'

select * from vwThanNhanNVNu

select * from NHANVIEN
select * from THANNHAN
4. Tạo view có tên vwPhongLuongCao để liệt kê tên các phòng ban có mức lương trung
bình trên 7.000.000 đồng. Thông tin bao gồm tên phòng ban và số lượng đề án mà phòng ban
đó chủ trì. Thực hiện truy vấn dữ liệu thông qua view.
create view vwPhongLuongCao as
select TENPHG,COUNT(*) as 'Số lượng DA' from PHONGBAN, DEAN, NHANVIEN
where PHONGBAN.MAPHG=DEAN.PHONG
group by TENPHG
having avg(LUONG)>7000

select * from vwPhongLuongCao
DROP VIEW vwPhongLuongCao

select * from PHONGBAN
select * from DEAN
5. Thông qua view vwNhanVienNam, thêm nhân viên với thông tin như sau:
Kiểm tra dữ liệu vừa nhập ở bảng NHANVIEN bằng câu lệnh SELECT.

6. Thông qua view vwNhanVienNam, kiểm tra dữ liệu vừa nhập ở câu 6. Vì sao dữ liệu
vừa nhập không được hiển thị trong view này?
7. Thông qua view vwNhanVienPhong5, thêm một nhân viên có thông tin như sau:
Việc thêm có thực hiện được hay không? Vì sao?
8. Sử dụng thủ tục sp_helptext để xem nội dung câu lệnh SELECT định nghĩa view
vwNhanVienPhong5.
9. Định nghĩa lại view vwNhanVienPhong5 để giấu nội dung câu lệnh SELECT định
nghĩa view này. Kiểm tra kết quả với thủ tục sp_helptext.
10. Định nghĩa lại view vwNhanVienPhong5 để thông qua view, có thể hiển thị thông tin
mã phòng của nhân viên.
11. Thông qua view vwNhanVienPhong5, thêm một nhân viên có thông tin như sau:
Kiểm tra dữ liệu vừa nhập trong bảng NHANVIEN và view vwNhanVienPhong5
12. Định nghĩa lại view vwNhanVienPhong5 bổ sung thêm từ khóa WITH CHECK
OPTION. Sau đó, thông qua view vwNhanVienPhong5, thêm một nhân viên có thông tin như
sau:
Việc thêm có thực hiện được hay không? Vì sao?