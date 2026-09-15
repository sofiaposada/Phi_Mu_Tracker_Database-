USE phi_mu_tracker;
CREATE TABLE Member (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    class_year INT,
    major VARCHAR(50),
    join_date DATE
);
SHOW TABLES;
CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(100),
    event_type VARCHAR(50),
    event_date DATE,
    event_location VARCHAR(100),
    point_value INT
);
SHOW TABLES;
CREATE TABLE Officer (
    officer_id INT PRIMARY KEY,
    member_id INT,
    position_title VARCHAR(50),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);
SHOW TABLES;
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    member_id INT,
    event_id INT,
    attendance_status VARCHAR(20),
    check_in_time TIME,
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);
SHOW TABLES;
CREATE TABLE Points (
    points_id INT PRIMARY KEY,
    member_id INT,
    event_id INT,
    points_earned INT,
    date_awarded DATE,
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);
SHOW TABLES;
INSERT INTO Member VALUES
(1, 'Ava', 'Johnson', 'ava.johnson@cnu.edu', 2026, 'Marketing', '2024-09-01'),
(2, 'Mia', 'Smith', 'mia.smith@cnu.edu', 2027, 'Psychology', '2024-09-01'),
(3, 'Emma', 'Brown', 'emma.brown@cnu.edu', 2025, 'Business', '2023-09-01'),
(4, 'Olivia', 'Davis', 'olivia.davis@cnu.edu', 2026, 'Communication', '2024-01-15'),
(5, 'Sophia', 'Wilson', 'sophia.wilson@cnu.edu', 2027, 'Information Science', '2024-09-01'),
(6, 'Grace', 'Miller', 'grace.miller@cnu.edu', 2025, 'Biology', '2023-09-01'),
(7, 'Ella', 'Taylor', 'ella.taylor@cnu.edu', 2026, 'English', '2024-01-15'),
(8, 'Lily', 'Moore', 'lily.moore@cnu.edu', 2027, 'Sociology', '2024-09-01');
SELECT * FROM Member;
INSERT INTO Event VALUES
(1, 'Bid Day Celebration', 'Social', '2025-09-01', 'Phi Mu House', 10),
(2, 'Philanthropy Night', 'Philanthropy', '2025-09-10', 'Student Center', 15),
(3, 'Chapter Meeting', 'Meeting', '2025-09-05', 'Lecture Hall', 5);
SELECT * FROM Event;
INSERT INTO Officer VALUES
(1, 1, 'President', '2025-01-01', '2025-12-01'),
(2, 3, 'Vice President', '2025-01-01', '2025-12-01'),
(3, 5, 'Treasurer', '2025-01-01', '2025-12-01');
SELECT * FROM Officer;
INSERT INTO Attendance VALUES
(1, 1, 1, 'Present', '18:00:00'),
(2, 2, 1, 'Present', '18:05:00'),
(3, 3, 1, 'Absent', NULL),
(4, 4, 2, 'Present', '19:00:00'),
(5, 5, 2, 'Late', '19:10:00'),
(6, 6, 2, 'Present', '19:02:00'),
(7, 7, 3, 'Present', '17:00:00'),
(8, 8, 3, 'Absent', NULL),
(9, 1, 3, 'Present', '17:05:00'),
(10, 2, 2, 'Present', '19:03:00');
SELECT * FROM Attendance;
INSERT INTO Points VALUES
(1, 1, 1, 10, '2025-09-01'),
(2, 2, 1, 10, '2025-09-01'),
(3, 4, 2, 15, '2025-09-10'),
(4, 5, 2, 10, '2025-09-10'),
(5, 6, 2, 15, '2025-09-10'),
(6, 7, 3, 5, '2025-09-05'),
(7, 1, 3, 5, '2025-09-05'),
(8, 2, 2, 15, '2025-09-10'),
(9, 3, 1, 0, '2025-09-01'),
(10, 8, 3, 0, '2025-09-05');
SELECT * FROM Points;
SELECT * FROM Member;
SELECT * FROM Event;
SELECT 
    Member.first_name,
    Member.last_name,
    Officer.position_title
FROM Officer
JOIN Member ON Officer.member_id = Member.member_id;
SELECT 
    Event.event_name,
    Member.first_name,
    Member.last_name,
    Attendance.attendance_status
FROM Attendance
JOIN Member ON Attendance.member_id = Member.member_id
JOIN Event ON Attendance.event_id = Event.event_id;

SELECT 
    Member.first_name,
    Member.last_name,
    SUM(Points.points_earned) AS total_points
FROM Points
JOIN Member ON Points.member_id = Member.member_id
GROUP BY Member.member_id, Member.first_name, Member.last_name
ORDER BY total_points DESC;

SELECT 
    Member.first_name,
    Member.last_name,
    Event.event_name,
    Attendance.attendance_status
FROM Attendance
JOIN Member ON Attendance.member_id = Member.member_id
JOIN Event ON Attendance.event_id = Event.event_id
WHERE Attendance.attendance_status = 'Absent';

SELECT 
    Member.first_name,
    Member.last_name,
    Officer.position_title
FROM Officer
JOIN Member ON Officer.member_id = Member.member_id;

SELECT 
    Event.event_name,
    Member.first_name,
    Member.last_name,
    Attendance.attendance_status
FROM Attendance
JOIN Member ON Attendance.member_id = Member.member_id
JOIN Event ON Attendance.event_id = Event.event_id;

SELECT 
    Member.first_name,
    Member.last_name,
    SUM(Points.points_earned) AS total_points
FROM Points
JOIN Member ON Points.member_id = Member.member_id
GROUP BY Member.member_id, Member.first_name, Member.last_name
ORDER BY total_points DESC;

SELECT 
    Member.first_name,
    Member.last_name,
    Event.event_name,
    Attendance.attendance_status
FROM Attendance
JOIN Member ON Attendance.member_id = Member.member_id
JOIN Event ON Attendance.event_id = Event.event_id
WHERE Attendance.attendance_status = 'Absent';
