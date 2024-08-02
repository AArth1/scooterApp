import React, { useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import mapboxgl from 'mapbox-gl';
import './RideOverview.css'; // Import the CSS file for styling

mapboxgl.accessToken = 'pk.eyJ1Ijoia2F0YWthbWEiLCJhIjoiY2x5cTR4aXYyMDBzbzJpcG43NXZvNTd5byJ9.nEGo9hPCJwE4SrmFaborZw';

function RideOverview() {
  const location = useLocation();
  const navigate = useNavigate();
  const { rideData } = location.state;

  const { startLocation, endLocation, path, cost, distance, battery } = rideData;

  useEffect(() => {
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/dark-v11',
      center: startLocation,
      zoom: 12,
    });

    const startel = document.createElement('div');
    startel.className = 'scooter-marker';
    const container = document.createElement('div');
    container.className = 'scooter-marker-container';
    container.appendChild(startel);

    new mapboxgl.Marker(startel)
      .setLngLat(startLocation)
      .addTo(map);

    new mapboxgl.Marker({ color: 'red' })
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
          'line-color': '#FFA500', // Changed to orange
          'line-width': 4,
        },
      });
    });
  }, [startLocation, endLocation, path]);

  const handleNewRide = () => {
    navigate('/scooter-map');
  };

  return (
    <div className="ride-overview-container">
      <div id="map" className="map-container"></div>
      <div className="ride-details">
        <h2>Ride Overview</h2>
        <p>Total Cost: ${cost}</p>
        <p>Total Distance: {distance} miles</p>
        <p>Ending Battery Level: {battery}%</p>
        <button onClick={handleNewRide}>New Ride</button>
      </div>
    </div>
  );
}

export default RideOverview;

