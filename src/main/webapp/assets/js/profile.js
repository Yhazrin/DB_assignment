// src/main/webapp/assets/js/profile.js

/**
 * profile.js - Handle all interaction logic on the user profile page (simplified version)
 */
document.addEventListener('DOMContentLoaded', function() {
    const ctx    = getContextPath();
    const USERID = "u1";
    const endpoint = 'http://localhost:8080/ServerletFinal_war_exploded/data?type=readSQL&table=users&userID=' + USERID;

    // Fetch and render user basic information
    fetch(endpoint)
        .then(res => res.ok ? res.json() : Promise.reject(res.status))
        .then(users => {
            const user = users[0];  // Take the first element
            // Render username and email
            document.getElementById('userName').textContent = user.username;
            document.getElementById('email').textContent    = user.email;
            // Placeholder for registerDate as it is not provided by the backend
            document.getElementById('registerDate').textContent = '—';
        })
        .catch(err => console.error('Loading user information failed', err));

    // Placeholder for additional features that will be implemented later
    // renderDevices([]);
    // renderActivities([]);
    // …… other sidebar, export CSV, logout functionalities remain unchanged
});

/**
 * Get the context path
 */
function getContextPath() {
    return document.body.dataset.contextPath || '';
}
