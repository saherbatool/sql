-- Saher Batool | individual Part C | 04_individual_queries.sql
-- Four SELECT queries from Saher's own Part C evidence.
-- Requires 01_schema.sql and 02_seed_data.sql.
-- No data is changed by this file.
USE crownfield_eye_hospital;

-- C1: Aggregate with GROUP BY and HAVING
-- Question: Which clinics have at least two appointments?
SELECT cl.clinic_id, cl.clinic_name,
       COUNT(a.appointment_id) AS total_appointments
FROM clinics AS cl
INNER JOIN appointments AS a ON a.clinic_id = cl.clinic_id
GROUP BY cl.clinic_id, cl.clinic_name
HAVING COUNT(a.appointment_id) >= 2
ORDER BY total_appointments DESC, cl.clinic_name;
-- With the original Part B seed: City Road 4, Bedford 2, Croydon 2.

-- C2: INNER JOIN across five related tables
-- Question: Which patient saw which clinician and specialty at each original visit?
SELECT a.appointment_id, p.full_name AS patient,
       c.full_name AS clinician, s.specialty_name,
       cl.clinic_name, a.appointment_date, a.appointment_time
FROM appointments AS a
INNER JOIN patients AS p ON p.patient_id = a.patient_id
INNER JOIN clinicians AS c ON c.clinician_id = a.clinician_id
INNER JOIN specialties AS s ON s.specialty_id = c.specialty_id
INNER JOIN clinics AS cl ON cl.clinic_id = a.clinic_id
WHERE a.appointment_id BETWEEN 1 AND 5
ORDER BY a.appointment_id;
-- With the original seed: five records from Appendix 1.

-- C3: LEFT JOIN for missing related rows
-- Question: Which clinics currently have no appointments?
SELECT cl.clinic_id, cl.clinic_name,
       COUNT(a.appointment_id) AS total_appointments
FROM clinics AS cl
LEFT JOIN appointments AS a ON a.clinic_id = cl.clinic_id
GROUP BY cl.clinic_id, cl.clinic_name
HAVING COUNT(a.appointment_id) = 0
ORDER BY cl.clinic_name;
-- With the original seed: Parkside Clinic (clinic_id 13).

-- C4: Subquery
-- Question: Which patients have attended more than one clinic location?
SELECT p.patient_id, p.full_name
FROM patients AS p
WHERE p.patient_id IN (
    SELECT a.patient_id
    FROM appointments AS a
    GROUP BY a.patient_id
    HAVING COUNT(DISTINCT a.clinic_id) > 1
)
ORDER BY p.patient_id;
-- With the original seed: OP001 Amina Yusuf (City Road and Bedford).

