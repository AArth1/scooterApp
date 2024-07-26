import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  //const [message, setMessage] = useState('');
  const navigate = useNavigate();

  //check if username exists on Users.json. If username does not exist --> create a new account
//   const handleNoUser = () => {
//     setMessage('This username does not exist. Would you like to create an account?');

//   };

  //if username exists, but password does not match --> password is incorrect

  //forgot password logic

//if username exists and password matches --> successful login --> navigate to scooter map page
  const handleLogin = () => {
    // Add login logic here
    navigate('/scooter-map');
  };

  return (
    <div className="login">
      <h2>Login</h2>
      <input type="text" placeholder="Username" value={username} onChange={(e) => setUsername(e.target.value)} />
      <input type="password" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} />
      <button onClick={handleLogin}>Login</button>
    </div>
  );
}

export default Login;
