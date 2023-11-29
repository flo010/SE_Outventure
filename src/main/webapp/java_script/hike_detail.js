function deleteHike(hikeID) {
    // Redirect to the DeleteHikeServlet
    window.location.href = 'delete_hike?hikeID=' + hikeID;
}

function showDeleteHikeModal() {
    let deleteHikeModal = new bootstrap.Modal(document.getElementById('deleteHikeModal'), {
        keyboard: false
    });
    deleteHikeModal.show();
}

// map functions
document.addEventListener("DOMContentLoaded", function (){
    let mapData = document.getElementById('mapData');
    let startName = mapData.getAttribute('start-name');
    let startLatitude = mapData.getAttribute('start-latitude');
    let startLongitude = mapData.getAttribute('start-longitude');
    let destinationName = mapData.getAttribute('destination-name');
    let destinationLatitude = mapData.getAttribute('destination-latitude');
    let destinationLongitude = mapData.getAttribute('destination-longitude');

    let map = L.map('map').setView([startLatitude, startLongitude], 14);
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    let destination = L.marker([destinationLatitude, destinationLongitude]).addTo(map);
    destination.bindPopup("<b>Destination: </b>" + destinationName).openPopup();
    let start = L.marker([startLatitude, startLongitude]).addTo(map);
    start.bindPopup("<b>Start: </b>" + startName).openPopup();

    let polyline = L.polyline([
        [startLatitude, startLongitude],
        [destinationLatitude, destinationLongitude]
    ]).addTo(map);
})

