-- create database department;
create database department;
use department;
create table dept(DeptNo int primary key, Dname varchar(30), loc varchar(30));
create table emp(EmpNO int primary key, DeptNo int,foreign key(DeptNo) references dept(DeptNo), Ename varchar(30) NOT NULL, Job char(30) NOT NULL, ManagerID int,foreign key(ManagerID) references emp(EmpNo), Hiredate date, Salary int NOT NULL CHECK(Salary >0),Commission int CHECK(Commission > 0) DEFAULT 10000);
ALTER TABLE dept ALTER DeptNo SET DEFAULT 1;
insert into dept values(10,'Accounting','Japan');
insert into dept values(20,'Research','USA');
insert into dept values(30,'Management','Abu Dhabi');
insert into dept values(40,'Software and IT','India');
select * from dept;
insert into emp values(1, 10, 'Rahul', 'CEO', NULL, '2020-03-16', 290000, 100000);
insert into emp values(2, 20, 'Sahil', 'COO', 1, '2020-03-17', 390000, 80000);
insert into emp values(3, 20, 'Rajas', 'CTO', 1, '2020-03-18', 230000, 90000);
insert into emp values(4, 20, 'Paritosh', 'VP', 2, '2020-03-19', 260000, 100000);
insert into emp values(5, 30, 'Shreeya', 'Director of IT', 3, '2020-03-20', 190000, 70000);
insert into emp values(6, 30, 'Astha', 'Delivery Head', 4, '2020-03-21', 200000, 50000);
insert into emp values(7, 40, 'Pranav', 'Senior IT Manager', 3, '2021-03-22', 300000, 75000);
insert into emp values(8, 40, 'Rakesh', 'Branch Manager', 7, '2021-03-23', 250000, 100000);
select * from emp;
-- SET:1
-- Q1) List the number of employees and average salary for employees in department 20;
   select count(*), avg(Salary) from emp WHERE DeptNo=20;
Q) List name, salary and PF amount of all employees. (PF is calculated as 10% of basic salary);
   select Ename, Salary, Salary* .10 PF from emp;
Q) List the employee details in the ascending order of their basic salary.
   select * from emp ORDER BY Salary ASC;
Q)
select Ename, Hiredate FROM emp ORDER BY Hiredate DESC;
Q)
select Ename,Salary, Salary/100*50 AS HRA, Salary/100*10 AS PF,Salary/100*30 AS DA, Salary+Salary/100*50+Salary/100*10+Salary/100*30 AS gross FROM emp;
Q)
select DeptNO, count(*) FROM emp GROUP BY DeptNO;
Q)
update emp SET Salary = Salary + (Salary*10/100) Where job = "salesman";
Q)
select sum(salary), max(salary), min(salary), avg(salary) from emp where deptno=20;
Q)
select ename from emp where ename like'__i%';
Q)
select max(salary) from emp WHERE job="salesman";
Q)
update emp set salary=salary+(salary*0.01) WHERE job="salesman";

-- SET 2
select Ename,salary from emp ORDER BY deptNo;
select ename,salary from emp ORDER BY salary desc limit 0,5;
select empno from emp WHERE deptno=NULL;
select * FROM emp WHERE mod(salary,2) = 1;
select * from emp WHERE length(salary)=3;
select * from emp where DATE_FORMAT(hiredate,'%m') = 3;
select * from emp where ename like '%A%';
select min(salary),max(salary),avg(salary) from emp;
select weekday(hiredate) from emp;
select char_length(ename) from emp;
select * from emp WHERE salary < 1000 ORDER BY salary;

-- SET 3
select distinct(dname) from dept;
DELETE FROM emp WHERE hiredate BETWEEN '1980-01-01' AND '1980-12-31';
delete from emp where DATE_FORMAT(hiredate,'%Y') = 1980;
update emp set salary=salary+salary*0.2 where job="manager";
select ename,deptno from emp where deptno not in(30,40,10);
select ename, salary from emp where commission IS NULL;
select ename from emp where ename LIKE ('S%') and ename LIKE('%S');
select ename from emp where ename LIKE '_a%';
select COUNT(*) from employees;
select ename, date_format(hiredate,'%M,%d,%Y.') from emp;
select * from emp where job = 'Salesman' and commission between 200 and 500;

-- SET 4
select ename from emp where year(current_date())-year(hiredate)>2;
select * from emp order by salary;
select ename from emp where salary > (select salary from emp where ename="Smith");
update emp set salary=salary+(salary*0.1) where empno=7499;
select * from emp where salary between 10000 and 25000;
select ename,commission from emp where commission is null;
update emp set salary = salary + (salary*10/100) where job="COO";
select job, sum(salary), max(salary), min(salary), avg(salary) from emp group by job;
delete from emp where ename like "A%";
select * from emp where job="clerk" and commission > 500 order by ename desc; 
select ename,deptno from emp where deptno in(20,30,40);

-- SET 5
select deptno, count(*) AS num_employees_hired from emp where hiredate >= '2022-01-01' and hiredate <= '2022-12-31' group by deptno having count(*) > 5 order by deptno;
select deptno ,job,count(*) from emp group by deptno,job order by deptno,job;
select deptno,count(empno),sum(salary) from emp where commission is null group by deptno;
select deptno, sum(salary) as totalsalary from emp where job='Manager' group by deptno having sum(salary)>500000;
select deptno, job, sum(salary) from emp group by deptno,job;
