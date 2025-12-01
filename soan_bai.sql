create database if not exists soan_bai ;
use soan_bai;

create table accounts(
username varchar(100),
password varchar(100) not null,
is_deleted bit(1) default b'0',
is_blocked bit(1) default b'0',
primary key(username)
);

create table students(
id int auto_increment,
name_student varchar(100) not null,
dob date,
score double,
is_deleted bit(1) default b'0',
username varchar(100) unique not null,
primary key(id),
foreign key (username) references accounts(username)
);


create table classes(
id int auto_increment,
name_class varchar(100) not null,
class_type varchar(100) not null,
is_deleted bit(1) default b'0',
primary key (id)
);

create table student_class(
id_student int,
id_class int,
primary key(id_student,id_class),
foreign key (id_student) references students(id),
foreign key (id_class) references classes(id)
);

create table teachers(
id int auto_increment,
name_student varchar(100) not null,
dob date,
exp varchar(100) not null,
is_deleted bit(1) default b'0',
username varchar(100) unique not null,
primary key(id),
foreign key (username) references accounts(username)
);

create table teacher_class(
id_teacher int,
id_class int,
primary key(id_teacher,id_class),
foreign key (id_teacher) references teachers(id),
foreign key (id_class) references classes(id)
);

INSERT INTO accounts (username, password, is_deleted, is_blocked) VALUES
('student1', 'pass123', b'0', b'0'),
('student2', 'pass123', b'0', b'0'),
('student3', 'pass123', b'0', b'0'),
('student4', 'pass123', b'0', b'0'),
('student5', 'pass123', b'0', b'0'),
('student6', 'pass123', b'0', b'0'),
('student7', 'pass123', b'0', b'0'),
('student8', 'pass123', b'0', b'0'),
('student9', 'pass123', b'0', b'0'),
('student10', 'pass123', b'0', b'0'),
('teacher1', 'teach123', b'0', b'0'),
('teacher2', 'teach123', b'0', b'0'),
('teacher3', 'teach123', b'0', b'0'),
('teacher4', 'teach123', b'0', b'0'),
('teacher5', 'teach123', b'0', b'0'),
('teacher6', 'teach123', b'0', b'0'),
('teacher7', 'teach123', b'0', b'0'),
('teacher8', 'teach123', b'0', b'0'),
('teacher9', 'teach123', b'0', b'0'),
('teacher10', 'teach123', b'0', b'0');

-- Thêm dữ liệu cho bảng students
INSERT INTO students (name_student, dob, score, is_deleted, username) VALUES
('Nguyễn Văn An', '2005-03-15', 8.5, b'0', 'student1'),
('Trần Thị Bích', '2005-07-20', 7.8, b'0', 'student2'),
('Lê Hoàng Cường', '2005-01-10', 9.2, b'0', 'student3'),
('Phạm Thị Dung', '2005-09-25', 6.5, b'0', 'student4'),
('Hoàng Văn Em', '2005-05-30', 8.0, b'0', 'student5'),
('Võ Thị Phương', '2005-11-12', 7.3, b'0', 'student6'),
('Đặng Văn Giang', '2005-02-18', 8.8, b'0', 'student7'),
('Bùi Thị Hà', '2005-08-05', 9.0, b'0', 'student8'),
('Phan Văn Inh', '2005-04-22', 7.5, b'0', 'student9'),
('Ngô Thị Kim', '2005-12-08', 8.3, b'0', 'student10');

-- Thêm dữ liệu cho bảng classes (Đã bổ sung class_type)
INSERT INTO classes (name_class, class_type, is_deleted) VALUES
('Lớp C0825G1', 'fulltime', b'0'),
('Lớp C0925G1', 'parttime', b'0'),
('Lớp C1025G1', 'fulltime', b'0'),
('Lớp Java Backend', 'parttime', b'0'),
('Lớp Python AI', 'fulltime', b'0'),
('Lớp Web Frontend', 'parttime', b'0'),
('Lớp Mobile Android', 'fulltime', b'0'),
('Lớp Database MySQL', 'parttime', b'0'),
('Lớp DevOps', 'fulltime', b'0'),
('Lớp Data Science', 'parttime', b'0');


-- Thêm dữ liệu cho bảng teachers
INSERT INTO teachers (name_student, dob, exp, is_deleted, username) VALUES
('Trần Văn Long', '1985-05-10', '10 năm kinh nghiệm Java', b'0', 'teacher1'),
('Nguyễn Thị Mai', '1987-08-15', '8 năm kinh nghiệm Python', b'0', 'teacher2'),
('Lê Văn Nam', '1983-03-20', '12 năm kinh nghiệm Web', b'0', 'teacher3'),
('Phạm Thị Oanh', '1990-11-25', '7 năm kinh nghiệm Mobile', b'0', 'teacher4'),
('Hoàng Văn Phong', '1986-01-30', '9 năm kinh nghiệm Database', b'0', 'teacher5'),
('Võ Thị Quỳnh', '1988-06-12', '8 năm kinh nghiệm DevOps', b'0', 'teacher6'),
('Đặng Văn Rồng', '1984-09-18', '11 năm kinh nghiệm AI', b'0', 'teacher7'),
('Bùi Thị Sương', '1989-04-05', '6 năm kinh nghiệm Security', b'0', 'teacher8'),
('Phan Văn Tùng', '1985-12-22', '10 năm kinh nghiệm Cloud', b'0', 'teacher9'),
('Ngô Thị Uyên', '1987-07-08', '9 năm kinh nghiệm Testing', b'0', 'teacher10');

-- Thêm dữ liệu cho bảng student_class
INSERT INTO student_class (id_student, id_class) VALUES
(1, 1), (1, 4),
(2, 1), (2, 6),
(3, 2), (3, 4),
(4, 2), (4, 5),
(5, 3), (5, 7),
(6, 3), (6, 8),
(7, 1), (7, 9),
(8, 2), (8, 10),
(9, 3), (9, 6),
(10, 1), (10, 5);

-- Thêm dữ liệu cho bảng teacher_class
INSERT INTO teacher_class (id_teacher, id_class) VALUES
(1, 1), (1, 4),
(2, 5), (2, 10),
(3, 6), (3, 1),
(4, 7), (4, 2),
(5, 8), (5, 3),
(6, 9), (6, 4),
(7, 5), (7, 10),
(8, 1), (8, 6),
(9, 2), (9, 7),
(10, 3), (10, 8);

SELECT 
    s.id,
    s.name_student,
    s.dob,
    s.score,
    c.name_class
FROM students s
JOIN student_class sc ON s.id = sc.id_student
JOIN classes c ON sc.id_class = c.id
WHERE s.is_deleted = b'0' AND c.is_deleted = b'0'
ORDER BY s.id, c.name_class;

SELECT 
    s.id,
    s.name_student,
    s.dob,
    s.score,
    c.name_class,
    c.class_type
FROM students s
JOIN student_class sc ON s.id = sc.id_student
JOIN classes c ON sc.id_class = c.id
WHERE s.is_deleted = b'0' AND c.is_deleted = b'0'
ORDER BY s.id, c.name_class;

SELECT 
    s.id,
    s.name_student,
    s.dob,
    s.score,
    COALESCE(c.name_class, 'Chưa đăng ký lớp') AS name_class
FROM students s
LEFT JOIN student_class sc ON s.id = sc.id_student
LEFT JOIN classes c ON sc.id_class = c.id AND c.is_deleted = b'0'
WHERE s.is_deleted = b'0'
ORDER BY s.id, c.name_class;

SELECT 
    s.id,
    s.name_student,
    s.dob,
    s.score,
    s.username
FROM students s
WHERE s.is_deleted = b'0' 
    AND (s.name_student LIKE '%Tien%' OR s.name_student LIKE '%Toan%')
ORDER BY s.name_student;

SELECT 
    c.id,
    c.name_class,
    COUNT(sc.id_student) AS so_luong_hoc_vien
FROM classes c
LEFT JOIN student_class sc ON c.id = sc.id_class
LEFT JOIN students s ON sc.id_student = s.id AND s.is_deleted = b'0'
WHERE c.is_deleted = b'0'
GROUP BY c.id, c.name_class
ORDER BY so_luong_hoc_vien DESC, c.name_class;

SELECT 
    s.id,
    s.name_student,
    s.dob,
    s.score,
    s.username
FROM students s
WHERE s.is_deleted = b'0'
ORDER BY 
    SUBSTRING_INDEX(s.name_student, ' ', -1) ASC,  -- Sắp xếp theo tên
    s.name_student ASC;  -- Nếu trùng tên thì xếp theo họ