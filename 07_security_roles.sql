-- Saher Batool | individual Part D | 07_security_roles.sql
-- Saher's allocated work is D1: defining four roles and checking their grants.
-- Requires MySQL administrative permission to CREATE ROLE / GRANT.
-- No plaintext passwords are included, and no login accounts are created.
-- The patient role deliberately has no direct table access in the demonstrated state.
USE crownfield_eye_hospital;

-- D1: Four application roles and least privilege
CREATE ROLE IF NOT EXISTS
  'cf_admin'@'%',
  'cf_doctor'@'%',
  'cf_receptionist'@'%',
  'cf_patient'@'%';

-- Administrator: application database only, not global privileges.
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, INDEX,
      REFERENCES, EXECUTE, CREATE VIEW, SHOW VIEW,
      CREATE ROUTINE, ALTER ROUTINE, TRIGGER
ON crownfield_eye_hospital.* TO 'cf_admin'@'%';

-- Doctor: read patient context, maintain clinical records.
GRANT SELECT ON crownfield_eye_hospital.patients TO 'cf_doctor'@'%';
GRANT SELECT ON crownfield_eye_hospital.appointments TO 'cf_doctor'@'%';
GRANT SELECT ON crownfield_eye_hospital.clinicians TO 'cf_doctor'@'%';
GRANT SELECT ON crownfield_eye_hospital.clinics TO 'cf_doctor'@'%';
GRANT SELECT ON crownfield_eye_hospital.specialties TO 'cf_doctor'@'%';
GRANT SELECT ON crownfield_eye_hospital.medicines TO 'cf_doctor'@'%';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.diagnoses TO 'cf_doctor'@'%';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.prescriptions TO 'cf_doctor'@'%';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.prescription_items TO 'cf_doctor'@'%';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.followups TO 'cf_doctor'@'%';

-- Receptionist: patient and appointment administration, limited follow-up update.
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.patients TO 'cf_receptionist'@'%';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.appointments TO 'cf_receptionist'@'%';
GRANT SELECT ON crownfield_eye_hospital.clinics TO 'cf_receptionist'@'%';
GRANT SELECT ON crownfield_eye_hospital.clinicians TO 'cf_receptionist'@'%';
GRANT SELECT ON crownfield_eye_hospital.specialties TO 'cf_receptionist'@'%';
GRANT SELECT, UPDATE (status) ON crownfield_eye_hospital.followups TO 'cf_receptionist'@'%';

-- Patient role intentionally receives NO direct base-table access.
-- It will receive SELECT on a filtered view in D3.

-- SCREENSHOT D1: Run each SHOW GRANTS, capture results.
SHOW GRANTS FOR 'cf_admin'@'%';
SHOW GRANTS FOR 'cf_doctor'@'%';
SHOW GRANTS FOR 'cf_receptionist'@'%';
SHOW GRANTS FOR 'cf_patient'@'%';


