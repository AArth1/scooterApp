// import { useRef, useEffect} from 'react';

// import mapboxgl from 'mapbox-gl'; // eslint-disable-line import/no-webpack-loader-syntax
// import 'mapbox-gl/dist/mapbox-gl.css';
// import "./ScooterMap.css"
// import geoJson from "./scooter-list.json";

// import { useSharedState } from './SharedStateContext';

// const ScooterMap = () => {

//   const mapContainerRef = useRef();
//   const mapRef = useRef();

//   const { setSelectedItemId } = useSharedState();

//   // Initialize map when component mounts
//   useEffect(() => {
//     mapboxgl.accessToken = 'pk.eyJ1Ijoia2F0YWthbWEiLCJhIjoiY2x5cTR4aXYyMDBzbzJpcG43NXZvNTd5byJ9.nEGo9hPCJwE4SrmFaborZw';

//     const map = new mapboxgl.Map({
//       container: mapContainerRef.current,
//       style: 'mapbox://styles/mapbox/streets-v12',
//       center: [-122.130821,47.643543],
//       zoom: 10
//     });
    
//     mapRef.current = map;

//     map.on('load', function() {
//     // Add markers from geoJson to the map
//     geoJson.features.forEach((feature) => {
//       const el = document.createElement('div');
//       el.className = 'scooter-marker';
//       el.addEventListener('click', () => setSelectedItemId(feature.properties.ID));

//       // Optionally, add a popup to each marker
//       const popup = new mapboxgl.Popup({ offset: 25 }).setText(
//         `${feature.properties.title}: Battery ${feature.properties.battery}%, Price $${feature.properties.price}, Range ${feature.properties.range} miles`
//       );
//       // Add the marker to the map with the popup
//       new mapboxgl.Marker(el)
//         .setLngLat(feature.geometry.coordinates)
//         .setPopup(popup) // sets a popup on this marker
//         .addTo(map);
//     });
//     }, []);
  
//     map.addControl(
//       new mapboxgl.GeolocateControl({
//         positionOptions: {
//           enableHighAccuracy: true
//         },
//         trackUserLocation: true,
//         showUserHeading: true
//       })
//     );
//     // Add navigation control (the +/- zoom buttons)
//     map.addControl(new mapboxgl.NavigationControl(), 'top-right');

//     return () => {
//       map.remove();
//     };
//     }, [setSelectedItemId]);

//     return (
//         <div>
//       <div className='map-container' ref={mapContainerRef} />
//     </div>
//     );
// };

// export default ScooterMap;

// import React, { useState, useEffect, useRef } from 'react';
// import mapboxgl from 'mapbox-gl';
// import UnlockPopup from './UnlockPopup';
// import './ScooterMap.css';

// mapboxgl.accessToken = 'pk.eyJ1Ijoia2F0YWthbWEiLCJhIjoiY2x5cTR4aXYyMDBzbzJpcG43NXZvNTd5byJ9.nEGo9hPCJwE4SrmFaborZw';

// function ScooterMap() {
//   const [userLocation, setUserLocation] = useState([0, 0]);
//   const [scooters, setScooters] = useState([]);
//   const [selectedScooterId, setSelectedScooterId] = useState(null);
//   const [showUnlockPopup, setShowUnlockPopup] = useState(false);
//   const [markers, setMarkers] = useState({});
//   const itemRefs = useRef({});

//   useEffect(() => {
//     navigator.geolocation.getCurrentPosition((position) => {
//       setUserLocation([position.coords.longitude, position.coords.latitude]);
//     });

//     fetch('/scooter-list.json')
//       .then((response) => response.json())
//       .then((data) => {
//         setScooters(data.features);
//         data.features.forEach(feature => {
//           itemRefs.current[feature.properties.ID] = React.createRef();
//         });
//       });
//   }, []);

//   useEffect(() => {
//     if (userLocation[0] !== 0 && scooters.length > 0) {
//       const map = new mapboxgl.Map({
//         container: 'map',
//         style: 'mapbox://styles/mapbox/streets-v11',
//         center: userLocation,
//         zoom: 12,
//       });

//       // Add geolocation control to the map.
//       map.addControl(
//         new mapboxgl.GeolocateControl({
//           positionOptions: {
//             enableHighAccuracy: true
//           },
//           trackUserLocation: true,
//           showUserHeading: true
//         })
//       );

//       // Add navigation control (the +/- zoom buttons)
//       map.addControl(new mapboxgl.NavigationControl(), 'top-right');

//       const newMarkers = {};
//       scooters.forEach((scooter) => {
//         const marker = new mapboxgl.Marker()
//           .setLngLat(scooter.geometry.coordinates)
//           .addTo(map)
//           .getElement()
//           .addEventListener('click', () => handleMarkerClick(scooter.properties.ID));
        
//         newMarkers[scooter.properties.ID] = marker;
//       });

//       setMarkers(newMarkers);
//     }
//   }, [userLocation, scooters]);

//   const handleMarkerClick = (id) => {
//     setSelectedScooterId(id);
//     if (itemRefs.current[id]) {
//       itemRefs.current[id].current.scrollIntoView({
//         behavior: 'smooth',
//         block: 'nearest',
//         inline: 'start'
//       });
//     }
//   };

//   const handleItemClick = (id) => {
//     setSelectedScooterId(selectedScooterId === id ? null : id);
//     if (markers[id]) {
//       Object.values(markers).forEach(marker => marker.getElement().style.backgroundColor = '');
//       markers[id].getElement().style.backgroundColor = 'red';
//     }
//   };

//   const handleUnlockClick = (event) => {
//     event.stopPropagation(); // Prevent the card from collapsing
//     setShowUnlockPopup(true);
//   };

//   const handleClosePopup = () => {
//     setShowUnlockPopup(false);
//   };

//   const selectedScooter = scooters.find(s => s.properties.ID === selectedScooterId);

//   return (
//     <div className="scooter-map">
//       <div id="map"></div>
//       <div className="scooter-list">
//         {scooters.map((scooter) => (
//           <div 
//             key={scooter.properties.ID} 
//             ref={itemRefs.current[scooter.properties.ID]} 
//             className={`card ${selectedScooterId === scooter.properties.ID ? 'expanded' : ''}`}
//             onClick={() => handleItemClick(scooter.properties.ID)}
//           >
//             <h2>{scooter.properties.title}</h2>
//             <p>Battery: {scooter.properties.battery}%</p>
//             <p>Distance: {scooter.properties.distance}</p>
//             {selectedScooterId === scooter.properties.ID && (
//               <div className="additional-info">
//                 <p>Price: ${scooter.properties.price}</p>
//                 <p>Range: {scooter.properties.range} miles</p>
//                 <button onClick={handleUnlockClick}>Unlock Ride</button>
//               </div>
//             )}
//           </div>
//         ))}
//       </div>
//       {showUnlockPopup && selectedScooter && (
//         <UnlockPopup scooter={selectedScooter.properties} onClose={handleClosePopup} />
//       )}
//     </div>
//   );
// }

// export default ScooterMap;

import React, { useState, useEffect, useRef } from 'react';
import mapboxgl from 'mapbox-gl';
import UnlockPopup from './UnlockPopup';
import './ScooterMap.css';

mapboxgl.accessToken = 'pk.eyJ1Ijoia2F0YWthbWEiLCJhIjoiY2x5cTR4aXYyMDBzbzJpcG43NXZvNTd5byJ9.nEGo9hPCJwE4SrmFaborZw';

function ScooterMap() {
  const [userLocation, setUserLocation] = useState([0, 0]);
  const [scooters, setScooters] = useState([]);
  const [selectedScooterId, setSelectedScooterId] = useState(null);
  const [showUnlockPopup, setShowUnlockPopup] = useState(false);
  const [markers, setMarkers] = useState({});
  const itemRefs = useRef({});

  useEffect(() => {
    navigator.geolocation.getCurrentPosition((position) => {
      setUserLocation([position.coords.longitude, position.coords.latitude]);
    });

    fetch('/scooter-list.json')
      .then((response) => response.json())
      .then((data) => {
        const availableScooters = data.features.filter(scooter => !scooter.properties.isBooked);
        setScooters(availableScooters);
        availableScooters.forEach(feature => {
          itemRefs.current[feature.properties.ID] = React.createRef();
        });
      });
  }, []);

  useEffect(() => {
    if (userLocation[0] !== 0 && scooters.length > 0) {
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/navigation-night-v1',
        center: userLocation,
        zoom: 12,
      });

      // Add geolocation control to the map.
      map.addControl(
        new mapboxgl.GeolocateControl({
          positionOptions: {
            enableHighAccuracy: true
          },
          trackUserLocation: true,
          showUserHeading: true
        })
      );

      // Add navigation control (the +/- zoom buttons)
      map.addControl(new mapboxgl.NavigationControl(), 'top-right');

      const newMarkers = {};
      scooters.forEach((scooter) => {
        const el = document.createElement('div');
        el.className = 'scooter-marker';
        const container = document.createElement('div');
        container.className = 'scooter-marker-container';
        container.innerHTML = '<svg width="24px" height="24px" viewBox="-4.8 -4.8 33.60 33.60" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#ffffff" stroke-width="0.00024000000000000003"><g id="SVGRepo_bgCarrier" stroke-width="0" transform="translate(0,0), scale(1)"><rect x="-4.8" y="-4.8" width="33.60" height="33.60" rx="16.8" fill="#ffffff" strokewidth="0"></rect></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="0.192"></g><g id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd" d="M12 4C12 3.44772 12.4477 3 13 3H14.5585C15.8498 3 16.9962 3.82629 17.4045 5.05132L20.7525 15.0952C22.0451 15.429 23 16.603 23 18C23 19.6569 21.6569 21 20 21C18.3431 21 17 19.6569 17 18C17 16.8051 17.6986 15.7734 18.7096 15.2909L18.0147 13.2065L15.9472 17.3416C15.439 18.3579 14.4002 18.9999 13.2639 18.9999H6.82931C6.41749 20.1652 5.30624 21 4 21C2.34315 21 1 19.6569 1 18C1 16.3431 2.34315 15 4 15C5.3062 15 6.41743 15.8348 6.82928 16.9999H13.2639C13.6427 16.9999 13.989 16.7859 14.1584 16.4472L17.1056 10.5527L17.1351 10.5675L15.5072 5.68377C15.3711 5.27543 14.9889 5 14.5585 5H13C12.4477 5 12 4.55228 12 4ZM4 19.0032C3.44595 19.0032 2.99681 18.554 2.99681 18C2.99681 17.446 3.44595 16.9968 4 16.9968C4.55405 16.9968 5.00319 17.446 5.00319 18C5.00319 18.554 4.55405 19.0032 4 19.0032ZM20 19.0032C19.446 19.0032 18.9968 18.554 18.9968 18C18.9968 17.446 19.446 16.9968 20 16.9968C20.554 16.9968 21.0032 17.446 21.0032 18C21.0032 18.554 20.554 19.0032 20 19.0032Z" fill="#000000"></path> </g></svg>';
        el.appendChild(container);

        const marker = new mapboxgl.Marker(el)
          .setLngLat(scooter.geometry.coordinates)
          .addTo(map)
          .getElement()
          .addEventListener('click', () => handleMarkerClick(scooter.properties.ID));
        
        newMarkers[scooter.properties.ID] = marker;
      });

      setMarkers(newMarkers);
    }
  }, [userLocation, scooters]);

  const handleMarkerClick = (id) => {
    setSelectedScooterId(id);
    if (itemRefs.current[id]) {
      itemRefs.current[id].current.scrollIntoView({
        behavior: 'smooth',
        block: 'nearest',
        inline: 'start'
      });
    }
  };

  const handleItemClick = (id) => {
    setSelectedScooterId(selectedScooterId === id ? null : id);
    if (markers[id]) {
      Object.values(markers).forEach(marker => marker.getElement().style.backgroundColor = '');
      markers[id].getElement().style.backgroundColor = 'red';
    }
  };

  const handleUnlockClick = (event) => {
    event.stopPropagation(); // Prevent the card from collapsing
    setShowUnlockPopup(true);
  };

  const handleClosePopup = () => {
    setShowUnlockPopup(false);
  };

  const selectedScooter = scooters.find(s => s.properties.ID === selectedScooterId);

  return (
    <div className="scooter-map">
      <div id="map"></div>
      <div className="scooter-list">
        {scooters.map((scooter) => (
          <div 
            key={scooter.properties.ID} 
            ref={itemRefs.current[scooter.properties.ID]} 
            className={`card ${selectedScooterId === scooter.properties.ID ? 'expanded' : ''}`}
            onClick={() => handleItemClick(scooter.properties.ID)}
          >
            <h2>{scooter.properties.title}</h2>
            <p>Battery: {scooter.properties.battery}%</p>
            <p>Distance: {scooter.properties.distance}</p>
            {selectedScooterId === scooter.properties.ID && (
              <div className="additional-info">
                <p>Price: ${scooter.properties.price}</p>
                <p>Range: {scooter.properties.range} miles</p>
                <button onClick={handleUnlockClick}>Unlock Ride</button>
              </div>
            )}
          </div>
        ))}
      </div>
      {showUnlockPopup && selectedScooter && (
        <UnlockPopup scooter={selectedScooter.properties} onClose={handleClosePopup} />
      )}
    </div>
  );
}

export default ScooterMap;
