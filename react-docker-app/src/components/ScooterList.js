//do not need it
import React, { useEffect, useRef } from 'react';
import './ScooterList.css';
import scooterData from './scooter-list.json';
import { useSharedState } from './SharedStateContext';
import UnlockRideButton from './UnlockRideButton';

const ScooterList = () => {
  const { selectedItemId, setSelectedItemId } = useSharedState();
  
  // Create refs for each feature
  const itemRefs = useRef({});
  scooterData.features.forEach(feature => {
    itemRefs.current[feature.properties.ID] = React.createRef();
  });

  useEffect(() => {
    // If an item is selected, scroll it into view
    if (selectedItemId && itemRefs.current[selectedItemId]) {
      itemRefs.current[selectedItemId].current.scrollIntoView({
        behavior: 'smooth',
        block: 'nearest',
        inline: 'start'
      });
    }
  }, [selectedItemId]);

  const handleItemClick = (id) => {
    // Toggle between selected and not-selected
    setSelectedItemId(selectedItemId === id ? null : id);
  };

  return (
    <div className="scooter-list">
      {scooterData.features.map((feature) => (
        <div 
          key={feature.properties.ID} 
          ref={itemRefs.current[feature.properties.ID]} // Assign ref here
          className={`card ${selectedItemId === feature.properties.ID ? 'expanded' : ''}`}
          onClick={() => handleItemClick(feature.properties.ID)}
        >
          <h2>{feature.properties.title}</h2>
          <p>Battery: {feature.properties.battery}%</p>
          <p>Distance: {feature.properties.distance}</p>
          {selectedItemId === feature.properties.ID && (
            <div className="additional-info">
              <p>Price: ${feature.properties.price}</p>
              <p>Range: {feature.properties.range} miles</p>
              <UnlockRideButton/>
            </div>
          )}
        </div>
      ))}
    </div>
  );
};

export default ScooterList;
