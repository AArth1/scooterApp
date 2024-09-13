import React from 'react';
import { Link } from 'react-router-dom';
import './Home.css';

function Home() {
  return (
    <div className="home-container">
      <h1 className="title">Scooti</h1>
      <h2 className="subheading">City Exploration Made Easy</h2>
      <div className="button-container">
        <Link to="/login" className="btn login-btn">
          <button className="login-button">Login</button>
        </Link>
        <Link to="/register" className="btn register-btn">
          <button className="register-button">Sign Up</button>
        </Link>
      </div>
      <div className="scooter-container">
        <svg className="scooter" fill="#ffffff" height="188px" width="188px" version="1.1" id="Icons" viewBox="0 0 32.00 32.00" xmlSpace="preserve" stroke="#ffffff" strokeWidth="0.00032">
              <g id="SVGRepo_bgCarrier" strokeWidth="0"/>
              <g id="SVGRepo_tracerCarrier" strokeLinecap="round" strokeLinejoin="round"/>
              <g id="SVGRepo_iconCarrier">
              <path d="M28.2,21L25,4.8C24.9,4.3,24.5,4,24,4h-3c-0.6,0-1,0.4-1,1s0.4,1,1,1h2.2l2.1,10.4c0,0-0.1,0.1-0.1,0.1L20.4,24h-9.5 c-0.5-3.4-3.4-6-6.9-6c-0.6,0-1,0.4-1,1s0.4,1,1,1c2.4,0,4.4,1.7,4.9,4h-1c-0.4-1.7-2-3-3.9-3c-2.2,0-4,1.8-4,4s1.8,4,4,4 c1.9,0,3.4-1.3,3.9-3H21c0.3,0,0.7-0.2,0.8-0.5l4-6.3l0.4,2.2c-1.3,0.6-2.3,2-2.3,3.6c0,2.2,1.8,4,4,4s4-1.8,4-4 C32,22.9,30.3,21.1,28.2,21z"/>
            </g>
          </svg>
      </div>
    </div>
  );
}

export default Home;
