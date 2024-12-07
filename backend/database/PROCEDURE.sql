USE UNIVERSITY_MANAGEMENT;

/******* PERSON *******/

-- Insert
DROP PROCEDURE IF EXISTS InsertPerson;
CREATE PROCEDURE InsertPerson(
    IN p_StartedDay DATE,
    IN p_Email VARCHAR(255),
    IN p_Status ENUM('In_progress', 'Expelled', 'Graduate'),
    IN p_FirstName VARCHAR(255),
    IN p_LastName VARCHAR(255),
    IN p_PhoneNumber VARCHAR(11),
    IN p_Gender VARCHAR(255),
    IN p_DateOfBirth DATE,
    IN p_Age INT
)
BEGIN
    -- Validate constraints
    IF LENGTH(p_PhoneNumber) NOT IN (10, 11) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phone number must be 10 or 11 digits long';
    END IF;

    IF p_Gender NOT IN ('Male', 'Female') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Gender must be Male or Female';
    END IF;

    IF NOT (p_FirstName REGEXP '^[A-Za-z]+$') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'FirstName must contain only alphabetic characters';
    END IF;

    IF NOT (p_LastName REGEXP '^[A-Za-z]+$') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LastName must contain only alphabetic characters';
    END IF;

    IF p_Email NOT LIKE '%@hcmut.edu.vn' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email must belong to the hcmut.edu.vn domain';
    END IF;

    -- Insert data
    INSERT INTO PERSON (StartedDay, Email, Status, FirstName, LastName, PhoneNumber, Gender, DateOfBirth, Age)
    VALUES (p_StartedDay, p_Email, p_Status, p_FirstName, p_LastName, p_PhoneNumber, p_Gender, p_DateOfBirth, p_Age);
END;

-- Update
DROP PROCEDURE IF EXISTS UpdatePerson;
CREATE PROCEDURE UpdatePerson(
    IN p_PersonID INT,
    IN p_StartedDay DATE,
    IN p_Email VARCHAR(255),
    IN p_Status ENUM('In_progress', 'Expelled', 'Graduate'),
    IN p_FirstName VARCHAR(255),
    IN p_LastName VARCHAR(255),
    IN p_PhoneNumber VARCHAR(11),
    IN p_Gender ENUM('Male', 'Female'),
    IN p_DateOfBirth DATE,
    IN p_Age INT
)
BEGIN
    -- Validate: Ensure PersonID exists in the table
    IF NOT EXISTS (SELECT 1 FROM PERSON WHERE PersonID = p_PersonID) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'PersonID does not exist in the PERSON table.';
    END IF;

    -- Validate: Ensure StartedDay is not in the future
    IF p_StartedDay > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'StartedDay cannot be a future date.';
    END IF;

    -- Validate: Ensure Email is valid (simple regex-like pattern)
    IF NOT (p_Email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid email format.';
    END IF;

    -- Validate: Ensure PhoneNumber is exactly 10 or 11 digits
    IF NOT (p_PhoneNumber REGEXP '^[0-9]{10,11}$') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'PhoneNumber must contain 10 or 11 digits.';
    END IF;

    -- Validate: Ensure Age matches the DateOfBirth
    IF p_Age <> TIMESTAMPDIFF(YEAR, p_DateOfBirth, CURDATE()) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Age does not match the DateOfBirth.';
    END IF;

    -- Perform the update
    UPDATE PERSON
    SET
        StartedDay = p_StartedDay,
        Email = p_Email,
        Status = p_Status,
        FirstName = p_FirstName,
        LastName = p_LastName,
        PhoneNumber = p_PhoneNumber,
        Gender = p_Gender,
        DateOfBirth = p_DateOfBirth,
        Age = p_Age
    WHERE PersonID = p_PersonID;
END;

-- Delete
DROP PROCEDURE IF EXISTS DeletePerson;
CREATE PROCEDURE DeletePerson(
    IN p_PersonID INT
)
BEGIN
    -- Validate if the PersonID exists
    IF NOT EXISTS (SELECT 1 FROM PERSON WHERE PersonID = p_PersonID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PersonID does not exist';
    END IF;

    -- Delete the person
    DELETE FROM PERSON WHERE PersonID = p_PersonID;
END;

/******* LECTURER *******/

-- Insert
DROP PROCEDURE IF EXISTS InsertLecturer;
CREATE PROCEDURE InsertLecturer(
    IN p_LecturerID INT,
    IN p_DepartmentID INT,
    IN p_AcademicQualification VARCHAR(255)
)
BEGIN
    -- Check if LecturerID exists in PERSON table
    IF NOT EXISTS (SELECT 1 FROM PERSON WHERE PersonID = p_LecturerID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: LecturerID does not exist in PERSON table.';
    END IF;

    -- Check if DepartmentID exists in DEPARTMENT table
    IF NOT EXISTS (SELECT 1 FROM DEPARTMENT WHERE DepartmentID = p_DepartmentID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: DepartmentID does not exist in DEPARTMENT table.';
    END IF;

    -- Insert into LECTURER table
    INSERT INTO LECTURER (LecturerID, DepartmentID, AcademicQualification)
    VALUES (p_LecturerID, p_DepartmentID, p_AcademicQualification);
END;

-- Update
DROP PROCEDURE IF EXISTS UpdateLecturer;
CREATE PROCEDURE UpdateLecturer(
    IN p_LecturerID INT,
    IN p_DepartmentID INT,
    IN p_AcademicQualification VARCHAR(255)
)
BEGIN
    -- Check if LecturerID exists in LECTURER table
    IF NOT EXISTS (SELECT 1 FROM LECTURER WHERE LecturerID = p_LecturerID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: LecturerID does not exist in LECTURER table.';
    END IF;

    -- Check if DepartmentID exists in DEPARTMENT table
    IF NOT EXISTS (SELECT 1 FROM DEPARTMENT WHERE DepartmentID = p_DepartmentID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: DepartmentID does not exist in DEPARTMENT table.';
    END IF;

    -- Update LECTURER table
    UPDATE LECTURER
    SET DepartmentID = p_DepartmentID,
        AcademicQualification = p_AcademicQualification
    WHERE LecturerID = p_LecturerID;
END;

-- Delete
DROP PROCEDURE IF EXISTS DeleteLecturer;
CREATE PROCEDURE DeleteLecturer(
    IN p_LecturerID INT
)
BEGIN
    -- Check if LecturerID exists in LECTURER table
    IF NOT EXISTS (SELECT 1 FROM LECTURER WHERE LecturerID = p_LecturerID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: LecturerID does not exist in LECTURER table.';
    END IF;

    -- Delete from LECTURER table
    DELETE FROM LECTURER
    WHERE LecturerID = p_LecturerID;
END;

/******* Mentoring *******/

-- Insert
DROP PROCEDURE IF EXISTS InsertMentoring;
CREATE PROCEDURE InsertMentoring(
    IN p_MentorID INT,
    IN p_MenteeID INT,
    IN p_CourseID VARCHAR(255),
    IN p_SectionID VARCHAR(255),
    IN p_Number INT,
    IN p_Salary INT
)
BEGIN
    -- Check if MentorID exists in STUDENT table
    IF NOT EXISTS (SELECT 1 FROM STUDENT WHERE StudentID = p_MentorID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: MentorID does not exist in STUDENT table.';
    END IF;

    -- Check if MenteeID exists in STUDENT table
    IF NOT EXISTS (SELECT 1 FROM STUDENT WHERE StudentID = p_MenteeID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: MenteeID does not exist in STUDENT table.';
    END IF;

    -- Check if Mentee already has a Mentor
    IF EXISTS (
    SELECT 1
    FROM MENTORING
    WHERE MenteeID = p_MenteeID AND CourseID = p_CourseID
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: This Mentee already has a Mentor for the course.';
    END IF;

    -- Check if CourseID exists in COURSE table
    IF NOT EXISTS (SELECT 1 FROM COURSE WHERE CourseID = p_CourseID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: CourseID does not exist in COURSE table.';
    END IF;

    -- Check if SectionYear and SectionSemester exist in SECTION table
    IF NOT EXISTS (SELECT 1 FROM SECTION WHERE SectionID = p_SectionID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: SectionID does not exist in SECTION table.';
    END IF;

    -- Check if Number is positive
    IF p_Number <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Number must be greater than 0.';
    END IF;

    -- Check if Salary is positive
    IF p_Salary < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Salary cannot be negative.';
    END IF;

    -- Insert into MENTORING table
    INSERT INTO MENTORING (
        MentorID, MenteeID, CourseID, SectionID, Number, Salary
    )
    VALUES (
        p_MentorID, p_MenteeID, p_CourseID, p_SectionID, p_Number, p_Salary
    );
END;

-- SELECT
DROP PROCEDURE IF EXISTS SelectMentoring;
CREATE PROCEDURE SelectMentoring()
BEGIN
    SELECT
	m.MentorID,
	m.MenteeID,
	m.CourseID,
	m.`Number`,
	m.Salary ,
	CONCAT(p1.FirstName, ' ', p1.LastName) AS MentorFullName,
    CONCAT(p2.FirstName, ' ', p2.LastName) AS MenteeFullName ,
    p1.Email as MentorEmail,
    p2.Email as MenteeEmail,
    m.SectionID
    FROM
        MENTORING m
    JOIN STUDENT s1 ON m.MentorID = s1.StudentID
    JOIN PERSON p1 ON s1.StudentID = p1.PersonID
    JOIN STUDENT s2 ON m.MenteeID = s2.StudentID
    JOIN PERSON p2 ON s2.StudentID = p2.PersonID
    ORDER BY
	    m.SectionID;
END;

-- Update
DROP PROCEDURE IF EXISTS UpdateMentoring;
CREATE PROCEDURE UpdateMentoring(
    IN p_MentorID INT,
    IN p_MenteeID INT,
    IN p_CourseID VARCHAR(255),
    IN p_SectionID VARCHAR(255),
    IN p_Number INT,
    IN p_Salary INT
)
BEGIN
    -- Check if the mentoring record exists
    IF NOT EXISTS (
        SELECT 1 FROM MENTORING
        WHERE MentorID = p_MentorID
          AND MenteeID = p_MenteeID
          AND CourseID = p_CourseID
          AND SectionID = p_SectionID
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Mentoring record does not exist.';
    END IF;

    -- Check if Number is positive
    IF p_Number <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Number must be greater than 0.';
    END IF;

    -- Check if Salary is positive
    IF p_Salary < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Salary cannot be negative.';
    END IF;

    -- Update the MENTORING table
    UPDATE MENTORING
    SET Number = p_Number,
        Salary = p_Salary
    WHERE MentorID = p_MentorID
      AND MenteeID = p_MenteeID
      AND CourseID = p_CourseID
      AND SectionID = p_SectionID;
END;

-- Delete
DROP PROCEDURE IF EXISTS DeleteMentoring;
CREATE PROCEDURE DeleteMentoring(
    IN p_MentorID INT,
    IN p_MenteeID INT,
    IN p_CourseID VARCHAR(255),
    IN p_SectionID VARCHAR(255)
)
BEGIN
    -- Check if the mentoring record exists
    IF NOT EXISTS (
        SELECT 1 FROM MENTORING
        WHERE MentorID = p_MentorID
          AND MenteeID = p_MenteeID
          AND CourseID = p_CourseID
          AND SectionID = p_SectionID
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Mentoring record does not exist.';
    END IF;

    -- Delete the mentoring record
    DELETE FROM MENTORING
    WHERE MentorID = p_MentorID
      AND MenteeID = p_MenteeID
      AND CourseID = p_CourseID
      AND SectionID = p_SectionID;
END;


-- PROCEDURE: Find suitable mentors
DROP PROCEDURE IF EXISTS SearchMentor;
CREATE PROCEDURE SearchMentor(IN course_id VARCHAR(255))
BEGIN
    SELECT DISTINCT
        p.PersonID,
        p.FirstName,
        p.LastName,
        p.Email,
        hs.GPA as Course_GPA,
        ROUND(AVG(st.GPA), 2) as Overall_GPA
    FROM
        PERSON p
        INNER JOIN STUDENT s ON p.PersonID = s.StudentID
        INNER JOIN HasScore hs ON s.StudentID = hs.StudentID
        INNER JOIN InSection ins ON s.StudentID = ins.StudentID
        INNER JOIN STUDY st ON s.StudentID = st.StudentID
    WHERE
        hs.CourseID = course_id
        AND hs.GPA >= 8.0
        AND p.Status = 'In_progress'
        AND ins.Status = 'Studying'
    GROUP BY
		p.PersonID,
        p.FirstName,
        p.LastName,
        p.Email,
        hs.GPA
	HAVING
        AVG(hs.GPA) > 8.0
    ORDER BY
        Overall_GPA DESC,
        Course_GPA DESC,
        LastName ASC,
        FirstName ASC;
END;

-- PROCEDURE 3: Get all mentors from all courses
DROP PROCEDURE IF EXISTS GetMentor;
CREATE PROCEDURE GetMentor()
BEGIN
    SELECT DISTINCT
        p.PersonID,
        p.FirstName,
        p.LastName,
        p.Email,
        hs.GPA as Course_GPA,
        c.Name as Course_name
    FROM
        PERSON p
        INNER JOIN STUDENT s ON p.PersonID = s.StudentID
        INNER JOIN HasScore hs ON s.StudentID = hs.StudentID
        INNER JOIN InSection ins ON s.StudentID = ins.StudentID
        INNER JOIN STUDY st ON s.StudentID = st.StudentID
        INNER JOIN COURSE c ON hs.CourseID = c.CourseID
    WHERE
        hs.GPA >= 8.0
        AND p.Status = 'In_progress'
        AND ins.Status = 'Studying'
    GROUP BY
		p.PersonID,
        p.FirstName,
        p.LastName,
        p.Email,
        hs.GPA,
        c.Name
	HAVING
        AVG(hs.GPA) > 8.0
    ORDER BY
        Course_GPA DESC,
        LastName ASC,
        FirstName ASC;
END;

-- PROCEDURE: Find researches in progress
DROP PROCEDURE IF EXISTS GetActiveResearches;
CREATE PROCEDURE GetActiveResearches()
BEGIN
    SELECT
        r.ResearchID,
        r.Name AS ResearchName,
        d.Name AS DepartmentName,
        COUNT(a.StudentID) AS StudentCount
    FROM
        RESEARCH r
    LEFT JOIN
        ASSIST a ON r.ResearchID = a.ResearchID
    INNER JOIN
        DEPARTMENT d ON r.DepartmentID = d.DepartmentID
    WHERE
        r.PublishDate IS NULL -- Only active researches
    GROUP BY
        r.ResearchID, r.Name, d.Name
    HAVING
        StudentCount > 0 -- Optional: Include only researches with at least one student
    ORDER BY
        StudentCount DESC, r.StartDate ASC; -- Order by student count and then start date
END;

-- Procedure: Check enrollment for each semester
DROP PROCEDURE IF EXISTS CheckEnrollment;
CREATE PROCEDURE CheckEnrollment(IN studentId INT, IN sectionId VARCHAR(255), IN sectionYear INT)
BEGIN
    DECLARE TotalCredits INT;

    -- Calculate the total credits for courses the student is enrolled in for the given section and semester
    SELECT SUM(COURSE.Credit)
    INTO TotalCredits
    FROM STUDY
    JOIN CLASS  ON STUDY.ClassID = CLASS.ID
    JOIN SECTION ON CLASS.SectionID = SECTION.SectionID
    JOIN COURSE ON CLASS.CourseID = COURSE.CourseID
    WHERE STUDY.StudentID = studentId
      AND SECTION.SectionID = sectionId
      AND SECTION.Year = sectionYear;

    -- Check if the total credits meet the minimum requirement
    IF TotalCredits < 13 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A student must enroll in courses totaling at least 13 credits in a semester before finalizing.';
    END IF;
END;