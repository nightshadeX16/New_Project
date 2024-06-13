CREATE DATABASE CPEN_Project1

CREATE SCHEMA eng;

-- Create the "students" table
CREATE TABLE eng.students (
    student_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    department VARCHAR(50) NOT NULL,
    student_pin VARCHAR(20) NOT NULL
);

-- Create the "courses" table
CREATE TABLE eng.courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL
);

-- Function to authenticate a student
CREATE OR REPLACE FUNCTION eng.authenticate_student(
    student_id_param VARCHAR(20),
    student_pin_param VARCHAR(20)
)
RETURNS BOOLEAN
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM eng.students
        WHERE student_id = student_id_param
        AND student_pin = student_pin_param
    );
END;
$$ LANGUAGE plpgsql;

-- Function to insert a new student
CREATE OR REPLACE FUNCTION eng.insert_student(
    student_id_param VARCHAR(20),
    first_name_param VARCHAR(50),
    last_name_param VARCHAR(50),
    date_of_birth_param DATE,
    department_param VARCHAR(50),
    student_pin_param VARCHAR(20)
)
RETURNS VOID
AS $$
BEGIN
    INSERT INTO eng.students (student_id, first_name, last_name, date_of_birth, department, student_pin)
    VALUES (student_id_param, first_name_param, last_name_param, date_of_birth_param, department_param, student_pin_param);
END;
$$ LANGUAGE plpgsql;

-- Function to add a new course
CREATE OR REPLACE FUNCTION eng.add_new_course(
    course_code_param VARCHAR(20),
    course_name_param VARCHAR(100)
)
RETURNS VOID
AS $$
BEGIN
    INSERT INTO eng.courses (course_code, course_name)
    VALUES (course_code_param, course_name_param);
END;
$$ LANGUAGE plpgsql;

-- Function to select all courses
CREATE OR REPLACE FUNCTION eng.select_all_courses()
RETURNS SETOF eng.courses
AS $$
BEGIN
    RETURN QUERY SELECT * FROM eng.courses;
END;
$$ LANGUAGE plpgsql;
