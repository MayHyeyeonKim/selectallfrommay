-- ==========================
-- Table Schema
-- ==========================
CREATE TABLE Class (
    id character(255),
    year integer NOT NULL,
    PRIMARY KEY(id)
);
/*
 varchar: variable character
 255: maximum length of the string
 NOT NULL: this column cannot be empty
 NULL: this column can be empty
 dob: date of birth
 */
CREATE TABLE Student (
    id varchar(255) NOT NULL,
    class varchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    lastName varchar(255) NOT NULL,
    dob date NOT NULL,
    sex varchar(1) NOT NULL,
    FOREIGN KEY (class) REFERENCES Class(id),
    PRIMARY KEY (id)
);
/*
 student should have a class
 class should have a primary key
 forign key points from the dependent side to the parent side
 */
-- ==========================
-- Insert Data
-- ==========================
INSERT INTO Class (id, year)
VALUES ('c1', 1);
INSERT INTO Class (id, year)
VALUES ('c2', 2);
INSERT INTO Class (id, year)
VALUES ('c3', 3);
INSERT INTO Student
VALUES ('s1', 'c1', 'John', 'Doe', '2000-01-01', 'M');
INSERT INTO Student
VALUES ('s2', 'c1', 'Jane', 'Doe', '2000-01-02', 'F');
INSERT INTO Student
VALUES ('s3', 'c2', 'Jim', 'Beam', '2000-01-03', 'M');
-- ==========================
-- Query Examples
-- ==========================
SELECT *
FROM Class;
--
SELECT id,
firstName,
lastName,
class
FROM Student;
-- use single quotes for string values
SELECT id,
    firstName,
    lastName
FROM Student
WHERE class = 'c1';
-- 
/*
 19
 ✔️ SQL is a declarative language that describes what you want.
 ✔️ Solving algorithms with Java or Python is an imperative style that tells how to do it.
 
 20
 https://www.youtube.com/watch?v=KG-mqHoXOXY
 SQL started from an IBM research paper in the 1970s and became a standardized language for querying and managing data.
 It was originally called SEQUEL but was renamed to SQL due to copyright issues.
 
 IMS = Information Management System
 
 IMS is the first commercial database system developed by IBM in the 1960s.
 It used a hierarchical structure rather than a relational model, meaning data was organized like a tree.
 IMS was the primary method of storing data before SQL and relational databases were introduced.
 
 RMS (Record Management System)
 → A low-level system used to store, retrieve, and manage records within files, especially in early operating systems.
 
 VMS RMS
 → RMS in the VMS (Virtual Memory System) operating system allows applications to access data records directly from structured files.
 
 DBMS (Database Management System)
 → A software system that enables users to define, create, maintain, and control access to databases.
 
 RDBMS (Relational Database Management System)
 → A type of DBMS based on the relational model, which stores data in tables and allows users to perform SQL queries.
 */