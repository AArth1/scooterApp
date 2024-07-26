//do not need it

// Import the scooterData from the JSON file
import scooterData from './scooter-list.json';
import React, { useState } from 'react';
import './UnlockRideButton.css'
import UnlockRidePopup from './UnlockPopup';
import './UnlockRidePopup.css'; // Make sure to create a corresponding CSS file for styling

// Parent component that will render the UnlockRidePopup
const UnlockRideButton = () => {
  const [showPopup, setShowPopup] = useState(false);

  // Function to handle closing the popup
  const handleClosePopup = () => {
    console.log("Closing popup");
    setShowPopup(false);
  };

  const handleButtonClick = () => {
    console.log("Showing popup");
    setShowPopup(true);
  };

  return (
    <div>
      {/* Button to show the popup */}
      <button onClick={handleButtonClick}>Unlock Ride</button>

      {/* Conditionally render the UnlockRidePopup component */}
      {showPopup && (
        <UnlockRidePopup
          scooterData={scooterData} // Pass the imported data as a prop
          onClose={handleClosePopup} // Pass the function to handle closing the popup
        />
      )}
    </div>
  );
};

export default UnlockRideButton;
