import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import './UnlockPopup.css';

function UnlockPopup({ scooter = {}, onClose }) {
  const [scooterCode, setScooterCode] = useState('');
  const [message, setMessage] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    console.log('Scooter object:', scooter);
  }, [scooter]);

  const handleUnlock = () => {
    if (scooterCode === scooter.ScooterCode && scooter.IsAvailable) {
      setMessage('Ride confirmed!');
      // Update the scooter's availability status
      scooter.IsAvailable = false;
      console.log('Scooter properties:', scooter);
    } else {
      setMessage('Scooter cannot be booked');
    }
  };

  const handleBeginRide = () => {
    navigate('/ride-progress');
  };

  return (
    <div className="unlock-popup">
      <button className="close-button" onClick={onClose}>X</button>
      <h2>Unlock Scooter</h2>
      <input 
        className = 'input'
        type="text" 
        placeholder="Enter Scooter Code" 
        value={scooterCode} 
        onChange={(e) => setScooterCode(e.target.value)} 
      />
      <button onClick={handleUnlock}>Confirm</button>
      <p>{message}</p>
      {message === 'Ride confirmed!' && <button onClick={handleBeginRide}>Begin Ride</button>}
    </div>
  );
}

export default UnlockPopup;

