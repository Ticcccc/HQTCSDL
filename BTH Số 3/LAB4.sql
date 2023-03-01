1. Liệt kê danh sách tất cả các nhân viên
select * from NHANVIEN
2. Tìm các nhân viên làm việc ở phòng số 5
select * from NHANVIEN
where NHANVIEN.PHG=5
3. Liệt kê họ tên và phòng làm việc các nhân viên có mức lương trên 6.000.000 đồng
select HONV+' '+TENLOT+' '+TENNV as 'Họ và tên', LUONG, PHG from NHANVIEN
where NHANVIEN.LUONG>6000
4. Tìm các nhân viên có mức lương trên 6.500.000 ở phòng 1 hoặc các nhân viên có mức
lương trên 5.000.000 ở phòng 4
select * from NHANVIEN
where NHANVIEN.LUONG>6500 AND NHANVIEN.PHG=1 OR NHANVIEN.LUONG>5000 AND NHANVIEN.PHG=4
5. Cho biết họ tên đầy đủ của các nhân viên ở TP Quảng Ngãi
select HONV+' '+TENLOT+' '+TENNV as 'Họ và tên', DCHI from NHANVIEN
where NHANVIEN.DCHI like N'%Quãng Ngãi'

select * from NHANVIEN
6. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
select HONV+' '+TENLOT+' '+TENNV as 'Họ và tên' from NHANVIEN
where NHANVIEN.HONV like N'N%'
7. Cho biết ngày sinh và địa chỉ của nhân viên Cao Thanh Huyền
select NGSINH, DCHI from NHANVIEN
where NHANVIEN.HONV=N'Cao' AND NHANVIEN.TENLOT=N'Thanh' AND NHANVIEN.TENNV=N'Huyền'

select * from NHANVIEN
8. Cho biết các nhân viên có năm sinh trong khoảng 1955 đến 1975
select * from NHANVIEN
where YEAR(NGSINH) between 1955 and 1975
9. Cho biết các nhân viên và năm sinh của nhân viên
select TENNV, YEAR(NGSINH) as 'Năm sinh' from NHANVIEN
10. Cho biết họ tên và tuổi của tất cả các nhân viên
select HONV+' '+TENLOT+' '+TENNV as 'Họ và tên', YEAR(GETDATE())-YEAR(NGSINH) as 'Tuổi' from NHANVIEN
11. Tìm tên những người trưởng phòng của từng phòng ban
select TENNV as 'Tên trưởng phòng', PHG from NHANVIEN, PHONGBAN
where PHONGBAN.TRPHG=NHANVIEN.MANV and NHANVIEN.PHG=PHONGBAN.MAPHG

select * from PHONGBAN
12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Điều hành".
select TENNV, DCHI, PHG from PHONGBAN, NHANVIEN
where PHONGBAN.MAPHG=NHANVIEN.PHG and TENPHG like N'Điều hành' and PHONGBAN.MAPHG=NHANVIEN.PHG

select * from PHONGBAN
13. Với mỗi đề án ở Tp Quảng Ngãi, cho biết tên đề án, tên phòng ban, họ tên và ngày
nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
select TENDEAN, TENPHG, HONV+' '+TENLOT+' '+TENNV as 'Họ và tên', NG_NHANCHUC from NHANVIEN, PHONGBAN, DEAN
where NHANVIEN.MANV=PHONGBAN.TRPHG and PHONGBAN.MAPHG=DEAN.PHONG and DEAN.DDIEM_DA like N'Quãng Ngãi'

select * from NHANVIEN
select * from PHONGBAN
select * from DEAN
14. Tìm tên những nữ nhân viên và tên người thân của họ
select TENNV, TENTN from NHANVIEN, THANNHAN
where NHANVIEN.MANV=THANNHAN.MA_NVIEN and NHANVIEN.PHAI like N'Nữ'
15. Với mỗi nhân viên, cho biết họ tên của nhân viên, họ tên trưởng phòng của phòng ban mà nhân viên đó đang làm việc.
select nv.HONV+' '+nv.TENLOT+' '+nv.TENNV as 'Họ Và Tên NV',ql.HONV+' '+ql.TENLOT+' '+ql.TENNV as 'Họ Và Tên QL', 
tp.HONV+' '+tp.TENLOT+' '+tp.TENNV as 'Họ Và Tên TP'
from NHANVIEN nv,NHANVIEN ql,NHANVIEN tp , PHONGBAN pb
where nv.MA_NQL=ql.MANV and tp.MANV= pb.TRPHG and pb.MAPHG=nv.PHG
16. Tên những nhân viên phòng Nghiên cứu có tham gia vào đề án "Xây dựng nhà máy chế biến thủy sản".
select TENNV from NHANVIEN, DEAN, PHONGBAN
where PHONGBAN.MAPHG=NHANVIEN.PHG and TENPHG like N'Nghiên cứu' and TENDEAN like N'Xây dựng nhà máy chế biến thủy sản'

select * from NHANVIEN
select * from DEAN
select * from PHONGBAN
17. Cho biết tên các đề án mà nhân viên Trần Thanh Tâm đã tham gia.
select DEAN.TENDEAN from NHANVIEN,PHANCONG,DEAN
where NHANVIEN.MANV = PHANCONG.MA_NVIEN and PHANCONG.MADA= DEAN.MADA and HONV = N'Trần' and TENLOT=N'Thanh' and TENNV=N'Tâm'