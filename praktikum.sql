show databases;
use classicmodels;
show tables;

delimiter $$
create procedure customers()
begin
	select * from customers;
end $$
delimiter ;

delimiter $$
create procedure helloNama(in namaparam varchar(100))
begin
	select concat("Hello ", namaparam) as nama;
end $$
delimiter ;

delimiter $$
create procedure helloNamaOut(out namaparam varchar(100))
begin
	select "Hello Efrizal" into namaparam;
end $$
delimiter ;

delimiter $$
create procedure jumlahOffice(out total int)
begin
	select count(*) into total from offices;
end $$
delimiter ;

delimiter $$
create function nama()
returns varchar(100)
begin
	declare nama varchar(100);
	set nama = "Efrizal";
    return nama;
end $$
delimiter ;


delimiter $$
create function helloNama(nama1 varchar(100), nama2 varchar(100))
returns varchar(100)
begin
	declare nama varchar(100);
    set nama = concat("Hello ", nama1," dan ", nama2);
    return nama;
end $$
delimiter ;


create table anggota(
	anggota_id int(11) auto_increment primary key,
    nama varchar(255) not null,
    alamat varchar(255)
);
create table anggota_log(
	anggota_log_id int(11) auto_increment primary key,
    created datetime
);

delimiter $$
create trigger aft_ins_anggota
after insert on anggota for each row
begin
	insert into anggota_log(created) values
    (now());
end $$
delimiter ;

show tables;
show triggers;

insert into anggota_log(created) values (now());
insert into anggota(nama, alamat) values ("Efrizal", "Jakarta Selatan");
select * from anggota_log;

select nama();
select helloNama("Upin","Ipin");

call nama("Nurul Fikri");
call helloNama("Nurul Fikri");
call helloNamaOut(@nama);
call jumlahOffice(@jumlah);
select @jumlah as jumlah;
select @nama as nama;
call customers();

show procedure status;