const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
app.use(cors());

const db = mysql.createConnection({
    host: "localhost",
    user: 'root',   // your username goes here
    password: '1234',   // your password goes here
    database: "hospital"
})

app.get('/', (req, res) => {
    const sql = `select * from records`;
    db.query(sql, (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.post('/patient', async(req, res) => {
    const sql = `insert into patient (name, age, sex, phone) values (?)`;
    const values = [req.query.name, req.query.age, req.query.sex, req.query.phone];
    db.query(sql, [values], (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.post('/doctor', async(req, res) => {
    const sql = `insert into doctor (name, age, sex, specialisation, phone) values (?)`;
    const values = [req.query.name, req.query.age, req.query.sex, req.query.spec, req.query.phone];
    db.query(sql, [values], (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.post('/staff', async(req, res) => {
    const sql = `insert into staff (name, age, sex, phone, salary) values (?)`;
    const values = [req.query.name, req.query.age, req.query.sex, req.query.phone, req.query.salary];
    db.query(sql, [values], (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.post('/apt', async(req, res) => {
    const sql = req.query.apt === '' ? `INSERT INTO appointment (patient_id, doctor_id, apt_date, apt_time) values (?);`
    : `UPDATE appointment SET apt_date = ${req.query.date}, apt_time = ${req.query.time}
    WHERE appointment_id = ${req.query.apt};`;
    const values = [req.query.patient, req.query.doctor, req.query.date, req.query.time];
    db.query(sql, [values], (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.post('/diag', async(req, res) => {
    const sql = `insert into diagnosis (patient_id, doctor_id, result) values (?);`
    const values = [req.query.patient, req.query.doctor, req.query.result];
    db.query(sql, [values], (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.post('/record', async(req, res) => {
    const sql = `insert into records values (?);`
    const values = [req.query.patient, req.query.no, req.query.date, req.query.prob];
    db.query(sql, [values], (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.post('/room', async(req, res) => {
    const sql = req.query.room === '' ? `UPDATE room SET status = 'booked', 
    patient_id = ${req.query.patient}, 
    staff_id = ${req.query.staff}
    WHERE status = 'free'
    LIMIT 1;` : `UPDATE room SET status = 'free', 
    patient_id = null, 
    staff_id = null
    WHERE room_no = ${req.query.room}`;
    db.query(sql, (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.post('/bill', async(req, res) => {
    const sql = `call generate_bill (?)`;
    const values = [req.query.aptid, req.query.amt];
    db.query(sql, [values], (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.get('/doctors', (req, res) => {
    const sql = `call view_doctors()`;
    db.query(sql, (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.get('/patients', (req, res) => {
    const sql = `call view_medical_history()`;
    db.query(sql, (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.get('/doc_earn', (req, res) => {
    const sql = `SELECT SUM(amount) / 1.18 AS earning, doctor.doctor_id
    FROM bill 
    JOIN appointment ON bill.appointment_id = appointment.appointment_id 
    JOIN doctor on appointment.doctor_id = doctor.doctor_id
    GROUP BY doctor.doctor_id;`;
    db.query(sql, (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.get('/spec_earn', (req, res) => {
    const sql = `SELECT SUM(amount) / 1.18 as earning, doctor.specialisation
    FROM bill 
    JOIN appointment ON bill.appointment_id = appointment.appointment_id 
    JOIN doctor on appointment.doctor_id = doctor.doctor_id
    GROUP BY doctor.specialisation;`;
    db.query(sql, (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.get('/find_pat', (req, res) => {
    const sql = `SELECT DISTINCT patient.patient_id, patient.name, patient.age, patient.sex, patient.phone, doctor.doctor_id FROM
    patient JOIN appointment ON patient.patient_id = appointment.patient_id
    JOIN doctor ON appointment.doctor_id = doctor.doctor_id;`;
    db.query(sql, (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})

app.get('/fetch_diag', (req, res) => {
    const sql = `CALL fetch_diagnosis()`;
    db.query(sql, (err, data) => {
        if(err) return res.json(err);
        return res.json(data);
    })
})


app.listen(8081, () => {
    console.log("Server started on port 8081");
})