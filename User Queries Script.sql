-- DO NOT RUN THE QUERIES DEFINING THE TRIGGERS AND PROCEDURES AS THOSE ARE ALREADY DEFINED IN THE DATABASE SCRIPT

-- query 1
INSERT INTO doctor VALUES ('Nitin', 47, 'Male', 'heart', 9876543210);

-- query 2
INSERT INTO records VALUES (12, 2, '2023-04-06', 'fever');

-- query 3
INSERT INTO staff VALUES ('Priya', 29, 'Female', 9829104820, 1000000);

-- query 4
-- book appointment on the basis of doctor specialisation, find the first free doctor
INSERT INTO appointment (patient_id, doctor_id, apt_date, apt_time)
(SELECT 12, doctor.doctor_id, '2023-04-06', '16:00:00'
FROM doctor LEFT JOIN appointment 
ON doctor.doctor_id = appointment.doctor_id 
WHERE (specialisation = 'HEART' 
AND apt_date IS NULL AND apt_time IS NULL)
LIMIT 1);

-- query 5
-- reschedule appointment
UPDATE appointment SET apt_date = '2023-04-07', apt_time = '17:00:00'
WHERE appointment_id = 1;

-- query 6
-- book room and update status
UPDATE room SET status = 'booked', 
patient_id = 12, 
staff_id = 12
WHERE status = 'free'
LIMIT 1;

-- query 7
-- allot room to staff member
UPDATE room SET
staff_id = 10
WHERE room_no = 4;

select * from room;

-- query 8
-- generate bill, this is used in the procedure defined below
INSERT INTO bill (appointment_id, amount) VALUES (15, 1500);

INSERT INTO pays (receipt_no, patient_id) 
(SELECT COUNT(receipt_no) + 1 AS count, 12 FROM pays);

-- query 8
-- for generating bill, this adds data in both bill and pays table simultaneously
DELIMITER | 
CREATE TRIGGER add_gst BEFORE INSERT ON bill
FOR EACH ROW BEGIN
SET new.amount = new.amount * 1.18;
END;
|

DELIMITER |
CREATE PROCEDURE GENERATE_BILL(IN APPOINTMENT_ID INT, AMOUNT FLOAT)
BEGIN
insert into bill (appointment_id, amount) values(APPOINTMENT_ID, AMOUNT);
INSERT INTO pays (patient_id)
select patient_id FROM
appointment
WHERE appointment_id = appointment.appointment_id;
END;
|
DELIMITER ;

call generate_bill(8, 2400);
select * from bill;

-- query 10
-- for viewing all the doctors
CREATE PROCEDURE view_doctors()
SELECT * FROM doctor;

CALL view_doctors();

-- query 11
-- view the records of each patient
CREATE PROCEDURE view_medical_history()
SELECT * FROM patient LEFT JOIN records
ON patient.patient_id = records.patient_id;

CALL view_medical_history();

-- query 12
-- calculate the doctor earning based on the amount paid by patients for their appointments and subtract the amount added due to gst
CREATE PROCEDURE doctor_earnings(IN id INT)
SELECT SUM(amount) / 1.18 
FROM bill 
JOIN appointment ON bill.appointment_id = appointment.appointment_id 
JOIN doctor on appointment.doctor_id = doctor.doctor_id
WHERE id = doctor.doctor_id;

CALL doctor_earnings(1);

-- query 13
-- earnings categorized by specialisation, calculated similar to previous one
CREATE PROCEDURE specialisation_earnings(IN specialisation VARCHAR(255))
SELECT SUM(amount) / 1.18
FROM bill 
JOIN appointment ON bill.appointment_id = appointment.appointment_id 
JOIN doctor on appointment.doctor_id = doctor.doctor_id
WHERE specialisation = doctor.specialisation;

CALL specialisation_earnings('heart');

-- query 14
-- find patients who are treated by a specific doctor by joining appointment, patient and doctor tables
CREATE PROCEDURE find_patients(IN id INT)
SELECT DISTINCT patient.patient_id, patient.name, patient.age, patient.sex, patient.phone FROM
patient JOIN appointment ON patient.patient_id = appointment.patient_id
JOIN doctor ON appointment.doctor_id = doctor.doctor_id
WHERE doctor.doctor_id = id;

CALL find_patients(1);

-- query 15
-- fetch all the records stored in the diagnosis table
CREATE PROCEDURE fetch_diagnosis()
SELECT * FROM diagnosis;

CALL fetch_diagnosis();