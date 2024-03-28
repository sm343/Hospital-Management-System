import React from "react";
import "../CSS Components/Form.css";
import '../CSS Components/Home.css'
import Navbar from "./Navbar";
import { Link } from 'react-router-dom'

export default function Admin() {

  return (
    <div className="admin">
      <Navbar />
      <div className="options">
        <a href="http://localhost:8081/doctors" target="_blank"><button type="button" className="btn btn-light">View Doctors</button></a>
        <a href="http://localhost:8081/patients" target="_blank"><button type="button" className="btn btn-light">View Patients</button></a>
        <a href="http://localhost:8081/doc_earn" target="_blank"><button type="button" className="btn btn-light">Doctor Earnings</button></a>
        <a href="http://localhost:8081/spec_earn" target="_blank"><button type="button" className="btn btn-light">Specialisation Earnings</button></a>
        <a href="http://localhost:8081/find_pat" target="_blank"><button type="button" className="btn btn-light">Find Patients</button></a>
        <a href="http://localhost:8081/fetch_diag" target="_blank"><button type="button" className="btn btn-light">View Diagnoses</button></a>
        </div>
    </div>
  )
}
