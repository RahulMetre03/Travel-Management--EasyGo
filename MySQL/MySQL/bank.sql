create database bank;
use bank;

drop table customer;
CREATE TABLE customer(custid INT PRIMARY KEY, custname VARCHAR(20), city VARCHAR(15), mobileno VARCHAR(10));

drop table branch;
CREATE TABLE branch(branchname VARCHAR(20) PRIMARY KEY , branchcity VARCHAR(20));

drop table employee;
CREATE TABLE employee(empid INT PRIMARY KEY, ename VARCHAR(20), ephnno VARCHAR(10), emp_custid INT, empdependents VARCHAR(20), 
CONSTRAINT emp_cust_fk FOREIGN KEY(emp_custid) REFERENCES customer(custid));

drop table account;
CREATE TABLE account(accno INT PRIMARY KEY,category VARCHAR(20), accbalance float, accessdate date, acc_branchname VARCHAR(20),
CONSTRAINT acc_branch_fk FOREIGN KEY(acc_branchname) REFERENCES branch(branchname));

drop table loan;
CREATE TABLE loan(loanno INT PRIMARY KEY,paymentno VARCHAR(20), ln_branchname VARCHAR(20),
CONSTRAINT loan_branch_fk FOREIGN KEY(ln_branchname) REFERENCES branch(branchname));

drop table payment;
CREATE TABLE payment(paymentno INT PRIMARY KEY,datepaid date, loanno INT,
CONSTRAINT pay_loan_fk FOREIGN KEY(loanno) REFERENCES loan(loanno));

truncate table customer;
select * from customer;

insert into customer values (1, 'rahul', 'pune', '9876543210');
insert into customer values (2, 'ramesh', 'nasik', '9876548654');
insert into customer values (3, 'prajay', 'pune', '9876543211');
insert into customer values (4, 'pintu', 'sangli', '9845673210');
insert into customer values (5, 'chnitu', 'nasik', '982345210');

insert into branch values ('br1','pune');
insert into branch values ('br2','nasik');
insert into branch values ('br3','sangli');

insert into employee values (11, 'rajesh','2345678901', 1, 'sunita');
insert into employee values (22, 'sunil','2345678901', 2, 'anita');
insert into employee values (33, 'sanjay','2345678901', 3, 'mumta');
insert into employee values (44, 'amey','2345678901', 3, 'radha');
insert into employee values (55, 'rajas','2345678901', 4, 'shyama');

insert into account values (111,'salary', 100000, '2023-02-14','br1');
insert into account values (222,'abc', 110000, '2023-02-16','br1');
insert into account values (333,'xyz', 120000, '2023-02-18','br2');
insert into account values (444,'pqr', 130000, '2023-02-20','br3');

insert into loan values (123,1111,'br1');
insert into loan values (456,2222,'br2');
insert into loan values (321,3333,'br1');
insert into loan values (654,4444,'br3');

insert into payment values (1111,2023-04-22,123);
insert into payment values (2222,2023-04-24,123);
insert into payment values (3333,2023-04-26,123);
insert into payment values (4444,2023-04-2,123);

alter table account drop constraint acc_branch_fk;
alter table loan drop constraint loan_branch_fk;
alter table employee drop column empdependents;
select * from employee;
alter table employee add column empdependents VARCHAR(20);

alter table payment rename payments;

alter table payments rename column datepaid to paymentdate;