-- Saher Batool | CPU4:103 | Crownfield Eye Hospital
-- 01_schema.sql  | MySQL 8.0.16+ (recommended MySQL 8.4)
-- Source: shared Part B relational implementation.
-- This file does not DROP the database. Run on a fresh/empty instance.
-- It will fail if tables already exist: do not overwrite your assessed data.

CREATE DATABASE IF NOT EXISTS crownfield_eye_hospital
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE crownfield_eye_hospital;

-- Table 1/10: specialties
CREATE TABLE specialties (
 specialty_id INT PRIMARY KEY,
 specialty_name VARCHAR(80) NOT NULL UNIQUE
);

-- Table 2/10: clinics
CREATE TABLE clinics (
 clinic_id INT PRIMARY KEY,
 clinic_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table 3/10: patients
CREATE TABLE patients (
 patient_id CHAR(5) PRIMARY KEY,
 full_name VARCHAR(100) NOT NULL,
 postcode VARCHAR(12) NOT NULL
);

-- Table 4/10: clinicians
CREATE TABLE clinicians (
 clinician_id INT PRIMARY KEY,
 full_name VARCHAR(100) NOT NULL,
 specialty_id INT NOT NULL,
 CONSTRAINT fk_clinician_specialty FOREIGN KEY (specialty_id) REFERENCES specialties(specialty_id)
);

-- Table 5/10: medicines
CREATE TABLE medicines (
 medicine_id INT PRIMARY KEY,
 medicine_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table 6/10: appointments
CREATE TABLE appointments (
 appointment_id INT PRIMARY KEY,
 patient_id CHAR(5) NOT NULL,
 clinician_id INT NOT NULL,
 clinic_id INT NOT NULL,
 appointment_date DATE NOT NULL,
 appointment_time TIME NOT NULL,
 notes VARCHAR(255),
 CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
 CONSTRAINT fk_appointment_clinician FOREIGN KEY (clinician_id) REFERENCES clinicians(clinician_id),
 CONSTRAINT fk_appointment_clinic FOREIGN KEY (clinic_id) REFERENCES clinics(clinic_id),
 CONSTRAINT uq_clinician_slot UNIQUE (clinician_id, appointment_date, appointment_time),
 CONSTRAINT uq_clinic_slot UNIQUE (clinic_id, appointment_date, appointment_time)
);

-- Additional appointment-date validation from Part B ALTER TABLE task
ALTER TABLE appointments ADD CONSTRAINT ck_appointment_year CHECK (appointment_date >= '2020-01-01');

-- Table 7/10: diagnoses
CREATE TABLE diagnoses (
 diagnosis_id INT PRIMARY KEY,
 appointment_id INT NOT NULL,
 diagnosis_text VARCHAR(200) NOT NULL,
 CONSTRAINT fk_diagnosis_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Table 8/10: prescriptions
CREATE TABLE prescriptions (
 prescription_id INT PRIMARY KEY,
 appointment_id INT NOT NULL,
 issued_date DATE NOT NULL,
 CONSTRAINT fk_prescription_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Table 9/10: prescription_items
CREATE TABLE prescription_items (
 prescription_id INT NOT NULL,
 medicine_id INT NOT NULL,
 dose VARCHAR(100) NOT NULL,
 route VARCHAR(50) NOT NULL,
 frequency VARCHAR(80) NOT NULL,
 duration_days SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY (prescription_id, medicine_id),
 CONSTRAINT ck_duration_positive CHECK (duration_days > 0),
 CONSTRAINT fk_item_prescription FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id),
 CONSTRAINT fk_item_medicine FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- Table 10/10: followups
CREATE TABLE followups (
 followup_id INT PRIMARY KEY,
 appointment_id INT NOT NULL UNIQUE,
 due_date DATE NOT NULL,
 priority ENUM('Routine','High','Urgent') NOT NULL DEFAULT 'Routine',
 status ENUM('Planned','Booked','Completed','Cancelled') NOT NULL DEFAULT 'Planned',
 CONSTRAINT fk_followup_appointment FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Inspect the complete schema in MySQL Workbench
SHOW TABLES;
