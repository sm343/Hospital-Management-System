import React from "react";
import "../CSS Components/Form.css";
import Navbar from "./Navbar";

export default function Doctor() {
  const values = {
    name: "",
    age: "",
    sex: "",
    spec: "",
    phone: "",
  };

  const handleSubmit = async (evt) => {
    values.name = document.getElementById("name").value.trim();
    values.age = document.getElementById("age").value.trim();
    values.phone = document.getElementById("phone").value.trim();
    values.spec = document.getElementById("spec").value.trim();
    values.sex = document.querySelector('input[name="sex"]:checked').value;
    evt.preventDefault();
    await fetch(
      `http://localhost:8081/doctor?name=${values.name}&age=${values.age}&spec=${values.spec}&sex=${values.sex}&phone=${values.phone}`,
      { method: "post" }
    )
      .then((res) => {
        res.json();
      })
      .then((data) => console.log(data))
      .catch((err) => console.log(err));
  };

  return (
    <div className="doctor">
      <Navbar />
      <form onSubmit={handleSubmit}>
        <h1>Add Doctor</h1>
        <div className="mb-3">
          <label htmlFor="name" className="form-label">
            Name
          </label>
          <input type="text" className="form-control" id="name" />
        </div>
        <div className="mb-3">
          <label htmlFor="age" className="form-label">
            Age
          </label>
          <input type="number" className="form-control" id="age" />
        </div>
        <div className="mb-3">
          <label htmlFor="spec" className="form-label">
            Specialisation
          </label>
          <input type="text" className="form-control" id="spec" />
        </div>

        <div className="form-check">
          <input
            className="form-check-input"
            type="radio"
            name="sex"
            value="male"
            id="male"
          />
          <label className="form-check-label" htmlFor="male">
            Male
          </label>
        </div>
        <div className="form-check">
          <input
            className="form-check-input"
            type="radio"
            name="sex"
            value="female"
            id="female"
          />
          <label className="form-check-label" htmlFor="female">
            Female
          </label>
        </div>
        <div className="form-check">
          <input
            className="form-check-input"
            type="radio"
            name="sex"
            value="others"
            id="others"
          />
          <label className="form-check-label" htmlFor="others">
            Others
          </label>
        </div>

        <div className="mb-3">
          <label htmlFor="phone" className="form-label">
            Phone no
          </label>
          <input type="number" className="form-control" id="phone" />
        </div>
        <button type="submit" className="btn btn-primary">
          Submit
        </button>
      </form>
    </div>
  );
}
