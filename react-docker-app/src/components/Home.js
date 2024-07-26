// const StartButton = () => {
//     const handleClick = () => {
//       console.log('Button clicked');
//     };
  
//     return (
//     <div className="start">
//       <button onClick={handleClick}>
//         Start
//         </button>
//     </div>
//     );
//   };
  
//   const Card = () => {
//     return (
//       <div className="card">
//         <h2>Log in or register to start riding</h2>
//         <StartButton />
//       </div>
//     );
//   };

//   const Home = () => {
//     return (
//     <div className="home">
//         <h1>Website Home</h1>
//       <section>
//         <Card />
//       </section>
//     </div>  
//     );
//   };

//   export default Home;
// 

import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import './Home.css';

const Home = () => {
  const [showContent, setShowContent] = useState(false);

  useEffect(() => {
    setTimeout(() => setShowContent(true), 500);
  }, []);

  return (
    <div className="home-container">
      <div className={`content ${showContent ? 'show' : ''}`}>
        <h1 className="title">SCOOTER APP</h1>
        <div className="scooter-animation">
          <div className="scooter">
            <div className="wheel"></div>
            <div className="body"></div>
            <div className="handlebar"></div>
          </div>
        </div>
        <div className="buttons">
          <Link to="/login" className="btn login-btn">Login</Link>
          <Link to="/register" className="btn register-btn">Register</Link>
        </div>
        <p className="tagline">Zip through the city with ease!</p>
      </div>
    </div>
  );
};

export default Home;