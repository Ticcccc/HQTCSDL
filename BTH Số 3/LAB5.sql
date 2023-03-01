18. Cho biết số lượng đề án của công ty
select count(*) as 'Số lượng DA' from DEAN

select * from DEAN
19. Liệt kê danh sách các phòng ban có tham gia chủ trì các đề án
select TENPHG, TENDEAN from PHONGBAN,DEAN
where PHONGBAN.MAPHG=DEAN.PHONG
group by TENPHG, TENDEAN 
20. Cho biết số lượng các phòng ban có tham gia chủ trì các đề án
select TENDEAN,count(*) as 'Số lượng phòng ban' from PHONGBAN,DEAN
where PHONGBAN.MAPHG=DEAN.PHONG
group by TENDEAN
21. Cho biết số lượng đề án do phòng Nghiên Cứu chủ trì
select count(*) as 'Số lượng DA' from DEAN, PHONGBAN
where PHONGBAN.MAPHG=DEAN.PHONG and TENPHG like N'Nghiên cứu'

select * from DEAN
select * from PHONGBAN
22. Cho biết lương trung bình của các nữ nhân viên
select avg(LUONG) as 'Lương TB của các NV nữ' from NHANVIEN
where PHAI like N'Nữ'
23. Cho biết số thân nhân của nhân viên Đinh Bá Tiến
select count(*) as 'Số thân nhân' from NHANVIEN,THANNHAN
where NHANVIEN.MANV=THANNHAN.MA_NVIEN and HONV = N'Đinh' and TENLOT=N'Bá' and TENNV=N'Tiến'

select * from NHANVIEN
select * from THANNHAN
24. Liệt kê danh sách 3 nhân viên lớn tuổi nhất, danh sách bao gồm họ tên và năm sinh.
select top (3) HONV+' '+TENLOT+' '+TENNV as 'Họ Và Tên', max(YEAR(NGSINH)) as 'Năm sinh' from NHANVIEN
group by HONV, TENLOT, TENNV
25. Với mỗi đề án, liệt kê mã đề án và tổng số giờ làm việc của tất cả các nhân viên tham
gia đề án đó.
select DEAN.MADA,sum(THOIGIAN) as 'Tổng giờ làm' from PHANCONG,DEAN
where DEAN.MADA=PHANCONG.MADA
group by DEAN.MADA
26. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc của tất cả các nhân viên tham
gia đề án đó.
select TENDEAN,sum(THOIGIAN) as 'Tổng giờ làm' from PHANCONG,DEAN
where PHANCONG.MADA = DEAN.MADA
group by TENDEAN
27. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó, thông tin bao gồm
tên đề án và số lượng nhân viên.
select TENDEAN, count(*) as 'Số lượng NV' from PHANCONG, NHANVIEN, DEAN
where NHANVIEN.MANV=PHANCONG.MA_NVIEN and DEAN.MADA=PHANCONG.MADA
group by TENDEAN

select * from PHANCONG
select * from DEAN
28. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên
đó.
select HONV+' '+TENLOT+' '+TENNV as 'Họ Và Tên',count(*) as 'Số lượng TN' from NHANVIEN,THANNHAN
where NHANVIEN.MANV = THANNHAN.MA_NVIEN
group by HONV, TENLOT, TENNV
29. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó
đã tham gia.
select HONV+' '+TENLOT+' '+TENNV as 'Họ Và Tên',count(*) as 'Số lượng DA' from NHANVIEN,PHANCONG
where NHANVIEN.MANV=PHANCONG.MA_NVIEN
group by HONV, TENLOT, TENNV
30. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên
làm việc cho phòng ban đó.
select TENPHG,AVG(LUONG) as 'Lương TB' from PHONGBAN,NHANVIEN
where PHONGBAN.MAPHG=NHANVIEN.PHG
group by TENPHG
31. Với các phòng ban có mức lương trung bình trên 5.200.000, liệt kê tên phòng ban và
số lượng nhân viên của phòng ban đó.
select TENPHG,COUNT(*) as 'Số lượng NV' from PHONGBAN,NHANVIEN
where PHONGBAN.MAPHG=NHANVIEN.PHG
group by TENPHG
having avg(LUONG)>52000
32. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ
trì
select TENPHG,count(*) as 'Số lượng DA' from PHONGBAN,DEAN
where PHONGBAN.MAPHG=DEAN.PHONG
group by TENPHG

select * from DEAN
33. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng
đề án mà phòng ban đó chủ trì
select TENPHG,HONV+' '+TENLOT+' '+TENNV as 'Họ và Tên TP',count(*) as 'Số lượng DA'
from PHONGBAN,NHANVIEN,DEAN
where NHANVIEN.MANV=PHONGBAN.TRPHG and PHONGBAN.MAPHG=DEAN.PHONG
group by TENPHG,HONV,TENLOT,TENNV

select * from NHANVIEN
select * from PHONGBAN
select * from DEAN
34. Với mỗi đề án, cho biết tên đề án và số lượng nhân viên tham gia đề án
select TENDEAN, count(*) as 'Số lượng NV' from PHANCONG, NHANVIEN, DEAN
where NHANVIEN.MANV=PHANCONG.MA_NVIEN and DEAN.MADA=PHANCONG.MADA
group by TENDEAN