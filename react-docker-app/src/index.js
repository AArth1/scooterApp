import React from 'react';
import { createRoot } from 'react-dom/client';
//import { ApolloClient, InMemoryCache, ApolloProvider } from '@apollo/client';
import './index.css';
import 'mapbox-gl/dist/mapbox-gl.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

// Initialize Apollo Client
// const client = new ApolloClient({
//   uri: 'https://your-graphql-api-endpoint.com/graphql', // Replace with your GraphQL API endpoint
//   cache: new InMemoryCache()
// });

// Use createRoot from react-dom/client
const root = createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>

      <App />

  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();