SET foreign_key_checks = 0;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS instructor;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS offering;
DROP TABLE IF EXISTS enrollment;
Set foreign_key_checks = 1;
/* --- END TABLE DROPS --- */

create table person
(
	Name char(20),
	ID char(9) not null,
	Address char(30),
	DOB date,
	primary key(ID)
);
 create table instructor
(
	InstructorID char(9) not null,
	Rank char(12),
	Salary integer,
	primary key(InstructorID),
    foreign key(InstructorID) references person(ID)
);
create table student
(
	StudentID char(9) not null,
	Classification char(10),
	GPA double,
	MentorID char(9),
	CreditHours integer,
	primary key(StudentID),
    foreign key(MentorID) references instructor(InstructorID)
);
create table course
(
	CourseCode char(6) not null,
	CourseName char(50),
	PreReq char(6),
	primary key (CourseCode, CourseName)
);

create table offering
(
	CourseCode char(6) not null,
	SectionNo integer not null,
	InstructorID char(9) not null,
	primary key(CourseCode, SectionNo),
    foreign key(InstructorID) references instructor(InstructorID)
);
create table enrollment
(
	CourseCode char(6) not null,
	SectionNo int not null,
	StudentID char(9) not null references Student,
	Grade char(4) not null,
	primary key(CourseCode, StudentID),
	foreign key(CourseCode, SectionNo) references offering(CourseCode, SectionNo)
);
LOAD XML LOCAL INFILE 'C:/DataSets/UniversityXML/Person.xml' INTO TABLE person ROWS IDENTIFIED BY '<person>';
LOAD XML LOCAL INFILE 'C:/DataSets/UniversityXML/Instructor.xml' INTO TABLE instructor ROWS IDENTIFIED BY '<instructor>';
LOAD XML LOCAL INFILE 'C:/DataSets/UniversityXML/Student.xml' INTO TABLE student ROWS IDENTIFIED BY '<student>';
LOAD XML LOCAL INFILE 'C:/DataSets/UniversityXML/Course.xml' INTO TABLE course ROWS IDENTIFIED BY '<course>';
LOAD XML LOCAL INFILE 'C:/DataSets/UniversityXML/Offering.xml' INTO TABLE offering ROWS IDENTIFIED BY '<offering>';
LOAD XML LOCAL INFILE 'C:/DataSets/UniversityXML/Enrollment.xml' INTO TABLE enrollment ROWS IDENTIFIED BY '<enrollment>';