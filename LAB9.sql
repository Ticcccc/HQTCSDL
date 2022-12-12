--16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT SANPHAM.MASP, SANPHAM.TENSP
FROM SANPHAM
WHERE SANPHAM.MASP NOT IN
(
SELECT DISTINCT SANPHAM.MASP
FROM SANPHAM, HOADON, CTHD
WHERE SANPHAM.MASP = CTHD.MASP AND CTHD.SOHD = HOADON.SOHD AND YEAR(HOADON.NGHD) = '2006'
)
--17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT SANPHAM.MASP, SANPHAM.TENSP
FROM SANPHAM
WHERE SANPHAM.NUOCSX = 'Trung Quoc' AND SANPHAM.MASP NOT IN
(
SELECT DISTINCT SANPHAM.MASP
FROM SANPHAM, CTHD, HOADON
WHERE SANPHAM.MASP = CTHD.MASP AND CTHD.SOHD = HOADON.SOHD AND SANPHAM.NUOCSX = 'Trung Quoc'
AND YEAR(HOADON.NGHD) = '2006'
)
--18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT DISTINCT CTHD.SOHD
FROM CTHD
WHERE NOT EXISTS
(
SELECT SANPHAM.MASP
FROM SANPHAM
WHERE SANPHAM.NUOCSX = 'Singapore'
AND NOT EXISTS
(
SELECT *
FROM CTHD AS CTHD_S
WHERE CTHD_S.MASP = SANPHAM.MASP AND CTHD_S.SOHD = CTHD.SOHD
)
)
--19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
**Trùng câu 18**
--20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(*) AS SOHD_KHONGTHANHVIEN
FROM HOADON
WHERE HOADON.MAKH IS NULL
--21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT DISTINCT COUNT(*) AS SL_SANPHAM_KHACNHAU
FROM
(
SELECT DISTINCT CTHD.MASP
FROM CTHD, HOADON
WHERE CTHD.SOHD = HOADON.SOHD AND YEAR(HOADON.NGHD) = '2006'
) AS TABLE_A
--22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(TRIGIA) AS MAX_TRIGIA, MIN(TRIGIA) AS MIN_TRIGIA
FROM HOADON
--23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AS TRIGIA_TB
FROM HOADON
--24. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(HOADON.TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(HOADON.NGHD) = '2006'
--25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HOADON.SOHD
FROM HOADON
WHERE HOADON.TRIGIA IN 
(
SELECT MAX(TRIGIA) AS MAX_TRIGIA
FROM HOADON
WHERE YEAR(HOADON.NGHD) = '2006'
)
--26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT KHACHHANG.HOTEN
FROM KHACHHANG
WHERE KHACHHANG.MAKH IN
(
SELECT HOADON.MAKH
FROM HOADON
WHERE HOADON.TRIGIA IN 
(
SELECT MAX(TRIGIA) AS MAX_TRIGIA
FROM HOADON
WHERE YEAR(HOADON.NGHD) = '2006'
)
)
--27. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
--28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP, TENSP
FROM SANPHAM
WHERE SANPHAM.GIA IN
(
SELECT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC
)
--29. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP, TENSP
FROM SANPHAM
WHERE SANPHAM.NUOCSX = 'Thai Lan' AND SANPHAM.GIA IN
(
SELECT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC
)
--30. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP, TENSP
FROM SANPHAM
WHERE SANPHAM.NUOCSX = 'Trung Quoc' AND SANPHAM.GIA IN
(
SELECT TOP 3 GIA
FROM SANPHAM
WHERE SANPHAM.NUOCSX = 'Trung Quoc'
ORDER BY GIA DESC
)
--31. * In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
--32. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(SANPHAM.MASP) AS SUM_SP
FROM SANPHAM
WHERE SANPHAM.NUOCSX = 'Trung Quoc'
--33. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT SANPHAM.NUOCSX, COUNT(SANPHAM.MASP) AS SL_SP
FROM SANPHAM
GROUP BY SANPHAM.NUOCSX
--34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT SANPHAM.NUOCSX, MAX(SANPHAM.GIA) AS GIAMAX, MIN(SANPHAM.GIA) AS GIAMIN, AVG(SANPHAM.GIA) AS GIATB
FROM SANPHAM
GROUP BY SANPHAM.NUOCSX
--35. Tính doanh thu bán hàng mỗi ngày.
SELECT HOADON.NGHD, SUM(HOADON.TRIGIA) AS DOANHTHU
FROM HOADON
GROUP BY HOADON.NGHD
