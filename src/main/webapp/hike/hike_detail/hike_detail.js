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

function showLastSearchResults() {
    window.location.href = "/hike/search_results/search_results.jsp";
}
let startLatitude, startLongitude, destinationLatitude, destinationLongitude, startName, destinationName;
let waypoints = [];
// map functions
document.addEventListener("DOMContentLoaded", function (){
    initializeMap()
});

function initializeMap() {
    let newMap;

    let mapData = document.getElementById('mapData');
    startName = mapData.getAttribute('data-start-name');
    startLatitude = parseFloat(mapData.getAttribute('data-start-latitude'));
    startLongitude = parseFloat(mapData.getAttribute('data-start-longitude'));
    destinationName = mapData.getAttribute('data-destination-name');
    destinationLatitude = parseFloat(mapData.getAttribute('data-destination-latitude'));
    destinationLongitude = parseFloat(mapData.getAttribute('data-destination-longitude'));


    // leaflet methods to initialize the map so that entire hike is always visible
    let startBound = L.latLng(startLatitude, startLongitude);
    let destinationBound = L.latLng(destinationLatitude, destinationLongitude);
    let bounds = L.latLngBounds(startBound, destinationBound);

    newMap = new L.Map('map', {fullscreenControl: true,});
    newMap.fitBounds(bounds);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(newMap);

    let start = L.marker([startLatitude, startLongitude]).addTo(newMap);
    waypoints.push(start.getLatLng());
    start.bindPopup("<strong>Start: </strong>" + startName + "<br> <strong>Coordinates: </strong>" + startLatitude + " N, " + startLongitude + " E");
    start.bindTooltip("<strong>Start: </strong>" + startName);

    let destination = L.marker([destinationLatitude, destinationLongitude]).addTo(newMap);
    waypoints.push(destination.getLatLng());
    destination.bindPopup("<strong>Destination: </strong>" + destinationName + "<br> <strong>Coordinates: </strong>" + destinationLatitude + " N, " + destinationLongitude + " E");
    destination.bindTooltip("<strong>Destination: </strong>" + destinationName)

    let poiDataListElement = document.getElementById('poiDataList');
    let poiDataListJson = poiDataListElement.getAttribute('data-poi-data');

    let poiDataList = JSON.parse(poiDataListJson);

    let poiIcon = L.Icon.extend({
        options: {
            iconSize: [40, 40],
            iconAnchor: [20, 40],
            popupAnchor: [0, -48]
        }
    });

    let hutIcon = new poiIcon({iconUrl: '/hike/marker_images/hut.png'}),
        refreshmentPointIcon = new poiIcon({iconUrl: '/hike/marker_images/refreshment_point.png'}),
        sightIcon = new poiIcon({iconUrl: '/hike/marker_images/sight.jpg'}),
        viewpointIcon = new poiIcon({iconUrl: '/hike/marker_images/viewpoint.jpg'});

    poiDataList.forEach(function (poiData) {
        let poiName = poiData.poiName;
        let poiType = poiData.poiType;
        let poiLatitude = poiData.poiLatitude;
        let poiLongitude = poiData.poiLongitude;

        switch (poiType) {
            case 'Hut':
                let hutMarker = L.marker([poiLatitude, poiLongitude], {icon: hutIcon}).addTo(newMap);
                console.log("hutMarker: " + hutMarker);
                hutMarker.bindPopup("<strong>Hut Name: </strong>" + poiName + "<br> <strong>Coordinates: </strong>" + poiLatitude + " N, " + poiLongitude + " E");
                hutMarker.bindTooltip("<strong>Hut Name: </strong>" + poiName);
                break;
            case 'Refreshment Point':
                let refreshmentPointMarker = L.marker([poiLatitude, poiLongitude], {icon: refreshmentPointIcon}).addTo(map);
                console.log("RP marker: " + refreshmentPointMarker);
                refreshmentPointMarker.bindPopup("<strong>Refreshment Point Name: </strong>" + poiName + "<br> <strong>Coordinates: </strong>" + poiLatitude + " N, " + poiLongitude + " E");
                refreshmentPointMarker.bindTooltip("<strong>Refreshment Point Name: </strong>" + poiName);
                break;
            case 'Viewpoint':
                let viewpointMarker = L.marker([poiLatitude, poiLongitude], {icon: viewpointIcon}).addTo(newMap);
                console.log("vp marker: " + viewpointMarker);
                viewpointMarker.bindPopup("<strong>Viewpoint Name: </strong>" + poiName + "<br> <strong>Coordinates: </strong>" + poiLatitude + " N, " + poiLongitude + " E");
                viewpointMarker.bindTooltip("<strong>Viewpoint Name: </strong>" + poiName);
                break;
            case 'Sight':
                let sightMarker = L.marker([poiLatitude, poiLongitude], {icon: sightIcon}).addTo(newMap);
                console.log("sight marker: " + sightMarker);
                sightMarker.bindPopup("<strong>Sight Name: </strong>" + poiName + "<br> <strong>Coordinates: </strong>" + poiLatitude + " N, " + poiLongitude + " E");
                sightMarker.bindTooltip("<strong>Sight Name: </strong>" + poiName);
                break;
        }
    });
    sendWaypointsToAPI_route(waypoints, newMap);
}

const startMarkerIcon = L.icon({
    iconUrl: '/hike/marker_images/pin-icon-start.png',
    iconSize: [32, 32],
    iconAnchor: [16, 32],
    popupAnchor: [0, -32]
});

const destinationMarkerIcon = L.icon({
    iconUrl: '/hike/marker_images/pin-icon-end.png',
    iconSize: [32, 32],
    iconAnchor: [16, 32],
    popupAnchor: [0, -32]
});

function sendWaypointsToAPI_route(waypoints, newMap) {
    const waypointData = waypoints.map(function (waypoint) {
        return [waypoint.lng, waypoint.lat];
    });

    const startMarker = L.marker([waypoints[0].lat, waypoints[0].lng], { icon: startMarkerIcon }).addTo(newMap);
    const destinationMarker = L.marker([waypoints[waypoints.length - 1].lat, waypoints[waypoints.length - 1].lng], { icon: destinationMarkerIcon }).addTo(newMap);


    const payload = {
        "coordinates": waypointData,
        "profile": "foot-hiking",
        "format": "gpx",
        "elevation": true,
        "extra_info": ["steepness", "suitability", "surface", "green", "noise"]
    };

    fetch('https://api.openrouteservice.org/v2/directions/foot-hiking/gpx', {
        method: 'POST',
        headers: {
            'Authorization': 'Bearer 5b3ce3597851110001cf62483d1f73a95e10453194e38bd4eb0fd59c',
            'Content-Type': 'application/json',
            'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png'
        },
        body: JSON.stringify(payload)
    })
        .then(response => response.text())
        .then(gpxData => {
            drawRoute(gpxData, newMap);
            console.log(gpxData);
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

let existingGpxLayer = null;
function drawRoute(gpxData, newMap) {
    const newGpxLayer = new L.GPX(gpxData, { async: true });

    newGpxLayer.on('loaded', function (e) {
        newMap.fitBounds(e.target.getBounds());

        if (existingGpxLayer) {
            newMap.removeLayer(existingGpxLayer);
        }
        existingGpxLayer = newGpxLayer;

        newGpxLayer.addTo(newMap);
    });
}


function exportGPX() {
    const gpxData = createGPX();
    const gpxDataBlob = new Blob([gpxData], {type: 'application/gpx+xml'});

    const link = document.createElement('a');
    link.href = URL.createObjectURL(gpxDataBlob);
    link.download = 'waypoints.gpx';
    link.click();
}

function createGPX() {
    return '<?xml version="1.0" encoding="UTF-8" standalone="no" ?>' +
        '<gpx version="1.1" creator="Outventure">' +
        '<trk>' +
        '<name>A hike created with Outventure!</name>' +
        '<trkseg>' +
        waypoints.map(function () {
        }).join('') +
        '</trkseg>' +
        '</trk>' +
        '<wpt lat="' + startLatitude + '" lon="' + startLongitude + '">' +
        '<name>' + startName + '</name>' +
        '</wpt>' +
        '<wpt lat="' + destinationLatitude + '" lon="' + destinationLongitude + '">' +
        '<name>' + destinationName + '</name>' +
        '</wpt>' +
        '</gpx>';
}

function updateFavorites(hikeID, hikerID) {
    window.location.href = '/favorite_hike?hikeID=' + hikeID + '&hikerID=' + hikerID + '&page=detail';
}

function showHikeCompletedModal() {
    const hikeCompletedModal = new bootstrap.Modal(document.getElementById('hikeCompletedModal'), {
        keyboard: false
    });
    document.getElementById('completionDate').value = "";
    hikeCompletedModal.show();
}


