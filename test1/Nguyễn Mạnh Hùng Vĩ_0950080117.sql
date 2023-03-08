Câu 1:
Có 2 nhóm nhân viên với các công việc cụ thể sau:
- Nhóm 1 gồm : trưởng nhóm TN và nhân viên NV, có quyền hiệu chỉnh (thêm, sửa, xóa)
và xem dữ liệu bảng Production.ProductInventory.
- Nhóm 2 gồm : quản lý QL, thuộc role db_datawriter
Thực hiện các yêu cầu sau:
a. Tạo các login; tạo các user khai thác CSDL AdventureWorks2008R2 cho các nhân viên nêu
trên (tên login trùng tên user).
--Tạo login, user cho trưởng nhóm trưởng nhóm
CREATE LOGIN TN WITH PASSWORD = '234234';

CREATE USER TN FOR LOGIN TN;

-- Tạo login, user cho nhân viên NV
CREATE LOGIN NV WITH PASSWORD = '123123';

CREATE USER NV FOR LOGIN NV;

-- Tạo login, user cho nhân viên QuanLy
CREATE LOGIN QL WITH PASSWORD = '345345';

CREATE USER QL FOR LOGIN QL;
b. Phân quyền để các nhân viên hoàn thành nhiệm vụ được phân công. Lưu ý : Admin chỉ cấp
quyền cho trưởng nhóm TN và quản lý QL. Quyền của nhân viên NV được trưởng nhóm cấp.
-- Phân quyền cho trưởng nhóm TN
GRANT SELECT, UPDATE,DELETE ON Production.ProductInventory TO TN

-- Phân quyền cho nhân viên NV
GRANT SELECT, UPDATE, DELETE ON Production.ProductInventory TO NV

-- Phân quyền quản lý QL
GRANT SELECT, UPDATE, DELETE ON Production.ProductInventory TO QL

c. Đăng nhập phù hợp, mở cửa sổ query tương ứng và viết lệnh để:
- trưởng nhóm TN sửa 1 dòng dữ liệu tùy ý,
- nhân viên NV xóa 1 dòng dữ liệu tùy ý và
- quản lý QL xem lại kết quả thực hiện của 2 user trên.
(Lưu ý: Đặt tên các cửa sổ query làm việc ứng với các nhân viên là TN, NV, QL và lưu các query
này vào thư mục bài làm)
d. Ai có thể sửa được dữ liệu bảng Production.Product ? Viết lệnh cụ thể và giải thích vì sao?
--Chỉ có trưởng nhóm TN và quản lý QL có thể sửa được dữ liệu bảng Production.Product, 
--vì họ được phân quyền SELECT và UPDATE trên bảng này.
e. Nhân viên NV nghỉ việc, trưởng nhóm hãy thu hồi quyền cấp cho nhân viên NV này.
-- Thu hồi quyền của nhân viên NV
REVOKE SELECT, UPDATE, DELETE ON Production.ProductInventory FROM NV;

-- Xóa user của nhân viên NV
DROP USER NV;

f. Nhóm 1 hoàn thành dự án, admin hãy vô hiệu hóa các hoạt động của nhóm này trên CSDL
Câu 2:Thực hiện chuỗi các thao tác sau để có thể phục hồi database khi có sự cố ở thời điểm T8?
Yêu cầu :
- Các backup được ghi vào cùng một thiết bị
- Thực hiện 3 dạng backup
T1 : [thực hiện Full Backup]
T2 : Cập nhật tăng mức tồn kho an toàn SafetyStockLevel trong table Production.Product lên
10% cho các mặt hàng là nguyên liệu sản xuất
T3 : [thực hiện Differential Backup]
T4 : Xóa mọi bản ghi trong bảng Person.Emailaddress
T5 : [thực hiện Differential Backup]
T6 : Thêm một dòng trong table Person.ContactType
T7 : [thực hiện Log Backup]
T8 : Xóa CSDL AdventureWorks2008R2.
T9 : Phục hồi CSDL về trạng thái ở T7
T10 : Kiểm tra xem DB phục hồi có ở trạng thái T7 không ?
