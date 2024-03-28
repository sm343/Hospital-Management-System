import React from "react";
import "../CSS Components/Form.css";
import Navbar from "./Navbar";

export default function Record() {
  const values = {
    patient: "",
    no: "",
    date: "",
    prob: "",
  };

  const handleSubmit = async (evt) => {
    values.patient = document.getElementById("patient").value.trim();
    values.no = document.getElementById("record").value.trim();
    values.date = document.getElementById("date").value.trim();
    values.prob = document.getElementById("problem").value.trim();
    evt.preventDefault();
    await fetch(
      `http://localhost:8081/record?patient=${values.patient}&no=${values.no}&date=${values.date}&prob=${values.prob}`,
      { method: "post" }
    )
      .then((res) => {
        res.json();
      })
      .then((data) => console.log(data))
      .catch((err) => console.log(err));
  };

  return (
    <div className="record">
      <Navbar />
      <form onSubmit={handleSubmit}>
        <h1>Record</h1>
        <div className="mb-3">
          <label htmlFor="patient" className="form-label">
            Patient ID
          </label>
          <input type="number" className="form-control" id="patient" />
        </div>
        <div className="mb-3">
          <label htmlFor="record" className="form-label">
            Record No
          </label>
          <input type="number" className="form-control" id="record" />
        </div>
        <div className="mb-3">
          <label htmlFor="date" className="form-label">
            Date of Examination
          </label>
          <input type="date" className="form-control" id="date" />
        </div>
        <div className="mb-3">
          <label htmlFor="problem" className="form-label">
            Problem
          </label>
          <input type="text" className="form-control" id="problem" />
        </div>
        <button type="submit" className="btn btn-primary">
          Submit
        </button>
      </form>
    </div>
  );
}
