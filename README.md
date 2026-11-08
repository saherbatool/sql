# Crownfield Eye Hospital Database — Saher Batool

**CPU4:103 – Introduction to Database | Individual code repository**

This repository accompanies Saher Batool's Parts A–D report for the **fictional** Crownfield Eye Hospital. It contains the shared relational database schema and teaching dataset, Saher's individual Part C SQL, Saher's assigned Part D role-permission work, and the two ER diagrams **extracted from Saher's submitted Word assignment**.

All patient and clinician information is synthetic teaching data. No real patient records or credentials are included.

## Entity relationship diagrams

**Conceptual model (Part A2)** — entities and cardinalities:

![Conceptual ER model](ERD/conceptual_model.png)

**Logical model (Part A3)** — attributes, keys and constraints:

![Logical ER model](ERD/logical_model.png)

The `ERD/*.mmd` files are editable Mermaid descriptions of the same relationships. The PNGs are the actual images embedded in the supplied Saher assignment. The Mermaid source represents the schema but is not the original editable artwork.

## Repository files and execution order

| Order | File | Purpose / notes |
| --- | --- | --- |
| 1 | [`01_schema.sql`](01_schema.sql) | Shared ten-table database DDL with primary/foreign keys, UNIQUE and CHECK constraints. **Fresh database only**. |
| 2 | [`02_seed_data.sql`](02_seed_data.sql) | Original Appendix 1 cases plus synthetic sample rows. Run **once**. |
| 3 | [`03_part_b_tests.sql`](03_part_b_tests.sql) | Shared Part B controlled UPDATE, DELETE and row-count/foreign-key checks. |
| 4 | [`04_individual_queries.sql`](04_individual_queries.sql) | Saher's C1–C4 SELECT features: GROUP BY/HAVING; five-table INNER JOIN; LEFT JOIN; subquery. |
| 5 | [`05_procedure_and_trigger.sql`](05_procedure_and_trigger.sql) | Saher's C5 parameterised stored procedure; C6 follow-up date trigger; positive rollback test. |
| 6 | [`06_trigger_negative_test.sql`](06_trigger_negative_test.sql) | **Run in separate steps** to deliberately provoke a follow-up-date error, then ROLLBACK. |
| 7 | [`07_security_roles.sql`](07_security_roles.sql) | Saher's D1 administrator, doctor, receptionist and patient roles; SHOW GRANTS evidence. |
| – | [`ERD/`](ERD/) | Conceptual and logical ERD images and editable Mermaid text. |

## MySQL setup

1. Use **MySQL 8.0.16 or later** (the DDL uses CHECK constraints; tested syntax targets MySQL 8.x). Open MySQL Workbench using an account with schema-creation privileges.
2. **Back up any existing `crownfield_eye_hospital` database.** This package is for a fresh teaching database. `01_schema.sql` deliberately does *not* drop existing tables; it should not be run over populated assessed work.
3. Run the numbered files in the order above. Use the lightning button in MySQL Workbench and check the **Result Grid** and **Action Output** after each stage.
4. The security file requires `CREATE ROLE` and `GRANT` privileges. Its grants target **roles**, not login accounts. `cf_patient` has no direct table SELECT access in Saher's original Part D evidence. The wider group's patient-specific view is **not** Saher's demonstrated work and is not represented as such here.
5. The routine uses `DELIMITER $$`; run its creation as a script in MySQL Workbench. To verify C5, run `CALL sp_saher_clinic_schedule(1);`. The screenshot in the uploaded report only shows procedure **creation**.
6. For C6 use `06_trigger_negative_test.sql` and follow its instructions **one statement block at a time**. The negative test is deliberately designed to produce a MySQL `SQLSTATE 45000` error. After capturing it, run `ROLLBACK` and the final verification queries.

### Seed data counts (expected, not independently executed here)

| Table | Expected rows |
| --- | ---: |
| specialties | 13 |
| clinics | 13 |
| patients | 16 |
| clinicians | 13 |
| medicines | 13 |
| appointments | 17 |
| diagnoses | 17 |
| prescriptions | 16 |
| prescription_items | 17 |
| followups | 17 |

Part B's controlled UPDATE sets follow-up 1 to `Booked` and commits that single assessed change. The temporary patient INSERT/DELETE leaves no patient `OP999` after COMMIT. Be careful: executing the scripts multiple times may produce duplicate-key errors.

## Individual contributions and assessment evidence

- **Part A:** data repetition and redundancy; master entities (Patients, Clinicians, Specialties, Clinics); UNF to 1NF reasoning.
- **Part B:** shared database set-up and the four master tables identified in the report. The full schema and synthetic dataset are included for reproducibility; the report attributes this work as collaborative.
- **Part C:** Saher's six SQL features. C1 returned City Road 4, Bedford 2, Croydon 2. C2 returned five original appointments. C3 found Parkside Clinic unused. C4 found Amina Yusuf visiting more than one clinic. The submitted screenshot for C5 verifies procedure creation but **not its CALL output**; C6 verifies trigger creation but **not rejection of an invalid due date**. The rollback screenshot shows the temporary valid row was removed.
- **Part D:** Saher's four role/grant verifications. The patient role initially has only `USAGE`, which is not evidence of patient-specific record access. Encryption work was allocated to another group member and is **not** claimed as Saher's own implementation here.

**Evidence status:** Source screenshots exist in the Word report; these SQL files were assembled and statically reviewed from the prior group/individual scripts, but no MySQL server execution was performed during packaging. Do not describe the outstanding C5/C6 checks as passed until you run and screenshot them.

## Original assessment and GitHub submission

Upload this folder's **contents** to an individual GitHub repository; keep the numbered filenames in the root and the `ERD` directory as-is. The assignment separately requires an individual DOCX report, presentation/recording, and a runnable repository. Do **not** upload secrets or passwords.

