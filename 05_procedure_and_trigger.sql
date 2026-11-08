-- Saher Batool | individual Part C | 05_procedure_and_trigger.sql
-- C5: stored procedure with an input parameter
-- C6: follow-up date validation trigger
-- Includes a temporary valid follow-up test, undone with ROLLBACK.
-- Both routines are from Saher's original Part C script.
USE crownfield_eye_hospital;

-- C5: Stored procedure with one input parameter
-- Question: What is the scheduled appointment list for a chosen clinic?
DROP PROCEDURE IF EXISTS sp_saher_clinic_schedule;
DELIMITER $$
CREATE PROCEDURE sp_saher_clinic_schedule(IN p_clinic_id INT)
READS SQL DATA
BEGIN
    SELECT a.appointment_id, a.appointment_date, a.appointment_time,
           cl.clinic_name, p.full_name AS patient,
           c.full_name AS clinician, s.specialty_name
    FROM appointments AS a
    INNER JOIN clinics AS cl ON cl.clinic_id = a.clinic_id
    INNER JOIN patients AS p ON p.patient_id = a.patient_id
    INNER JOIN clinicians AS c ON c.clinician_id = a.clinician_id
    INNER JOIN specialties AS s ON s.specialty_id = c.specialty_id
    WHERE a.clinic_id = p_clinic_id
    ORDER BY a.appointment_date, a.appointment_time;
END$$
DELIMITER ;

-- Screenshot C5: routine creation + actual output from CALL
SHOW CREATE PROCEDURE sp_saher_clinic_schedule;
CALL sp_saher_clinic_schedule(1);
-- With the original seed: four appointments at City Road.

-- C6: Trigger enforcing a clinical follow-up date rule
-- Question: Can the database prevent follow-ups being scheduled before the visit?
DROP TRIGGER IF EXISTS trg_saher_followup_due_date;
DELIMITER $$
CREATE TRIGGER trg_saher_followup_due_date
BEFORE INSERT ON followups
FOR EACH ROW
BEGIN
    DECLARE v_appointment_date DATE DEFAULT NULL;
    SELECT a.appointment_date INTO v_appointment_date
    FROM appointments AS a
    WHERE a.appointment_id = NEW.appointment_id;

    IF v_appointment_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A valid appointment is required for follow-up';
    ELSEIF NEW.due_date < v_appointment_date THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Follow-up due date cannot be before appointment date';
    END IF;
END$$
DELIMITER ;

-- Screenshot C6a: confirm the trigger has been created.
SHOW TRIGGERS FROM crownfield_eye_hospital LIKE 'followups';

-- Screenshot C6b: a VALID new appointment + follow-up succeeds.
-- ROLLBACK ensures the test leaves no permanent rows.
START TRANSACTION;
INSERT INTO appointments
    (appointment_id, patient_id, clinician_id, clinic_id,
     appointment_date, appointment_time, notes)
VALUES (9911, 'OP001', 1, 13, '2026-12-03', '16:40:00',
        'Temporary valid follow-up trigger test');
INSERT INTO followups
    (followup_id, appointment_id, due_date, priority, status)
VALUES (9911, 9911, '2026-12-10', 'Routine', 'Planned');
SELECT f.followup_id, a.appointment_date, f.due_date, f.status
FROM followups AS f
INNER JOIN appointments AS a ON a.appointment_id = f.appointment_id
WHERE f.followup_id = 9911;
ROLLBACK;
SELECT COUNT(*) AS remaining_valid_test_followups
FROM followups WHERE followup_id = 9911;
-- Expected remaining_valid_test_followups = 0 after rollback.

-- IMPORTANT: use the separate 02_Saher_Trigger_Rejection_Test.sql
-- to prove that the trigger rejects a backdated due_date.
