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
    let startLatitude = mapData.getAttribute('start-latitude');
    let startLongitude = mapData.getAttribute('start-longitude');
    let destinationName = mapData.getAttribute('destination-name');
    let destinationLatitude = mapData.getAttribute('destination-latitude');
    let destinationLongitude = mapData.getAttribute('destination-longitude');

    let map = new L.Map('map', {fullscreenControl: true,}).setView([startLatitude, startLongitude], 14);
    
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
}