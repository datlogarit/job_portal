CREATE DATABASE jobPortal;

CREATE TABLE users(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50) DEFAULT '',
    phone_number VARCHAR(20) DEFAULT '',
    dob DATE DEFAULT '1970-01-01',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    role ENUM('admin', 'applicant', 'recruiter') NOT NULL,
    url_avatar VARCHAR,
    is_active TINYINT DEFAULT 1
);
CREATE TABLE applicants(
    id BIGINT PRIMARY KEY,
    resume VARCHAR(255) DEFAULT '',
    gender VARCHAR(30) DEFAULT '',
    working_time VARCHAR(255) DEFAULT '',
    profession VARCHAR(255) DEFAULT '',
    desired_position VARCHAR(255) DEFAULT '',
    desired_location VARCHAR(255) DEFAULT '',
    work_experience VARCHAR(255) DEFAULT '',
    FOREIGN KEY (id) REFERENCES users(id)
);

CREATE TABLE companys(
    id BIGINT PRIMARY KEY AUTO_INCREMENT ,
    company_name VARCHAR(50) NOT NULL,
    company_location VARCHAR(100) NOT NULL,
    introduction VARCHAR(255) NOT NULL,
    url_avatar VARCHAR(255),
    hotline VARCHAR(255) UNIQUE,
    is_active TINYINT DEFAULT 0
);

CREATE TABLE recruiters(
    id BIGINT PRIMARY KEY,
    company_id BIGINT,
    is_verify TINYINT DEFAULT 0,
    number_of_post INT DEFAULT 0,
    position VARCHAR(255),
    FOREIGN KEY (id) REFERENCES users(id), 
    FOREIGN KEY (company_id) REFERENCES companys(id)
);

CREATE TABLE categories(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);


