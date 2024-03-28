import React from "react";
import "../CSS Components/Form.css";
import Navbar from "./Navbar";

export default function Diagnosis() {
  const values = {
    patient: "",
    doctor: "",
    result: "",
  };

  const handleSubmit = async (evt) => {
    values.patient = document.getElementById("patient").value.trim();
    values.doctor = document.getElementById("doctor").value.trim();
    values.result = document.getElementById("result").value.trim();
    evt.preventDefault();
    await fetch(
      `http://localhost:8081/diag?patient=${values.patient}&doctor=${values.doctor}&result=${values.result}`,
      { method: "post" }
    )
      .then((res) => {
        res.json();
      })
      .then((data) => console.log(data))
      .catch((err) => console.log(err));
  };

  return (
    <div className="diagnosis">
      <Navbar />
      <form onSubmit={handleSubmit}>
        <h1>Diagnosis</h1>
        <div className="mb-3">
          <label htmlFor="patient" className="form-label">
            Patient ID
          </label>
          <input type="number" className="form-control" id="patient" />
        </div>
        <div className="mb-3">
          <label htmlFor="doctor" className="form-label">
            Doctor ID
          </label>
          <input type="number" className="form-control" id="doctor" />
        </div>
        <div className="mb-3">
          <label htmlFor="result" className="form-label">
            Result
          </label>
          <input type="text" className="form-control" id="result" />
        </div>
        <button type="submit" className="btn btn-primary">
          Submit
        </button>
      </form>
    </div>
  );
}
