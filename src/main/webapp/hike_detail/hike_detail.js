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
    window.location.href = "/search_results/search_results.jsp";
}

// map functions
document.addEventListener("DOMContentLoaded", function (){
    initializeMap();
});

function initializeMap() {
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
    start.bindPopup("<strong>Start: </strong>" + startName + "<br> <strong>Coordinates: </strong>" + startLatitude + " N, " + startLongitude + " E");
    start.bindTooltip("<strong>Start: </strong>" + startName);

    let poiDataListElement = document.getElementById('poiDataList');
    let poiDataListJson = poiDataListElement.getAttribute('data-poi-data');

    let poiDataList = JSON.parse(poiDataListJson);

    let poiIcon = L.Icon.extend({
        options: {
            iconSize:     [40, 40],
            iconAnchor:   [20, 40],
            popupAnchor:  [0, -48]
        }
    });

    let hutIcon = new poiIcon({iconUrl: 'images/marker_images/hut.png'}),
        refreshmentPointIcon = new poiIcon({iconUrl: 'images/marker_images/refreshment_point.png'}),
        sightIcon = new poiIcon({iconUrl: 'images/marker_images/sight.jpg'}),
        viewpointIcon = new poiIcon({iconUrl: 'images/marker_images/viewpoint.jpg'});

    poiDataList.forEach(function (poiData) {
        let poiName = poiData.poiName;
        let poiType = poiData.poiType;
        let poiLatitude = poiData.poiLatitude;
        let poiLongitude = poiData.poiLongitude;

        switch(poiType) {
            case 'Hut':
                let hutMarker = L.marker([poiLatitude, poiLongitude], {icon: hutIcon}).addTo(map);
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
                let viewpointMarker = L.marker([poiLatitude, poiLongitude], {icon: viewpointIcon}).addTo(map);
                console.log("vp marker: " + viewpointMarker);
                viewpointMarker.bindPopup("<strong>Viewpoint Name: </strong>" + poiName + "<br> <strong>Coordinates: </strong>" + poiLatitude + " N, " + poiLongitude + " E");
                viewpointMarker.bindTooltip("<strong>Viewpoint Name: </strong>" + poiName);
                break;
            case 'Sight':
                let sightMarker = L.marker([poiLatitude, poiLongitude], {icon: sightIcon}).addTo(map);
                console.log("sight marker: " + sightMarker);
                sightMarker.bindPopup("<strong>Sight Name: </strong>" + poiName + "<br> <strong>Coordinates: </strong>" + poiLatitude + " N, " + poiLongitude + " E");
                sightMarker.bindTooltip("<strong>Sight Name: </strong>" + poiName);
                break;
        }
    });

    L.polyline([
        [startLatitude, startLongitude],
        [destinationLatitude, destinationLongitude]
    ]).addTo(map);
}

function updateFavorites(hikeID, hikerID) {
    window.location.href = '/favorite_hike?hikeID=' + hikeID + '&hikerID=' + hikerID + '&page=detail';
}

// completed hike modal functions
function showHikeCompletedModal() {
    const hikeCompletedModal = new bootstrap.Modal(document.getElementById('hikeCompletedModal'), {
        keyboard: false
    });
    document.getElementById('completionDate').value = "";
    hikeCompletedModal.show();
}

