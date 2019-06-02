create table insurance
( agentId int,
policyname char(3),
premium int
)

insert into insurance(agentId, policyname, premium) values
(101, 'CP', 10000),(101, 'PP', 5000),(101, 'CP', 6000),(102, 'CP', 7000),(102, 'CP', 8000),(101, 'PP', 7000),(102, 'PP', 10000)
 select * from insurance
 drop table insurance
 SET SQL_SAFE_UPDATES=0;


select agentId, policyname, sum(premium) as total, count(premium)
from insurance
group by agentId, policyname