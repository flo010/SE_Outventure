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
    if (!poiName || isNaN(poiLatitude) || isNaN(poiLongitude) || poiType === "Select type") {
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

function openPoiModal() {
    // JavaScript code to activate the modal
    let pointsOfInterestModal = new bootstrap.Modal(document.getElementById("pointsOfInterestModal"));

    pointsOfInterestModal.show();
}

let cardToEdit;

function deletePointOfInterest(button) {
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

    openPoiModal();
}

// functions to save form input
function saveInput() {
    let requiredInputs = document.querySelectorAll("[required]:not(.exclude-from-validation)");
    let allInputsFilled = true;

    for (let i = 0; ((i < requiredInputs.length) && (allInputsFilled === true)); i += 1) {
        if (!requiredInputs[i].value.trim()) {
            allInputsFilled = false;
        }
    }

    if (allInputsFilled) {
        const fileInput = document.getElementById('coverImageInput');
        const file = fileInput.files[0];

        if (file) {
            uploadImageToServer(file);
            shouldPromptBeforeUnload = false;
            document.getElementById("createHikeOverview").submit();
        } else {
            // Handle case when no file is selected
            console.error('No file selected');
            alert('Please select a file.');
        }
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
            hiddenInput.value = 1;
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
    window.location.href = "/index/index.jsp";
}

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

    let container = document.getElementById("monthContainer");

    for (let i = 0; i < months.length; i++) {
        // Create the month div
        let monthDiv = document.createElement("div");
        monthDiv.className = "form-check form-check-inline";

        // Create the checkbox input
        let checkboxInput = document.createElement("input");
        checkboxInput.className = "form-check-input months";
        checkboxInput.type = "checkbox";
        checkboxInput.id = "optimalSeason" + months[i];
        checkboxInput.value = "false";
        checkboxInput.name = "monthCheckbox" + months[i]; // Added name attribute

        // Create the label for the checkbox
        let label = document.createElement("label");
        label.className = "form-check-label";
        label.setAttribute("for", "monthCheckbox" + i);
        label.innerText = months[i];

        checkboxInput.addEventListener("change", function () {
            // Update the value of the checkbox based on its checked state
            checkboxInput.value = checkboxInput.checked ? "true" : "false";
        });

        // Append the input and label to the month div
        monthDiv.appendChild(checkboxInput);
        monthDiv.appendChild(label);

        // Append the month div to the container
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
                    let toast = new bootstrap.Toast(document.getElementById("validationToast"));
                    toast.show();
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }, false);
})();

// function to prompt
window.onbeforeunload = function () {
    if (shouldPromptBeforeUnload) {
        return 'Do you really want to leave this page?';
    }
}

// map functions
function initializeMap() {
    let map = new L.Map('map').setView([47.4167, 9.7500], 13);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    let startMarker, destinationMarker, route;

    map.on('click', function(event) {
        let clickedLatLng = event.latlng;
        let markerCount = 0;

        if ((!startMarker) && (markerCount <= 2)) {
            // Prompt for entering a name for the start point
            let startName = prompt('Enter a name for the start point:');
            if (startName) {
                markerCount += 1;
                startMarker = L.marker(clickedLatLng, { draggable: true }).addTo(map);
                startMarker.bindPopup(`<strong>Start:</strong> ${startName}<br><strong>Coordinates:</strong> ${startMarker.getLatLng().lat} N, ${startMarker.getLatLng().lng} E`).openPopup();
                startMarker.bindTooltip("<strong>Start: </strong>" + startName);

                startMarker.on('dragend', function(event) {
                    startMarker.getPopup().setContent(`<strong>Start:</strong> ${startName}<br><strong>Coordinates:</strong> ${startMarker.getLatLng().lat} N, ${startMarker.getLatLng().lng} E`);
                    route = updatePolyline(startMarker, destinationMarker, route);
                    updateStart(startName, startMarker);
                });

                updateStart(startName, startMarker);
            }
        }
        else if ((!destinationMarker) && (markerCount <= 2)) {
            // Prompt for entering a name for the end point
            let destinationName = prompt('Enter a name for the end point:');
            if (destinationName) {
                markerCount += 1;
                destinationMarker = L.marker(clickedLatLng, { draggable: true }).addTo(map);
                destinationMarker.bindPopup(`<strong>Destination:</strong> ${destinationName}<br><strong>Coordinates:</strong> ${destinationMarker.getLatLng().lat} N, ${destinationMarker.getLatLng().lng} E`).openPopup();
                destinationMarker.bindTooltip("<strong>Destination: </strong>" + destinationName);

                destinationMarker.on('dragend', function(event) {
                    destinationMarker.getPopup().setContent(`<strong>Destination:</strong> ${destinationName}<br><strong>Coordinates:</strong> ${destinationMarker.getLatLng().lat} N, ${destinationMarker.getLatLng().lng} E`);
                    route = updatePolyline(startMarker, destinationMarker, route);
                    updateDestination(destinationName, destinationMarker);
                });

                route = L.polyline([startMarker.getLatLng(), destinationMarker.getLatLng()]).addTo(map);

                updateDestination(destinationName, destinationMarker);
            }
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

// Call the function when the DOM is ready
document.addEventListener('DOMContentLoaded', function () {
    initializePage();
    setTimeout(initializeMap, 10);
});

function updateStart(startName, startMarker) {
    const startNameInput = document.getElementById("startNameInput");
    const latitudeStartCoordinateInput = document.getElementById("latitudeStartCoordinateInput");
    const longitudeStartCoordinateInput = document.getElementById("longitudeStartCoordinateInput");

    startNameInput.value = startName;
    latitudeStartCoordinateInput.value = startMarker.getLatLng().lat;
    longitudeStartCoordinateInput.value = startMarker.getLatLng().lng;

    startNameInput.setAttribute("disabled", "");
    latitudeStartCoordinateInput.setAttribute("disabled", "");
    longitudeStartCoordinateInput.setAttribute("disabled", "");
}

function updateDestination(destinationName, destinationMarker) {
    const destinationNameInput = document.getElementById("destinationNameInput");
    const latitudeDestinationCoordinateInput = document.getElementById("latitudeDestinationCoordinateInput");
    const longitudeDestinationCoordinateInput = document.getElementById("longitudeDestinationCoordinateID");

    destinationNameInput.value = destinationName;
    latitudeDestinationCoordinateInput.value = destinationMarker.getLatLng().lat;
    longitudeDestinationCoordinateInput.value = destinationMarker.getLatLng().lng;

    destinationNameInput.setAttribute("disabled", "");
    latitudeDestinationCoordinateInput.setAttribute("disabled", "");
    longitudeDestinationCoordinateInput.setAttribute("disabled", "");
}