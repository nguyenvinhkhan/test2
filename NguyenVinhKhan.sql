Create table VatTu
(
MaVT nvarchar(50) not null Primary Key,
TenVT nvarchar(50),
DVTinh char(10),
SLCon int
)
Create table HDBan
(
MAHD nvarchar(50) not null Primary Key,
HoTenKhach nvarchar(20),
NgayXuat date,
)
Create table HangXuat
(
MaHD nvarchar(50) FOREIGN KEY references HDBan(MaHD),
MaVT nvarchar(50) FOREIGN KEY references VatTu(MaVT),
DonGia int,
SLBan int,
)
--Cau 1
select Top 1 (SLBan*DonGia) as 'TongTien',MaHD
from HangXuat
order by [TongTien]
--Cau 2
use QLHANG
go
select top 1 MaHD, sum(DonGia)
as TongTien
from HangXuat
group by MaHD, DonGia
order by DonGia desc
go

select * from HangXuat

--Cau 3
Create function cau 3(MaHD nvarchar(10))
returns @infoHD table (MaHD nvarchar(10), NgayXuat date, MaVT nvarchar(10),Dongla float ,SLBan int, NgayThu date)
as 
begin 
   insert into @infoHD
     SELECT MaHD, NgayXuat, MaVT 
	 from HDBan
	 inner join HangXuat on HangXuat.MaHD