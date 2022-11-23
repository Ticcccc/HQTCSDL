Nguyễn Mạnh Hùng Vĩ
09ĐHCNTT3
--LAB3:
Bài 1:
➢Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.
o Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân.
SELECT TENDEAN, CAST(SUM(THOIGIAN) AS decimal(5,2)) AS 'tổng số giờ làm việc' FROM CONGVIEC
INNER JOIN DEAN ON CONGVIEC.MADA=DEAN.MADA
INNER JOIN PHANCONG ON CONGVIEC.MADA=PHANCONG.MADA
GROUP BY TENDEAN
o Xuất định dạng “tổng số giờ làm việc” kiểu varchar
SELECT TENDEAN, CONVERT(varchar, SUM(THOIGIAN)) AS 'tổng số giờ làm việc' FROM CONGVIEC
INNER JOIN DEAN ON CONGVIEC.MADA=DEAN.MADA
INNER JOIN PHANCONG ON CONGVIEC.MADA=PHANCONG.MADA
GROUP BY TENDEAN
--Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
o Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu phẩy để phân biệt phần nguyên và phần thập phân.
SELECT TENPHG, CAST(AVG(LUONG) as decimal(10,2)) AS 'Lương trung bình' from NHANVIEN
INNER JOIN PHONGBAN ON NHANVIEN.PHG=PHONGBAN.MAPHG
GROUP BY TENPHG
o Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3 chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace
SELECT TENPHG, LEFT(CAST(AVG(LUONG) as varchar(10)), 3)+','
+REPLACE(CAST(AVG(LUONG) as varchar(10)), LEFT(CAST(AVG(LUONG) as varchar(10)), 3), ',' )
AS 'Lương trung bình' from NHANVIEN
INNER JOIN PHONGBAN ON NHANVIEN.PHG=PHONGBAN.MAPHG
GROUP BY TENPHG
Bài 2:
➢Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.
o Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
SELECT TENDEAN, CEILING(CAST(SUM(THOIGIAN) AS decimal(5,2))) AS 'tổng số giờ làm việc' FROM CONGVIEC
INNER JOIN DEAN ON CONGVIEC.MADA=DEAN.MADA
INNER JOIN PHANCONG ON CONGVIEC.MADA=PHANCONG.MADA
GROUP BY TENDEAN
o Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
SELECT TENDEAN, FLOOR(CAST(SUM(THOIGIAN) AS decimal(5,2))) AS 'tổng số giờ làm việc' FROM CONGVIEC
INNER JOIN DEAN ON CONGVIEC.MADA=DEAN.MADA
INNER JOIN PHANCONG ON CONGVIEC.MADA=PHANCONG.MADA
GROUP BY TENDEAN
o Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân
SELECT TENDEAN, ROUND(CAST(SUM(THOIGIAN) AS decimal(5,2)), 2) AS 'tổng số giờ làm việc' FROM CONGVIEC
INNER JOIN DEAN ON CONGVIEC.MADA=DEAN.MADA
INNER JOIN PHANCONG ON CONGVIEC.MADA=PHANCONG.MADA
GROUP BY TENDEAN
--Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình (làm tròn đến 2 số thập phân) của phòng "Nghiên cứu"
SELECT LUONG, (HONV+' '+TENLOT+' '+TENNV+' ') AS 'Họ tên NV có mức lương trung bình' FROM NHANVIEN
WHERE LUONG>
(SELECT ROUND(AVG(LUONG), 2) FROM NHANVIEN, PHONGBAN
WHERE PHG=MAPHG AND TENPHG=N'Nghiên cứu')
Bài 3:
➢Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) có trên 2 thân nhân, thỏa các yêu cầu
o Dữ liệu cột HONV được viết in hoa toàn bộ
SELECT UPPER(HONV) AS 'Nhân viên có trên 2 thân nhân', TENLOT, TENNV, DCHI
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV=THANNHAN.MA_NVIEN
GROUP BY UPPER(HONV), TENLOT, TENNV, DCHI
HAVING COUNT(THANNHAN.MA_NVIEN) > 2
o Dữ liệu cột TENLOT được viết chữ thường toàn bộ
SELECT UPPER(HONV) AS 'TENNV', LOWER(TENLOT) AS 'TENLOT', TENNV, DCHI
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV=THANNHAN.MA_NVIEN
GROUP BY UPPER(HONV), LOWER(TENLOT), TENNV, DCHI
HAVING COUNT(THANNHAN.MA_NVIEN) > 2
o Dữ liệu chột TENNV có ký tự thứ 2 được viết in hoa, các ký tự còn lại viết thường( ví dụ: kHanh)
SELECT UPPER(HONV) AS 'TENNV', LOWER(TENLOT) AS 'TENLOT', 
LOWER(LEFT(TENNV, 1))+UPPER(SUBSTRING(TENNV, 2, 1))+LOWER(SUBSTRING(TENNV, 3, LEN(TENNV))), DCHI
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV=THANNHAN.MA_NVIEN
GROUP BY UPPER(HONV), LOWER(TENLOT), 
LOWER(LEFT(TENNV, 1))+UPPER(SUBSTRING(TENNV, 2, 1))+LOWER(SUBSTRING(TENNV, 3, LEN(TENNV))), DCHI
HAVING COUNT(THANNHAN.MA_NVIEN) > 2
o Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác như số nhà hay thành phố.
SELECT UPPER(HONV) AS 'TENNV', LOWER(TENLOT) AS 'TENLOT', 
LOWER(LEFT(TENNV, 1))+UPPER(SUBSTRING(TENNV, 2, 1))+LOWER(SUBSTRING(TENNV, 3, LEN(TENNV))), 
SUBSTRING(DCHI, CHARINDEX(' ', DCHI)+1, CHARINDEX(',', DCHI) - CHARINDEX(' ', DCHI)-1)
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV=THANNHAN.MA_NVIEN
GROUP BY UPPER(HONV), LOWER(TENLOT), 
LOWER(LEFT(TENNV, 1))+UPPER(SUBSTRING(TENNV, 2, 1))+LOWER(SUBSTRING(TENNV, 3, LEN(TENNV))), 
SUBSTRING(DCHI, CHARINDEX(' ', DCHI)+1, CHARINDEX(',', DCHI) - CHARINDEX(' ', DCHI)-1)
HAVING COUNT(THANNHAN.MA_NVIEN) > 2
➢Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất, hiển thị thêm một cột thay thế tên trưởng phòng bằng tên “Fpoly”
DECLARE @THONGKE TABLE (MAP INT, MANVTP INT, TK INT)
INSERT INTO @THONGKE
SELECT PHG, MA_NQL, COUNT(MANV) FROM NHANVIEN GROUP BY PHG, MA_NQL
DECLARE @MAX INT
SELECT @MAX = MAX(TK) FROM @THONGKE
SELECT TENPHG, HONV+' '+TENLOT+' '+TENNV AS 'Họ tên NV', HONV+' '+TENLOT+' Fpoly' AS 'Họ tên FPOLY' FROM PHONGBAN
A INNER JOIN (SELECT *FROM @THONGKE WHERE TK=@MAX) B ON A.MAPHG = B.MAP
INNER JOIN NHANVIEN C ON C.MANV = B.MANVTP
Bài 4:
➢Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.
SELECT * FROM NHANVIEN
WHERE YEAR(NGSINH)
BETWEEN 1960 AND 1965
➢Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại.
SELECT YEAR(GETDATE())-YEAR(NGSINH) AS 'Tuổi', TENNV FROM NHANVIEN
➢Dựa vào dữ liệu NGSINH, cho biết nhân viên sinh vào thứ mấy.
SELECT DATENAME(WEEKDAY, NGSINH) AS 'Thứ', TENNV FROM NHANVIEN
➢Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức trưởng phòng và ngày nhận chức trưởng phòng hiển thi theo định dạng dd-mm-yy (ví dụ 25-04-2019)
SELECT TRPHG, HONV+' '+TENLOT+' '+TENNV AS 'Họ tên TP', CONVERT(VARCHAR, NG_NHANCHUC, 105) AS 'Ngày nhận chức', SL AS 'SLNV'
FROM PHONGBAN
A INNER JOIN (SELECT PHG, COUNT(MANV) AS SL FROM NHANVIEN GROUP BY PHG) B ON A.MAPHG=B.PHG
INNER JOIN NHANVIEN C ON A.TRPHG=C.MANV
