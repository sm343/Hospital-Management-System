-- -----------------------------------------create hospital database-------------------------------------------
CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

-- --------------------------------------------tables definitions----------------------------------------------
CREATE TABLE IF NOT EXISTS patient (
patient_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
age INT NOT NULL,
sex CHAR(6) NOT NULL,
phone BIGINT NOT NULL CHECK (phone >= 1000000000 AND phone < 10000000000));

CREATE TABLE IF NOT EXISTS doctor (
doctor_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
age INT NOT NULL,
sex CHAR(6) NOT NULL,
specialisation varchar(15) NOT NULL,
phone BIGINT NOT NULL CHECK (phone >= 1000000000 AND phone < 10000000000));

CREATE TABLE IF NOT EXISTS staff (
staff_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
age INT NOT NULL,
sex CHAR(6) NOT NULL,
phone BIGINT NOT NULL CHECK (phone >= 1000000000 AND phone < 10000000000),
salary BIGINT NOT NULL);

CREATE TABLE IF NOT EXISTS room (
room_no INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
status CHAR(6) NOT NULL,
patient_id INT UNIQUE,
staff_id INT UNIQUE,
FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id));

CREATE TABLE IF NOT EXISTS records (
patient_id INT NOT NULL,
record_no INT NOT NULL,
date_of_examination DATE NOT NULL,
problem VARCHAR(255) NOT NULL,
PRIMARY KEY (patient_id, record_no),
FOREIGN KEY (patient_id) REFERENCES patient(patient_id));

CREATE TABLE IF NOT EXISTS appointment (
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
appointment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
apt_date DATE NOT NULL,
apt_time TIME NOT NULL,
FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id));

CREATE TABLE IF NOT EXISTS diagnosis (
diagnosis_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
result VARCHAR(255) NOT NULL,
FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id));

CREATE TABLE IF NOT EXISTS bill (
receipt_no INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
appointment_id INT NOT NULL,
amount FLOAT NOT NULL,
FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id));

CREATE TABLE IF NOT EXISTS pays (
receipt_no INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
patient_id INT NOT NULL,
FOREIGN KEY (receipt_no) REFERENCES bill(receipt_no),
FOREIGN KEY (patient_id) REFERENCES patient(patient_id));

-- --------------------------------------------------TRIGGERS--------------------------------------------------
-- add 18% gst before adding the row in the bill
DELIMITER | 
CREATE TRIGGER add_gst BEFORE INSERT ON bill
FOR EACH ROW BEGIN
SET new.amount = new.amount * 1.18;
END;
|
DELIMITER;

-- ------------------------------------------------PROCEDURES-----------------------------------------------
-- for generating bill, this adds data in both bill and pays table simultaneously
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
DELIMITER;

-- for viewing all the doctors
DELIMITER |
CREATE PROCEDURE view_doctors()
BEGIN
SELECT * FROM doctor;
END;
|
DELIMITER;

-- view the records of each patient
DELIMITER |
CREATE PROCEDURE view_medical_history()
BEGIN
SELECT * FROM patient LEFT JOIN records
ON patient.patient_id = records.patient_id;
END;
|
DELIMITER;

-- calculate the doctor earning based on the amount paid by patients for their appointments and subtract the amount added due to gst
DELIMITER |
CREATE PROCEDURE doctor_earnings(IN id INT)
BEGIN
SELECT SUM(amount) / 1.18
FROM bill 
JOIN appointment ON bill.appointment_id = appointment.appointment_id 
JOIN doctor on appointment.doctor_id = doctor.doctor_id
WHERE id = doctor.doctor_id;
END;
|
DELIMITER;

-- earnings categorized by specialisation, calculated similar to previous one
DELIMITER |
CREATE PROCEDURE specialisation_earnings(IN specialisation VARCHAR(255))
BEGIN
SELECT SUM(amount) / 1.18
FROM bill 
JOIN appointment ON bill.appointment_id = appointment.appointment_id 
JOIN doctor on appointment.doctor_id = doctor.doctor_id
WHERE specialisation = doctor.specialisation;
END;
|
DELIMITER;

-- find patients who are treated by a specific doctor by joining appointment, patient and doctor tables
DELIMITER |
CREATE PROCEDURE find_patients(IN id INT)
BEGIN
SELECT DISTINCT patient.patient_id, patient.name, patient.age, patient.sex, patient.phone FROM
patient JOIN appointment ON patient.patient_id = appointment.patient_id
JOIN doctor ON appointment.doctor_id = doctor.doctor_id
WHERE doctor.doctor_id = id;
END;
|
DELIMITER;

-- fetch all the records stored in the diagnosis table
DELIMITER |
CREATE PROCEDURE fetch_diagnosis()
BEGIN
SELECT * FROM diagnosis;
END;
|

DELIMITER ;

-- -----------------------------------ADD PATIENTS-----------------------------------------
insert into patient (name, age, sex, phone) VALUES ( 'Sanjeev' , 20 , 'male' ,8757740706);
insert into patient (name, age, sex, phone) values ( 'Vaibhav' , 29 , 'male' ,9767778987);
insert into patient (name, age, sex, phone) values ( 'Urvashi' , 34 , 'female' ,9757740777);
insert into patient (name, age, sex, phone) values ( 'Anirudh' , 43, 'male' ,6957740756);
insert into patient (name, age, sex, phone) values ( 'Adya' , 54 , 'female' ,6787740799);
insert into patient (name, age, sex, phone) values ( 'Jay' , 71 , 'male' ,8750007026);
insert into patient (name, age, sex, phone) values ( 'Adrija' , 47 , 'female' ,8657440760);
insert into patient (name, age, sex, phone) values ( 'Aliya' , 12 , 'female' ,7797740768);
insert into patient (name, age, sex, phone) values ( 'Harsh' , 67 , 'male' ,7757748806);
insert into patient (name, age, sex, phone) values ( 'Akash' , 45 , 'male' ,9877740706);
insert into patient (name, age, sex, phone) values ( 'Purvi' , 13 , 'female' ,8757706876);
insert into patient (name, age, sex, phone) values ( 'Deepak' , 19 , 'male' ,8757890769);
insert into patient (name, age, sex, phone) values ( 'Shreya' , 78 , 'female' ,7740707656);
insert into patient (name, age, sex, phone) values ( 'Kavin' , 64 , 'male' ,7896547078);
insert into patient (name, age, sex, phone) values ( 'Atharv' , 35 , 'male' ,7434242306);
insert into patient (name, age, sex, phone) values ( 'Priyanka' , 39 , 'female' ,8757894098);
insert into patient (name, age, sex, phone) values ( 'Tanisha' , 41 , 'female' ,7466707706);
insert into patient (name, age, sex, phone) values ( 'Anshika' , 53 , 'female' ,9878778706);
insert into patient (name, age, sex, phone) values ( 'Aditya' , 25 , 'male' ,9875740768);
insert into patient (name, age, sex, phone) values ( 'Aryan' , 17 , 'others' ,8897740709);
insert into patient (name, age, sex, phone) values ( 'Ojas' , 58 , 'male' ,7898706766);
insert into patient (name, age, sex, phone) values ( 'Kriti' , 46 , 'female' ,9994070665);
insert into patient (name, age, sex, phone) values ( 'Sourav' , 22 , 'male' ,8997740886);
insert into patient (name, age, sex, phone) values ( 'Lavanya' , 26 , 'female' ,7574006877);
insert into patient (name, age, sex, phone) values ( 'Mrinal' , 47 , 'others' ,9999070676);
insert into patient (name, age, sex, phone) values ( 'Deepika' , 92 , 'female' ,9898675676);
insert into patient (name, age, sex, phone) values ( 'Pratyush' , 83 , 'male' ,6787656786);
insert into patient (name, age, sex, phone) values ( 'Anushka' , 36 , 'female' ,6350602942);
insert into patient (name, age, sex, phone) values ( 'Apul' , 55 , 'male' ,8987663170);
insert into patient (name, age, sex, phone) values ( 'Sheetal' , 42 , 'female' ,8987880656);

-- -----------------------------------------ADD DOCTORS-------------------------------------------
insert into doctor (name, age, sex, specialisation, phone) values ('Vikas',40,'male', 'heart' ,8293445689);
insert into doctor (name, age, sex, specialisation, phone) values ('Suman',39,'female', 'skin' ,6355667987);
insert into doctor (name, age, sex, specialisation, phone) values ('Apurv',28,'male', 'neuro' ,9987878735);
insert into doctor (name, age, sex, specialisation, phone) values ('Bhavna',32,'female', 'neuro' ,8987445690);
insert into doctor (name, age, sex, specialisation, phone) values ('Tanmay',46,'male', 'stomach' ,7760895585);
insert into doctor (name, age, sex, specialisation, phone) values ('Virat',40,'male', 'dental' ,9834567894);
insert into doctor (name, age, sex, specialisation, phone) values ('Sonam',36,'female', 'heart' ,8943785689);
insert into doctor (name, age, sex, specialisation, phone) values ('Mamta',35,'female', 'eyes' ,7768189585);

-- -------------------------------------ADD STAFF-----------------------------------------
insert into staff (name, age, sex, phone, salary) values ('Tony',24,'male',7787646568,340000);
insert into staff (name, age, sex, phone, salary) values ('Ravi',24,'male',8997646568,540000);
insert into staff (name, age, sex, phone, salary) values ('Mohan',24,'male',7797646999,230000);
insert into staff (name, age, sex, phone, salary) values ('Varun',24,'male',9987646568,120000);
insert into staff (name, age, sex, phone, salary) values ('Ritik',24,'male',7887666688,330000);
insert into staff (name, age, sex, phone, salary) values ('Sakshi',24,'female',8987646689,620000);
insert into staff (name, age, sex, phone, salary) values ('Umang',24,'male',6587646566,390000);
insert into staff (name, age, sex, phone, salary) values ('Rohan',24,'male',9887646577,370000);
insert into staff (name, age, sex, phone, salary) values ('Navya',24,'female',7667647996,510000);
insert into staff (name, age, sex, phone, salary) values ('Bharti',24,'female',6998607087,210000);
insert into staff (name, age, sex, phone, salary) values ('Manas',24,'male',7978776579,840000);
insert into staff (name, age, sex, phone, salary) values ('Akshat',24,'male',9898999642,440000);

-- ----------------------------------------ADD ROOMS---------------------------------------------
insert into room (status, patient_id, staff_id) values ('booked',14, 6);
insert into room (status, patient_id, staff_id) values ('booked',21, 9);
insert into room (status, patient_id, staff_id) values ('free',null, null);
insert into room (status, patient_id, staff_id) values ('booked',15, 12);
insert into room (status, patient_id, staff_id) values ('free',null, null);
insert into room (status, patient_id, staff_id) values ('free',null, null);
insert into room (status, patient_id, staff_id) values ('free',null, null);
insert into room (status, patient_id, staff_id) values ('booked',12, 4);
insert into room (status, patient_id, staff_id) values ('free',null, null);
insert into room (status, patient_id, staff_id) values ('free',null, null);

-- --------------------------------------------ADD RECORDS----------------------------------------------
insert into records values (12,1,'2022-04-13','cough problem');
insert into records values (12,2,'2023-07-23','blood pressure');
insert into records values (13,1,'2021-08-14','heart problem');
insert into records values (14,1,'2022-02-05','lung problem');
insert into records values (15,1,'2020-10-28','skin problem');
insert into records values (15,2,'2022-04-19','liver problem');
insert into records values (15,3,'2023-03-12','blood pressure');
insert into records values (16,1,'2022-04-30','skin problem');
insert into records values (17,1,'2022-04-12','blood pressure');
insert into records values (18,1,'2022-05-07','stomach ache');
insert into records values (18,2,'2023-09-06','cough problem');
insert into records values (21,1,'2023-01-09','stomach ach');
insert into records values (19,1,'2023-01-13','blood pressure');
insert into records values (27,1,'2022-11-23','liver problem');
insert into records values (21,2,'2022-12-26','cough problem');
insert into records values (21,3,'2023-02-24','heart problem');
insert into records values (12,3,'2021-05-06','eye problem');
insert into records values (11,1,'2020-06-30','dental problem');
insert into records values (11,2,'2021-07-21','skin problem');
insert into records values (11,3,'2023-03-05','liver problem');
insert into records values (30,1,'2023-04-04','heart problem');
insert into records values (2,1,'2022-10-10','cough problem');
insert into records values (2,2,'2023-08-15','skin problem');
insert into records values (3,1,'2023-04-14','lung problem');
insert into records values (11,4,'2023-02-11','stomach ache');
insert into records values (11,5,'2023-09-26','spinal problem');
insert into records values (22,1,'2023-04-15','ligament injury');
insert into records values (22,2,'2023-11-30','dental problem');
insert into records values (19,2,'2023-05-19','stomach ache');
insert into records values (27,2,'2022-05-14','blood pressure');
insert into records values (27,3,'2023-12-04','blood pressure');

 -- ----------------------------------------------BOOK APPOINTMENTS--------------------------------------------------
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(12,1,'2023-04-06','10:30:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(13,1,'2023-05-23','11:15:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(15,2,'2023-04-12','10:50:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(21,2,'2023-06-14','09:40:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(7,2,'2023-06-26','08:20:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(21,4,'2023-05-16','17:30:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(11,1,'2023-06-27','18:15:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(30,7,'2023-04-05','16:30:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(26,5,'2023-07-28','17:35:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(8,1,'2023-08-10','16:50:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(27,6,'2023-09-22','17:25:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(12,1,'2023-06-17','10:20:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(15,4,'2023-07-01','11:45:00');
insert into appointment (patient_id, doctor_id, apt_date, apt_time) values(15,2,'2023-07-30','09:05:00');

-- ----------------------------------------ADD DIAGNOSIS DATA-------------------------------------------------
insert into diagnosis (patient_id, doctor_id, result) values ( 12,1,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 13,1,'pending');
insert into diagnosis (patient_id, doctor_id, result) values ( 15,2,'pending');
insert into diagnosis (patient_id, doctor_id, result) values ( 21,2,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 7,2,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 21,4,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 11,1,'pending');
insert into diagnosis (patient_id, doctor_id, result) values ( 30,7,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 8,1,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 8,1,'pending');
insert into diagnosis (patient_id, doctor_id, result) values ( 27,6,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 12,1,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 15,4,'successful');
insert into diagnosis (patient_id, doctor_id, result) values ( 15,2,'successful');

-- ------------------------------------------GENERATE BILLS----------------------------------------------
CALL generate_bill(1,2400);
CALL generate_bill(2,400);
CALL generate_bill(3,204);
CALL generate_bill(4,2000);
CALL generate_bill(5,500);
CALL generate_bill(6,700);
CALL generate_bill(7,864);
CALL generate_bill(8,4578);
CALL generate_bill(9,2345);
CALL generate_bill(10,2401);
CALL generate_bill(11,1234);
CALL generate_bill(12,5678);