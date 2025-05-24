CREATE DATABASE IF NOT EXISTS main;
USE main;

-- 1. student_info table
CREATE TABLE IF NOT EXISTS student_info (
    application_id VARCHAR(255) NOT NULL PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    is_temp TINYINT(1) DEFAULT 1,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(20),
    address VARCHAR(250),
    city VARCHAR(255),
    province VARCHAR(255),
    zip VARCHAR(10),
    birthdate DATE,
    gender ENUM('Male', 'Female'),
    civil_status ENUM('Single', 'Married', 'Divorced', 'Widowed'),
    last_school_attended VARCHAR(255),
    school_address VARCHAR(255),
    year_graduated YEAR,
    track_strand VARCHAR(100),
    general_average DECIMAL(5,2),
    first_choice VARCHAR(200),
    second_choice VARCHAR(200),
    third_choice VARCHAR(200),
    emergency_contact_name VARCHAR(255),
    emergency_contact_relationship VARCHAR(100),
    emergency_contact_number VARCHAR(20)
);

-- 2. doc_uploaded table
CREATE TABLE IF NOT EXISTS doc_uploaded (
    doc_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id VARCHAR(255) NOT NULL,
    doc_name VARCHAR(255) NOT NULL,
    doc_type VARCHAR(100),
    file_path VARCHAR(500),
    CONSTRAINT fk_doc_application FOREIGN KEY (application_id) REFERENCES student_info(application_id) ON DELETE CASCADE
);

-- 3. payments table
CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    application_id VARCHAR(255) NOT NULL,
    method VARCHAR(100),
    reference_number VARCHAR(100),
    amount DECIMAL(10,2),
    status VARCHAR(50),
    created_at DATETIME,
    CONSTRAINT fk_pay_application FOREIGN KEY (application_id) REFERENCES student_info(application_id) ON DELETE CASCADE
);

-- 4. exam table
CREATE TABLE IF NOT EXISTS exam (
    id INT AUTO_INCREMENT PRIMARY KEY,
    application_id VARCHAR(255) NOT NULL,
    exam_schedule DATE,
    CONSTRAINT fk_exam_application FOREIGN KEY (application_id) REFERENCES student_info(application_id) ON DELETE CASCADE
);

-- 5. messages table
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    application_id VARCHAR(255) NOT NULL,
    sender VARCHAR(50),
    message TEXT,
    created_at DATETIME,
    CONSTRAINT fk_msg_application FOREIGN KEY (application_id) REFERENCES student_info(application_id) ON DELETE CASCADE
);

-- Insert sample student_info
INSERT INTO student_info (application_id, password)
SELECT 'test', 'test'
WHERE NOT EXISTS (SELECT 1 FROM student_info WHERE application_id = 'test');

INSERT INTO student_info (application_id, password)
SELECT 'test1', 'test1'
WHERE NOT EXISTS (SELECT 1 FROM student_info WHERE application_id = 'test1');

INSERT INTO student_info (application_id, password)
SELECT 'test6', 'test6'
WHERE NOT EXISTS (SELECT 1 FROM student_info WHERE application_id = 'test6');

-- Insert sample payment
INSERT INTO payments (application_id, method, reference_number, amount, status, created_at)
SELECT 'test', 'PayMaya', '51510212120202120', 1000.00, 'pending', '2025-05-25 00:23:04'
WHERE NOT EXISTS (
    SELECT 1 FROM payments WHERE application_id = 'test' AND reference_number = '51510212120202120'
);

-- Insert sample exam schedule
INSERT INTO exam (application_id, exam_schedule)
SELECT 'test6', '2025-06-14'
WHERE NOT EXISTS (
    SELECT 1 FROM exam WHERE application_id = 'test6' AND exam_schedule = '2025-06-14'
);

-- Insert sample messages
INSERT INTO messages (application_id, sender, message, created_at)
SELECT 'test', 'user', 'What are the available payment methods?', '2025-05-20 21:58:44'
WHERE NOT EXISTS (
    SELECT 1 FROM messages WHERE application_id = 'test' AND message = 'What are the available payment methods?'
);

INSERT INTO messages (application_id, sender, message, created_at)
SELECT 'test1', 'user', 'What are the admission requirements?', '2025-05-21 16:44:44'
WHERE NOT EXISTS (
    SELECT 1 FROM messages WHERE application_id = 'test1' AND message = 'What are the admission requirements?'
);