//do not need it
import { createContext, useState, useContext } from 'react';

const SharedStateContext = createContext();

export const useSharedState = () => useContext(SharedStateContext);

export const SharedStateProvider = ({ children }) => {
  const [selectedItemId, setSelectedItemId] = useState(null);

  return (
    <SharedStateContext.Provider value={{ selectedItemId, setSelectedItemId }}>
      {children}
    </SharedStateContext.Provider>
  );
};
