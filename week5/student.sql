use test;

create database test;
create table student
( id int, 
  name varchar(30),
  gender char(1),
  DOB date,
  primary key(id)
)  
drop table student
show columns from student

create table Telephone
( id int,
  telnum varchar(20),
  foreign key(id) references student(id)
)

insert into student values(1, 'Vikas', 'M','2000-08-21')

select * from student
select name, gender from student

insert into student(id, name, gender, DOB) values
(2, 'Vijay', 'M','2002-08-21')

insert into student(id, name, gender) values
(4, 'Vikam', 'M'), (5, 'Vikam', 'M'),(6, 'Vikam', 'M'),(7, 'Vikam', 'M')																		

insert into student(id, name, gender) values
(8, 'Preeti', 'F'),(9, 'Mridu', 'F'),(10, 'Pallavi', 'F'),(11, 'Sejal', 'F')

delete from student where id=7
update student set dob='1999-12-12' where id=4
update student set dob='1999-02-12' where id=3
update student set name='virat',dob='1998-12-03' where id=2