-- Saher Batool | shared Part B dataset | 02_seed_data.sql
-- Run only once, after 01_schema.sql, on a newly created EMPTY schema.
-- Original five Appendix 1 appointments + coherent synthetic teaching data.
-- This file does not create, drop or delete tables.
USE crownfield_eye_hospital;

-- Populate specialties
INSERT INTO specialties (specialty_id, specialty_name) VALUES
 (1, 'Glaucoma'),
 (2, 'Retina'),
 (3, 'Cornea'),
 (4, 'Cataract'),
 (5, 'Paediatric Ophthalmology'),
 (6, 'Oculoplastics'),
 (7, 'Neuro-ophthalmology'),
 (8, 'Uveitis'),
 (9, 'Low Vision'),
 (10, 'Emergency Eye Care'),
 (11, 'Orthoptics'),
 (12, 'Ocular Oncology'),
 (13, 'Medical Retina');

-- Populate clinics
INSERT INTO clinics (clinic_id, clinic_name) VALUES
 (1, 'City Road'),
 (2, 'Bedford'),
 (3, 'Croydon'),
 (4, 'North Wing'),
 (5, 'South Wing'),
 (6, 'Westbrook'),
 (7, 'Eastgate'),
 (8, 'Riverside'),
 (9, 'Hillview'),
 (10, 'Central Clinic'),
 (11, 'Lakeside Clinic'),
 (12, 'Meadow Clinic'),
 (13, 'Parkside Clinic');

-- Populate patients
INSERT INTO patients (patient_id, full_name, postcode) VALUES
 ('OP001', 'Amina Yusuf', 'NE1 4AB'),
 ('OP002', 'Daniel Reed', 'N16 7QP'),
 ('OP003', 'Sofia Bennett', 'E8 2LD'),
 ('OP004', 'Michael Okoro', 'SE6 3RT'),
 ('OP005', 'Grace Evans', 'M1 2AB'),
 ('OP006', 'Oliver Khan', 'M2 3CD'),
 ('OP007', 'Noah Wilson', 'M3 4EF'),
 ('OP008', 'Isla Ahmed', 'M4 5GH'),
 ('OP009', 'Mia Carter', 'M5 6JK'),
 ('OP010', 'Leo Morgan', 'M6 7LM'),
 ('OP011', 'Ruby Patel', 'M7 8NP'),
 ('OP012', 'Ethan Brooks', 'M8 9QR'),
 ('OP013', 'Ella Scott', 'M9 1ST'),
 ('OP014', 'Adam Ali', 'M11 2UV'),
 ('OP015', 'Amelia Ford', 'M12 3AA'),
 ('OP016', 'Harry Clark', 'M13 4BB');

-- Populate clinicians
INSERT INTO clinicians (clinician_id, full_name, specialty_id) VALUES
 (1, 'Dr Maya Shah', 1),
 (2, 'Dr Leo Grant', 2),
 (3, 'Dr Priya Nair', 3),
 (4, 'Dr Aisha Malik', 4),
 (5, 'Dr James Turner', 5),
 (6, 'Dr Sarah Wong', 6),
 (7, 'Dr Nina Brown', 7),
 (8, 'Dr Omar Patel', 8),
 (9, 'Dr Emily Hughes', 9),
 (10, 'Dr Alex Green', 10),
 (11, 'Dr Zara Lewis', 11),
 (12, 'Dr Ibrahim Saeed', 12),
 (13, 'Dr Chloe Price', 13);

-- Populate medicines
INSERT INTO medicines (medicine_id, medicine_name) VALUES
 (1, 'Latanoprost'),
 (2, 'Timolol'),
 (3, 'Aflibercept'),
 (4, 'Sodium chloride drops'),
 (5, 'Dorzolamide'),
 (6, 'Brimonidine'),
 (7, 'Artificial tears'),
 (8, 'Prednisolone acetate'),
 (9, 'Ofloxacin'),
 (10, 'Cyclopentolate'),
 (11, 'Ketorolac drops'),
 (12, 'Hypromellose drops'),
 (13, 'Tropicamide');

-- Populate appointments
INSERT INTO appointments (appointment_id, patient_id, clinician_id, clinic_id, appointment_date, appointment_time, notes) VALUES
 (1, 'OP001', 1, 1, '2026-10-05', '09:00:00', 'Review IOP'),
 (2, 'OP002', 2, 1, '2026-10-05', '09:30:00', 'OCT before review'),
 (3, 'OP001', 1, 2, '2026-11-16', '10:15:00', 'Visual field test'),
 (4, 'OP003', 1, 1, '2026-10-06', '11:00:00', 'Monitor'),
 (5, 'OP004', 3, 3, '2026-10-07', '14:00:00', 'Corneal topography'),
 (6, 'OP005', 5, 6, '2026-11-07', '14:00:00', 'Synthetic scheduled review'),
 (7, 'OP006', 6, 7, '2026-11-08', '15:00:00', 'Synthetic scheduled review'),
 (8, 'OP007', 7, 8, '2026-11-09', '08:00:00', 'Synthetic scheduled review'),
 (9, 'OP008', 8, 9, '2026-11-10', '09:00:00', 'Synthetic scheduled review'),
 (10, 'OP009', 9, 10, '2026-11-11', '10:00:00', 'Synthetic scheduled review'),
 (11, 'OP010', 10, 1, '2026-11-12', '11:00:00', 'Synthetic scheduled review'),
 (12, 'OP011', 1, 2, '2026-11-13', '12:00:00', 'Synthetic scheduled review'),
 (13, 'OP012', 2, 3, '2026-11-14', '13:00:00', 'Synthetic scheduled review'),
 (14, 'OP013', 3, 4, '2026-11-15', '14:00:00', 'Synthetic scheduled review'),
 (15, 'OP014', 4, 5, '2026-11-16', '15:00:00', 'Synthetic scheduled review'),
 (16, 'OP015', 11, 11, '2026-11-17', '09:30:00', 'Orthoptics assessment'),
 (17, 'OP016', 12, 12, '2026-11-18', '10:30:00', 'Ocular oncology assessment');

-- Populate diagnoses
INSERT INTO diagnoses (diagnosis_id, appointment_id, diagnosis_text) VALUES
 (1, 1, 'Ocular hypertension'),
 (2, 2, 'Diabetic macular oedema'),
 (3, 3, 'Ocular hypertension'),
 (4, 4, 'Glaucoma suspect'),
 (5, 5, 'Keratoconus'),
 (6, 6, 'Dry eye syndrome'),
 (7, 7, 'Cataract'),
 (8, 8, 'Conjunctivitis'),
 (9, 9, 'Uveitis'),
 (10, 10, 'Retinal tear'),
 (11, 11, 'Blepharitis'),
 (12, 12, 'Myopia'),
 (13, 13, 'Macular degeneration'),
 (14, 14, 'Corneal abrasion'),
 (15, 15, 'Raised intraocular pressure'),
 (16, 16, 'Strabismus'),
 (17, 17, 'Choroidal lesion');

-- Populate prescriptions
INSERT INTO prescriptions (prescription_id, appointment_id, issued_date) VALUES
 (1, 1, '2026-10-05'),
 (2, 2, '2026-10-05'),
 (3, 3, '2026-11-16'),
 (4, 5, '2026-10-07'),
 (5, 6, '2026-11-07'),
 (6, 7, '2026-11-08'),
 (7, 8, '2026-11-09'),
 (8, 9, '2026-11-10'),
 (9, 10, '2026-11-11'),
 (10, 11, '2026-11-12'),
 (11, 12, '2026-11-13'),
 (12, 13, '2026-11-14'),
 (13, 14, '2026-11-15'),
 (14, 15, '2026-11-16'),
 (15, 16, '2026-11-17'),
 (16, 17, '2026-11-18');

-- Populate prescription_items
INSERT INTO prescription_items (prescription_id, medicine_id, dose, route, frequency, duration_days) VALUES
 (1, 1, '1 drop', 'Ophthalmic', 'Nightly', 42),
 (1, 2, '1 drop', 'Ophthalmic', 'Twice daily', 42),
 (2, 3, '2 mg', 'Intravitreal', 'As directed', 28),
 (3, 1, '1 drop', 'Ophthalmic', 'Nightly', 84),
 (4, 4, '1 drop', 'Ophthalmic', 'Four times daily', 56),
 (5, 6, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (6, 7, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (7, 8, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (8, 9, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (9, 10, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (10, 1, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (11, 2, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (12, 3, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (13, 4, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (14, 5, '1 drop', 'Ophthalmic', 'Twice daily', 28),
 (15, 11, '1 drop', 'Ophthalmic', 'As directed', 14),
 (16, 12, '1 drop', 'Ophthalmic', 'As directed', 14);

-- Populate followups
INSERT INTO followups (followup_id, appointment_id, due_date, priority, status) VALUES
 (1, 1, '2026-11-16', 'High', 'Planned'),
 (2, 2, '2026-11-02', 'Urgent', 'Planned'),
 (3, 3, '2027-02-08', 'Routine', 'Planned'),
 (4, 4, '2027-04-06', 'Routine', 'Planned'),
 (5, 5, '2026-12-02', 'Routine', 'Planned'),
 (6, 6, '2026-12-19', 'Routine', 'Planned'),
 (7, 7, '2026-12-06', 'Routine', 'Planned'),
 (8, 8, '2026-12-14', 'Routine', 'Planned'),
 (9, 9, '2026-12-22', 'Routine', 'Planned'),
 (10, 10, '2026-12-09', 'Routine', 'Planned'),
 (11, 11, '2026-12-17', 'Routine', 'Planned'),
 (12, 12, '2026-12-25', 'Routine', 'Planned'),
 (13, 13, '2026-12-12', 'Routine', 'Planned'),
 (14, 14, '2026-12-20', 'Routine', 'Planned'),
 (15, 15, '2026-12-28', 'Routine', 'Planned'),
 (16, 16, '2026-12-29', 'Routine', 'Planned'),
 (17, 17, '2026-12-30', 'High', 'Planned');

-- Check the number of records in each base table
SELECT 'specialties' AS table_name, COUNT(*) AS row_count FROM specialties
UNION ALL SELECT 'clinics', COUNT(*) FROM clinics
UNION ALL SELECT 'patients', COUNT(*) FROM patients
UNION ALL SELECT 'clinicians', COUNT(*) FROM clinicians
UNION ALL SELECT 'medicines', COUNT(*) FROM medicines
UNION ALL SELECT 'appointments', COUNT(*) FROM appointments
UNION ALL SELECT 'diagnoses', COUNT(*) FROM diagnoses
UNION ALL SELECT 'prescriptions', COUNT(*) FROM prescriptions
UNION ALL SELECT 'prescription_items', COUNT(*) FROM prescription_items
UNION ALL SELECT 'followups', COUNT(*) FROM followups;
