delete from section
where s.year>=2018;

insert into section(course_id,sec_id,semester,year,building,room_number,time_slot_id)
select course_id,sec_id,'Spring',2019,building,room_number,time_slot_id 
from section as s
where  s.year<2018 and s.course_id>=300;

insert into section(course_id,sec_id,semester,year,building,room_number,time_slot_id)
select course_id,sec_id,'Fall',2018,building,room_number,time_slot_id 
from section as s
where  s.year<2018 and s.course_id>=300;

insert into section(course_id,sec_id,semester,year,building,room_number,time_slot_id)
select course_id,sec_id,semester,2017,building,room_number,time_slot_id 
from section as s
where  s.year<2018;

commit;