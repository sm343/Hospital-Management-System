import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";
import './index.css'
import Patient from './JSX Components/Patient';
import Doctor from './JSX Components/Doctor';
import Staff from './JSX Components/Staff';
import Bill from './JSX Components/Bill';
import Appointment from './JSX Components/Appointment';
import Room from './JSX Components/Room';
import Diagnosis from './JSX Components/Diagnosis';
import Admin from './JSX Components/Admin';
import Record from './JSX Components/Record';

const router = createBrowserRouter([
  {
    path: "/",
    element: <App />,
  },
  {
    path: "/patient",
    element: <Patient />,
  },
  {
    path: "/doctor",
    element: <Doctor />,
  },
  {
    path: "/staff",
    element: <Staff />,
  },
  {
    path: "/appointment",
    element: <Appointment />,
  },
  {
    path: "/diagnosis",
    element: <Diagnosis />,
  },
  {
    path: "/record",
    element: <Record />,
  },
  {
    path: "/bill",
    element: <Bill />,
  },
  {
    path: "/room",
    element: <Room />,
  },
  {
    path: "/admin",
    element: <Admin />,
  },
]);

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>,
)
