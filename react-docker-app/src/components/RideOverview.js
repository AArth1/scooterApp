import React, { useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import mapboxgl from 'mapbox-gl';
import './RideOverview.css'; // Import the CSS file for styling

mapboxgl.accessToken = '/*REPLACE WITH YOUR MAPBOX ACCESS TOKEN*/';

function calculateDistance(startLocation, endLocation){
  const toRadians = (degrees) => degrees * (Math.PI / 180);
  const R = 3958.8; // Radius of the Earth in miles
  const [lat1, lon1] = startLocation;
  const [lat2, lon2] = endLocation;

  const dLat = toRadians(lat2 - lat1);
  const dLon = toRadians(lon2 - lon1);

  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) *
            Math.sin(dLon / 2) * Math.sin(dLon / 2);

  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  return R * c; // Distance in miles
} 

function RideOverview() {
  const location = useLocation();
  const navigate = useNavigate();
  const { rideData } = location.state;

  const { startLocation, endLocation, path, cost, /*distance,*/ battery } = rideData;

  useEffect(() => {
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/dark-v11',
      center: startLocation,
      zoom: 20,
    });

    const startel = document.createElement('div');
    startel.className = 'start-scooter-marker';

    const endel = document.createElement('div'); 
    endel.className = 'end-scooter-marker';

    new mapboxgl.Marker(startel)
      .setLngLat(startLocation)
      .addTo(map);

    new mapboxgl.Marker(endel)
      .setLngLat(endLocation)
      .addTo(map);

    map.on('load', () => {
      map.addSource('route', {
        type: 'geojson',
        data: {
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'LineString',
            coordinates: path,
          },
        },
      });

      map.addLayer({
        id: 'route',
        type: 'line',
        source: 'route',
        layout: {
          'line-join': 'round',
          'line-cap': 'round',
        },
        paint: {
          'line-color': '#bcacf9', // Changed to purple
          'line-width': 4,
        },
      });
    });
  }, [startLocation, endLocation, path]);

  const handleNewRide = () => {
    navigate('/scooter-map');
  };

  const traveldistance = calculateDistance(startLocation, endLocation).toFixed(2);

  return (
    <div className="ride-overview-container">
      <div id="map" className="map-container"></div>
      <div className="ride-details">
        <h2>Ride Overview</h2>
        <p>Total Cost: ${cost}</p>
        <p>Total Distance: {traveldistance} miles</p>
        <p>Ending Battery Level: {battery}%</p>
        <button onClick={handleNewRide}>New Ride</button>
      </div>
    </div>
  );
}

export default RideOverview;

