-- comp9311 19s1 Project 1
--
-- MyMyUNSW Solutions


-- Q1:ok
create or replace view Q1(unswid, longname)
as
select distinct unswid,longname 
from rooms 
where  id In(
	select room from classes where course in (
		select id from courses where subject in(
			select id from subjects where code='COMP9311')and semester in(
			select id from semesters where term = 'S1'and year='2013'))) and rtype in (
select id from room_types where description ='Laboratory');



-- Q2:ok
create or replace view Q2(unswid,name)
as
select unswid,name from people 
where id in(
	select distinct staff from course_staff where course in(
		select course from course_enrolments where student in (
			select id from people where name = 'Bich Rae')));

-- Q3:not satisfy same semester

create or replace view Q3_1(id, semester)
as
select id,semester 
from courses 
where subject in (select id from subjects where code='COMP9311');


create or replace view Q3_2(id, semester)
as
select id,semester 
from courses 
where subject in (select id from subjects where code='COMP9021');
	

create or replace view Q3_3(id)
as

select id 
from Q3_1,Q3_2
where Q3_1.semester = Q3_2.semester;


create or replace view Q3(unswid, name)
as 
select unswid,name from people where id in (
select distinct student from course_enrolments where course in Q3_3.id

intersect 

select distinct id from students where stype ='intl');






-- Q4:
-----------seek total student
create or replace view Q4_1(program, All_student)
as
select program, CAST(COUNT(distinct student) AS DECIMAL(10,4))
from Program_enrolments
group by program;


create or replace view Q4_2(program, Intl_student)
as
select program, CAST(COUNT(distinct student) AS DECIMAL(10,4))
from Program_enrolments
where student in(
	select distinct id
	from Students
	where stype = 'intl'
)
group by program;


create or replace view Q4_3(program, percent)
as
select Q4_1.program, Q4_2.Intl_student / Q4_1.All_student
from Q4_1, Q4_2
where Q4_1.program = Q4_2.program;



create or replace view Q4(code,name)
as

select  distinct code, name
from Programs
where id in(
	select program
	from Q4_3
	where percent >= 0.3 and percent <=0.7

);
--Q5:

create or replace view Q5_1(course,avg_mark)
as

select course,avg(mark)
from course_enrolments
where mark is not null
group by course
having count(mark is not null)>= 20;

create or replace view Q5_2(max_mark)
as
select max(avg_mark)
from Q5_1;

--Q5:
create or replace view Q5_3(course,max_mark)
as

select Q5_1.course, Q5_2.max_mark
from Q5_1, Q5_2
where Q5_1.avg_mark = Q5_2.max_mark;



create or replace view Q5(code,name,semester)
as
select subjects.code,subjects.name,semesters.name
from subjects,semesters,Q5_3,courses
WHERE subjects.id = courses.subject
and
course.id = Q5_3.course
and
semesters.id = course.semester;

-- Q6:
create or replace view Q6(num1, num2, num3)
as
--... SQL statements, possibly using other views/functions defined by you ...
;

-- Q7:
create or replace view Q7(name, school, email, starting, num_subjects)
as
--... SQL statements, possibly using other views/functions defined by you ...
;

-- Q8: 
create or replace view Q8(subject)
as
--... SQL statements, possibly using other views/functions defined by you ...
;

-- Q9:
create or replace view Q9(year,num,unit)
as
--... SQL statements, possibly using other views/functions defined by you ...
;

-- Q10:
create or replace view Q10(unswid,name,avg_mark)
as
--... SQL statements, possibly using other views/functions defined by you ...
;

-- Q11:
create or replace view Q11(unswid, name, academic_standing)
as
--... SQL statements, possibly using other views/functions defined by you ...
;

-- Q12:
create or replace view Q12(code, name, year, s1_ps_rate, s2_ps_rate)
as
--... SQL statements, possibly using other views/functions defined by you ...
;
