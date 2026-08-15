-- =========================================================
-- Project: Hospital Management System
-- Author: Mokhtar Houssien
-- Database: Oracle Database 12c / SQL*Plus
-- =========================================================

-- 1. Create Tables (DDL)
CREATE TABLE DEPARTMENTS (
    dept_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dept_name VARCHAR2(50) NOT NULL UNIQUE,
    location VARCHAR2(50) NOT NULL,
    budget NUMBER(12, 2) CHECK (budget > 0)
);

CREATE TABLE DOCTORS (
    doc_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    doc_name VARCHAR2(60) NOT NULL,
    specialty VARCHAR2(50) NOT NULL,
    phone NUMBER(9) UNIQUE,
    hire_date DATE DEFAULT SYSDATE,
    dept_id NUMBER REFERENCES DEPARTMENTS(dept_id)
);

CREATE TABLE PATIENTS (
    patient_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_name VARCHAR2(60) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    age NUMBER(3) CHECK (age BETWEEN 0 AND 120),
    phone NUMBER(9) UNIQUE,
    address VARCHAR2(50)
);

CREATE TABLE APPOINTMENTS (
    app_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_id NUMBER REFERENCES PATIENTS(patient_id),
    doc_id NUMBER REFERENCES DOCTORS(doc_id),
    app_date DATE DEFAULT SYSDATE,
    status VARCHAR2(20) CHECK (status IN ('Scheduled', 'Completed', 'Cancelled'))
);

CREATE TABLE ROOMS (
    room_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number VARCHAR2(10) NOT NULL UNIQUE,
    room_type VARCHAR2(30) CHECK (room_type IN ('ICU', 'General', 'Private', 'Operating')),
    capacity NUMBER(2) DEFAULT 1 CHECK (capacity > 0),
    dept_id NUMBER REFERENCES DEPARTMENTS(dept_id)
);

-- 2. Insert Data (DML)
INSERT INTO DEPARTMENTS (dept_name, location, budget) VALUES ('Cardiology', 'Building A - Floor 2', 500000);
INSERT INTO DEPARTMENTS (dept_name, location, budget) VALUES ('Pediatrics', 'Building B - Floor 1', 300000);
INSERT INTO DEPARTMENTS (dept_name, location, budget) VALUES ('Surgery', 'Building C - Floor 3', 750000);

INSERT INTO DOCTORS (doc_name, specialty, phone, dept_id) VALUES ('Dr. Ali Al-Sabri', 'Cardiologist', 771111111, 1);
INSERT INTO DOCTORS (doc_name, specialty, phone, dept_id) VALUES ('Dr. Sara Ahmed', 'Pediatrician', 772222222, 2);
INSERT INTO DOCTORS (doc_name, specialty, phone, dept_id) VALUES ('Dr. Khaled Omar', 'General Surgeon', 773333333, 3);

INSERT INTO PATIENTS (patient_name, gender, age, phone, address) VALUES ('Mokhtar Houssien', 'M', 20, 774444444, 'Sanaa - Hadda');
INSERT INTO PATIENTS (patient_name, gender, age, phone, address) VALUES ('Amal Mohammed', 'F', 35, 775555555, 'Sanaa - Sixty St');
INSERT INTO PATIENTS (patient_name, gender, age, phone, address) VALUES ('Youssef Hassan', 'M', 10, 776666666, 'Sanaa - Al-Zubairi');

INSERT INTO APPOINTMENTS (patient_id, doc_id, status) VALUES (1, 1, 'Completed');
INSERT INTO APPOINTMENTS (patient_id, doc_id, status) VALUES (2, 3, 'Scheduled');
INSERT INTO APPOINTMENTS (patient_id, doc_id, status) VALUES (3, 2, 'Scheduled');

INSERT INTO ROOMS (room_number, room_type, capacity, dept_id) VALUES ('R-101', 'Private', 1, 1);
INSERT INTO ROOMS (room_number, room_type, capacity, dept_id) VALUES ('R-102', 'General', 4, 2);
INSERT INTO ROOMS (room_number, room_type, capacity, dept_id) VALUES ('OR-1', 'Operating', 2, 3);

COMMIT;

-- 3. Queries (SELECT & JOIN)
SELECT P.PATIENT_NAME, D.DOC_NAME, A.APP_DATE, A.STATUS
FROM APPOINTMENTS A
JOIN PATIENTS P ON A.PATIENT_ID = P.PATIENT_ID
JOIN DOCTORS D ON A.DOC_ID = D.DOC_ID;
