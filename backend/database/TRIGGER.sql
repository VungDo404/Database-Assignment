USE UNIVERSITY_MANAGEMENT;

DROP TRIGGER IF EXISTS CheckCourseTotalPercentage_Insert;
	CREATE TRIGGER CheckCourseTotalPercentage_Insert
		AFTER INSERT ON COURSE
			FOR EACH ROW
				BEGIN
					DECLARE invalidSum CONDITION FOR SQLSTATE '45000';
					IF (NEW.QuizPercentage + NEW.MidPercentage + NEW.FinalPercentage) <> 1 THEN
						SIGNAL invalidSum
						SET MESSAGE_TEXT = 'The total percentage of “final_percentage”, “mid_percentage”, “quiz_percentage” of each course must be 1';
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckCourseTotalPercentage_Update;
	CREATE TRIGGER CheckCourseTotalPercentage_Update
		BEFORE UPDATE ON COURSE
			FOR EACH ROW
				BEGIN
					DECLARE invalidSum CONDITION FOR SQLSTATE '45000';
					IF (NEW.QuizPercentage + NEW.MidPercentage + NEW.FinalPercentage) <> 1 THEN
						SIGNAL invalidSum
						SET MESSAGE_TEXT = 'The total percentage of “final_percentage”, “mid_percentage”, “quiz_percentage” of each course must be 1';
					END IF;
				END;

DROP TRIGGER IF EXISTS StudentGraduateStatus;
	CREATE TRIGGER StudentGraduateStatus
		AFTER UPDATE ON PERSON
			FOR EACH ROW
				BEGIN
					IF NEW.status = 'Graduate' THEN
						UPDATE InSection
						SET Status = 'Graduate'
						WHERE StudentID = NEW.PersonID;
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckWarningStatus_Insert;
	CREATE TRIGGER CheckWarningStatus_Insert
		AFTER INSERT ON InSection
			FOR EACH ROW
				BEGIN
					DECLARE warningCount INT;
					SELECT COUNT(*) INTO warningCount
					FROM InSection WHERE StudentID = NEW.StudentID AND Status = 'Warning';
					
					IF warningCount > 2 THEN
						UPDATE PERSON
						SET Status = 'Expelled'
						WHERE PersonID = NEW.StudentID;
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckWarningStatus_Update;
	CREATE TRIGGER CheckWarningStatus_Update
		AFTER UPDATE ON InSection
			FOR EACH ROW
				BEGIN
					DECLARE warningCount INT;
					SELECT COUNT(*) INTO warningCount
					FROM InSection WHERE StudentID = NEW.StudentID AND Status = 'Warning';
					
					IF warningCount > 2 THEN
						UPDATE PERSON
						SET Status = 'Expelled'
						WHERE PersonID = NEW.StudentID;
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckGpaExpulsion_Insert;
	CREATE TRIGGER CheckGpaExpulsion_Insert
		AFTER INSERT ON STUDY
			FOR EACH ROW
				BEGIN
					DECLARE LowGpaCount INT;
					SELECT COUNT(*)
					INTO LowGpaCount
					FROM STUDY
					WHERE StudentID = NEW.StudentID AND GPA < 1.0;
					
					IF LowGpaCount >= 3 THEN
						UPDATE PERSON
						SET Status = 'Expelled'
						WHERE PersonID = NEW.StudentID;
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckGpaExpulsion_Update;
	CREATE TRIGGER CheckGpaExpulsion_Update
		AFTER UPDATE ON STUDY
			FOR EACH ROW
				BEGIN
					DECLARE LowGpaCount INT;
					SELECT COUNT(*)
					INTO LowGpaCount
					FROM STUDY
					WHERE StudentID = NEW.StudentID AND GPA < 1.0;
					
					IF LowGpaCount >= 3 THEN
						UPDATE PERSON
						SET Status = 'Expelled'
						WHERE PersonID = NEW.StudentID;
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckStudentDuration_Insert;
	CREATE TRIGGER CheckStudentDuration_Insert
		AFTER INSERT ON InSection
			FOR EACH ROW
				BEGIN
					DECLARE YearDuration INT;
					SELECT COUNT(DISTINCT SectionID)
					INTO YearDuration
					FROM InSection
					WHERE StudentID = NEW.StudentID AND Status = 'Studying';
					
					IF YearDuration >= 8 THEN
						UPDATE PERSON
						SET Status = 'Expelled'
						WHERE PersonID = NEW.StudentID;
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckStudentDuration_Update;
	CREATE TRIGGER CheckStudentDuration_Update
		AFTER UPDATE ON InSection
			FOR EACH ROW
				BEGIN
					DECLARE YearDuration INT;
					SELECT COUNT(DISTINCT SectionID)
					INTO YearDuration
					FROM InSection
					WHERE StudentID = NEW.StudentID AND Status = 'Studying';
					
					IF YearDuration >= 8 THEN
						UPDATE PERSON
						SET Status = 'Expelled'
						WHERE PersonID = NEW.StudentID;
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckGraduationCondition_Insert;
	CREATE TRIGGER CheckGraduationCondition_Insert
		AFTER INSERT ON InSection
			FOR EACH ROW
				BEGIN
					DECLARE NotEnoughCondition CONDITION FOR SQLSTATE '45000';
					DECLARE totalCredit INT;
					SELECT SUM(Credit)
					INTO totalCredit
					FROM STUDY
					JOIN CLASS ON STUDY.ClassID = CLASS.ID
					JOIN COURSE ON CLASS.CourseID = COURSE.CourseID
					WHERE STUDY.StudentID = NEW.StudentID;
					
					IF totalCredit < 120 AND NEW.Status = 'graduate' THEN
						SIGNAL NotEnoughCondition
						SET MESSAGE_TEXT = 'Student cannot graduate with less than 120 credits';
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckGraduationCondition_Update;
	CREATE TRIGGER CheckGraduationCondition_Update
		AFTER UPDATE ON InSection
			FOR EACH ROW
				BEGIN
					DECLARE NotEnoughCondition CONDITION FOR SQLSTATE '45000';
					DECLARE totalCredit INT;
					SELECT SUM(Credit)
					INTO totalCredit
					FROM STUDY
					JOIN CLASS ON STUDY.ClassID = CLASS.ID
					JOIN COURSE ON CLASS.CourseID = COURSE.CourseID
					WHERE STUDY.StudentID = NEW.StudentID;
					
					IF totalCredit < 120 AND NEW.Status = 'graduate' THEN
						SIGNAL NotEnoughCondition
						SET MESSAGE_TEXT = 'Student cannot graduate with less than 120 credits';
					END IF;
				END;

DROP TRIGGER IF EXISTS CheckCourseOverlap;
	CREATE TRIGGER CheckCourseOverlap
		BEFORE INSERT ON STUDY
		FOR EACH ROW
		BEGIN
			DECLARE class_time TIME;
			DECLARE class_date ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
			DECLARE class_section VARCHAR(255);
			DECLARE courseOverlap CONDITION FOR SQLSTATE '45000';
			
			SELECT Time, DateOfWeek, SectionID INTO class_time, class_date, class_section
			FROM CLASS
			WHERE ID = NEW.ClassID;

			IF EXISTS (
				SELECT 1
				FROM STUDY
				JOIN CLASS ON STUDY.ClassID = CLASS.ID
				WHERE STUDY.StudentID = NEW.StudentID
				AND CLASS.DateOfWeek = class_date
				AND CLASS.Time = class_time
				AND CLASS.SectionID = class_section
			) THEN
				SIGNAL courseOverlap
				SET MESSAGE_TEXT = 'Course timing overlap with another course';
			END IF;
END;

-- Automatically decrease the number of available scholaships when it is given to a student
DROP TRIGGER IF EXISTS trg_after_award_scholarship;
	CREATE TRIGGER trg_after_award_scholarship
		AFTER INSERT ON AWARD_TO
			FOR EACH ROW
			BEGIN
				UPDATE SCHOLARSHIP
				SET number = number - 1
				WHERE ScholarshipID = NEW.ScholarshipID AND number > 0;
			END;

-- Automatically Capitalize FirstName and LastName on Insert Person
DROP TRIGGER IF EXISTS trg_capitalize_names;
	CREATE TRIGGER trg_capitalize_names
	BEFORE INSERT ON PERSON
	FOR EACH ROW
	BEGIN
		SET NEW.FirstName = CONCAT(UPPER(SUBSTRING(NEW.FirstName, 1, 1)), LOWER(SUBSTRING(NEW.FirstName, 2)));
		SET NEW.LastName = CONCAT(UPPER(SUBSTRING(NEW.LastName, 1, 1)), LOWER(SUBSTRING(NEW.LastName, 2)));
END;
    
-- Prevent duplicate phone number when inserting Person    
DROP TRIGGER IF EXISTS trg_prevent_duplicate_phone;
	CREATE TRIGGER trg_prevent_duplicate_phone
	BEFORE INSERT ON PERSON
	FOR EACH ROW
	BEGIN
		IF EXISTS (SELECT 1 FROM PERSON WHERE PhoneNumber = NEW.PhoneNumber) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Duplicate PhoneNumber is not allowed.';
		END IF;
	END;

-- Check valid Course before insert into Study
DROP TRIGGER IF EXISTS trg_check_valid_course_study;
	CREATE TRIGGER trg_check_valid_course_study
	BEFORE INSERT ON STUDY
	FOR EACH ROW
	BEGIN
		DECLARE student_department_id INT;
		DECLARE course_department_id INT;

		-- Get the department of the student
		SELECT DepartmentID INTO student_department_id
		FROM STUDENT
		WHERE StudentID = NEW.StudentID;

		-- Get the department of the course linked to the class
		SELECT c.DepartmentID INTO course_department_id
		FROM CLASS cl
		JOIN COURSE c ON cl.CourseID = c.CourseID
		WHERE cl.ID = NEW.ClassID;

		-- Check if the departments match
		IF student_department_id IS NULL OR course_department_id IS NULL THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Student or Course not found, cannot insert into STUDY';
		ELSEIF student_department_id != course_department_id THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Student can only study courses within their department';
		END IF;
	END;

-- Update GPA in HasScore when inserting a new GPA
DROP TRIGGER IF EXISTS trg_insert_new_gpa;
	CREATE TRIGGER trg_insert_new_gpa
	AFTER INSERT ON STUDY
	FOR EACH ROW
	BEGIN
		IF NEW.Pass = TRUE THEN
			-- Check if an entry already exists for the student and course in HasScore
			IF NOT EXISTS (
				SELECT 1
				FROM HasScore
				WHERE StudentID = NEW.StudentID AND CourseID = (
					SELECT CourseID
					FROM CLASS
					WHERE ID = NEW.ClassID
				)
			) THEN
				-- Insert the GPA into HasScore
				INSERT INTO HasScore (StudentID, CourseID, GPA)
				VALUES (
					NEW.StudentID,
					(SELECT CourseID FROM CLASS WHERE ID = NEW.ClassID),
					NEW.GPA
				);
			END IF;
		END IF;
	END;
    
-- Update higher Course GPA when passed
DROP TRIGGER IF EXISTS trg_update_higher_gpa;
	CREATE TRIGGER trg_update_higher_gpa
	AFTER INSERT ON STUDY
	FOR EACH ROW
	BEGIN
		IF NEW.Pass = TRUE THEN
			-- Check if the GPA in STUDY is higher than the existing GPA in HasScore
			IF EXISTS (
				SELECT 1
				FROM HasScore
				WHERE StudentID = NEW.StudentID
				AND CourseID = (
					SELECT CourseID
					FROM CLASS
					WHERE ID = NEW.ClassID
				)
				AND NEW.GPA > (
					SELECT GPA
					FROM HasScore
					WHERE StudentID = NEW.StudentID
					AND CourseID = (
						SELECT CourseID
						FROM CLASS
						WHERE ID = NEW.ClassID
					)
				)
			) THEN
				-- Update HasScore with the higher GPA
				UPDATE HasScore
				SET GPA = NEW.GPA
				WHERE StudentID = NEW.StudentID
				AND CourseID = (
					SELECT CourseID
					FROM CLASS
					WHERE ID = NEW.ClassID
				);
			END IF;
		END IF;
	END;



