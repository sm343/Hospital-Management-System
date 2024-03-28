import React from "react";
import "../CSS Components/Form.css";
import Navbar from "./Navbar";

export default function Room() {
  const values = {
    room: "",
    patient: "",
    staff: "",
  };

  const handleSubmit1 = async (evt) => {
    values.patient = document.getElementById("patient").value.trim();
    values.staff = document.getElementById("staff").value.trim();
    evt.preventDefault();

    await fetch(
      `http://localhost:8081/room?room=${values.room}&patient=${values.patient}&staff=${values.staff}`,
      { method: "post" }
    )
      .then((res) => {
        res.json();
      })
      .then((data) => console.log(data))
      .catch((err) => console.log(err));
  };

  const handleSubmit2 = async (evt) => {
    values.room = document.getElementById("room").value.trim();
    evt.preventDefault();

    await fetch(
      `http://localhost:8081/room?room=${values.room}&patient=${values.patient}&staff=${values.staff}`,
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
          <label htmlFor="staff" className="form-label">
            Staff ID
          </label>
          <input type="number" className="form-control" id="staff" />
        </div>

        <button type="submit" className="btn btn-primary">
          Book Room
        </button>
      </form>
      <form onSubmit={handleSubmit2}>
        <h1>Free</h1>
        <div className="mb-3">
          <label htmlFor="room" className="form-label">
            Room No
          </label>
          <input type="number" className="form-control" id="room" />
        </div>

        <button type="submit" className="btn btn-primary">
          Free Room
        </button>
      </form>
      </div>
    </div>
  );
}
