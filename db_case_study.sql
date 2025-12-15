-- ==============================
-- DATABASE
-- ==============================
CREATE DATABASE IF NOT EXISTS dna_system
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE dna_system;

-- ==============================
-- TABLE: users
-- ==============================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password CHAR(60) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- TABLE: dna_samples
-- ==============================
CREATE TABLE dna_samples (
    sample_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    gender CHAR(1),
    test_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
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
-- TABLE: comparison_results
-- ==============================
CREATE TABLE comparison_results (
    comparison_id INT AUTO_INCREMENT PRIMARY KEY,
    sample_1 INT NOT NULL,
    sample_2 INT NOT NULL,
    matched_locus INT NOT NULL,
    similarity_percent FLOAT NOT NULL,
    relationship VARCHAR(50),
    compared_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sample_1) REFERENCES dna_samples(sample_id)
        ON DELETE CASCADE,
    FOREIGN KEY (sample_2) REFERENCES dna_samples(sample_id)
        ON DELETE CASCADE
);

-- ==============================
-- INDEXES (TỐI ƯU)
-- ==============================
CREATE INDEX idx_dna_sample_user
ON dna_samples(user_id);

CREATE INDEX idx_comparison_samples
ON comparison_results(sample_1, sample_2);

-- ==============================
-- VIEW: lấy dữ liệu ADN đầy đủ 1 sample
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

-- User mẫu
INSERT INTO users (full_name, email, password)
VALUES 
('Nguyen Van A', 'a@test.com', '123456'),
('Nguyen Van B', 'b@test.com', '123456');

-- Thêm DNA SAMPLE cho mỗi user
INSERT INTO dna_samples (user_id, gender, test_date)
VALUES
(1, 'M', '2025-01-01'),
(2, 'M', '2025-01-01');

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

-- Kiểm tra dữ liệu (nếu đủ 16 dòng thì ok, nếu không đủ thì từ chối upload)
SELECT * FROM v_dna_sample_detail WHERE sample_id = 1;
SELECT * FROM v_dna_sample_detail WHERE sample_id = 2;


