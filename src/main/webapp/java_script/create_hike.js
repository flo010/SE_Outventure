// functions for switching pills
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
    var rangeInput = document.getElementById(id);
    var rangeValue = document.getElementById(labelId);

    rangeInput.addEventListener('input', function () {
        rangeValue.textContent = rangeInput.value;
    });
}

// POI modal functions
var pointsOfInterestModal = new bootstrap.Modal(document.getElementById("pointsOfInterestModal"));

function savePointOfInterest() {
    // Get values from the form
    const poiName = document.getElementById('poiName').value;
    const poiLatitude = document.getElementById('latitude').value;
    const poiLongitude = document.getElementById('longitude').value;
    const poiDescription = document.getElementById("poiDescription").value;

    // Check if required fields are empty
    if (!poiName || !poiLatitude || !poiLongitude) {
        const errorMessage = document.getElementById('poiErrorMessage');
        errorMessage.style.display = 'block';
        return;
    }

    appendNewPOI(poiName, poiLatitude, poiLongitude, poiDescription);

    // Close the modal
    pointsOfInterestModal.hide();
}

function appendNewPOI(poiName, poiLatitude, poiLongitude, poiDescription) {
    const poiContainer = document.getElementById("poiContainer");
    const poiTemplate = document.getElementById("poiTemplate");

    const pointOfInterest = poiTemplate.content.cloneNode(true);
    const name = pointOfInterest.getElementById("poiTempName");
    const coordinates = pointOfInterest.getElementById("poiTempCoordinates");

    const poiNameInput = pointOfInterest.getElementById("poiNameInput");
    const poiLatitudeInput = pointOfInterest.getElementById("poiLatitudeInput");
    const poiLongitudeInput = pointOfInterest.getElementById("poiLongitudeInput");
    const description = pointOfInterest.getElementById("poiTempDescription");

    const coordinatesTextNode = document.createTextNode(`${poiLatitude}, ${poiLongitude}`);
    name.textContent = poiName;
    coordinates.appendChild(coordinatesTextNode);
    poiNameInput.value = poiName;
    poiLatitudeInput.value = poiLatitude;
    poiLongitudeInput.value = poiLongitude;

    if (poiDescription) {
        const descriptionTextNode = document.createTextNode(poiDescription);
        description.appendChild(descriptionTextNode);
        const poiDescriptionInput = pointOfInterest.getElementById("poiDescriptionInput");
        poiDescriptionInput.value = poiDescription;
    } else {
        description.remove();
    }

    poiContainer.appendChild(pointOfInterest);
}

function saveInput() {
    let requiredInputs = document.querySelectorAll("[required]:not(.exclude-from-validation)");
    let allInputsFilled = true;

    for (let i = 0; ((i < requiredInputs.length) && (allInputsFilled === true)); i += 1) {
        if (!requiredInputs[i].value.trim()) {
            allInputsFilled = false;
        }
    }

    if (allInputsFilled) {

        shouldPromptBeforeUnload = false;
        document.getElementById("createHikeOverview").submit();
    }
}
