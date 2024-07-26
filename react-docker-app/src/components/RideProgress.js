import React, { useState, useEffect, useRef } from 'react';
import mapboxgl from 'mapbox-gl';
import EndRidePopup from './EndRidePopup';

mapboxgl.accessToken = 'pk.eyJ1Ijoia2F0YWthbWEiLCJhIjoiY2x5cTR4aXYyMDBzbzJpcG43NXZvNTd5byJ9.nEGo9hPCJwE4SrmFaborZw';

function RideProgress() {
  const [userLocation, setUserLocation] = useState([0, 0]);
  const [startLocation, setStartLocation] = useState([0, 0]);
  const [path, setPath] = useState([]);
  const [timer, setTimer] = useState(0);
  const [showEndRidePopup, setShowEndRidePopup] = useState(false);
  const mapRef = useRef(null);

  useEffect(() => {
    navigator.geolocation.getCurrentPosition((position) => {
      const { latitude, longitude } = position.coords;
      setUserLocation([longitude, latitude]);
      setStartLocation([longitude, latitude]);
      setPath([[longitude, latitude]]);
    });

    const interval = setInterval(() => {
      setTimer((prev) => prev + 1);
      navigator.geolocation.getCurrentPosition((position) => {
        const { latitude, longitude } = position.coords;
        setUserLocation([longitude, latitude]);
        setPath((prev) => [...prev, [longitude, latitude]]);
      });
    }, 1000);

    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    if (userLocation[0] !== 0 && !mapRef.current) {
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/navigation-night-v1',
        center: userLocation,
        zoom: 12,
      });

      new mapboxgl.Marker()
        .setLngLat(startLocation)
        .addTo(map);

      new mapboxgl.Marker({ color: 'red' })
        .setLngLat(userLocation)
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

      mapRef.current = map;
    } else if (mapRef.current) {
      const map = mapRef.current;
      const source = map.getSource('route');
      if (source) {
        source.setData({
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'LineString',
            coordinates: path,
          },
        });
      }
    }
  }, [userLocation, path, startLocation]);

  const handleEndRide = () => {
    setShowEndRidePopup(true);
  };

  const handleClosePopup = () => {
    setShowEndRidePopup(false);
  };

  const rideData = {
    startLocation,
    endLocation: userLocation,
    path,
    cost: 10, // Example cost, replace with actual calculation
    distance: path.length, // Example distance, replace with actual calculation
    battery: 50, // Example battery level, replace with actual data
  };

  return (
    <div className="ride-progress">
      <div className="ride-header">
        <h2>Ride in Progress</h2>
        <p>Time: {timer} seconds</p>
        <button onClick={handleEndRide}>End Ride</button>
      </div>
      <div id="map" style={{ width: '100%', height: '90vh' }}></div>
      {showEndRidePopup && <EndRidePopup onClose={handleClosePopup} rideData={rideData} />}
    </div>
  );
}

export default RideProgress;

