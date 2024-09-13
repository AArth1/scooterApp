import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Login.css';


const Login = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [message, setMessage] = useState('');
  const navigate = useNavigate();

  const handleLogin = async () => {
    try {
      const response = await fetch('./UserAuthentication.json');
      const userAuthData = await response.json();

      const user = userAuthData.UserAuthentication.find(user => user.Username === username);

      if (!user) {
        setMessage('This username does not exist. Would you like to create an account?');
      } else if (user.Password !== password) {
        setMessage('Password is incorrect.');
      } else {
        navigate('/scooter-map');
      }
    } catch (error) {
      console.error('Error fetching user authentication data:', error);
      setMessage('An error occurred. Please try again later.');
    }
  };

  const handleRegisterRedirect = () => {
    navigate('/register');
  };

  return (
    <div className="login-container">
      <div className="log-title">Login</div>
      <div className="row">
        <div className="login-column">
          <div className="form">
            <input
              className="input"
              type="text"
              placeholder="Username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
            />
            <input
              className="input"
              type="password"
              placeholder="Password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
            <div className="log-button" onClick={handleLogin}>Login</div>
            {message && (
              <div className="message">
                <p>{message}</p>
                {message.includes('create an account') && (
                  <button className="reg-button" onClick={handleRegisterRedirect}>Register</button>
                )}
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Login;
