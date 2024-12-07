USE UNIVERSITY_MANAGEMENT;

-- FUNCTION 1: Calculate average GPA in a section (or all)
DROP FUNCTION IF EXISTS CalculateStudentSectionGPA;
CREATE FUNCTION CalculateStudentSectionGPA(
    f_student_id INT,
    f_section_id VARCHAR(255)
) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE student_exists INT;
    DECLARE section_exists INT;
    DECLARE student_name VARCHAR(511);
    DECLARE avg_gpa DECIMAL(4,2);
    DECLARE result VARCHAR(255);
    
    -- Validate student exists
    SELECT COUNT(*) INTO student_exists
    FROM STUDENT 
    WHERE StudentID = f_student_id;
    
    IF student_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: Invalid Student ID';
    END IF;
    
    -- Get student's full name
    SELECT CONCAT(FirstName, ' ', LastName) INTO student_name
    FROM PERSON
    WHERE PersonID = f_student_id;
    
    -- 'all' sections case
    IF f_section_id = 'all' THEN
        SELECT AVG(s.GPA) INTO avg_gpa
        FROM STUDY s
        INNER JOIN CLASS c ON s.ClassID = c.ID
        WHERE s.StudentID = f_student_id;
        
        SET result = CONCAT('Student ', f_student_id, ', ', 
                          student_name, ', has ', 
                          ROUND(avg_gpa, 2), 
                          ' GPA across all sections');
        
        RETURN result;
    END IF;
    
    -- Validate section exists
    SELECT COUNT(*) INTO section_exists
    FROM CLASS 
    WHERE SectionID = f_section_id;
    
    IF section_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: Invalid Section ID';
    END IF;
    
    -- Calculate GPA for specific section
    SELECT AVG(s.GPA) INTO avg_gpa
    FROM STUDY s
    INNER JOIN CLASS c ON s.ClassID = c.ID
    WHERE s.StudentID = f_student_id 
    AND c.SectionID = f_section_id;
    
    IF avg_gpa IS NULL THEN
        RETURN CONCAT('Student ', f_student_id, 
                     ' has not taken any classes in section ', 
                     f_section_id);
    END IF;
    
    SET result = CONCAT('Student ', f_student_id, ', ', 
                       student_name, ', has ', 
                       ROUND(avg_gpa, 2), 
                       ' GPA across section ', 
                       f_section_id);
    
    RETURN result;
END;

-- drop function CalculateStudentSectionGPA;
-- SELECT CalculateStudentSectionGPA(1, '231');

-- FUNCTION 2: Get Course average GPA by section (or all)
DROP FUNCTION IF EXISTS CalculateCourseAverageGPA;
CREATE FUNCTION CalculateCourseAverageGPA(
    f_course_id VARCHAR(255),
    f_section_id VARCHAR(255)
) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE course_exists INT;
    DECLARE section_exists INT;
    DECLARE avg_gpa DECIMAL(4,2);
    DECLARE student_count INT;
    DECLARE result VARCHAR(255);
    
    -- Validate course exists
    SELECT COUNT(*) INTO course_exists
    FROM COURSE 
    WHERE CourseID = f_course_id;
    
    IF course_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: Invalid Course ID';
    END IF;
    
    -- 'all' sections case
    IF f_section_id = 'all' THEN
        SELECT 
            AVG(s.GPA), 
            COUNT(DISTINCT s.StudentID)
        INTO 
            avg_gpa, 
            student_count
        FROM STUDY s
        INNER JOIN CLASS c ON s.ClassID = c.ID
        WHERE c.CourseID = f_course_id;
        
        IF avg_gpa IS NULL THEN
            RETURN CONCAT('Course ', f_course_id, 
                         ' has no student records yet');
        END IF;
        
        SET result = CONCAT('Course ', f_course_id, 
                           ' has average GPA of ', 
                           ROUND(avg_gpa, 2),
                           ' across all sections (',
                           student_count,
                           ' students)');
        RETURN result;
    END IF;
    
    -- Validate section exists
    SELECT COUNT(*) INTO section_exists
    FROM CLASS 
    WHERE SectionID = f_section_id
    AND CourseID = f_course_id;
    
    IF section_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: Section ID does not exist for chosen course';
    END IF;
    
    -- Calculate GPA for specific section
    SELECT 
        AVG(s.GPA),
        COUNT(DISTINCT s.StudentID)
    INTO 
        avg_gpa,
        student_count
    FROM STUDY s
    INNER JOIN CLASS c ON s.ClassID = c.ID
    WHERE c.CourseID = f_course_id 
    AND c.SectionID = f_section_id;
    
    IF avg_gpa IS NULL THEN
        RETURN CONCAT('Course ', f_course_id, 
                     ' section ', f_section_id,
                     ' has no student records yet');
    END IF;
    
    SET result = CONCAT('Course ', f_course_id,
                       ' has average GPA of ',
                       ROUND(avg_gpa, 2),
                       ' in section ', f_section_id,
                       ' (', student_count, ' students)');
    
    RETURN result;
END;

-- drop function CalculateCourseAverageGPA;
-- select CalculateCourseAverageGPA('mt1003', '231');