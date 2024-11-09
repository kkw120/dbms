Create table student (roll number, name varchar(20));
Insert into student values(1,”áaa’’);
Insert into student values(2,’’bbb’’);
Insert into student values(3,’’ccc’’);

Create table student_audit(roll number, name varchar(20), action varchar(20), changedate date);


CREATE TRIGGER before_student_update 
BEFORE UPDATE ON student 
FOR EACH ROW 
INSERT INTO student_audit SET action = 'update', roll = OLD.roll, name = OLD.name, changedate = NOW();


Update student set name=’XYZ’ where roll=2;

