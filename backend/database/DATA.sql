
USE UNIVERSITY_MANAGEMENT;

-- Add department

INSERT INTO DEPARTMENT(Name, CreatedTime) VALUES 
	('Computer Science and Engineering', '1990-01-01'),
	('Mechanical Engineering', '1985-01-01'),
	('Chemical Engineering', '1984-01-02'),
	('Applied Science', '1989-01-03'),
	('Electrical and Electronics Engineering', '1980-01-04');
-- Add Person

INSERT INTO PERSON ( StartedDay, Email, Status, FirstName, LastName, PhoneNumber, Gender, DateOfBirth, Age) VALUES
	('2024-08-15', 'stu.dent2@hcmut.edu.vn', 'In_progress', 'John', 'Nguyen', '0234567891', 'Male', '2006-03-12', 18),
	( '2023-01-10', 'student2@hcmut.edu.vn', 'In_progress', 'Jane', 'Smith', '0923456789', 'Female', '2005-06-15', 19),
	('2024-09-20', 'student3@hcmut.edu.vn', 'In_progress', 'Michael', 'Brown', '0934567891', 'Male', '2006-11-22', 18),
	( '2000-09-01', 'lecturer1@hcmut.edu.vn', 'In_progress', 'Alice', 'White', '09012345678', 'Female', '1975-05-17', 49),
	( '2004-09-01', 'lecturer2@hcmut.edu.vn', 'In_progress', 'Bob', 'Martin', '0902345678', 'Male', '1990-08-12', 34),
	( '1995-01-15', 'lecturer3@hcmut.edu.vn', 'In_progress', 'Bob', 'Kevin', '0903456789', 'Male', '1970-03-25', 54),
	( '2023-01-15', 'student4@hcmut.edu.vn', 'Expelled', 'William', 'Nguyen', '09023456789', 'Male', '2005-03-25', 19),
	( '2023-01-15', 'student5@hcmut.edu.vn', 'Expelled', 'Alice', 'Brown', '0905456789', 'Female', '2005-02-20', 19),
	( '2018-01-15', 'student6@hcmut.edu.vn', 'Graduate', 'Shelby', 'Thomas', '0909456789', 'Male', '2000-01-25', 24);
-- Insert
CALL InsertPerson('2024-01-01', 'test@hcmut.edu.vn', 'In_progress', 'John', 'Doe', '0987654321', 'Male', '2000-01-01', 24);
-- Update
-- CALL UpdatePerson(10, '2024-02-01', 'updated@hcmut.edu.vn', 'Graduate', 'Jane', 'Smith', '01234567890', 'Female', '1995-06-15', 29);

-- Delete
-- CALL DeletePerson(13);

-- Invalid Email
-- CALL InsertPerson('2024-11-23', 'john.doe@gmail.com', 'In_progress', 'John', 'Doe', '0912345678', 'Male', '2002-01-01', 22);

-- Invalid Phone Number
-- CALL InsertPerson('2024-11-23', 'john.doe@hcmut.edu.vn', 'In_progress', 'John', 'Doe', '09123', 'Male', '2002-01-01', 22);

-- Invalid First Name
-- CALL InsertPerson('2024-11-23', 'john.doe@hcmut.edu.vn', 'In_progress', 'J0hn', 'Doe', '0912345678', 'Male', '2002-01-01', 22);

-- Duplicated email
-- CALL InsertPerson('2024-11-23', 'john.doe@hcmut.edu.vn', 'In_progress', 'John', 'Doe', '0912345678', 'Male', '2002-01-01', 22);
-- Re-run with the same email
-- CALL InsertPerson('2024-11-23', 'john.doe@hcmut.edu.vn', 'In_progress', 'Jane', 'Smith', '0912345679', 'Female', '2002-02-02', 21);

-- Testing Automatic Capitalization of FirstName and LastName on Insert Person
INSERT INTO PERSON ( StartedDay, Email, Status, FirstName, LastName, PhoneNumber, Gender, DateOfBirth, Age) 
VALUES ('2024-08-15', 'abcd@hcmut.edu.vn', 'In_progress', 'john', 'nguyen', '0432561891', 'Male', '2006-03-12', 18);
-- Or
-- CALL InsertPerson('2024-08-15', 'abcd@hcmut.edu.vn', 'In_progress', 'john', 'nguyen', '0432561891', 'Male', '2006-03-12', 18);

-- Testing duplicate PhoneNumber
-- INSERT INTO PERSON ( StartedDay, Email, Status, FirstName, LastName, PhoneNumber, Gender, DateOfBirth, Age) VALUES 
-- ('2024-08-15', 'abcde@hcmut.edu.vn', 'In_progress', 'Tuan', 'Le', '0984561891', 'Male', '2006-03-12', 18),
-- ('2024-08-15', 'abcdef@hcmut.edu.vn', 'In_progress', 'Hieu', 'Nguyen', '0984561891', 'Male', '2006-03-12', 18);
    INSERT INTO PERSON ( StartedDay, Email, Status, FirstName, LastName, PhoneNumber, Gender, DateOfBirth, Age) VALUES
    ( '2023-01-15', 'student7@hcmut.edu.vn', 'Expelled', 'Travis', 'Nguyen', '09067456789', 'Male', '2005-08-23', 19),
	( '2023-01-15', 'student8@hcmut.edu.vn', 'Expelled', 'Tian', 'Tran', '0924456789', 'Male', '2005-05-21', 19);

-- -----------------------------------------------------------------
-- SELECT * FROM LECTURER;
-- Insert into LECTURER table
INSERT INTO LECTURER (LecturerID, DepartmentID, AcademicQualification) VALUES
(4, 1, 'PhD in Computer Science'),
(5, 4, 'PhD in Applied Science'),
(6, 1, 'PhD in Computer Science');

-- Insert into STUDENT table
INSERT INTO STUDENT (StudentID, SocialWork, DepartmentID) VALUES
(1, 0, 1),
(2, 0, 4),
(3, 0, 4),
(7, 0, 1),
(8, 1, 4),
(9, 2, 4),
(12, 5, 1),
(13, 5, 1);
-- Add Scholarhsip
INSERT INTO SCHOLARSHIP (CreatedTime, Name, Issuer, Price, Number) VALUES
	('2024-09-05', 'SCG Sharing the Dream', 'SCG', '15000000', '100'),
	('2024-09-09', 'VPBANKER', 'VPBank', '10000000', '60'),
	('2024-04-22', 'Panasonic', 'Panasonic Company', '30000000', '20'),
	('2024-10-04', 'Sacombank', 'Sacombank', '10000000', '5'),
	('2023-12-27', 'Jabil', 'Jabil', '30000000', '30');
    
-- Add Section
INSERT INTO SECTION (SectionID, Year, Semester) VALUES
	('231', '2023', '1'),
	('232', '2023', '2'),
	('241', '2024', '3'),
	('242', '2024', '1'),
	('233', '2023', '3');

-- Add Course
INSERT INTO COURSE (CourseID, Credit, Name, QuizPercentage, MidPercentage, FinalPercentage, DepartmentID) VALUES
	('MT1003', '5', 'Calculus 1', '0.2', '0.3', '0.5', '4'),
	('CH1003', '4', 'General Chemistry', '0.2', '0.3', '0.5', '4'),
    ('PH1009','5', 'General Physics 1', '0.2', '0.3', '0.5','4'),
	('SP1035', '4', 'Scientific Socialism ', '0.2', '0.3', '0.5', '4'),
	('PH1007', '4', 'General Physics Lab', '0.2', '0.3', '0.5', '4'),
	('MT1005', '5', 'Calculus 2','0.2', '0.3', '0.5', '4'),
    ('PH2001','4', 'General Physics 2', '0.2', '0.3', '0.5','4'),
    ('MT2007', '5', 'Probability and Statistic','0.2', '0.3', '0.5', '4'),
    ('MT2009', '5', 'Calculus 3','0.2', '0.3', '0.5', '4'),
    
    ('CO1023', '4', 'Digital System', '0.1', '0.4', '0.5', '1'),
	('CO2013', '5', 'Database Systems', '0.1', '0.4', '0.5', '1'),
	('CO2003', '5', 'Data Structure and Algorithm', '0.2', '0.3', '0.5', '1'),
	('CO1027', '5', 'Fundamental Programming', '0.3', '0.2', '0.5','1'),
    ('CO2007', '5', 'Computer Architecture', '0.1','0.4','0.5', '1'),
    ('CO2011', '4', 'Mathematical Modeling', '0.2','0.3','0.5', '1'),
    ('CO2017', '5', 'Operating System', '0.2','0.3','0.5', '1'),
    ('CO3003', '5', 'Computer Network', '0.2','0.3','0.5', '1'),
    ('CO2039', '4', 'Advanced Programming', '0.2','0.3','0.5', '1');
-- Add Class
-- Semester 1 2023

INSERT INTO CLASS (Identifier, SectionID, CourseID, DateOfWeek, Time, Room) VALUES
	('CC01', '231', 'MT1003', 'Monday', '07:00:00', 'C4-103'),
    ('CC02', '231', 'MT1003', 'Tuesday', '07:00:00', 'C4-205'),
    ('CC03', '231', 'MT1003', 'Wednesday', '07:00:00', 'C4-303'),
    ('CC04', '231', 'MT1003', 'Thursday', '07:00:00', 'C5-303'),
    ('CC05', '231', 'MT1003', 'Friday', '07:00:00', 'C6-303'),

    ('CC01', '231', 'MT1005', 'Monday', '09:00:00', 'C4-304'),
    ('CC02', '231', 'MT1005', 'Tuesday', '09:00:00', 'C5-203'),
    ('CC03', '231', 'MT1005', 'Wednesday', '09:00:00', 'C4-403'),
    
	('CC01', '231', 'CO1023', 'Saturday', '10:00:00', 'B1-202'),
    ('CC02', '231', 'CO1023', 'Thursday', '10:00:00', 'B1-201'),
    ('CC03', '231', 'CO1023', 'Friday', '10:00:00', 'C4-201'),
    
    ('CC01', '231', 'CH1003', 'Monday', '12:00:00', 'B10-201'),
    ('CC02', '231', 'CH1003', 'Tuesday', '13:00:00', 'B10-203'),
    ('CC03', '231', 'CH1003', 'Friday', '14:00:00', 'B10-202'),
    
    ('CC01', '231', 'SP1035', 'Saturday', '08:00:00', 'B6-205'),
    ('CC02', '231', 'SP1035', 'Wednesday', '07:00:00', 'B6-405'),
    ('CC03', '231', 'SP1035', 'Thursday', '07:00:00', 'B6-505'),
    
    ('CC01', '231', 'CO2003', 'Monday', '07:00:00', 'B8-302'),
    ('CC02', '231', 'CO2003', 'Monday', '14:00:00', 'B6-205'),
    ('CC03', '231', 'CO2003', 'Monday', '15:00:00', 'B4-301'),
   
    ('CC01', '231', 'CO2013', 'Monday', '16:00:00', 'B8-203'),
    ('CC02', '231', 'CO2013', 'Tuesday', '15:00:00', 'B4-501'),
    ('CC03', '231', 'CO2013', 'Saturday', '13:00:00', 'B4-502'),
    
    ('CC01', '231', 'PH1007', 'Monday', '07:00:00', 'B6-102'),
    ('CC02', '231', 'PH1007', 'Friday', '16:00:00', 'B6-101'),
    ('CC03', '231', 'PH1007', 'Monday', '15:00:00', 'B6-102'),
    
    ('CC01', '231', 'CO1027', 'Friday', '07:00:00', 'B6-102'),
    
	('CC01', '231', 'CO2007', 'Wednesday', '07:00:00', 'C6-302'),
    
	('CC01', '231', 'CO2011', 'Tuesday', '07:00:00', 'B4-503');
-- Semester 2 2023
INSERT INTO CLASS (Identifier, SectionID, CourseID, DateOfWeek, Time, Room) VALUES
	('CC01', '232', 'MT1003', 'Monday', '07:00:00', 'C4-103'),
    ('CC02', '232', 'MT1003', 'Tuesday', '07:00:00', 'C4-205'),
    ('CC03', '232', 'MT1003', 'Wednesday', '07:00:00', 'C4-303'),
    ('CC04', '232', 'MT1003', 'Thursday', '07:00:00', 'C5-303'),
    ('CC05', '232', 'MT1003', 'Friday', '07:00:00', 'C6-303'),

    ('CC01', '232', 'MT1005', 'Monday', '09:00:00', 'C4-304'),
    ('CC02', '232', 'MT1005', 'Tuesday', '09:00:00', 'C5-203'),
    ('CC03', '232', 'MT1005', 'Wednesday', '09:00:00', 'C4-403'),
    
	('CC01', '232', 'CO1023', 'Saturday', '10:00:00', 'B1-202'),
    ('CC02', '232', 'CO1023', 'Thursday', '10:00:00', 'B1-201'),
    ('CC03', '232', 'CO1023', 'Friday', '10:00:00', 'C4-201'),
    
    ('CC01', '232', 'CH1003', 'Monday', '12:00:00', 'B10-201'),
    ('CC02', '232', 'CH1003', 'Tuesday', '13:00:00', 'B10-203'),
    ('CC03', '232', 'CH1003', 'Friday', '14:00:00', 'B10-202'),
    
    ('CC01', '232', 'SP1035', 'Saturday', '08:00:00', 'B6-205'),
    ('CC02', '232', 'SP1035', 'Wednesday', '07:00:00', 'B6-405'),
    ('CC03', '232', 'SP1035', 'Thursday', '07:00:00', 'B6-505'),
    
    ('CC01', '232', 'CO2003', 'Monday', '07:00:00', 'B8-302'),
    ('CC02', '232', 'CO2003', 'Monday', '14:00:00', 'B6-205'),
    ('CC03', '232', 'CO2003', 'Monday', '15:00:00', 'B4-301'),
   
    ('CC01', '232', 'CO2013', 'Monday', '16:00:00', 'B8-203'),
    ('CC02', '232', 'CO2013', 'Tuesday', '15:00:00', 'B4-501'),
    ('CC03', '232', 'CO2013', 'Saturday', '13:00:00', 'B4-502'),
    
    ('CC01', '232', 'PH1007', 'Monday', '07:00:00', 'B6-102'),
    ('CC02', '232', 'PH1007', 'Friday', '16:00:00', 'B6-101'),
    ('CC03', '232', 'PH1007', 'Monday', '15:00:00', 'B6-102'),
    
    ('CC01', '232', 'CO1027', 'Friday', '7:00:00', 'B6-102'),
    
	('CC01', '232', 'CO2007', 'Wednesday','07:00:00', 'C6-302'),
    
	('CC01', '232', 'CO2011', 'Tuesday', '7:00:00', 'B4-503'),
    
    ('CC01', '232', 'PH1009', 'Tuesday', '7:00:00', 'B8-203');
-- Semester 3 2023
INSERT INTO CLASS (Identifier, SectionID, CourseID, DateOfWeek, Time, Room) VALUES
	('CC01', '233', 'MT1003', 'Monday', '7:00:00', 'C4-103'),
    ('CC02', '233', 'MT1003', 'Monday', '9:00:00', 'C4-205'),
    
    ('CC01', '233', 'MT1005', 'Tuesday', '7:00:00', 'C4-304'),
    ('CC02', '233', 'MT1005', 'Tuesday', '9:00:00', 'C5-203'),
    
	('CC01', '233', 'CO1023', 'Monday', '13:00:00', 'B1-202'),

    ('CC01', '233', 'CH1003', 'Monday', '16:00:00', 'B10-201'),
    
    ('CC01', '233', 'CO2003', 'Tuesday', '13:00:00', 'B8-302'),
    ('CC02', '233', 'CO2003', 'Tuesday', '16:00:00', 'B6-205'),
    
    ('CC01', '233', 'CO2013', 'Wednesday', '9:00:00', 'B8-203'),
    ('CC02', '233', 'CO2013', 'Wednesday', '7:00:00', 'B4-501'),
    
    ('CC01', '233', 'PH1007', 'Wednesday', '13:00:00', 'B6-102'),

	('CC01', '233', 'CO1027', 'Friday', '07:00:00', 'B6-102'),
    
	('CC01', '233', 'CO2007', 'Wednesday', '07:00:00', 'C6-302'),
    
	('CC01', '233', 'CO2011', 'Saturday', '07:00:00', 'B4-503'),
    
    ('CC01', '233', 'PH2001', 'Thursday', '07:00:00', 'C6-406'),
    
	('CC01', '233', 'CO1027', 'Friday', '07:00:00', 'B6-203'),
    
	('CC01', '233', 'CO2007', 'Friday', '09:00:00', 'C6-302');
-- Semester 1 2024 
INSERT INTO CLASS (Identifier, SectionID, CourseID, DateOfWeek, Time, Room) VALUES
	('CC01', '241', 'MT2007', 'Monday', '7:00:00', 'C4-103'),
    ('CC02', '241', 'MT2007', 'Monday', '9:00:00', 'C4-205'),
    ('CC03', '241', 'MT2007', 'Monday', '11:00:00', 'C4-303'),
    ('CC04', '241', 'MT2007', 'Monday', '13:00:00', 'C5-303'),
    ('CC05', '241', 'MT2007', 'Monday', '16:00:00', 'C6-303'),
    
    ('CC01', '241', 'MT2009', 'Tuesday', '07:00:00', 'C4-304'),
    ('CC02', '241', 'MT2009', 'Tuesday', '09:00:00', 'C5-203'),
    ('CC03', '241', 'MT2009', 'Tuesday', '13:00:00', 'C4-403'),
    
	('CC01', '241', 'PH2001', 'Wednesday', '07:00:00', 'B1-202'),
    ('CC02', '241', 'PH2001', 'Wednesday', '09:00:00', 'B1-201'),
    ('CC03', '241', 'PH2001', 'Wednesday', '13:00:00', 'C4-201'),
    
    ('CC01', '241', 'CO2017', 'Thursday', '07:00:00', 'B10-201'),
    ('CC02', '241', 'CO2017', 'Thursday', '09:00:00', 'B10-203'),
    ('CC03', '241', 'CO2017', 'Thursday', '13:00:00', 'B10-202'),
    
    ('CC01', '241', 'CO3003', 'Friday', '07:00:00', 'B6-205'),
    ('CC02', '241', 'CO3003', 'Friday', '09:00:00', 'B6-405'),
    ('CC03', '241', 'CO3003', 'Friday', '13:00:00', 'B6-505'),
    
    ('CC01', '241', 'CO2039', 'Monday', '10:00:00', 'B8-302'),
    ('CC02', '241', 'CO2039', 'Monday', '16:00:00', 'B6-205'),
    ('CC03', '241', 'CO2039', 'Tuesday', '15:00:00', 'B4-301'),
    
    ('CC01', '241', 'CO2013', 'Saturday', '07:00:00', 'B8-203'),
    ('CC02', '241', 'CO2013', 'Monday', '09:00:00', 'B4-501'),
    ('CC03', '241', 'CO2013', 'Friday', '16:00:00', 'B4-502'),
    
    ('CC01', '241', 'PH1007', 'Saturday', '09:00:00', 'B6-102'),
    ('CC02', '241', 'PH1007', 'Saturday', '11:00:00', 'B6-101'),
    ('CC03', '241', 'PH1007', 'Thursday', '16:00:00', 'B6-102'),
    
    ('CC01', '241', 'CO1027', 'Friday', '07:00:00', 'B6-102'),
    
	('CC01', '241', 'CO2007', 'Wednesday', '07:00:00', 'C6-302'),
    
	('CC01', '241', 'CO2011', 'Tuesday', '07:00:00', 'B4-503');

-- Semester 2 2024
INSERT INTO CLASS (Identifier, SectionID, CourseID, DateOfWeek, Time, Room) VALUES
	('CC01', '242', 'MT1003', 'Monday', '7:00:00', 'C4-103'),
    ('CC02', '242', 'MT1003', 'Monday', '7:00:00', 'C4-205'),
    ('CC03', '242', 'MT1003', 'Monday', '7:00:00', 'C4-303'),
    ('CC04', '242', 'MT1003', 'Monday', '7:00:00', 'C5-303'),
    ('CC05', '242', 'MT1003', 'Monday', '7:00:00', 'C6-303'),
    
    ('CC01', '242', 'MT1005', 'Monday', '7:00:00', 'C4-304'),
    ('CC02', '242', 'MT1005', 'Monday', '7:00:00', 'C5-203'),
    ('CC03', '242', 'MT1005', 'Monday', '7:00:00', 'C4-403'),
    
	('CC01', '242', 'CO1023', 'Monday', '7:00:00', 'B1-202'),
    ('CC02', '242', 'CO1023', 'Monday', '7:00:00', 'B1-201'),
    ('CC03', '242', 'CO1023', 'Monday', '7:00:00', 'C4-201'),
    
    ('CC01', '242', 'CH1003', 'Monday', '7:00:00', 'B10-201'),
    ('CC02', '242', 'CH1003', 'Monday', '7:00:00', 'B10-203'),
    ('CC03', '242', 'CH1003', 'Monday', '7:00:00', 'B10-202'),
    
    ('CC01', '242', 'SP1035', 'Monday', '7:00:00', 'B6-205'),
    ('CC02', '242', 'SP1035', 'Monday', '7:00:00', 'B6-405'),
    ('CC03', '242', 'SP1035', 'Monday', '7:00:00', 'B6-505'),
    
    ('CC01', '242', 'CO2003', 'Monday', '7:00:00', 'B8-302'),
    ('CC02', '242', 'CO2003', 'Monday', '7:00:00', 'B6-205'),
    ('CC03', '242', 'CO2003', 'Monday', '7:00:00', 'B4-301'),
    
    ('CC01', '242', 'CO2013', 'Monday', '7:00:00', 'B8-203'),
    ('CC02', '242', 'CO2013', 'Monday', '7:00:00', 'B4-501'),
    ('CC03', '242', 'CO2013', 'Monday', '7:00:00', 'B4-502'),
    
    ('CC01', '242', 'PH1007', 'Monday', '7:00:00', 'B6-102'),
    ('CC02', '242', 'PH1007', 'Monday', '7:00:00', 'B6-101'),
    ('CC03', '242', 'PH1007', 'Monday', '7:00:00', 'B6-102'),
    
    ('CC01', '242', 'CO1027', 'Friday', '07:00:00', 'B6-102'),
    
	('CC01', '242', 'CO2007', 'Wednesday', '07:00:00', 'C6-302'),
    
	('CC01', '242', 'CO2011', 'Tuesday', '07:00:00', 'B4-503');
-- Add Research
INSERT INTO RESEARCH ( DepartmentID, Name, StartDate, PublishDate) VALUES 
 (1, 'Computer Vision Research', '2020-01-20', NULL),
 (3, 'Substances Research', '2018-06-18', '2020-07-15'),
 (5, 'Circuit Research', '2021-09-20', NULL);
 
 -- Add Activity
 INSERT INTO ACTIVITY(Name, CreatedTime, Number) VALUES
 ('Spring Volunteer', '2023-12-25', 9),
 ('Summer Volunterr', '2023-06-01', 15);

 -- Add Student Activity
 INSERT INTO StudentActivity(ActivityID, StudentID) VALUES
 (1, 1),
 (2, 1),
 (1, 2),
 (2, 3),
 (1, 7),
(1, 9),
 (2, 9);
 -- Add Lecturer Activity
 INSERT INTO LecturerActivity(ActivityID, LecturerID) VALUES
 (1, 4),
 (2, 4),
 (1, 5),
 (2, 6);
-- SELECT * FROM CLASS;
-- Add Study Semester 231
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(1, 9, true, 6, 5, 5, 5.5),
(1, 18, true, 7, 8, 9, 7.8),
(1, 21, true, 9, 6, 5, 7.1);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(12, 9, true, 9.5, 7, 8, 8.65),
(12, 18, true, 8, 8, 9, 8.3),
(12, 21, true, 9, 6, 7, 7.9);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(13, 9, true, 6, 5, 9, 7.1),
(13, 18, true, 5, 6, 7, 5.8),
(13, 21, true, 6, 6, 5, 5.6);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(2, 1, true, 7, 8, 9, 7.8),
(2, 12, true, 6.5, 7, 8, 7.1),
(2, 16, true, 10, 10, 10, 10);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(3, 2, true, 5, 5, 5, 5),
(3, 13, true, 7.5, 6, 9, 7.65),
(3, 17, true, 8.5, 4, 7, 7.15);
--  SELECT * FROM CLASS;
--  Select * from course; 
-- CO1027 C02007 CO2011
-- Add Study Semester 232 
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(1, 56, true, 6, 5, 5, 5.5),
(1, 57, true, 6, 5, 4, 5.1),
(1, 58, true, 7, 5, 5, 6);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(12, 56, true, 9, 9, 9, 9),
(12, 57, true, 8, 6, 9, 7.6),
(12, 58, true, 7, 7, 8, 7.2);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(13, 56, true, 7, 7, 7, 7),
(13, 57, true, 9, 8, 9, 8.7),
(13, 58, true, 7, 5, 4, 5.8);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(2, 35, true, 6, 7, 8, 6.8),
(2, 54, true, 6.5, 5, 4, 5.45),
(2, 59, true, 10, 9, 8, 9.2);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(3, 37, true, 5, 6, 8, 6.1),
(3, 55, true, 7.5, 8, 10, 8.35),
(3, 59, true, 8.5, 8, 7, 7.95);
-- SELECT * FROM CLASS;
-- Add Study Semester 233
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(1, 64, true, 8, 6, 7, 7.4),
(1, 75, true, 9, 8, 6, 8.1),
(1, 76, true, 7, 6, 7, 6.9);
-- Add Study Semester 241
-- SELECT * FROM CLASS; 
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(1, 88, false, NULL, 4, 3, NULL),
(1, 91, false, NULL, 5, 9, NULL),
(1, 96, false, NULL, 6, 5, NULL);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(12, 88, false, NULL, 8, 8, NULL),
(12, 91, false, NULL, 8, 7, NULL),
(12, 96, false, NULL, 5, 7, NULL);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(13, 88, false, NULL, 4, 6.5, NULL),
(13, 91, false, NULL, 7.5, 9.5, NULL),
(13, 96, false, NULL, 6, 8, NULL);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(2, 77, false, NULL, 8, 9, NULL),
(2, 82, false, NULL, 7, 8, NULL),
(2, 85, false, NULL, 8, 7, NULL);
INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
(3, 78, false, 5, 3, 7, NULL),
(3, 83, false, 7.5, 6.5, 9, NULL),
(3, 86, false, 8.5, 4, 7.5, NULL);

INSERT INTO AWARD_TO (ScholarshipID, StudentID, SectionID) VALUES
(1, 2, '231');
-- Testing automatic decrement of scholarship number
INSERT INTO AWARD_TO (ScholarshipID, StudentID, SectionID)
VALUES (1, 1, '241');
-- SELECT * FROM STUDY;
INSERT INTO MENTORING (MentorID, MenteeID, CourseID, SectionID, Number, Salary) VALUES 
(2, 3, 'SP1035', '231', 0, 2000000),
(3, 2, 'PH1007', '232', 0, 2000000);
INSERT INTO MENTORING (MentorID, MenteeID, CourseID, SectionID, Number, Salary) VALUES 
(12, 1, 'CO1023', '231', 0, 150000),
(12, 13, 'CO2003', '231', 0, 200000);
INSERT INTO WorksON (LecturerID, ResearchID) VALUES
(4, 1),
(6, 3),
(5, 2);

INSERT INTO ASSIST (StudentID, ResearchID) VALUES
(1, 1),
(2, 2),
(3, 2);

INSERT INTO StudentParticipation (StudentID, ActivityID, SectionID, Status, NumberReceived) VALUES 
(1, 1, '231', 'Good', 9),
(2, 1, '231', 'Average', 5),
(1, 2, '232', 'Average', 8),
(3, 2, '232', 'Good', 15),
(2, '1', '241', 'Bad', 4);

INSERT INTO LecturerParticipation (LecturerID, ActivityID, SectionID) VALUES 
(6, 1, '231'),
(5, 1, '231'),
(6, 2, '232' ),
(6, 1, '241'),
(4, 1, '241');
-- Select * from course;
-- Student 1
INSERT INTO HasScore(StudentID, CourseID, GPA) VALUES 
(1, 'CO1023', 7.4),
(1, 'CO1027', 5.5),
(1, 'CO2003', 7.8),
(1, 'CO2007', 5.1),
(1, 'CO2011', 6),
(1, 'CO2013', 7.1),
(1, 'CO2017', 6),
(1, 'CO2039', NULL),
(1, 'CO3003', NULL);
-- Student 2 

INSERT INTO HasScore(StudentID, CourseID, GPA) VALUES 
(2, 'CH1003', 7.1),
(2, 'MT1003', 7.8),
(2, 'MT1005', 6.8),
(2, 'MT2009', NULL),
(2, 'MT2007', NULL),
(2, 'PH1007', 5.45),
(2, 'PH1009', 9.2),
(2, 'PH2001', NULL),
(2, 'SP1035', 10);
-- Student 3

-- SELECT * FROM STUDENT;
INSERT INTO HasScore(StudentID, CourseID, GPA) VALUES 
(3, 'CH1003', 7.65),
(3, 'MT1003', 5),
(3, 'MT1005', 6.1),
(3, 'MT2009', NULL),
(3, 'MT2007', NULL),
(3, 'PH1007', 8.35),
(3, 'PH1009', 7.95),
(3, 'PH2001', NULL),
(3, 'SP1035', 7.15);

-- Add Section
INSERT INTO InSection (StudentID, SectionID, Status, SectionYear) VALUES 
(1, '231', 'Studying',2023),
(2, '231', 'Studying',2023),
(3, '231', 'Studying',2023),

(1, '232', 'Studying',2023),
(2, '232', 'Studying',2023),
(3, '232', 'Studying',2023),

(1, '233', 'Studying',2023),

(1, '241', 'Studying',2024),
(2, '241', 'Studying',2024),
(3, '241', 'Studying',2024);

-- Check enrollment
-- INSERT INTO STUDY (StudentID, ClassID, Pass, FinalScore, QuizScore, MidtermScore, GPA) VALUES
-- (10, 9, true, 6, 5, 5, 5.5);
-- CALL FinalizeEnrollment(1,'231',2023); 