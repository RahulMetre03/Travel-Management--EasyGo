create database books;
use books;
drop database books;

create table book(Isbn varchar(20) primary key, Title varchar(255), SoldCopies int);
insert into book values('364646464','book1',10);
insert into book values('646477747','book2',7);
insert into book values('846255498','book3',11);
insert into book values('849363848','book4',12);
insert into book values('848373849','book5',8);
select * from book;

create table author(name varchar(30) primary key, SoldCopies int);
insert into author values('Rahul',10);
insert into author values('Akshay',7);
insert into author values('Sachin',11);
insert into author values('Raj',12);
insert into author values('Mihir',8);
select * from author;

create table writing(Isbn varchar(20),foreign key(Isbn) references book(Isbn),name varchar(30), foreign key (name) references author(name),primary key(Isbn,name));
insert into writing values('364646464','Rahul');
insert into writing values('646477747','Akshay');
insert into writing values('846255498','Sachin');
insert into writing values('849363848','Raj');
insert into writing values('848373849','Mihir');
select * from writing;

CREATE TRIGGER update_author_soldcopies1
AFTER UPDATE ON BOOK
FOR EACH ROW
UPDATE AUTHOR
SET SoldCopies = (
  SELECT SUM(SoldCopies)
  FROM BOOK
  JOIN WRITING ON BOOK.Isbn = WRITING.Isbn
  WHERE AUTHOR.name = WRITING.name
)
WHERE AUTHOR.name = (
  SELECT name FROM WRITING WHERE WRITING.Isbn = NEW.Isbn
);

CREATE TRIGGER update_author_new_writing1
AFTER INSERT ON WRITING
FOR EACH ROW
UPDATE AUTHOR
SET SoldCopies = (
  SELECT SUM(SoldCopies)
  FROM BOOK
  WHERE BOOK.Isbn = NEW.Isbn
)
WHERE AUTHOR.name = NEW.name;




