create database audit_system;
use audit_system;

create table client_master(cliebtno int primary key auto_increment,name varchar(20),address varchar(30),bal_due int);
alter table client_master auto_increment = 101;
insert into client_master(name,address,bal_due) values('a','kothrud',500),('b','Pune',1500),('c','Nashik',200);
select * from client_master;
create table audit_client(clientno int,name varchar(20),bal_due int,op varchar(20),odate date);

delimiter $$
create trigger after_update_client after update on client_master for each row
	begin
    insert into audit_client
    set op = 'update',clientno = new.clientno, name = new.name,
    bal_due = new.bal_due,
    odate = now();
    end$$
    
    create trigger after_del_client after delete on client_master for each row
    begin
    insert into audit_client
    set op = 'delete',clientno = old.clientno, name = old.bal_due,
    odate = now();
    end$$
    
    delimiter ;
    update client_master set bal_due = 1600 where bal_due >= 1500;
    select*from audit_client;
    delete from audit_client;
    delete from client_master where clientno = 102;
    show triggers;


-- set2
create database bankk;
use bankk;
create table trans_mstr(transno int primary key, accno int,transdate date,operation varchar(20), amt int, balance int);
delimiter $$
create trigger before_insert_trans before insert on trans_mstr for each row
begin
if new.amt<0 then signal sqlstate '45000' set message_text = 'amt less than 0';
end if;
if new.amt>new>new.balance then signal sqlstate '45000' set message_text = 'not enough balance';
end if;
end$$
delimiter ;
insert into trans_mtr values(15,100,curdate(),'deposit',1500,1000);
select * from trans_mstr;

delimiter $$
create trigger after_insert_trans after insert on trans_mstr for each row
begin
if new.amt<0 then
delete from trans_mstr where transno=new.transno;
end if;
if new.amt>new.balance then 
delete from trans_mstr where transno=new.transno;
end if;
end$$
delimiter ;
drop trigger after_insert_trans;

-- set3
create database company1;
use company1;
create table dept(
deptno int(2),
dname varchar(14),
loc varchar(13),
constraints pk_dept primary key(deptno),
no_of_emps int
);

insert into dept values (10,'ACCOUNTING','NEW YORK',0);
insert into dept values (20,'RESEARCH','DALLAS',0);
insert into dept values (30,'SALES','CHICAGO',0);
insert into dept values (40,'OPERATIONS','BOSTON',0);
insert into dept values (50,'DEV','NEW YORK',0);

select * from dept;
alter table dept add unique(dname);
desc dept;

create table emp(
empno int(4) primary key,
ename varchar(10),
job varchar(9),
mgr int(4), foreign key(mgr) references emp(empno),
hiredate date,
sal float(7,2),
comm float(7,2),
deptno int(2),
constraint fk_deptno foreign key(deptno) references dept(deptno)
);
desc emp;
select *from emp;

select *from emp;
delete from emp;
create table Emp_raise(empno int, raise_date date,raise_amt decimal(8,2));

-- after insert trigger
delimiter $$
create trigger after_insert_emp after insert on emp for each row
begin
update dept set no_of_emps_=no_of_emps +1 where deptno=new.deptno;
end$$
delimiter ;
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);
insert into emp values (7839,'KING','PRESIDENT',NULL,'1981-11-07',5000,NULL,10);




