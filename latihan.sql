use classicmodels;
show databases;
show tables;

-- 2a. Select menggunakan klausa where dengan lebih dari satu kondisi (AND atau OR)
-- 2b. Select menggunakan subquery dan klausa where
-- 2c. Select dari 2 tabel dengan inner join (klausa where optional)
-- 2d. Select dari 2 tabel dengan left atau right join (klausa where optional)
-- 3. Buat view yang dapat menampilkan komik yang sedang disewa beserta data member yang menyewanya.
-- 4. Buat Stored Procedures dengan parameter (IN) berupa id member dan mengembalikan melalui parameter (OUT) total biaya sewa yang telah dikeluarkan oleh member tersebut.
-- 5. Buat Stored Functions yang memiliki dua parameter, yaitu biaya sewa dan durasi penyewaan (dalam hari), serta mengembalikan total biaya sewa yang perlu dibayar. Terdapat biaya tambahan yang perlu dibayarkan juga jika durasi peminjaman cukup panjang, yaitu Rp20.000,- jika durasi lebih dari 7 hari dan Rp100.000,- jika durasi lebih dari 30 hari.
-- 6. Membuat Trigger di saat komik dipinjam maka jumlah stok ketersediaan komik berkurang.

--  jawaban
select * from customers where country = "france" or country = "usa";
select employeeNumber from employees where lastname = "murphy" and firstname = "diane"; -- subquery
select firstname, lastname from employees where reportsTo = (select employeeNumber from employees where lastname = "murphy" and firstname = "diane");
select orderdetails.orderNumber, products.productName from orderdetails inner join products on orderdetails.productCode = products.productCode limit 10;
select customerName, orderNumber from orders left join customers on customers.customerNumber = orders.customerNumber where orderNumber;
create view produkTerbanyak as select productName as produk, quantityInStock as banyak from products order by banyak desc limit 10;

delimiter $$
create procedure getOfficeByCountry(in country varchar(100))
begin
	select * from offices where country = country;
    select * from offices where country = country limit 10;
end $$
delimiter ;

call getOfficeByCountry("france");

show full tables;
desc customers;
desc orders;
select * from produkTerbanyak;
select * from employees;
select * from orders;
select * from customers;
select * from products;
select * from orderdetails;




















select count(*) from offices;
select * from offices;



delimiter $$
create procedure testing()
begin
select * from offices;
end$$
delimiter ;

-- WITHOUT PARAM	
delimiter $$
create procedure totalOffice()
begin
	declare total int default 0;
    select count(*) into total from offices;
	select total;
end$$
delimiter ;

-- WITH PARAM
delimiter $$
create procedure totalOffices(out total int)
begin
    select count(*) into total from offices;
end$$
delimiter ;

delimiter $$
create procedure getOfficeByCountry(in countryName varchar(45))
begin
	SELECT * FROM offices WHERE country = countryName;
end $$
delimiter ;

call totalOffices(@total);
call totalOffice();
select @total;
call getEmployees();
call getOfficeByCountry("USA");
drop procedure totalOffice;
drop procedure testing;
drop procedure getOfficeByCountry;
show procedure status;