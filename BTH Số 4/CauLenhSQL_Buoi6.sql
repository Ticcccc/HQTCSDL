﻿1. Cho biết danh sách các nhân viên có ít nhất một thân nhân
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV) AS 'Họ tên NV có ít nhất 1 TN'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN AND
		THANNHAN.MA_NVIEN IN (SELECT THANNHAN.MA_NVIEN
							FROM NHANVIEN, THANNHAN
							WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN
							)
GROUP BY HONV, TENLOT, TENNV
select * from THANNHAN
select * from NHANVIEN
2. Cho biết danh sách các nhân viên không có thân nhân nào
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV) AS 'Họ tên NV không có TN'
FROM NHANVIEN
WHERE NHANVIEN.MANV NOT IN (SELECT THANNHAN.MA_NVIEN
							FROM NHANVIEN, THANNHAN
							WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN
							)
3. Cho biết họ tên các nhân viên có trên 2 thân nhân.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV) AS 'Họ tên NV có trên 2 TN'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV= THANNHAN.MA_NVIEN
GROUP BY (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV)
HAVING COUNT(THANNHAN.MA_NVIEN) > 2
4. Cho biết họ tên những trưởng phòng có ít nhất một thân nhân.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV) AS 'Họ tên TP có ít nhất 1 TN'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.MANV = PHONGBAN.TRPHG AND
		PHONGBAN.TRPHG IN (SELECT THANNHAN.MA_NVIEN
							FROM NHANVIEN, THANNHAN
							WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN
							)
6. Cho biết họ tên các nhân viên phòng Quản lý có mức lương trên mức lương trung bình
của phòng Quản lý.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên NV có LTB trên mức LTB của phòng "Quản lý"'
FROM NHANVIEN
WHERE NHANVIEN.LUONG > (SELECT AVG(NHANVIEN.LUONG)
						FROM NHANVIEN, PHONGBAN
						WHERE NHANVIEN.PHG = PHONGBAN.MAPHG AND PHONGBAN.TENPHG = N'Quản lý')
select * from PHONGBAN
7. Cho biết họ tên nhân viên có mức lương trên mức lương trung bình của phòng mà nhân
viên đó đang làm việc
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên NV có LTB trên mức LTB của phòng ban'
FROM NHANVIEN
WHERE NHANVIEN.LUONG > (SELECT AVG(NHANVIEN.LUONG)
						FROM NHANVIEN, PHONGBAN
						WHERE NHANVIEN.PHG = PHONGBAN.MAPHG)
8. Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất.
SELECT PHONGBAN.TENPHG, (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên TP của phòng ban đông NV nhất'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.MANV = PHONGBAN.TRPHG AND 
		PHONGBAN.MAPHG = (SELECT TOP 1 PHONGBAN.MAPHG
							FROM NHANVIEN, PHONGBAN
							WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
							GROUP BY PHONGBAN.MAPHG
							ORDER BY COUNT (NHANVIEN.PHG) DESC
							)
9. Cho biết danh sách các đề án mà nhân viên có mã là 456 chưa tham gia.
SELECT DEAN.MADA FROM DEAN
WHERE DEAN.MADA NOT IN (SELECT PHANCONG.MADA
						FROM PHANCONG
						WHERE PHANCONG.MA_NVIEN = '456'
						)
10. Danh sách nhân viên gồm mã nhân viên, họ tên và địa chỉ của những nhân viên không
sống tại TP Quảng Ngãi nhưng làm việc cho một đề án ở TP Quảng Ngãi.
SELECT DISTINCT MANV ,(NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên NV', NHANVIEN.DCHI
FROM NHANVIEN, DEAN, DIADIEM_PHG
WHERE NHANVIEN.PHG = DEAN.PHONG AND 
		NHANVIEN.PHG = DIADIEM_PHG.MAPHG AND 
		DEAN.DDIEM_DA LIKE N'%Quãng Ngãi' AND
		DIADIEM_PHG.DIADIEM NOT LIKE N'%Quãng Ngãi'
select * from DEAN
11. Tìm họ tên và địa chỉ của các nhân viên làm việc cho một đề án ở một địa điểm nhưng
lại không sống tại địa điểm đó.
SELECT DISTINCT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên NV', NHANVIEN.DCHI
FROM NHANVIEN, DEAN, DIADIEM_PHG
WHERE NHANVIEN.PHG = DEAN.PHONG AND 
		NHANVIEN.PHG = DIADIEM_PHG.MAPHG AND
		DEAN.DDIEM_DA IN (SELECT DEAN.DDIEM_DA FROM DEAN) AND
		DIADIEM_PHG.DIADIEM NOT LIKE DEAN.DDIEM_DA
12. Cho biết danh sách các mã đề án có: nhân công với họ là Lê hoặc có người trưởng
phòng chủ trì đề án với họ là Lê.
SELECT PHANCONG.MADA FROM NHANVIEN, PHANCONG
WHERE NHANVIEN.MANV = PHANCONG.MA_NVIEN AND NHANVIEN.HONV = N'Lê'
UNION
SELECT DEAN.MADA FROM NHANVIEN, PHONGBAN, DEAN
WHERE NHANVIEN.MANV = PHONGBAN.TRPHG AND PHONGBAN.MAPHG = DEAN.PHONG AND NHANVIEN.HONV = N'Lê'
select * from NHANVIEN
13. Liệt kê danh sách các đề án mà cả hai nhân viên có mã số 123 và 789 cùng làm.
SELECT DEAN.MADA
FROM DEAN
WHERE DEAN.MADA IN (SELECT PHANCONG.MADA FROM PHANCONG
					WHERE PHANCONG.MA_NVIEN = '123' AND PHANCONG.MA_NVIEN = '789')
select * from DEAN
select * from PHANCONG
14. Liệt kê danh sách các đề án mà cả hai nhân viên Đinh Bá Tiến và Trần Thanh Tâm
cùng làm
SELECT DEAN.TENDEAN
FROM NHANVIEN, DEAN, PHANCONG
WHERE DEAN.MADA	= PHANCONG.MADA AND NHANVIEN.MANV = PHANCONG.MA_NVIEN
AND NHANVIEN.HONV = N'Trần' AND NHANVIEN.TENLOT = N'Thanh' AND NHANVIEN.TENNV = N'Tâm'
AND NHANVIEN.HONV = N'Đinh' AND NHANVIEN.TENLOT = N'Bá' AND NHANVIEN.TENNV = N'Tiến'
select * from dean
select * from phancong
select * from nhanvien
15. Danh sách những nhân viên (bao gồm mã nhân viên, họ tên, phái) làm việc trong mọi
đề án của công ty
select MANV,(NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên NV', PHAI from NHANVIEN, DEAN, PHANCONG
where PHANCONG.MADA = DEAN.MADA AND NHANVIEN.MANV = PHANCONG.MA_NVIEN
group by MANV, HONV, TENLOT, TENNV, PHAI