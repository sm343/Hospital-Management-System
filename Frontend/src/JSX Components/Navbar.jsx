import React from 'react'
import { Link, BrowserRouter as Router } from 'react-router-dom'

export default function Navbar() {
    return (
        <nav className="navbar navbar-expand-lg bg-body-tertiary">
            <div className="container-fluid">
                <Link className="navbar-brand" to="/">Hospital Management System</Link>
                <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span className="navbar-toggler-icon"></span>
                </button>
                <div className="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div className="navbar-nav">
                        <Link className="nav-link" aria-current="page" to="/">Home</Link>
                        <Link className="nav-link" to="/appointment">Appointment</Link>
                        <Link className="nav-link" to="/diagnosis">Diagnosis</Link>
                        <Link className="nav-link" to="/record">Record</Link>
                        <Link className="nav-link" to="/room">Room</Link>
                        <Link className="nav-link" to="/bill">Bill</Link>
                        <Link className="nav-link" to="/admin">Admin</Link>
                    </div>
                </div>
            </div>
        </nav>
    )
}
