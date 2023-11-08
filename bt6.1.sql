DROP DATABASE IF EXISTS StudentTest;
CREATE DATABASE IF NOT EXISTS StudentTest;
USE StudentTest;

create table Test
(
    testID int not null primary key auto_increment,
    tenMH  varchar(20)
);

create table student
(
    RN  int not null primary key auto_increment,
    ten varchar(20),
    age tinyint
);

create table StudentTest
(
    RN     int not null,
    TestID int not null,
    date   datetime,
    Mark   float default 0,
    primary key (RN, TestID),
    foreign key (RN) references student (RN),
    foreign key (TestID) references test (testID)
);

insert into Student (RN, ten, age)
values (1, 'Nguyen Hong Ha', 20),
       (2, 'Truong Ngoc Anh', 30),
       (3, 'Tuan Minh', 25),
       (4, 'Dan Truong', 22);

insert into Test(testID, tenMH)
values (1, 'EPC'),
       (2, 'DWMX'),
       (3, 'SQL1'),
       (4, 'SQL2');

insert into studenttest(RN, TestID, date, Mark)
values (1, 1, '2006-7-17', 8),
       (1, 2, '2006-7-18', 5),
       (1, 3, '2006-7-19', 7),
       (2, 1, '2006-7-17', 7),
       (2, 2, '2006-7-18', 4),
       (2, 3, '2006-7-19', 2),
       (3, 1, '2006-7-17', 10),
       (3, 4, '2006-7-17', 1);

ALTER table student
    add constraint ck_ageRange check ( age between 15 and 55);

alter table test
    add constraint UQ_NAME unique (tenMH);

alter table test
    drop constraint UQ_NAME;

SELECT s.ten AS StudentName, st.TestID, t.tenMH AS TestName, st.Mark, st.Date
FROM StudentTest st
         JOIN Student s ON st.RN = s.RN
         JOIN Test t ON st.TestID = t.TestID
ORDER BY s.ten;

select s.ten as StudentName, s.age
from student as s
         left join StudentTest ST on s.RN = ST.RN
where ST.RN is null;

SELECT s.ten AS StudentName, t.tenMH AS TestName, st.Mark, date
FROM StudentTest st
         INNER JOIN Student s ON st.RN = s.RN
         INNER JOIN Test t ON st.TestID = t.TestID
WHERE st.Mark < 5;

SELECT s.ten AS StudentName, AVG(st.Mark) AS AverageMark
FROM StudentTest st
         JOIN Student s ON st.RN = s.RN
GROUP BY s.ten
ORDER BY AverageMark DESC;

SELECT s.ten AS StudentName, AVG(st.Mark) AS AverageMark
FROM StudentTest st
         JOIN Student s ON st.RN = s.RN
GROUP BY s.ten
HAVING AVG(st.Mark) =
       (SELECT MAX(AverageMark) FROM (SELECT AVG(Mark) AS AverageMark FROM StudentTest GROUP BY RN) AS subquery);

SELECT t.tenMH AS TestName, MAX(st.Mark) AS MaxMark
FROM Test t
         JOIN StudentTest st ON t.TestID = st.TestID
GROUP BY t.tenMH
ORDER BY t.tenMH;

SELECT s.ten AS StudentName, COALESCE(t.tenMH, 'Null') AS TestName
FROM Student s
         LEFT JOIN StudentTest st ON s.RN = st.RN
         LEFT JOIN Test t ON st.TestID = t.TestID;

UPDATE Student
SET Age = Age + 1;

ALTER TABLE Student
    ADD Status VARCHAR(10);

UPDATE Student
SET Status = CASE
                 WHEN Age < 30 THEN 'Young'
                 ELSE 'Old'
    END;

select *
from student;

SELECT Student.ten, StudentTest.Date, StudentTest.Mark
FROM Student
         JOIN StudentTest ON Student.RN = StudentTest.RN
ORDER BY StudentTest.Date;

SELECT Student.ten, Student.Age, AVG(StudentTest.Mark) AS AverageMark
FROM Student
         JOIN StudentTest ON Student.RN = StudentTest.RN
GROUP BY Student.ten, Student.Age, Student.Age
HAVING Student.ten LIKE 'T%'
   AND AVG(StudentTest.Mark) > 4.5;

alter table student
    MODIFY ten varchar(255);
UPDATE Student
SET ten = CASE
              WHEN Age > 20 THEN CONCAT('Old ', ten)
              ELSE CONCAT('Young ', ten)
    END;

select *
from student;

delete
from test
where not exists(select *
                 from studenttest
                 where StudentTest.TestID = test.testID);

delete
from studenttest
where Mark < 5;

select *
from studenttest;