create database Test2;
use Test2;
SET SQL_SAFE_UPDATES=OFF;
create table Subjects(
SubjectID int primary key auto_increment,
SubjectName varchar(50) not null unique
);

create table Classes(
ClassID int primary key auto_increment,
ClassName varchar(50) not null unique
);

create table Students(
StudentID int primary key auto_increment,
StudentName varchar(50) not null,
Age int not null,
Email varchar(100)
);

create table Marks(
Mark int ,
SubjectID int,
 foreign key (SubjectID) references Subjects(SubjectID),
StudentID int,
 foreign key (StudentID) references Students(StudentID)
);

create table ClassStudent(
StudentID int,
 foreign key (StudentID) references Students(StudentID),
ClassID int,
 foreign key (ClassID) references Classes(ClassID)
);

insert into Students(StudentName, Age, Email) 
values ('Nguyen Quang An', 18, 'an@yahoo.com'),
('Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
('Nguyen Van Quyen', 19, 'quyen'),
('Pham Thanh Binh', 25, 'binh@com'),
('Nguyen Van Tai Em', 30, 'taiem@sport.vn');

insert into Classes(ClassName) values ('C0706L'),('C0708G');

insert into ClassStudent(StudentID, ClassID) values 
(1,1),(2,1),(3,2),(4,2),(5,2);

insert into Subjects(SubjectName) values ('SQL'),('Java'),('C'),('Visual Basic');

insert into Marks(Mark, SubjectID, StudentID) values 
(8,1,1),(4,2,1),(9,1,1),(7,1,3),(3,1,4),(5,2,5),(8,3,3),(1,3,5),(3,2,4);

-- Viet truy van:

-- 1. Hien thi danh sach tat ca cac hoc vien 
select * from Students ;

-- 2. Hien thi danh sach tat ca cac mon hoc
select * from Subjects;

-- 3. Tinh diem trung binh 
select StudentID, avg(Mark) from Marks group by StudentID ;

-- 4. Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select s.subjectname from Marks m join Subjects s on m.subjectid = s.subjectid where m.Mark = (select Mark from Marks order by Mark desc limit 1) ;

-- 5. Danh so thu tu cua diem theo chieu giam
select *, row_number() over(order by Mark desc) RowNumber from Marks ;

-- 6. Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
alter table subjects
modify column subjectname varchar(255);

-- 7. Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
update subjects set subjectname = concat("Day la mon hoc ", subjectname);


-- 8. Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
alter table students
add constraint check_age check(age > 15 and age < 50);

-- 9. Loai bo tat ca quan he giua cac bang
alter table marks
drop foreign key marks_ibfk_1,
drop foreign key marks_ibfk_2;

alter table classstudent
drop foreign key classstudent_ibfk_1,
drop foreign key classstudent_ibfk_2;

-- 10. Xoa hoc vien co StudentID la 1
delete from students where studentid = '1';

-- 11. Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table students
add column Status bit default 1;

-- 12. Cap nhap gia tri Status trong bang Student thanh 0
update students set status = 0 ;