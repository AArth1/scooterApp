//do not need it
import { SharedStateProvider } from './SharedStateContext';
import ScooterMap from './ScooterMap';
import ScooterList from './ScooterList';
import './FindScooterPage.css'

const FindScooterPage = () => {
    return ( 
        <div className="findScooterPage">
        <SharedStateProvider>
           
                <ScooterMap />
                <ScooterList />
         
        </SharedStateProvider>
    </div>
     );
}
 
export default FindScooterPage;