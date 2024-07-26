import React from 'react';
import { useNavigate } from 'react-router-dom';

function EndRidePopup({ onClose, rideData }) {
  const navigate = useNavigate();

  const handleConfirm = () => {
    // Add any logic to end the ride here
    navigate('/ride-overview', { state: { rideData } });
  };

  return (
    <div className="end-ride-popup">
      <h2>End Ride</h2>
      <p>Ending the ride will lock the scooter.</p>
      <button onClick={onClose}>Exit</button>
      <button onClick={handleConfirm}>Confirm</button>
    </div>
  );
}

export default EndRidePopup;
