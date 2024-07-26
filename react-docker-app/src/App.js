/* to do: 
styling of all pages (basic text, etc)
home page styling
DONE-- marker styling (scooter icons hehe)
login and register logic
forgot password logic
ride overview/cost/distance logic
user profile page
make distance from scooter accurate depending on user location, order based on location
scooter filtering??
issue reporting*/
import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Home from './components/Home';
import Register from './components/Register';
import Login from './components/Login';
import ScooterMap from './components/ScooterMap';
import RideProgress from './components/RideProgress';
import RideOverview from './components/RideOverview';
import './styles.css';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/register" element={<Register />} />
        <Route path="/login" element={<Login />} />
        <Route path="/scooter-map" element={<ScooterMap />} />
        <Route path="/ride-progress" element={<RideProgress />} />
        <Route path="/ride-overview" element={<RideOverview />} />
      </Routes>
    </Router>
  );
}

export default App;

