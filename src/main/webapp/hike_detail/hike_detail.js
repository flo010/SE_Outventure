// delete hike functions
function deleteHike(hikeID) {
    // Redirect to the DeleteHikeServlet
    window.location.href = '../delete_hike?hikeID=' + hikeID;
}

function showDeleteHikeModal() {
    let deleteHikeModal = new bootstrap.Modal(document.getElementById('deleteHikeModal'), {
        keyboard: false
    });
    deleteHikeModal.show();
}

// function to fill the circles
document.addEventListener("DOMContentLoaded", function() {
    let circles = document.querySelectorAll('.fa.fa-circle-o');

    function fillCircles(count, startIndex) {
        for (let i = startIndex; i < startIndex + count; i++) {
            circles[i].classList.replace('fa-circle-o', 'fa-circle');
            circles[i].style.color = "#B6FC9D";
        }
    }

    let hikeDataElement = document.getElementById('dataForCircles');

    if (hikeDataElement) {
        let stamina = parseInt(hikeDataElement.getAttribute('data-stamina'), 10);
        let strength = parseInt(hikeDataElement.getAttribute('data-strength'), 10);
        let experience = parseInt(hikeDataElement.getAttribute('data-experience'), 10);
        let landscape = parseInt(hikeDataElement.getAttribute('data-landscape'), 10);


        fillCircles(stamina, 0);
        fillCircles(strength, 5);
        fillCircles(experience, 10);
        fillCircles(landscape, 15);
    }
});

// map functions
document.addEventListener("DOMContentLoaded", function (){
    initialiseMap();
})

function initialiseMap() {
    let mapData = document.getElementById('mapData');
    let startName = mapData.getAttribute('start-name');
    let startLatitude = parseFloat(mapData.getAttribute('start-latitude'));
    let startLongitude = parseFloat(mapData.getAttribute('start-longitude'));
    let destinationName = mapData.getAttribute('destination-name');
    let destinationLatitude = parseFloat(mapData.getAttribute('destination-latitude'));
    let destinationLongitude = parseFloat(mapData.getAttribute('destination-longitude'));

    // leaflet methods to initialize the map so that entire hike is always visible
    let startBound = L.latLng(startLatitude, startLongitude);
    let destinationBound = L.latLng(destinationLatitude, destinationLongitude);
    let bounds = L.latLngBounds(startBound, destinationBound);

    let map = new L.Map('map', {fullscreenControl: true,});
    map.fitBounds(bounds);
    
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    let destination = L.marker([destinationLatitude, destinationLongitude]).addTo(map);
    destination.bindPopup("<strong>Destination: </strong>" + destinationName + "<br> <strong>Coordinates: </strong>" + destinationLatitude + " N, " + destinationLongitude + " E");
    destination.bindTooltip("<strong>Destination: </strong>" + destinationName)
    let start = L.marker([startLatitude, startLongitude]).addTo(map);
    start.bindPopup("<strong>Destination: </strong>" + startName + "<br> <strong>Coordinates: </strong>" + startLatitude + " N, " + startLongitude + " E");
    start.bindTooltip("<strong>Start: </strong>" + startName);

    let polyline = L.polyline([
        [startLatitude, startLongitude],
        [destinationLatitude, destinationLongitude]
    ]).addTo(map);
}