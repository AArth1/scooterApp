// import React, { useState } from 'react';
// import './UnlockRidePopup.css'; // Make sure to create a corresponding CSS file for styling

// const UnlockRidePopup = ({ scooterData, onClose }) => {
//   const [inputValue, setInputValue] = useState('');
//   const [rideConfirmed, setRideConfirmed] = useState(false);

//   console.log("UnlockRidePopup rendered");

//   const handleInputChange = (e) => {
//     setInputValue(e.target.value);
//   };

//   const handleConfirm = () => {
//     const matchingScooter = scooterData.features.find(
//       (feature) => feature.properties.ID === inputValue
//     );

//     if (matchingScooter) {
//       setRideConfirmed(true);
//     }
//   };

//   return (
//     <div className="unlock-ride-popup">
//       {rideConfirmed ? (
//         <>
//           <p>Ride confirmed!</p>
//           <button onClick={onClose}>Exit</button>
//         </>
//       ) : (
//         <>
//           <input
//             type="text"
//             placeholder="Enter scooter ID"
//             value={inputValue}
//             onChange={handleInputChange}
//           />
//           <button onClick={handleConfirm}>Confirm</button>
//           <button onClick={onClose}>Exit</button>
//         </>
//       )}
//     </div>
//   );
// };

// export default UnlockRidePopup;

/* import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './UnlockPopup.css'; // Import the CSS file for styling

function UnlockPopup({ scooter, onClose }) {
  const [scooterID, setScooterID] = useState('');
  const [message, setMessage] = useState('');
  const navigate = useNavigate();

  const handleUnlock = () => {
    if (scooterID === scooter.ID && !scooter.isBooked) {
      setMessage('Ride confirmed!');
      scooter.isBooked = true;
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
      <input type="text" placeholder="Enter Scooter ID" value={scooterID} onChange={(e) => setScooterID(e.target.value)} />
      <button onClick={handleUnlock}>Confirm</button>
      <p>{message}</p>
      {message === 'Ride confirmed!' && <button onClick={handleBeginRide}>Begin Ride</button>}
    </div>
  );
}

export default UnlockPopup; */

import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './UnlockPopup.css'; // Import the CSS file for styling

function UnlockPopup({ scooter, onClose }) {
  const [scooterID, setScooterID] = useState('');
  const [message, setMessage] = useState('');
  const navigate = useNavigate();

  const handleUnlock = () => {
    if (scooterID === scooter.ID && !scooter.isBooked) {
      setMessage('Ride confirmed!');
      scooter.isBooked = true;
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
      <input type="text" placeholder="Enter Scooter ID" value={scooterID} onChange={(e) => setScooterID(e.target.value)} />
      <button onClick={handleUnlock}>Confirm</button>
      <p>{message}</p>
      {message === 'Ride confirmed!' && <button onClick={handleBeginRide}>Begin Ride</button>}
    </div>
  );
}

export default UnlockPopup;
