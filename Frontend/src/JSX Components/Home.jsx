import React from 'react'
import '../CSS Components/Home.css'
import Navbar from './Navbar'
import { Link } from 'react-router-dom'

export default function Home() {
  return (
    <div className='home'>
      <Navbar />
        <div className="options">
        <Link to='/patient'><button type="button" className="btn btn-light">Add Patient</button></Link>
        <Link to='/doctor'><button type="button" className="btn btn-light">Add Doctor</button></Link>
        <Link to='/staff'><button type="button" className="btn btn-light">Add Staff</button></Link>
        </div>
    </div>
  )
}
