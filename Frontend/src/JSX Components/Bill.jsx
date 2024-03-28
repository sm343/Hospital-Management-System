import React from "react";
import "../CSS Components/Form.css";
import Navbar from "./Navbar";

export default function Bill() {
  const values = {
    aptid: "",
    amt: "",
  };

  const handleSubmit = async (evt) => {
    values.aptid = document.getElementById("aptid").value.trim();
    values.amt = document.getElementById("amt").value.trim();
    evt.preventDefault();
    await fetch(
      `http://localhost:8081/bill?aptid=${values.aptid}&amt=${values.amt}`,
      { method: "post" }
    )
      .then((res) => {
        res.json();
      })
      .then((data) => console.log(data))
      .catch((err) => console.log(err));
  };

  return (
    <div className="bill">
      <Navbar />
      <form onSubmit={handleSubmit}>
        <h1>Bill</h1>
        <div className="mb-3">
          <label htmlFor="aptid" className="form-label">
            Appointment ID
          </label>
          <input type="text" className="form-control" id="aptid" />
        </div>
        <div className="mb-3">
          <label htmlFor="amt" className="form-label">
            Amount*
          </label>
          <input type="number" className="form-control" id="amt" />
          <small>*plus 18% GST</small>
        </div>
        <button type="submit" className="btn btn-primary">
          Generate Bill
        </button>
      </form>
    </div>
  );
}
