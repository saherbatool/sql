-- Saher Part C | Trigger NEGATIVE validation (run separately)
-- Prerequisite: Run C6 from 05_procedure_and_trigger.sql successfully.
-- In MySQL Workbench run Step 1, then Step 2, screenshot the rejection,
-- then ALWAYS run Step 3 to undo the temporary appointment.
USE crownfield_eye_hospital;

-- STEP 1: insert one temporary valid appointment (highlight/run this block).
START TRANSACTION;
INSERT INTO appointments
    (appointment_id, patient_id, clinician_id, clinic_id,
     appointment_date, appointment_time, notes)
VALUES (9912, 'OP001', 1, 13, '2026-12-03', '16:55:00',
        'Temporary invalid follow-up trigger test');

-- STEP 2: highlight and execute ONLY the following INSERT.
-- It MUST fail with a user-defined SQLSTATE 45000 error because
-- the proposed follow-up due_date is BEFORE its appointment date.
-- Screenshot the statement AND the Action Output error message.
INSERT INTO followups
    (followup_id, appointment_id, due_date, priority, status)
VALUES (9912, 9912, '2026-12-02', 'Routine', 'Planned');

-- STEP 3: after taking the error screenshot, execute this block.
-- Do this even if Workbench halted when the INSERT was rejected.
ROLLBACK;
SELECT COUNT(*) AS temporary_appointments_remaining
FROM appointments WHERE appointment_id = 9912;
SELECT COUNT(*) AS invalid_followups_remaining
FROM followups WHERE followup_id = 9912;
-- Both counts should be 0. The trigger itself remains installed.
