create database ms;

use ms;

create table Movies
(MovieID int,
 MovieName varchar(30),
 Category char(3),
 Language varchar(15),
 primary key(MovieID)
);

insert into Movies(MovieID, MovieName, Category, Language) values
(100,'SPEED', 'UA', 'English'),(101,'Hanuman', 'U','Hindi'),(102,'Terminator', 'UA', 'English'),
(103,'Matrix', 'UA', 'English'),(104,'My Friend Ganesha', 'U', 'Hindi') ;

select * from Movies;


create table Shows
( id int,
Dateandtime datetime,
MovieID int,
Price int,
Primary key(id),
foreign key(MovieID) references Movies(MovieID)
);


insert into Shows(id, Dateandtime, MovieID, Price) values
(10, '2009-07-21 12:00:00', 100, 120),(11, '2009-07-21 16:00:00', 100, 150),(12, '2009-07-21 19:00:00', 101, 175),
(13, '2009-07-21 11:30:00', 102, 150),(14, '2009-07-21 23:30:00', 102, 175),(15, '2009-07-22 9:30:00', 103, 100),
(16, '2009-07-22 12:00:00', 103, 120),(17, '2009-07-22 14:30:00', 103, 150),(18, '2009-07-22 20:30:00', 104, 175);

drop table Shows;

select * from Shows;
select * from Movies;

Show columns from Movies;

insert into Shows(id, Dateandtime, MovieID, Price) values
(19, '2009-07-21 11:00:00', NULL, 130);
#1
select * from Movies where language='Hindi'
#2
select * from Movies where MovieName like 'H%'
#3
select * from Shows where language='Hindi'

#4)	Show total count of shows on each day

Select Date(Dateandtime),count(id) as NoOfShows from shows
group by Date(Dateandtime)

#5)	Show the total count of A.M(before 12 PM) shows and P.M (after 12PM) shows on each day. Hint: DATE_FORMAT(DateandTime, "%p") 

select DATE_FORMAT(DateandTime,"%p"), count(id) from shows
group by DATE_FORMAT(DateandTime,"%p")

#6)	Show the total price of all shows whose movie name is 'MATRIX'
Select m.MovieName, sum(s.Price) as total from 
shows s join Movies m
on s.MovieID=m.MovieID
Where m.MovieName='Matrix'

#7)	Show the maximum  price of the show whose movie name  is 'Terminator'
Select Max(Price) as Maxprice from shows
where MovieID='102'

#8)	Select number of shows running per movie
select * from Shows;
select * from Movies;

Select count(s.MovieID), m.MovieName
from Shows s Join Movies m
on s.MovieID= m.MovieID
group by MovieName