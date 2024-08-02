import React from 'react';

//code for User Profile page containing user information from UserManagement.json and PaymentMethods.json
const UserProfile = () => {
    // Assuming you have access to the necessary data from UserManagement.json, UserAuthentication.json, and PaymentMethods.json
    const userManagementData = fetch('./UserManagement.json');/* code to fetch UserManagement data */
    const userAuthenticationData = fetch('./UserAuthentication.json');/* code to fetch UserAuthentication data */
    const paymentMethodsData = fetch('./PaymentMethods.json');/* code to fetch PaymentMethods data */

    return (
        <div>
            <h1>User Profile</h1>
            <h2>Billing Address: {userManagementData.BillingAddress}</h2>
            <h2>Username: {userAuthenticationData.Username}</h2>
            <h2>Email: {userAuthenticationData.Email}</h2>
            <h2>First Name: {userAuthenticationData.FirstName}</h2>
            <h2>Last Name: {userAuthenticationData.LastName}</h2>
            <h2>Payment Method Type: {paymentMethodsData.MethodType}</h2>
            <h2>Provider: {paymentMethodsData.Provider}</h2>
            <h2>Account Number: {paymentMethodsData.AccountNumber}</h2>
        </div>
    );
};

export default UserProfile;