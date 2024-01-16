function updateFavorites(hikeID, hikerID) {
    window.location.href = '/favorite_hike?hikeID=' + hikeID + '&hikerID=' + hikerID + '&page=profile';
}