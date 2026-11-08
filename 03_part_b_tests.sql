-- Saher Batool | shared Part B validation | 03_part_b_tests.sql
-- Contains an assessed committed UPDATE and a temporary INSERT/DELETE.
-- IMPORTANT: Requires the seeded data. Run only when you intend to show these results.
-- This changes followup 1 from Planned to Booked, matching the Part B evidence.
-- Does not delete existing patients.

-- TASK 11: CONTROLLED UPDATE (before/after screenshots)
USE crownfield_eye_hospital;
SELECT followup_id, status FROM followups WHERE followup_id=1;
START TRANSACTION;
UPDATE followups SET status='Booked' WHERE followup_id=1;
COMMIT;
SELECT followup_id, status FROM followups WHERE followup_id=1;


-- TASK 12: CONTROLLED DELETE (before/after screenshots)
USE crownfield_eye_hospital;
START TRANSACTION;
INSERT INTO patients(patient_id,full_name,postcode) VALUES ('OP999','Temporary Test','ZZ1 1ZZ');
SELECT * FROM patients WHERE patient_id='OP999';
DELETE FROM patients WHERE patient_id='OP999';
COMMIT;
SELECT COUNT(*) AS remaining_temporary_patients FROM patients WHERE patient_id='OP999';


-- TASK 13: FINAL VERIFICATION + TEST LOG EVIDENCE
USE crownfield_eye_hospital;
SELECT 'patients' AS table_name, COUNT(*) AS row_count FROM patients
UNION ALL SELECT 'specialties', COUNT(*) FROM specialties
UNION ALL SELECT 'clinics', COUNT(*) FROM clinics
UNION ALL SELECT 'clinicians', COUNT(*) FROM clinicians
UNION ALL SELECT 'appointments', COUNT(*) FROM appointments
UNION ALL SELECT 'diagnoses', COUNT(*) FROM diagnoses
UNION ALL SELECT 'medicines', COUNT(*) FROM medicines
UNION ALL SELECT 'prescriptions', COUNT(*) FROM prescriptions
UNION ALL SELECT 'prescription_items', COUNT(*) FROM prescription_items
UNION ALL SELECT 'followups', COUNT(*) FROM followups;

-- Demonstrate the original Appendix 1 appointments and linked data
SELECT a.appointment_id, p.full_name AS patient, c.full_name AS clinician,
       cl.clinic_name, a.appointment_date, a.appointment_time, d.diagnosis_text
FROM appointments a JOIN patients p ON a.patient_id=p.patient_id
JOIN clinicians c ON a.clinician_id=c.clinician_id
JOIN clinics cl ON a.clinic_id=cl.clinic_id
LEFT JOIN diagnoses d ON a.appointment_id=d.appointment_id
WHERE a.appointment_id BETWEEN 1 AND 5 ORDER BY a.appointment_id;

-- Expected zero rows with missing required parents
SELECT COUNT(*) AS orphan_appointments FROM appointments a
LEFT JOIN patients p ON a.patient_id=p.patient_id
LEFT JOIN clinicians c ON a.clinician_id=c.clinician_id
LEFT JOIN clinics l ON a.clinic_id=l.clinic_id
WHERE p.patient_id IS NULL OR c.clinician_id IS NULL OR l.clinic_id IS NULL;
SELECT COUNT(*) AS orphan_prescription_items FROM prescription_items i
LEFT JOIN prescriptions p ON p.prescription_id=i.prescription_id
LEFT JOIN medicines m ON m.medicine_id=i.medicine_id
WHERE p.prescription_id IS NULL OR m.medicine_id IS NULL;
SELECT followup_id, status FROM followups WHERE followup_id=1;
SELECT COUNT(*) AS temporary_patient_remaining FROM patients WHERE patient_id='OP999';


