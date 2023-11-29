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
    let rangeInput = document.getElementById(id);
    let rangeValue = document.getElementById(labelId);

    rangeInput.addEventListener('input', function () {
        rangeValue.textContent = rangeInput.value;
    });
}

// POI modal functions

const pointsOfInterestModal = new bootstrap.Modal(document.getElementById("pointsOfInterestModal"));

function savePointOfInterest() {
    // Get values from the form
    const poiName = document.getElementById('poiName').value;
    const poiLatitude = document.getElementById('poiLatitude').value;
    const poiLongitude = document.getElementById('poiLongitude').value;
    const poiDescription = document.getElementById("poiDescription").value;
    const poiType = document.getElementById("poiType").value;

    // Check if required fields are empty
    if (!poiName || !poiLatitude || !poiLongitude || poiType === "Select type") {
        const errorMessage = document.getElementById('poiErrorMessage');
        errorMessage.style.display = 'block';
    }
    else {
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

let cardToEdit;

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

function deletePointOfInterest(button) {
    // Get the parent card element and remove it
    const card = button.closest('.pointOfInterest');
    card.remove();
}

// image functions
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
                img.src = e.target.result;
            };

            reader.readAsDataURL(file);
        }
    });
}

function importGpxButton() {
    document.getElementById("gpxInput").click();
}

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
    }
}