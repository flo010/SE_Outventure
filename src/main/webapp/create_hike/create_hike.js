// Call the function when the DOM is ready
document.addEventListener('DOMContentLoaded', function () {
    initializePage();

    let isEditing = document.getElementById("hiddenEditInput");
    if (isEditing) {
        setTimeout(initializeEditMap, 2000);
    } else {
        setTimeout(initializeNewMap, 2000);
    }
});

// function to initialize the page
function initializePage() {
    'use strict';

    // Setup for slider
    rangeCount('conditionInput', 'rangeValue1');
    rangeCount('difficultyInput', 'rangeValue2');
    rangeCount('experienceInput', 'rangeValue3');
    rangeCount('landscapeInput', 'rangeValue4');

    // Setup for images
    previewImage('coverImageInput', 'previewCoverImage');

    //Checkboxes
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    let isEdit = document.getElementById("hiddenEditInput");
    let hikeMonths;
    if (isEdit) {
        let hikeMonthsString = document.getElementById("hiddenMonthsInput").value;
        hikeMonths = JSON.parse(hikeMonthsString);
    }

    let container = document.getElementById("monthContainer");

    for (let i = 0; i < months.length; i++) {

        let monthDiv = document.createElement("div");
        monthDiv.className = "form-check form-check-inline";


        let checkboxInput = document.createElement("input");
        checkboxInput.className = "form-check-input months";
        checkboxInput.type = "checkbox";
        checkboxInput.id = "optimalSeason" + months[i];

        checkboxInput.name = "monthCheckbox" + months[i];
        checkboxInput.value = "false";
        if (isEdit && hikeMonths[i]) {
            checkboxInput.checked = true;
        }

        // Create the label for the checkbox
        let label = document.createElement("label");
        label.className = "form-check-label";
        label.setAttribute("for", "monthCheckbox" + i);
        label.innerText = months[i];

        checkboxInput.addEventListener("change", function () {
            // Update the value of the checkbox based on its checked state
            checkboxInput.value = checkboxInput.checked ? "true" : "false";
        });

        monthDiv.appendChild(checkboxInput);
        monthDiv.appendChild(label);

        container.appendChild(monthDiv);
    }

    // Input event listeners
    document.getElementById('distanceInput').addEventListener('input', function () {
        let value = this.value;
        this.value = value.replace(/[^0-9.]/g, '');
    });

    document.getElementById('hoursInput').addEventListener('input', function () {
        let value = this.value;
        this.value = value.replace(/[^0-9]/g, '');
    });

    document.getElementById('minutesInput').addEventListener('input', function () {
        let value = this.value;
        this.value = value.replace(/[^0-9]/g, '');
    });

    document.getElementById('altitudeInput').addEventListener('input', function () {
        let value = this.value;
        this.value = value.replace(/[^0-9]/g, '');
    });
}

// function for validation
(function () {
    window.addEventListener('load', function () {
        let forms = document.getElementsByClassName('needs-validation');
        Array.prototype.filter.call(forms, function (form) {
            form.addEventListener('submit', function (event) {
                if (form.checkValidity() === false) {
                    createToast("validationToast", "Validation failed! Please check your input.");
                    showToast("validationToast");
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }, false);
})();

// functions for switching tabs
function nextTab() {
    shouldPromptBeforeUnload = false;
    let activeTab = document.querySelector(".nav-link.active");
    let nextTab = activeTab.parentElement.nextElementSibling.querySelector(".nav-link");

    if (nextTab) {
        activeTab.classList.remove("active");
        nextTab.classList.add("active");
        activeTab.setAttribute("aria-selected", "false");
        nextTab.setAttribute("aria-selected", "true");

        let targetIdActiveTab = activeTab.getAttribute("data-bs-target");
        document.querySelector(targetIdActiveTab).classList.remove("show", "active");
        let targetIdNextTab = nextTab.getAttribute("data-bs-target");
        document.querySelector(targetIdNextTab).classList.add("show", "active");

        updateProgressBar();
    }
}

function prevTab() {
    shouldPromptBeforeUnload = false;
    let activeTab = document.querySelector(".nav-link.active");
    let prevTab = activeTab.parentElement.previousElementSibling.querySelector(".nav-link");

    if (prevTab) {
        activeTab.classList.remove("active");
        prevTab.classList.add("active");
        activeTab.setAttribute("aria-selected", "false");
        prevTab.setAttribute("aria-selected", "true");

        let targetIdActiveTab = activeTab.getAttribute("data-bs-target");
        document.querySelector(targetIdActiveTab).classList.remove("show", "active");
        let targetIdPrevTab = prevTab.getAttribute("data-bs-target");
        document.querySelector(targetIdPrevTab).classList.add("show", "active");

        updateProgressBar();
    }
}

// function to update the progress bar
function updateProgressBar () {
    let activeLink = document.querySelector(".nav-link.active");
    let progressBar = document.querySelector(".progress-bar.bg-success");

    switch (activeLink.id) {
        case "pills-overview-tab":
            progressBar.setAttribute("aria-valuenow", "20");
            progressBar.style.width = "20%";
            progressBar.innerHTML = "20%";
            break;
        case "pills-details-tab":
            progressBar.setAttribute("aria-valuenow", "40");
            progressBar.style.width = "40%";
            progressBar.innerHTML = "40%";
            break;
        case "pills-route-tab":
            progressBar.setAttribute("aria-valuenow", "60");
            progressBar.style.width = "60%";
            progressBar.innerHTML = "60%";
            break;
        case "pills-poi-tab":
            progressBar.setAttribute("aria-valuenow", "80");
            progressBar.style.width = "80%";
            progressBar.innerHTML = "80%";
            break;
        case "pills-getting-there-tab":
            progressBar.setAttribute("aria-valuenow", "100");
            progressBar.style.width = "100%";
            progressBar.innerHTML = "100%";
            break;
    }
}

// slider functions
function rangeCount(id, labelId){
    let rangeInput = document.getElementById(id);
    let rangeValue = document.getElementById(labelId);

    rangeInput.addEventListener('input', function () {
        rangeValue.textContent = rangeInput.value;
    });
}

//function to change the range values dynamically with the sliders
function updateLabel(inputId, labelId) {
    document.getElementById(labelId).innerText = document.getElementById(inputId).value;
    console.log('Function called with inputId:', inputId, 'labelId:', labelId);
}

// POI functions
const pointsOfInterestModal = new bootstrap.Modal(document.getElementById("pointsOfInterestModal"));

function savePointOfInterest() {
    // Reset previous validation errors
    resetValidationErrors();

    // Get values from the form
    const poiName = document.getElementById('poiName').value;
    const poiLatitude = parseFloat(document.getElementById('poiLatitude').value);
    const poiLongitude = parseFloat(document.getElementById('poiLongitude').value);
    const poiDescription = document.getElementById("poiDescription").value;
    const poiType = document.getElementById("poiType").value;

    // Check if required fields are empty
    if (!poiName || isNaN(poiLatitude) || isNaN(poiLongitude) || !poiType) {
        const errorMessage = document.getElementById('poiErrorMessage');
        errorMessage.style.display = 'block';
        return;
    }

    // Validate longitude and latitude ranges
    if (poiLongitude < -180.0 || poiLongitude > 180.0) {
        displayValidationError('Please enter a valid longitude between -180.0 and 180.0.', 'poiLongitude');
        return;
    }

    if (poiLatitude < -90.0 || poiLatitude > 90.0) {
        displayValidationError('Please enter a valid latitude between -90.0 and 90.0.', 'poiLatitude');
        return;
    }

    // Continue with saving the point of interest if validation passes
    appendNewPOI(poiName, poiType, poiDescription, poiLatitude, poiLongitude);

    // Clear the input fields in the modal
    document.getElementById('poiName').value = '';
    document.getElementById('poiLatitude').value = '';
    document.getElementById('poiLongitude').value = '';
    document.getElementById('poiDescription').value = '';
    document.getElementById('poiType').value = 'Select type';

    // Close the modal
    pointsOfInterestModal.hide();
}

function displayValidationError(message, fieldId) {
    // Display error message for the specified field
    let field = document.getElementById(fieldId);
    field.classList.add('is-invalid');
    field.nextElementSibling.innerText = message;
    field.nextElementSibling.style.color = 'red';
    field.nextElementSibling.style.display = 'block';
}

function resetValidationErrors() {
    // Reset all error messages and styling
    let formElements = document.getElementById('poiForm').elements;
    for (let i = 0; i < formElements.length; i++) {
        let element = formElements[i];
        if (element.type !== 'hidden') {
            element.classList.remove('is-invalid');
            if (element.nextElementSibling && element.nextElementSibling.className === 'invalid-feedback') {
                element.nextElementSibling.style.display = 'none';
            }
        }
    }
    document.getElementById('poiErrorMessage').style.display = 'none';
}

function appendNewPOI(poiName, poiType, poiDescription, poiLatitude, poiLongitude) {
    const poiContainer = document.getElementById("poiContainer");
    const poiTemplate = document.getElementById("poiTemplate");

    const pointOfInterest = poiTemplate.content.cloneNode(true);
    const name = pointOfInterest.querySelector(".poiTempName");
    const type = pointOfInterest.querySelector(".poiTempType");
    const description = pointOfInterest.querySelector(".poiTempDescription");
    const coordinates = pointOfInterest.querySelector(".poiTempCoordinates");

    const poiNameInput = pointOfInterest.querySelector(".poiNameInput");
    const poiTypeInput = pointOfInterest.querySelector(".poiTypeInput");
    const poiLatitudeInput = pointOfInterest.querySelector(".poiLatitudeInput");
    const poiLongitudeInput = pointOfInterest.querySelector(".poiLongitudeInput");

    const typeTextNode = document.createTextNode(poiType);
    const coordinatesTextNode = document.createTextNode(`${poiLatitude}, ${poiLongitude}`);

    name.innerText = poiName;
    type.appendChild(typeTextNode);
    coordinates.appendChild(coordinatesTextNode);

    poiNameInput.value = poiName;
    poiTypeInput.value = poiType;
    poiLatitudeInput.value = poiLatitude;
    poiLongitudeInput.value = poiLongitude;

    if (poiDescription) {
        const descriptionTextNode = document.createTextNode(poiDescription);
        description.appendChild(descriptionTextNode);

        const poiDescriptionInput = pointOfInterest.querySelector(".poiDescriptionInput");
        poiDescriptionInput.value = poiDescription;
    } else {
        description.remove();
    }

    if (!cardToEdit) {
        poiContainer.appendChild(pointOfInterest);
        return;
    }

    cardToEdit.before(pointOfInterest);
    cardToEdit = cardToEdit.remove();
}

let cardToEdit;
let poiIDArray = [];

function deletePointOfInterest(button, isEdit) {
    if (isEdit) {
        const poiID = document.getElementById("hiddenPoiID").value;
        poiIDArray.push(poiID);
    }

    // Get the parent card element and remove it
    const card = button.closest('.pointOfInterest');
    card.remove();
}

function editPointOfInterest(editButton) {
    const card = editButton.closest('.pointOfInterest');
    const cardPOIName = card.querySelector(".poiTempName");
    const cardPOIType = card.querySelector(".poiTempType");
    const cardPOICoordinates = card.querySelector(".poiTempCoordinates");
    const cardPOIDescription = card.querySelector(".poiTempDescription");

    const latitude = cardPOICoordinates.innerText.split(", ")[0];
    const longitude = cardPOICoordinates.innerText.split(", ")[1];

    document.getElementById('poiName').value = cardPOIName.innerText;
    document.getElementById("poiType").value = cardPOIType.innerText.slice(6);
    document.getElementById('poiLatitude').value = latitude.slice(17);
    document.getElementById('poiLongitude').value = longitude;

    if (cardPOIDescription) {
        document.getElementById('poiDescription').value = cardPOIDescription.innerText.slice(13);
    } else {
        document.getElementById('poiDescription').value = '';
    }

    const errorMessage = document.getElementById('poiErrorMessage');
    errorMessage.style.display = 'none';

    cardToEdit = card;

    pointsOfInterestModal.show();
}

// functions to save form input
function saveInput(isEdit) {
    shouldPromptBeforeUnload = false;

    if (isEdit) {
        document.getElementById("coverImageInput").required = false;
    }

    let requiredInputs = document.querySelectorAll("[required]:not(.exclude-from-validation)");
    let allInputsFilled = true;

    for (let i = 0; ((i < requiredInputs.length) && (allInputsFilled === true)); i += 1) {
        if (!requiredInputs[i].value.trim()) {
            allInputsFilled = false;
        }
    }

    if (allInputsFilled && !isEdit) {
        const fileInput = document.getElementById('coverImageInput');
        const file = fileInput.files[0];
        document.getElementById("createHikeOverview").submit();
    }
}

// image functions
function uploadImageToServer(file) {
    const formData = new FormData();
    formData.append('image', file);

    // Send a POST request to your server endpoint to handle the image upload
    fetch('/api/image', {
        method: 'POST',
        body: formData,
    })
        .then(response => response.json())
        .then(data => {
            console.log(data); // Log the server response
            const hiddenInput = document.getElementById('hiddenImageId');
            hiddenInput.value = data.pictureID;
            alert(data.pictureID);
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error uploading image.');
        });
}

function previewImage(inputId, previewId) {
    const input = document.getElementById(inputId);
    const preview = document.getElementById(previewId);

    // Check if input and preview element are present
    if (input && preview) {
        // Add EventListener for the event that the input changes
        input.addEventListener("change", function () {
            const [file] = input.files;

            // Check if a file is present and check for its file type
            if (file && (file.type === "image/png" || file.type === "image/jpeg")) {
                // Display the preview
                preview.src = URL.createObjectURL(file);
                preview.style.display = "block";
                uploadImageToServer(file);
            } else {
                input.classList.add("is-invalid");
                preview.style.display = "none";
            }
        });
    }
}

function handleCoverImage() {
    const input = document.getElementById('coverImageInput');
    const preview = document.getElementById('previewCoverImage');

    input.addEventListener('change', function () {
        const file = input.files[0];


        if (file && (file.type === 'image/png' || file.type === 'image/jpeg')) {
            const reader = new FileReader();

            reader.onload = function (e) {
                const img = new Image();

                img.onload = function () {
                    // Resize the image (you can adjust width and height as needed)
                    const canvas = document.createElement('canvas');
                    const ctx = canvas.getContext('2d');
                    canvas.width = 300; // set your desired width
                    canvas.height = (300 * img.height) / img.width; // maintain aspect ratio
                    ctx.drawImage(img, 0, 0, canvas.width, canvas.height);

                    // Compress the image (you can adjust quality as needed)
                    const compressedDataURL = canvas.toDataURL('image/jpeg', 0.7);

                    // Display the preview
                    preview.src = compressedDataURL;
                    preview.style.display = 'block';

                    // Optionally, you can upload the compressed image to a server here.
                    uploadImageToServer(compressedDataURL);
                };
                img.src = e.target.result.toString();
            };

            reader.readAsDataURL(file);
        }
    });
}

// prompt functions
let shouldPromptBeforeUnload = true; // Variable to track whether to prompt before unload

function cancelCancel(){
}

function confirmCancel() {
    let myModal = new bootstrap.Modal(document.getElementById('cancelConfirmationModal'), {
        keyboard: false
    });
    myModal.show();
}

function cancelProcess() {
    shouldPromptBeforeUnload = false;
    window.location.href = "/profile_hike_list/profile_hike_list.jsp"
}

// function to prompt
window.onbeforeunload = function () {
    if (shouldPromptBeforeUnload) {
        return 'Do you really want to leave this page?';
    }
}

// map functions
function initializeNewMap() {
    let newMap = new L.Map('map').setView([47.4167, 9.7500], 11);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(newMap);

    let startMarker, destinationMarker, route;

    let markerCount = 0;
    newMap.on('click', function(event) {
        let clickedLatLng = event.latlng;

        if ((!startMarker) && (markerCount < 2)) {
            showMarkerModal("Enter a name for the start point", "Enter start name", () => {
                let startName = document.getElementById("markerModalNameInput").value;

                markerCount += 1;
                startMarker = L.marker(clickedLatLng, { draggable: true });

                let popupContent = `<strong>Start:</strong> ${startName}<br><strong>Coordinates:</strong> ${startMarker.getLatLng().lat} N, ${startMarker.getLatLng().lng} E <br><br><button id="removeStartBtnNewMap" type="button" class="btn btn-danger btn-sm">Remove Start</button>`;
                startMarker.bindPopup(popupContent);
                startMarker.bindTooltip("<strong>Start: </strong>" + startName);

                startMarker.addTo(newMap);

                if (startMarker && destinationMarker) {
                    route = L.polyline([startMarker.getLatLng(), destinationMarker.getLatLng()]).addTo(newMap);
                }

                updateStart(startName, startMarker);

                startMarker.on('dragend', function() {
                    startMarker.getPopup().setContent(`<strong>Start:</strong> ${startName}<br><strong>Coordinates:</strong> ${startMarker.getLatLng().lat} N, ${startMarker.getLatLng().lng} E <br><br><button id="removeStartBtnNewMap" type="button" class="btn btn-danger btn-sm">Remove Start</button>`);
                    route = updatePolyline(startMarker, destinationMarker, route);
                    updateStart(startName, startMarker);
                });

                // Add click event to the "Remove Marker" button
                startMarker.on('popupopen', function() {
                    document.getElementById('removeStartBtnNewMap').addEventListener('click', function() {
                        newMap.removeLayer(startMarker);
                        markerCount -= 1;
                        startMarker = null; // Reset the marker
                        updateStart("", startMarker);
                        if (route) {
                            newMap.removeLayer(route);
                            route = null; // Reset the route
                        }
                    });
                });
            });
        }
        else if ((!destinationMarker) && (markerCount < 2)) {
            showMarkerModal("Enter a name for the destination point", "Enter destination name", () => {
                let destinationName = document.getElementById("markerModalNameInput").value;

                markerCount += 1;
                destinationMarker = L.marker(clickedLatLng, { draggable: true });

                let popupContent = `<strong>Destination:</strong> ${destinationName}<br><strong>Coordinates:</strong> ${destinationMarker.getLatLng().lat} N, ${destinationMarker.getLatLng().lng} E <br><br><button id="removeDestBtnNewMap" type="button" class="btn btn-danger btn-sm">Remove Destination</button>`;
                destinationMarker.bindPopup(popupContent);
                destinationMarker.bindTooltip("<strong>Destination: </strong>" + destinationName);

                destinationMarker.addTo(newMap);

                if (startMarker && destinationMarker) {
                    route = L.polyline([startMarker.getLatLng(), destinationMarker.getLatLng()]).addTo(newMap);
                }

                updateDestination(destinationName, destinationMarker);

                destinationMarker.on('dragend', function() {
                    destinationMarker.getPopup().setContent(`<strong>Destination:</strong> ${destinationName}<br><strong>Coordinates:</strong> ${destinationMarker.getLatLng().lat} N, ${destinationMarker.getLatLng().lng} E <br><br><button id="removeDestBtnNewMap" type="button" class="btn btn-danger btn-sm">Remove Destination</button>`);
                    route = updatePolyline(startMarker, destinationMarker, route);
                    updateDestination(destinationName, destinationMarker);
                });

                destinationMarker.on('popupopen', function() {
                    document.getElementById('removeDestBtnNewMap').addEventListener('click', function() {
                        newMap.removeLayer(destinationMarker);
                        markerCount -= 1;
                        destinationMarker = null; // Reset the marker
                        updateDestination("", destinationMarker);
                        if (route) {
                            newMap.removeLayer(route);
                            route = null; // Reset the route
                        }
                    });
                });
            });
        }
    });


    const importGpxButton = document.getElementById('importGpxButton');

    // Add an event listener for the 'click' event
    importGpxButton.addEventListener('click', function() {
        importGpx();
    });
    function importGpx() {
        document.getElementById("gpxInput").click();
    }

    const gpxInput = document.getElementById('gpxInput');
    // Add an event listener for the 'change' event
    gpxInput.addEventListener('change', function(event) {
        var file = event.target.files[0];

        if (file) {
            // Create a FileReader to read the contents of the GPX file
            var reader = new FileReader();

            reader.onload = function (event) {
                var gpxContent = event.target.result;

                // Load GPX content and add it as a layer to the existing map
                var gpxLayer = new L.GPX(gpxContent, {
                    async: true,
                }).on('loaded', function (e) {
                    newMap.fitBounds(e.target.getBounds()); // Fit the map to the GPX bounds
                }).addTo(newMap);
            };
            reader.readAsText(file); // Read the file as text
        }
        handleGpxFile(file)
    });

    function handleGpxFile(input) {
        if (input) {
            const [file] = input.files;
            const splitFileType = file.name.split(".");
            const fileType = splitFileType[splitFileType.length - 1];

            // Check if a file is present and check for its file type
            if (!file || fileType !== "gpx") {
                input.classList.add("is-invalid");
                return;
            }

            input.classList.remove("is-invalid");
            autoFillStartDestination(file);

            // Read the GPX content using FileReader
            const reader = new FileReader();

            reader.onload = function (e) {
                const gpxContent = e.target.result;

                // Send the GPX content to the server
                sendGpxToServer(gpxContent);
            };
            reader.readAsText(file);
        }
    }
}



function initializeEditMap() {
    let startName = document.getElementById("startNameInput").value;
    let startLatitude = document.getElementById("latitudeStartCoordinateInput").value;
    let startLongitude = document.getElementById("longitudeStartCoordinateInput").value;

    let destinationName = document.getElementById("destinationNameInput").value;
    let destinationLatitude = document.getElementById("latitudeDestinationCoordinateInput").value;
    let destinationLongitude = document.getElementById("longitudeDestinationCoordinateInput").value;

    let editMap = new L.Map('map');
    let startBound = L.latLng(startLatitude, startLongitude);
    let destinationBound = L.latLng(destinationLatitude, destinationLongitude);
    let bounds = L.latLngBounds(startBound, destinationBound);
    editMap.fitBounds(bounds);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(editMap);

    let startMarker = L.marker([startLatitude, startLongitude], { draggable: true }).addTo(editMap);
    startMarker.bindPopup(`<strong>Start:</strong> ${startName}<br><strong>Coordinates:</strong> ${startMarker.getLatLng().lat} N, ${startMarker.getLatLng().lng} E <br><br><button id="removeStartBtnEditHike" type="button" class="btn btn-danger btn-sm">Remove Start</button>`);
    startMarker.bindTooltip("<strong>Start: </strong>" + startName);

    let destinationMarker = L.marker([destinationLatitude, destinationLongitude], { draggable: true }).addTo(editMap);
    destinationMarker.bindPopup(`<strong>Destination:</strong> ${destinationName}<br><strong>Coordinates:</strong> ${destinationMarker.getLatLng().lat} N, ${destinationMarker.getLatLng().lng} E <br><br><button id="removeDestBtnEditMap" type="button" class="btn btn-danger btn-sm" onclick="removeMarker(destinationMarker)">Remove Destination</button>`);
    destinationMarker.bindTooltip("<strong>Destination: </strong>" + destinationName)

    let route = L.polyline([
        [startLatitude, startLongitude],
        [destinationLatitude, destinationLongitude]
    ]).addTo(editMap);

    startMarker.on('dragend', function() {
        let popupContent = `<strong>Start:</strong> ${startName}<br><strong>Coordinates:</strong> ${startMarker.getLatLng().lat} N, ${startMarker.getLatLng().lng} E <br><br><button id="removeStartBtnEditHike" type="button" class="btn btn-danger btn-sm">Remove Start</button>`;
        startMarker.getPopup().setContent(popupContent);
        updateStart(startName, startMarker);
        route = updatePolyline(startMarker, destinationMarker, route);
    });

    // Add click event to the "Remove Marker" button
    startMarker.on('popupopen', function() {
        document.getElementById('removeStartBtnEditHike').onclick = function() {
            editMap.removeLayer(startMarker);
            markerCount -= 1;
            startMarker = null; // Reset the marker
            updateStart("", startMarker);
            if (route) {
                editMap.removeLayer(route);
                route = null; // Reset the route
            }
        };
    });

    destinationMarker.on('dragend', function() {
        let popupContent = `<strong>Destination:</strong> ${destinationName}<br><strong>Coordinates:</strong> ${destinationMarker.getLatLng().lat} N, ${destinationMarker.getLatLng().lng} E <br><br><button id="removeDestBtnEditMap" type="button" class="btn btn-danger btn-sm">Remove Destination</button>`;
        destinationMarker.getPopup().setContent(popupContent);
        updateDestination(destinationName, destinationMarker);
        route = updatePolyline(startMarker, destinationMarker, route);
    });

    // Add click event to the "Remove Marker" button
    destinationMarker.on('popupopen', function() {
        document.getElementById('removeDestBtnEditMap').onclick = function() {
            editMap.removeLayer(destinationMarker);
            markerCount -= 1;
            destinationMarker = null; // Reset the marker
            updateDestination("", destinationMarker);
            if (route) {
                editMap.removeLayer(route);
                route = null; // Reset the route
            }
        };
    });

    let markerCount = 2;
    editMap.on('click', function(event) {
        let clickedLatLng = event.latlng;

        if ((!startMarker) && (markerCount < 2)) {
            showMarkerModal("Enter a name for the start point", "Enter start name", () => {
                startName = document.getElementById("markerModalNameInput").value;

                markerCount += 1;
                startMarker = L.marker(clickedLatLng, { draggable: true });

                let popupContent = `<strong>Start:</strong> ${startName}<br><strong>Coordinates:</strong> ${startMarker.getLatLng().lat} N, ${startMarker.getLatLng().lng} E <br><br><button id="removeStartBtnEditHike" type="button" class="btn btn-danger btn-sm">Remove Start</button>`;
                startMarker.bindPopup(popupContent);
                startMarker.bindTooltip("<strong>Start: </strong>" + startName);

                startMarker.addTo(editMap);

                updateStart(startName, startMarker);

                // create polyline with coordinates from markers if both they exist
                if (startMarker && destinationMarker) {
                    route = L.polyline([startMarker.getLatLng(), destinationMarker.getLatLng()]).addTo(editMap);
                }

                startMarker.on('dragend', function() {
                    let popupContent = `<strong>Start:</strong> ${startName}<br><strong>Coordinates:</strong> ${startMarker.getLatLng().lat} N, ${startMarker.getLatLng().lng} E <br><br><button id="removeStartBtnEditHike" type="button" class="btn btn-danger btn-sm">Remove Start</button>`;
                    startMarker.getPopup().setContent(popupContent);
                    updateStart(startName, startMarker);
                    route = updatePolyline(startMarker, destinationMarker, route);
                });

                // Add click event to the "Remove Marker" button
                startMarker.on('popupopen', function() {
                    document.getElementById('removeStartBtnEditHike').onclick = function() {
                        editMap.removeLayer(startMarker);
                        markerCount -= 1;
                        startMarker = null; // Reset the marker
                        updateStart("", startMarker);
                        if (route) {
                            editMap.removeLayer(route);
                            route = null; // Reset the route
                        }
                    };
                });
            });
        }
        else if ((!destinationMarker) && (markerCount < 2)) {
            showMarkerModal("Enter a name for the destination point", "Enter destination name", () => {
                destinationName = document.getElementById("markerModalNameInput").value;

                markerCount += 1;
                destinationMarker = L.marker(clickedLatLng, { draggable: true });

                // create tooltip and pop up and open it
                let popupContent = `<strong>Destination:</strong> ${destinationName}<br><strong>Coordinates:</strong> ${destinationMarker.getLatLng().lat} N, ${destinationMarker.getLatLng().lng} E <br><br><button id="removeDestBtnEditMap" type="button" class="btn btn-danger btn-sm">Remove Destination</button>`;
                destinationMarker.bindPopup(popupContent);
                destinationMarker.bindTooltip("<strong>Destination: </strong>" + destinationName);

                destinationMarker.addTo(editMap);

                updateDestination(destinationName, destinationMarker);

                // create polyline with coordinates from markers if both they exist
                if (startMarker && destinationMarker) {
                    route = L.polyline([startMarker.getLatLng(), destinationMarker.getLatLng()]).addTo(editMap);
                }

                destinationMarker.on('dragend', function() {
                    let popupContent = `<strong>Destination:</strong> ${destinationName}<br><strong>Coordinates:</strong> ${destinationMarker.getLatLng().lat} N, ${destinationMarker.getLatLng().lng} E <br><br><button id="removeDestBtnEditMap" type="button" class="btn btn-danger btn-sm">Remove Destination</button>`;
                    destinationMarker.getPopup().setContent(popupContent);
                    updateDestination(destinationName, destinationMarker);
                    route = updatePolyline(startMarker, destinationMarker, route);
                });

                // Add click event to the "Remove Marker" button
                destinationMarker.on('popupopen', function() {
                    document.getElementById('removeDestBtnEditMap').onclick = function() {
                        editMap.removeLayer(destinationMarker);
                        markerCount -= 1;
                        destinationMarker = null; // Reset the marker
                        updateDestination("", destinationMarker);
                        if (route) {
                            editMap.removeLayer(route);
                            route = null; // Reset the route
                        }
                    };
                });
            });
        }
    });
}

function updatePolyline(startMarker, destinationMarker, route) {
    if (startMarker && destinationMarker && route) {
        // Update the polyline with the new coordinates
        route.setLatLngs([startMarker.getLatLng(), destinationMarker.getLatLng()]);
    }
    return route;
}


function updateStart(startName, startMarker) {
    const startNameInput = document.getElementById("startNameInput");
    const latitudeStartCoordinateInput = document.getElementById("latitudeStartCoordinateInput");
    const longitudeStartCoordinateInput = document.getElementById("longitudeStartCoordinateInput");

    if (startMarker != null) {
        startNameInput.value = startName;
        latitudeStartCoordinateInput.value = parseFloat(startMarker.getLatLng().lat).toFixed(6).replace(',', '.');
        longitudeStartCoordinateInput.value = parseFloat(startMarker.getLatLng().lng).toFixed(6).replace(',', '.');
        latitudeStartCoordinateInput.setAttribute("readonly", "");
        longitudeStartCoordinateInput.setAttribute("readonly", "");
    }
    else {
        startNameInput.value = "";
        latitudeStartCoordinateInput.value = "";
        longitudeStartCoordinateInput.value = "";
    }
}

function updateDestination(destinationName, destinationMarker) {
    const destinationNameInput = document.getElementById("destinationNameInput");
    const latitudeDestinationCoordinateInput = document.getElementById("latitudeDestinationCoordinateInput");
    const longitudeDestinationCoordinateInput = document.getElementById("longitudeDestinationCoordinateInput");

    if (destinationMarker != null) {
        destinationNameInput.value = destinationName;
        latitudeDestinationCoordinateInput.value = parseFloat(destinationMarker.getLatLng().lat).toFixed(6).replace(',', '.');
        longitudeDestinationCoordinateInput.value = parseFloat(destinationMarker.getLatLng().lng).toFixed(6).replace(',', '.');
        latitudeDestinationCoordinateInput.setAttribute("readonly", "");
        longitudeDestinationCoordinateInput.setAttribute("readonly", "");
    }
    else {
        destinationNameInput.value = "";
        latitudeDestinationCoordinateInput.value = "";
        longitudeDestinationCoordinateInput.value = "";
    }
}

function showMarkerModal(markerModalHeader, markerModalNameInput, onModalSave) {
    const markerModal = new bootstrap.Modal(document.getElementById("markerModal"));

    const modalHeader = document.getElementById("markerModalHeader");
    const modalInput = document.getElementById("markerModalNameInput");
    const markerModalSaveButton = document.getElementById("markerModalSaveButton");
    const markerNameErrorMessage = document.getElementById("markerNameErrorMessage");

    modalHeader.innerText = markerModalHeader;
    modalInput.placeholder = markerModalNameInput;
    markerModalSaveButton.onclick = () => {
        if (modalInput.value) {
            onModalSave();
            modalInput.value = "";
            markerNameErrorMessage.style.display = "none";
            markerModal.hide();
        }
        else {
            markerNameErrorMessage.style.display = "block";
        }
    };

    markerModal.show();
}

// toast functions
function createToast(id, message) {
    // Create the toast container
    let toastContainer = document.createElement('div');
    toastContainer.className = 'toast position-fixed bottom-0 end-0 align-items-center text-white bg-danger border-0';
    toastContainer.id = id;
    toastContainer.setAttribute('role', 'alert');
    toastContainer.setAttribute('aria-live', 'assertive');
    toastContainer.setAttribute('aria-atomic', 'true');

    let flexContainer = document.createElement('div');
    flexContainer.className = 'd-flex';

    // Create the toast body
    let toastBody = document.createElement('div');
    toastBody.className = 'toast-body';
    toastBody.textContent = message;

    // Create the close button
    let closeButton = document.createElement('button');
    closeButton.type = 'button';
    closeButton.className = 'btn-close btn-close-white me-2 m-auto';
    closeButton.setAttribute('data-bs-dismiss', 'toast');
    closeButton.setAttribute('aria-label', 'Close');

    // Append elements to the toast container
    toastContainer.appendChild(flexContainer);
    flexContainer.appendChild(toastBody);
    flexContainer.appendChild(closeButton);

    // Append the toast container to the body
    document.body.appendChild(toastContainer);
}

function showToast(id) {
    let toast = new bootstrap.Toast(document.getElementById(id));
    toast.show();
}


function autoFillStartDestination(file) {
    const reader = new FileReader();

    reader.onload = function (e) {
        const gpxData = e.target.result;
        const parser = new DOMParser();
        const xmlDoc = parser.parseFromString(gpxData, "text/xml");

        const trackPoints = xmlDoc.querySelectorAll("rtept").length === 0 ? xmlDoc.querySelectorAll("trkpt") : xmlDoc.querySelectorAll("rtept");

        if (trackPoints.length !== 0) {
            const startPoint = trackPoints[0];
            const startNameElement = startPoint.querySelector("name");
            const startName = startNameElement ? startNameElement.textContent : "";

            const destinationPoint = trackPoints[trackPoints.length - 1];
            const destinationNameElement = destinationPoint.querySelector("name");
            const destinationName = destinationNameElement ? destinationNameElement.textContent : "";

            document.getElementById("startNameInput").value = startName;
            document.getElementById("latitudeStartCoordinateInput").value = startPoint.getAttribute("lat");
            document.getElementById("longitudeStartCoordinateInput").value = startPoint.getAttribute("lon");

            document.getElementById("destinationNameInput").value = destinationName;
            document.getElementById("latitudeDestinationCoordinateInput").value = destinationPoint.getAttribute("lat");
            document.getElementById("longitudeDestinationCoordinateInput").value = destinationPoint.getAttribute("lon");
        }
    };

    reader.readAsText(file);
}

function sendGpxToServer(gpxContent) {
    // Use fetch or XMLHttpRequest to send the GPX content to the server
    fetch('/save_data', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({gpxContent}),
    })
        .then(response => response.json())
        .then(data => {
            console.log('Response from server:', data);
            // Optionally handle the response from the server
        })
        .catch(error => {
            console.error('Error sending GPX content to server:', error);
        });
}



function clearStartDestInputs() {
    document.getElementById('markerModalNameInput').value = '';
}