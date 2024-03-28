import React from "react";
import "../CSS Components/Form.css";
import Navbar from "./Navbar";

export default function Room() {
  const values = {
    apt: "",
    patient: "",
    doctor: "",
    date: "",
    time: "",
  };

  const handleSubmit1 = async (evt) => {
    values.patient = document.getElementById("patient").value.trim();
    values.doctor = document.getElementById("doctor").value.trim();
    values.date = document.getElementById("date").value.trim();
    values.time = document.getElementById("time").value.trim() + ':00';
    evt.preventDefault();

    await fetch(
      `http://localhost:8081/apt?apt=${values.apt}&patient=${values.patient}&doctor=${values.doctor}&date=${values.date}&time=${values.time}`,
      { method: "post" }
    )
      .then((res) => {
        res.json();
      })
      .then((data) => console.log(data))
      .catch((err) => console.log(err));
  };

  const handleSubmit2 = async (evt) => {
    values.apt = document.getElementById("apt").value.trim();
    values.date = document.getElementById("date").value.trim();
    values.time = document.getElementById("time").value.trim() + ':00';
    evt.preventDefault();

    await fetch(
      `http://localhost:8081/apt?apt=${values.apt}&patient=${values.patient}&doctor=${values.doctor}&date=${values.date}&time=${values.time}`,
      { method: "post" }
    )
      .then((res) => {
        res.json();
      })
      .then((data) => console.log(data))
      .catch((err) => console.log(err));
  };

  return (
    <div className="room">
      <Navbar />
      <div className="forms">
      <form onSubmit={handleSubmit1}>
        <h1>Book</h1>
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
          <label htmlFor="date" className="form-label">
            Date
          </label>
          <input type="date" className="form-control" id="date" />
        </div>

        <div className="mb-3">
          <label htmlFor="time" className="form-label">
            Time
          </label>
          <input type="time" className="form-control" id="time" />
        </div>

        <button type="submit" className="btn btn-primary">
          Book Appointment
        </button>
      </form>

      <form onSubmit={handleSubmit2}>
        <h1>Reschedule</h1>
        <div className="mb-3">
          <label htmlFor="apt" className="form-label">
            Appointment ID
          </label>
          <input type="number" className="form-control" id="apt" />
        </div>

        <div className="mb-3">
          <label htmlFor="date" className="form-label">
            Date
          </label>
          <input type="date" className="form-control" id="date" />
        </div>

        <div className="mb-3">
          <label htmlFor="time" className="form-label">
            Time
          </label>
          <input type="time" className="form-control" id="time" />
        </div>

        <button type="submit" className="btn btn-primary">
          Reschedule Appointment
        </button>
      </form>
      </div>
    </div>
  );
}
