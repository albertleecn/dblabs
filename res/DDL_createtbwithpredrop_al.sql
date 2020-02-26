drop table if exists  prereq;
drop table if exists  time_slot;
drop table if exists  advisor;
drop table if exists  takes;
drop table if exists  student;
drop table if exists  teaches;
drop table if exists  section;
drop table if exists  instructor;
drop table if exists  course;
drop table if exists  department;
drop table if exists  classroom;

create table classroom
	(building		varchar(15),
	 room_number		varchar(7),
	 capacity		numeric(4,0),
	 primary key (building, room_number)
	);

create table department
	(dept_name		varchar(20), 
	 building		varchar(15), 
	 budget		        numeric(12,2) check (budget > 0),
	 primary key (dept_name)
	);

create table course
	(course_id		varchar(8), 
	 title			varchar(50), 
	 dept_name		varchar(20),
	 credits		numeric(2,0) check (credits > 0),
	 primary key (course_id)
	);
    
alter table `course` add constraint `course_fk1`
   foreign key (`dept_name`) references `department`(`dept_name`)
   on delete set null;   

create table instructor
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 salary			numeric(8,2) check (salary > 29000),
	 primary key (ID)
	);
    
alter table `instructor` add constraint `instructor_fk1`
   foreign key (`dept_name`) references `department`(`dept_name`)
   on delete set null;       

create table section
	(course_id		varchar(8), 
         sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	 year			numeric(4,0) check (year > 1701 and year < 2100), 
	 building		varchar(15),
	 room_number		varchar(7),
	 time_slot_id		varchar(4),
	 primary key (course_id, sec_id, semester, year)
	);
    
alter table `section` add constraint `section_fk1`
   foreign key (`course_id`) references `course`(`course_id`)
   on delete cascade;       
alter table `section` add constraint `section_fk2`
   foreign key (`building`,`room_number`) references `classroom`(`building`,`room_number`)
   on delete set null;       

create table teaches
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 primary key (ID, course_id, sec_id, semester, year)
	);
    
alter table `teaches` add constraint `teaches_fk1`
   foreign key (course_id,sec_id, semester, year) references `section`(course_id,sec_id, semester, year)
   on delete cascade;       
alter table `teaches` add constraint `teaches_fk2`
   foreign key (ID) references `instructor`(ID)
   on delete cascade;       
    

create table student
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 tot_cred		numeric(3,0) check (tot_cred >= 0),
	 primary key (ID)
	);
    
alter table `student` add constraint `student_fk1`
   foreign key (dept_name) references `department`(dept_name)
   on delete set null;       
    

create table takes
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 primary key (ID, course_id, sec_id, semester, year)
	);

alter table `takes` add constraint `takes_fk1`
   foreign key (course_id,sec_id, semester, year) references `section`(course_id,sec_id, semester, year)
   on delete cascade;       
    
alter table `takes` add constraint `takes_fk2`
   foreign key (ID) references `student`(ID)
   on delete cascade;       
    
    
create table advisor
	(s_ID			varchar(5),
	 i_ID			varchar(5),
	 primary key (s_ID),
	 foreign key (i_ID) references instructor (ID)
		on delete set null,
	 foreign key (s_ID) references student (ID)
		on delete cascade
	);

create table time_slot
	(time_slot_id		varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
	 primary key (time_slot_id, day, start_hr, start_min)
	);

create table prereq
	(course_id		varchar(8), 
	 prereq_id		varchar(8),
	 primary key (course_id, prereq_id),
	 foreign key (course_id) references course(course_id)
		on delete cascade,
	 foreign key (prereq_id) references course(course_id)
	);

