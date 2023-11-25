<%--
  Created by IntelliJ IDEA.
  User: Lea Roncero
  Date: 13.11.2023
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Create Hike Overview</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <jsp:include page="navbar.jsp"/>
        </header>


        <div class="container-sm mt-5 mb-5">
            <div class="progress mb-5">
                <div class="progress-bar bg-success" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                    20%
                </div>
            </div>

            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist"> <!-- insert nav-fill in class, when adding all tabs-->
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-overview-tab" data-bs-toggle="pill" data-bs-target="#pills-overview" type="button" role="tab" aria-controls="pills-overview" aria-selected="true" onclick="updateProgressBar()">Overview</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-details-tab" data-bs-toggle="pill" data-bs-target="#pills-details" type="button" role="tab" aria-controls="pills-details" aria-selected="false" onclick="updateProgressBar()">Details</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-route-tab" data-bs-toggle="pill" data-bs-target="#pills-route" type="button" role="tab" aria-controls="pills-route" aria-selected="false" onclick="updateProgressBar()">Route Description</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-poi-tab" data-bs-toggle="pill" data-bs-target="#pills-poi" type="button" role="tab" aria-controls="pills-poi" aria-selected="false" onclick="updateProgressBar()">Points of Interest</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-getting-there-tab" data-bs-toggle="pill" data-bs-target="#pills-getting-there" type="button" role="tab" aria-controls="pills-getting-there" aria-selected="false" onclick="updateProgressBar()">Getting There</button>
                </li>
            </ul>

            <hr>

            <form class="needs-validation" id="createHikeOverview" action="save_data" method="post" novalidate>
                <div class="tab-content mt-4" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-overview" role="tabpanel" aria-labelledby="pills-overview-tab" tabindex="0">
                        <div class="input-fields-group">
                            <label for="titleInput" class="form-label">Title *</label>
                            <input type="text" class="form-control" id="titleInput" name="titleInput" placeholder="Title" required maxlength="100" aria-describedby="titleHelpText">
                            <small id="titleHelpText" class="form-text text-muted">
                                The maximum length is 100 characters.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a title.
                            </div>
                        </div>
                        <div class="input-fields-group">
                            <label for="descriptionInput" class="form-label">Description *</label>
                            <textarea class="form-control" id="descriptionInput" name="descriptionInput" rows="8" placeholder="Description" required maxlength="1000" aria-describedby="descriptionHelpText"></textarea>
                            <small id="descriptionHelpText" class="form-text text-muted">
                                Describe your hike in a few sentences to provide an overview of the route. The maximum length is 1000 characters.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a description.
                            </div>
                        </div>
                        <div class="input-fields-group">
                            <label for="coverImageInput" class="form-label">Cover Image *</label><br>
                            <input onchange="handleCoverImage()" type="file" class="form-control" id="coverImageInput" name="coverImage" accept=".png, .jpg" required>
                            <div class="invalid-feedback alert alert-danger mt-2">
                                Invalid file type. Please provide a .png or.jpg.
                            </div>
                            <img id="previewCoverImage" width="250">
                            <input type="hidden" id="hiddenImageId" name="hiddenField">
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="button" id="nextButtonOverview" class="btn btn-success" onclick="nextTab()">Next</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonOverview" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-details" role="tabpanel" aria-labelledby="pills-details-tab" tabindex="0">
                        <div class="input-fields-group less-width">
                            <label for="distanceInput" class="form-label">Distance *</label>
                            <input type="text" class="form-control" id="distanceInput" name="distanceInput" placeholder="Distance" required maxlength="7" aria-describedby="distanceHelpText" pattern="\d+(\.\d{1,2})">
                            <small id="distanceHelpText" class="form-text text-muted">
                                The value must be specified as a decimal number in kilometers.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a valid distance.
                            </div>
                        </div>
                        <div class="input-fields-group less-width">
                            <div class="row">
                                <label for="hoursInput" class="form-label">Duration *</label>
                                <div class="col">
                                    <input type="text" class="form-control" id="hoursInput" name="hoursInput" placeholder="Hours" required maxlength="2" pattern="[0-9]{1,2}">
                                </div>
                                <div class="invalid-feedback">
                                    Please enter a valid duration.
                                </div>
                                <div class="col">
                                    <input type="number" min="0" max="59" class="form-control" id="minutesInput" name="minutesInput" placeholder="Minutes" required maxlength="2" aria-describedby="minutesHelpText" pattern="[0-5]?[0-9]">
                                    <small id="minutesHelpText" class="form-text text-muted">
                                        The value must be between 0 and 59.
                                    </small>
                                    <div class="invalid-feedback">
                                        Please enter a valid duration.
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="input-fields-group less-width">
                            <label for="altitudeInput" class="form-label">Altitude *</label>
                            <input type="text" class="form-control" id="altitudeInput" name="altitudeInput" placeholder="Altitude" required maxlength="10" aria-describedby="altitudeHelpText" pattern="\d{1,10}">
                            <small id="altitudeHelpText" class="form-text text-muted">
                                The value must be specified in meters.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a valid altitude.
                            </div>
                        </div>
                        <div class="input-fields-group less-width">
                            <div>
                                <label for="conditionInput" class="form-label">Required Condition *</label>
                                <input type="range" class="custom-range" id="conditionInput" name="conditionInput" min="1" max="5" step="1" value="0">
                                <label id="rangeValue1">1</label>
                            </div>
                            <div>
                                <label for="difficultyInput" class="form-label">Level of Difficulty *</label>
                                <input type="range" class="custom-range" id="difficultyInput" name="difficultyInput" min="1" max="5" step="1" value="0">
                                <label id="rangeValue2">1</label>
                            </div>
                            <div>
                                <label for="experienceInput" class="form-label">Required Experience *</label>
                                <input type="range" class="custom-range" id="experienceInput" name="experienceInput" min="1" max="5" step="1" value="0">
                                <label id="rangeValue3">1</label>
                            </div>
                            <div>
                                <label for="landscapeInput" class="form-label">Beauty of Landscape *</label>
                                <input type="range" class="custom-range" id="landscapeInput" name="landscapeInput" min="1" max="5" step="1" value="0">
                                <label id="rangeValue4">1</label>
                            </div>
                        </div>
                        <%--for loop for months--%>
                        <div class="input-fields-group">
                            <label class="form-label">Optimal Season *</label>
                            <div class="form-check form-check-inline" id="monthContainer">
                            </div>
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="button" id="nextButtonDetails" class="btn btn-success" onclick="nextTab()">Next</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="previousButtonDetails" class="btn btn-secondary" onclick="prevTab()">Previous</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonDetails" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-route" role="tabpanel" aria-labelledby="pills-route-tab" tabindex="0">
                        <div class="input-fields-group">
                            <label for="routeDescriptionInput" class="form-label">Route Description *</label>
                            <textarea class="form-control" id="routeDescriptionInput" name="routeDescriptionInput" rows="8" placeholder="Route Description" aria-describedby="routeHelpText" required maxlength="1000"></textarea>
                            <small id="routeHelpText" class="form-text text-muted">
                                Describe the route of your hike in detail. The maximum length is 1000 characters.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a route description.
                            </div>
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="button" id="nextButtonRoute" class="btn btn-success" onclick="nextTab()">Next</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="previousButtonRoute" class="btn btn-secondary" onclick="prevTab()">Previous</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonRoute" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="pills-poi" role="tabpanel" aria-labelledby="pills-poi-tab" tabindex="0">
                        <div class="input-fields-group less-width">
                            <label for="startNameInput" class="form-label">Start *</label>
                            <input type="text" class="form-control" id="startNameInput" name="startNameInput" placeholder="Name" aria-describedby="startLatitudeHelpText" required maxlength="100">
                            <div class="invalid-feedback">
                                Please enter a name for the starting point.
                            </div>
                            <input type="text" class="form-control mt-3" id="latitudeStartCoordinateInput" name="latitudeStartCoordinateInput" placeholder="Latitude" required maxlength="9" pattern="-?\d+(\.\d{1,7})?">
                            <small id="startLatitudeHelpText" class="form-text text-muted">
                                The value must be in the format XX.XXXXXX (negative sign optional).
                            </small>
                            <div class="invalid-feedback">
                                Please enter a valid latitude.
                            </div>
                            <input type="text" class="form-control mt-3" id="longitudeStartCoordinateInput" name="longitudeStartCoordinateInput" placeholder="Longitude" aria-describedby="startLongitudeHelpText" required maxlength="9" pattern="-?\d+(\.\d{1,7})?">
                            <small id="startLongitudeHelpText" class="form-text text-muted">
                                The value must be in the format XX.XXXXXX (negative sign optional).
                            </small>
                            <div class="invalid-feedback">
                                Please enter a valid longitude.
                            </div>
                        </div>
                        <div class="input-fields-group less-width">
                            <label for="destinationNameInput" class="form-label">Destination *</label>
                            <input type="text" class="form-control" id="destinationNameInput" name="destinationNameInput" placeholder="Name" required maxlength="100">
                            <div class="invalid-feedback">
                                Please enter a name for the destination point.
                            </div>
                            <input type="text" class="form-control mt-3" id="latitudeDestinationCoordinateInput" name="latitudeDestinationCoordinateInput" placeholder="Latitude" aria-describedby="destinationLatitudeHelpText" required maxlength="9" pattern="-?\d+(\.\d{1,7})?">
                            <small id="destinationLatitudeHelpText" class="form-text text-muted">
                                The value must be in the format XX.XXXXXX (negative sign optional).
                            </small>
                            <div class="invalid-feedback">
                                Please enter a valid latitude.
                            </div>
                            <input type="text" class="form-control mt-3" id="longitudeDestinationCoordinateID" name="longitudeDestinationCoordinateInput" placeholder="Longitude" aria-describedby="destinationLongitudeHelpText" required maxlength="9" pattern="-?\d+(\.\d{1,7})?">
                            <small id="destinationLongitudeHelpText" class="form-text text-muted">
                                The value must be in the format XX.XXXXXX (negative sign optional).
                            </small>
                            <div class="invalid-feedback">
                                Please enter a valid longitude.
                            </div>
                        </div>
                        <div>
                            <!-- List of Points of Interest -->
                            <div id="poiContainer" class="row">
                                <template id="poiTemplate">
                                    <div class="col-lg-6">
                                        <div class="card my-2">
                                            <div class="card-body">
                                                <h4 id="poiTempName" class="card-title text-center"></h4>
                                                <input type="hidden" id="poiNameInput" name="poiNameInput">
                                                <div class="d-flex justify-content-between align-items-center flex-wrap">
                                                    <div>
                                                        <p id="poiTempCoordinates">
                                                            <strong>GPS Coordinates: </strong>
                                                        </p>
                                                        <input type="hidden" id="poiLatitudeInput" name="poiLatitudeInput">
                                                        <input type="hidden" id="poiLongitudeInput" name="poiLongitudeInput">
                                                        <p id="poiTempDescription" class="text-break">
                                                            <strong>Description: </strong>
                                                        </p>
                                                        <input type="hidden" id="poiDescriptionInput" name="poiDescriptionInput">
                                                    </div>
                                                    <!-- Edit- und Delete-Buttons mit den gewünschten Symbolen -->
                                                    <div class="d-flex gap-2">
                                                        <!-- Edit-Button mit Stift-Icon -->
                                                        <span class="input-group-text" id="editCoordinates" onclick="editPointOfInterest()">
                                                             <i class="fa fa-pencil"></i>
                                                        </span>

                                                        <!-- Delete-Button mit Mülleimer-Icon -->
                                                        <span class="input-group-text" onclick="deletePointOfInterest(this)">
                                                             <i class="fa fa-trash"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="w-100"></div>
                                </template>
                            </div>
                            <!-- Add Points of Interest Button -->
                            <button type="button" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#pointsOfInterestModal">
                                <i class="fa fa-plus"></i> Add Points of Interest
                            </button>
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="button" id="nextButtonPOI" class="btn btn-success" onclick="nextTab()">Next</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="previousButtonPOI" class="btn btn-secondary" onclick="prevTab()">Previous</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonPOI" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-getting-there" role="tabpanel" aria-labelledby="pills-getting-there-tab" tabindex="0">
                        <div class="input-fields-group">
                            <label for="gettingThereInput" class="form-label">Getting There</label>
                            <textarea class="form-control" id="gettingThereInput" name="gettingThereInput" rows="8" placeholder="Getting There" aria-describedby="gettingThereHelpText" maxlength="1000"></textarea>
                            <small id="gettingThereHelpText" class="form-text text-muted">
                                Provide information on the best way to get to the starting point of your hike. The maximum length is 1000 characters.
                            </small>
                        </div>
                        <div class="input-fields-group">
                            <label for="parkingInput" class="form-label">Parking</label>
                            <textarea class="form-control" id="parkingInput" name="parkingInput" rows="8" placeholder="Parking" aria-describedby="parkingHelpText"maxlength="1000"></textarea>
                            <small id="parkingHelpText" class="form-text text-muted">
                                Provide information about the best parking options near the starting point of the hike. The maximum length is 1000 characters.
                            </small>
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="submit" id="saveButtonGettingThere" class="btn btn-success" onclick="saveInput()">Save</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="previousButtonGettingThere" class="btn btn-secondary" onclick="prevTab()">Previous</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonGettingThere" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                        <div class="toast position-fixed bottom-0 end-0 align-items-center text-white bg-danger border-0" id="validationToast" role="alert" aria-live="assertive" aria-atomic="true">
                            <div class="d-flex">
                                <div class="toast-body">
                                    Validation failed! Please check your input.
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <!-- Modal for Cancel -->
            <div class="modal fade" id="cancelConfirmationModal" tabindex="-1" role="dialog" aria-labelledby="cancelConfirmationModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="cancelConfirmationModalLabel">Confirm Cancel</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Do you really want to cancel? You will lose all the data you have entered.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="cancelCancel()" data-bs-dismiss="modal">No</button>
                            <button type="button" class="btn btn-success" onclick="cancelProcess()">Yes</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal for Points of Interest -->
            <div class="modal fade" id="pointsOfInterestModal" tabindex="-1" role="dialog" aria-labelledby="pointsOfInterestModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="pointsOfInterestModalLabel">Add Points of Interest</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="poiForm">
                                <div class="input-fields-group">
                                    <label for="poiName" class="form-label">Name *</label>
                                    <input type="text" class="form-control exclude-from-validation" id="poiName" name="poiName" placeholder="Enter Point of Interest Name" required maxlength="100">
                                    <small class="text-muted">* Required</small>
                                </div>
                                <div class="input-fields-group">
                                    <div class="coordinates-container">
                                        <div class="coordinates-container">
                                            <div class="row">
                                                <label for="poiLongitude" class="form-label">Coordinates *</label>
                                                <div class="col">
                                                    <input type="text" class="form-control exclude-from-validation" id="poiLongitude" name="longitude" placeholder="Longitude" required maxlength="20" aria-describedby="POILongitudeHelpText" pattern="-?\d+(\.\d{1,7})?">
                                                    <small id="POILongitudeHelpText" class="form-text text-muted">
                                                        The value must be in the format XX.XXXXXX (negative sign optional).
                                                    </small>
                                                </div>
                                                <div class="col">
                                                    <input type="text" class="form-control exclude-from-validation" id="poiLatitude" name="latitude" placeholder="Latitude" required maxlength="20" aria-describedby="POILatitudeHelpText" pattern="-?\d+(\.\d{1,7})?">
                                                    <small id="POILatitudeHelpText" class="form-text text-muted">
                                                        The value must be in the format XX.XXXXXX (negative sign optional).
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="input-fields-group">
                                    <label for="poiDescription" class="form-label">Description</label>
                                    <textarea class="form-control exclude-from-validation" id="poiDescription" name="poiDescription" placeholder="Enter Point of Interest Description" maxlength="255"></textarea>
                                </div>
                                <!-- Error message for required fields -->
                                <div id="poiErrorMessage" class="alert alert-danger mt-2" style="display: none">
                                    Please fill out all required fields marked with *.
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="savePointOfInterest()">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="java_script/create_hike.js"></script>
        <script>
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (function() {
                'use strict';
                window.addEventListener('load', function() {
                    let forms = document.getElementsByClassName('needs-validation');
                    let validation = Array.prototype.filter.call(forms, function(form) {
                        form.addEventListener('submit', function(event) {
                            if (form.checkValidity() === false) {
                                var toast = new bootstrap.Toast(document.getElementById("validationToast"));
                                toast.show();
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();

            let shouldPromptBeforeUnload = true; // Variable to track whether to prompt before unload

            // prompt functions
            function cancelCancel(){
            }
            // Funktion zum Öffnen des Points of Interest-Modals
            function openPoiModal() {
                // JavaScript code to activate the modal
                let pointsOfInterestModal = new bootstrap.Modal(document.getElementById("pointsOfInterestModal"));
                pointsOfInterestModal.show();
            }

            // Funktion zum Bearbeiten der Koordinaten
            function editPointOfInterest() {
                // Hier rufst du die Funktion zum Öffnen des Modals auf
                openPoiModal();

                // Implementiere ggf. zusätzliche Logik, um die bestehenden Koordinaten im Modal zu laden
                // Beispiel: document.getElementById('longitude').value = /* Wert aus deiner Datenbank */;
                // Beispiel: document.getElementById('latitude').value = /* Wert aus deiner Datenbank */;
            }
            function deletePointOfInterest(button) {
                // Get the parent card element and remove it
                var card = button.closest('.card');
                card.remove();
            }
            function confirmCancel() {
                let myModal = new bootstrap.Modal(document.getElementById('cancelConfirmationModal'), {
                    keyboard: false
                });
                myModal.show();
            }

            function cancelProcess() {
                shouldPromptBeforeUnload = false;
                window.location.href = "index.jsp";
            }

            window.onbeforeunload = function () {
                if (shouldPromptBeforeUnload) {
                    return 'Do you really want to leave this page?';
                }
            }

            rangeCount('conditionInput', 'rangeValue1');
            rangeCount('difficultyInput', 'rangeValue2');
            rangeCount('experienceInput', 'rangeValue3');
            rangeCount('landscapeInput', 'rangeValue4');

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



            // Setup for images
            previewImage('coverImageInput', 'previewCoverImage');
            // previewImage('optionalImageInput1', 'previewOptionalImage1');
            // previewImage('optionalImageInput2', 'previewOptionalImage2');

            //Checkboxes
            // Array of month names
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

                // Append the input and label to the month div
                monthDiv.appendChild(checkboxInput);
                monthDiv.appendChild(label);

                // Append the month div to the container
                container.appendChild(monthDiv);
            }

            document.getElementById('distanceInput').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^0-9.]/g, '');
            });

            document.getElementById('hoursInput').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^0-9]/g, '');
            });

            document.getElementById('minutesInput').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^0-9]/g, '');
            });

            document.getElementById('altitudeInput').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^0-9]/g, '');
            });

            document.getElementById('startID').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^\d.,-]/g, '');
            });

            document.getElementById('destinationID').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^\d.,-]/g, '');
            });
        </script>
    </body>
</html>

