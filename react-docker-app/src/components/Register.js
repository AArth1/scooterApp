import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Register.css';

const Register = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const navigate = useNavigate();

  const handleRegister = async () => {
    try {
      const response = await fetch('./UserAuthentication.json');
      const userAuthData = await response.json();

      const userExists = userAuthData.UserAuthentication.some(user => user.Username === username);

      if (userExists) {
        setMessage('This username is already in use. Please choose a different username.');
      } else {
        const newUser = {
          UserID: userAuthData.UserAuthentication.length + 1,
          Username: username,
          Password: password,
          FirstName: firstName,
          LastName: lastName,
          Email: email,
          CreatedAt: new Date().toISOString(),
          UpdatedAt: new Date().toISOString()
        };

        userAuthData.UserAuthentication.push(newUser);

        // Save the updated userAuthData to UserAuthentication.json
        // This part requires a backend API or server-side code to handle file writing

        setMessage('Registration successful!');
        navigate('/scooter-map');
        console.log('New user registered:', newUser, userAuthData);
      }
    } catch (error) {
      console.error('Error fetching user authentication data:', error);
      setMessage('An error occurred. Please try again later.');
    }
  };

  return (
    <div className="reg-container">
      <div className="reg-form-container">
      <div className = "reg-title">Register</div>
      <input
        className = "input"
        type="text"
        placeholder="First Name"
        value={firstName}
        onChange={(e) => setFirstName(e.target.value)}
      />
      <input
        className = "input"
        type="text"
        placeholder="Last Name"
        value={lastName}
        onChange={(e) => setLastName(e.target.value)}
      />
      <input
        className = "input"
        type="text"
        placeholder="Username"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
      />
      <input
        className = "input"
        type="password"
        placeholder="Password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <input
        className = "input"
        type="email"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />
      <button className = "reg-form-button" onClick={handleRegister}>Register</button>
      {message && <p>{message}</p>}
    </div>
    </div>
  );
};

export default Register;