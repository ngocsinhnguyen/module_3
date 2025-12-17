-- ==============================
-- DATABASE
-- ==============================
CREATE DATABASE IF NOT EXISTS dna_system_update
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE dna_system_update;

-- ==============================
-- TABLE: account (Thông tin đăng nhập)
-- ==============================
CREATE TABLE account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password CHAR(60) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- TABLE: users (Thông tin cá nhân)
-- ==============================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    dob DATE,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account(account_id)
        ON DELETE CASCADE
);

-- ==============================
-- TABLE: dna_samples
-- ==============================
CREATE TABLE dna_samples (
    sample_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    test_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    facility_name VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- ==============================
-- TABLE: locus (MASTER DATA – 16 dòng cố định)
-- ==============================
CREATE TABLE locus (
    locus_id INT PRIMARY KEY,
    locus_name VARCHAR(50) UNIQUE NOT NULL
);

-- ==============================
-- INSERT 16 LOCUS CHUẨN
-- ==============================
INSERT INTO locus (locus_id, locus_name) VALUES
(1, 'D8S1179'),
(2, 'D21S11'),
(3, 'D7S820'),
(4, 'CSF1PO'),
(5, 'D3S1358'),
(6, 'TH01'),
(7, 'D13S317'),
(8, 'D16S539'),
(9, 'D2S1338'),
(10, 'D19S433'),
(11, 'vWA'),
(12, 'TPOX'),
(13, 'D18S51'),
(14, 'AMEL'),
(15, 'D5S818'),
(16, 'FGA');

-- ==============================
-- TABLE: dna_locus_results
-- (16 dòng / 1 sample)
-- ==============================
CREATE TABLE dna_locus_results (
    sample_id INT NOT NULL,
    locus_id INT NOT NULL,
    allele_1 VARBINARY(255) NOT NULL,
    allele_2 VARBINARY(255) NOT NULL,
    PRIMARY KEY (sample_id, locus_id),
    FOREIGN KEY (sample_id) REFERENCES dna_samples(sample_id)
        ON DELETE CASCADE,
    FOREIGN KEY (locus_id) REFERENCES locus(locus_id)
);

-- ==============================
-- TABLE: comparison_results (Kết quả so sánh tổng hợp)
-- ==============================
CREATE TABLE comparison_results (
    comparison_id INT AUTO_INCREMENT PRIMARY KEY,
    sample_1 INT NOT NULL,
    sample_2 INT NOT NULL,
    matched_locus INT NOT NULL,
    similarity_percent FLOAT NOT NULL,
    paternity_index DECIMAL(10,4) NOT NULL,  -- CPI tổng hợp
    relationship VARCHAR(50),
    compared_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sample_1) REFERENCES dna_samples(sample_id)
        ON DELETE CASCADE,
    FOREIGN KEY (sample_2) REFERENCES dna_samples(sample_id)
        ON DELETE CASCADE
);

-- ==============================
-- TABLE: comparison_locus_results (Chi tiết PI từng locus)
-- ==============================
CREATE TABLE comparison_locus_results (
    comparison_id INT NOT NULL,
    locus_id INT NOT NULL,
    pi_value DECIMAL(10,4) NOT NULL,
    PRIMARY KEY (comparison_id, locus_id),
    FOREIGN KEY (comparison_id) REFERENCES comparison_results(comparison_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (locus_id) REFERENCES locus(locus_id)
);

-- ==============================
-- INDEXES (TỐI ƯU)
-- ==============================
CREATE INDEX idx_user_account ON users(account_id);
CREATE INDEX idx_dna_sample_user ON dna_samples(user_id);
CREATE INDEX idx_comparison_samples ON comparison_results(sample_1, sample_2);

-- ==============================
-- VIEW: Thông tin user đầy đủ (kết hợp account + users)
-- ==============================
CREATE VIEW v_user_info AS
SELECT
    u.user_id,
    u.full_name,
    u.email,
    u.phone,
    u.address,
    u.dob,
    u.gender,
    a.username,
    a.account_id,
    a.created_at AS account_created_at
FROM users u
JOIN account a ON u.account_id = a.account_id;

-- ==============================
-- VIEW: DNA sample detail
-- ==============================
CREATE VIEW v_dna_sample_detail AS
SELECT
    s.sample_id,
    s.user_id,
    l.locus_name,
    r.allele_1,
    r.allele_2
FROM dna_samples s
JOIN dna_locus_results r ON s.sample_id = r.sample_id
JOIN locus l ON r.locus_id = l.locus_id;


-- ==============================
-- TABLE: allele_frequency
-- (Tần suất allele – dùng chung toàn hệ thống)
-- ==============================
CREATE TABLE allele_frequency (
    locus_id INT NOT NULL,
    allele VARBINARY(255) NOT NULL,
    frequency DECIMAL(6,5) NOT NULL CHECK (frequency > 0 AND frequency < 1),
    PRIMARY KEY (locus_id, allele),
    FOREIGN KEY (locus_id) REFERENCES locus(locus_id)
        ON DELETE CASCADE
);

-- ==============================
-- DỮ LIỆU MẪU
-- ==============================

-- Tạo 4 account
INSERT INTO account (username, password) VALUES 
('user_a', '$2y$10$abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJ'),  -- hash password
('user_b', '$2y$10$abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGH2'),
('user_c', '$2y$10$randomhashCxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
('user_d', '$2y$10$randomhashDxxxxxxxxxxxxxxxxxxxxxxxxxxxx');


-- Tạo 4 users tương ứng
INSERT INTO users (account_id, full_name, email, phone, address, dob, gender) VALUES 
(1, 'Nguyen Van A', 'a@test.com', '0912345678', '123 Nguyen Hue, Da Nang', '1987-12-1', 'M'),
(2, 'Nguyen Van B', 'b@test.com', '0923456789', '456 Tran Phu, Da Nang', '1999-1-2', 'M'),
(3, 'Tran Van C', 'c@test.com','09328765676', '234 Le Duan, Ha Noi', '1985-05-10', 'M'),
(4, 'Le Thi D',   'd@test.com', '0937846372', '765 Nguyen Tat Thanh, Ho Chi Minh', '1990-08-20', 'F');

-- Thêm DNA samples
INSERT INTO dna_samples (user_id, gender, test_date, facility_name) VALUES
(1, 'M', '2025-01-01', 'Trung tâm A'),
(2, 'M', '2025-01-01', 'Trung tâm B'),
(3, 'M', '2025-01-02', 'Trung tâm C'),
(4, 'F', '2025-01-02', 'Trung tâm D');


-- Thêm 16 LOCUS cho SAMPLE 1
INSERT INTO dna_locus_results VALUES
(1, 1, '11', '14'),
(1, 2, '29', '30'),
(1, 3, '10', '12'),
(1, 4, '12', '12'),
(1, 5, '15', '17'),
(1, 6, '6',  '9'),
(1, 7, '8',  '11'),
(1, 8, '9',  '11'),
(1, 9, '18', '23'),
(1,10, '13', '14'),
(1,11, '16', '18'),
(1,12, '8',  '11'),
(1,13, '14', '17'),
(1,14, 'X',  'Y'),
(1,15, '10', '13'),
(1,16, '22', '25');

-- Thêm 16 LOCUS cho SAMPLE 2 (có quan hệ)
INSERT INTO dna_locus_results VALUES
(2, 1, '11', '16'),
(2, 2, '29', '29'),
(2, 3, '10', '11'),
(2, 4, '12', '10'),
(2, 5, '15', '14'),
(2, 6, '6',  '7'),
(2, 7, '8',  '9'),
(2, 8, '9',  '11'),
(2, 9, '18', '19'),
(2,10, '13', '13'),
(2,11, '16', '14'),
(2,12, '8',  '9'),
(2,13, '14', '13'),
(2,14, 'X',  'Y'),
(2,15, '10', '11'),
(2,16, '22', '21');

-- Thêm 16 LOCUS cho SAMPLE 3 (không có quan hệ)
INSERT INTO dna_locus_results VALUES
(3, 1, '9',  '13'),
(3, 2, '26', '33'),
(3, 3, '7',  '15'),
(3, 4, '9',  '14'),
(3, 5, '12', '18'),
(3, 6, '7',  '10'),
(3, 7, '6',  '14'),
(3, 8, '8',  '13'),
(3, 9, '16', '24'),
(3,10, '9',  '16'),
(3,11, '13', '20'),
(3,12, '6',  '13'),
(3,13, '10', '19'),
(3,14, 'X',  'Y'),
(3,15, '7',  '14'),
(3,16, '18', '27');

-- Thêm 16 LOCUS cho SAMPLE 4 (không có quan hệ)
INSERT INTO dna_locus_results VALUES
(4, 1, '8',  '15'),
(4, 2, '24', '34'),
(4, 3, '6',  '14'),
(4, 4, '8',  '15'),
(4, 5, '11', '19'),
(4, 6, '5',  '11'),
(4, 7, '7',  '13'),
(4, 8, '7',  '14'),
(4, 9, '15', '22'),
(4,10, '10', '15'),
(4,11, '14', '19'),
(4,12, '7',  '12'),
(4,13, '11', '18'),
(4,14, 'X',  'X'),
(4,15, '8',  '12'),
(4,16, '19', '26');


-- LOCUS 1 – D8S1179
INSERT INTO allele_frequency VALUES
(1,'8',0.02),(1,'9',0.04),(1,'10',0.10),(1,'11',0.20),
(1,'12',0.18),(1,'13',0.15),(1,'14',0.12),(1,'15',0.10),
(1,'16',0.06),(1,'17',0.03);

-- LOCUS 2 – D21S11
INSERT INTO allele_frequency VALUES
(2,'24',0.02),(2,'25',0.04),(2,'26',0.06),(2,'27',0.08),
(2,'28',0.12),(2,'29',0.18),(2,'30',0.16),(2,'31',0.14),
(2,'32',0.10),(2,'33',0.06),(2,'34',0.04);

-- LOCUS 3 – D7S820
INSERT INTO allele_frequency VALUES
(3,'6',0.03),(3,'7',0.05),(3,'8',0.08),(3,'9',0.12),
(3,'10',0.18),(3,'11',0.20),(3,'12',0.16),(3,'13',0.10),
(3,'14',0.05),(3,'15',0.03);

-- LOCUS 4 – CSF1PO
INSERT INTO allele_frequency VALUES
(4,'8',0.05),(4,'9',0.10),(4,'10',0.18),(4,'11',0.20),
(4,'12',0.18),(4,'13',0.12),(4,'14',0.10),(4,'15',0.07);

-- LOCUS 5 – D3S1358
INSERT INTO allele_frequency VALUES
(5,'11',0.04),(5,'12',0.06),(5,'13',0.10),(5,'14',0.16),
(5,'15',0.20),(5,'16',0.18),(5,'17',0.14),(5,'18',0.08),
(5,'19',0.04);

-- LOCUS 6 – TH01
INSERT INTO allele_frequency VALUES
(6,'5',0.05),(6,'6',0.15),(6,'7',0.22),(6,'8',0.20),
(6,'9',0.18),(6,'9.3',0.10),(6,'10',0.07),(6,'11',0.03);

-- LOCUS 7 – D13S317
INSERT INTO allele_frequency VALUES
(7,'6',0.04),(7,'7',0.06),(7,'8',0.14),(7,'9',0.20),
(7,'10',0.18),(7,'11',0.16),(7,'12',0.12),(7,'13',0.06),
(7,'14',0.04);

-- LOCUS 8 – D16S539
INSERT INTO allele_frequency VALUES
(8,'7',0.05),(8,'8',0.08),(8,'9',0.18),(8,'10',0.20),
(8,'11',0.22),(8,'12',0.15),(8,'13',0.08),(8,'14',0.04);

-- LOCUS 9 – D2S1338
INSERT INTO allele_frequency VALUES
(9,'15',0.04),(9,'16',0.06),(9,'17',0.08),(9,'18',0.12),
(9,'19',0.15),(9,'20',0.18),(9,'21',0.16),(9,'22',0.12),
(9,'23',0.06),(9,'24',0.03);

-- LOCUS 10 – D19S433
INSERT INTO allele_frequency VALUES
(10,'9',0.05),(10,'10',0.08),(10,'11',0.12),(10,'12',0.18),
(10,'13',0.20),(10,'14',0.17),(10,'15',0.12),(10,'16',0.08);

-- LOCUS 11 – vWA
INSERT INTO allele_frequency VALUES
(11,'13',0.05),(11,'14',0.12),(11,'15',0.18),(11,'16',0.20),
(11,'17',0.18),(11,'18',0.15),(11,'19',0.08),(11,'20',0.04);

-- LOCUS 12 – TPOX
INSERT INTO allele_frequency VALUES
(12,'6',0.04),(12,'7',0.08),(12,'8',0.20),(12,'9',0.22),
(12,'10',0.18),(12,'11',0.14),(12,'12',0.10),(12,'13',0.04);

-- LOCUS 13 – D18S51
INSERT INTO allele_frequency VALUES
(13,'10',0.04),(13,'11',0.06),(13,'12',0.08),(13,'13',0.12),
(13,'14',0.16),(13,'15',0.18),(13,'16',0.16),(13,'17',0.12),
(13,'18',0.06),(13,'19',0.02);

-- LOCUS 15 – D5S818
INSERT INTO allele_frequency VALUES
(15,'7',0.05),(15,'8',0.08),(15,'9',0.12),(15,'10',0.20),
(15,'11',0.22),(15,'12',0.18),(15,'13',0.10),(15,'14',0.05);

-- LOCUS 16 – FGA
INSERT INTO allele_frequency VALUES
(16,'18',0.03),(16,'19',0.05),(16,'20',0.08),(16,'21',0.12),
(16,'22',0.16),(16,'23',0.18),(16,'24',0.16),(16,'25',0.12),
(16,'26',0.06),(16,'27',0.04);



-- ==============================
-- QUERIES KIỂM TRA
-- ==============================

-- Xem thông tin user đầy đủ
SELECT * FROM v_user_info;

-- Xem DNA sample detail
SELECT * FROM v_dna_sample_detail WHERE sample_id = 1;
SELECT * FROM v_dna_sample_detail WHERE sample_id = 2;

SELECT locus_id, SUM(frequency) AS total_freq
FROM allele_frequency
GROUP BY locus_id;

SELECT l.locus_name, a.allele, a.frequency
FROM allele_frequency a
JOIN locus l ON a.locus_id = l.locus_id
ORDER BY l.locus_id;
