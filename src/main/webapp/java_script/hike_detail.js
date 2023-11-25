function deleteHike(hikeID) {
    // Redirect to the DeleteHikeServlet
    window.location.href = 'delete_hike?hikeID=' + hikeID;
}