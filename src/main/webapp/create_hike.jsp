<%--
  Created by IntelliJ IDEA.
  User: Lea Roncero
  Date: 13.11.2023
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Create Hike Overview</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <jsp:include page="navbar.jsp"/>
        </header>


        <div class="container-sm mt-5 mb-5">
            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist"> <!-- insert nav-fill in class, when adding all tabs-->
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-overview-tab" data-bs-toggle="pill" data-bs-target="#pills-overview" type="button" role="tab" aria-controls="pills-overview" aria-selected="true">Overview</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-details-tab" data-bs-toggle="pill" data-bs-target="#pills-details" type="button" role="tab" aria-controls="pills-details" aria-selected="false">Details</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-route-tab" data-bs-toggle="pill" data-bs-target="#pills-route" type="button" role="tab" aria-controls="pills-route" aria-selected="false">Route Description</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-poi-tab" data-bs-toggle="pill" data-bs-target="#pills-poi" type="button" role="tab" aria-controls="pills-poi" aria-selected="false">Points of Interest</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-getting-there-tab" data-bs-toggle="pill" data-bs-target="#pills-getting-there" type="button" role="tab" aria-controls="pills-getting-there" aria-selected="false">Getting There</button>
                </li>
            </ul>

            <hr>

            <form id="createHikeOverview" action="save_data" method="post">
                <div class="tab-content mt-4" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-overview" role="tabpanel" aria-labelledby="pills-overview-tab" tabindex="0">
                        <div class="input-fields-group">
                            <h3>Title</h3>
                            <input type="text" class="form-control" id="titleInput" name="titleInput" placeholder="Enter title here (max. 100 characters)" required maxlength="100">
                            <small class="text-muted">* Required</small>
                        </div>
                        <div class="input-fields-group">
                            <h3>Description</h3>
                            <textarea class="form-control" id="descriptionInput" name="descriptionInput" rows="8" placeholder="Enter description here (max. 1000 characters)" required maxlength="1000"></textarea>
                            <small class="text-muted">* Required</small>
                        </div>
                        <div class="input-fields-group">
                            <h3>Image</h3>
                            <label for="coverImageInput" class="form-label">Cover Image</label><br>
                            <input onchange="handleCoverImage()" type="file" class="form-control" id="coverImageInput" name="coverImage" accept=".png, .jpg" required>
                            <small class="text-muted">* Required</small><br>
                            <div class="invalid-feedback alert alert-danger mt-2">Invalid file type. Please provide a .png or.jpg.</div>
                            <img id="previewCoverImage" width="250">
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-details" role="tabpanel" aria-labelledby="pills-details-tab" tabindex="0">
                        <div class="input-fields-group less-width">
                            <h3>Distance</h3>
                            <input type="text" class="form-control" id="distanceID" name="distanceInput" placeholder="Enter distance here (decimal in km)" required maxlength="7" pattern="\d+(\.\d{1,2})">
                            <small class="text-muted">* Required</small>
                        </div>
                        <div class="input-fields-group less-width">
                            <h3>Duration</h3>
                            <div>
                                <input type="text" class="form-control" id="hoursID" name="hoursInput" placeholder="Enter hours here" required maxlength="2" pattern="[0-9]{1,2}">
                                <small class="text-muted">* Required</small>
                            </div>
                            <div>
                                <input type="text" class="form-control" id="minutesID" name="minutesInput" placeholder="Enter minutes here" required maxlength="2" pattern="[0-5]?[0-9]">
                                <small class="text-muted">* Required. Must be between 0 and 59.</small>
                            </div>
                        </div>
                        <div class="input-fields-group less-width">
                            <h3>Altitude</h3>
                            <input type="text" class="form-control" id="altitudeID" name="altitudeInput" placeholder="Enter altitude here (in meters)" required maxlength="10" pattern="\d{1,10}">
                            <small class="text-muted">* Required</small>
                        </div>
                        <div class="input-fields-group less-width">
                            <div>
                                <h5>Required Condition</h5>
                                <input type="range" class="custom-range" id="customRange1" name="conditionInput" min="1" max="5" step="1"value="0">
                                <label id="rangeValue1">1</label>
                            </div>
                            <div>
                                <h5>Level of Difficulty</h5>
                                <input type="range" class="custom-range" id="customRange2" name="difficultyInput" min="1" max="5" step="1" value="0">
                                <label id="rangeValue2">1</label>
                            </div>
                            <div>
                                <h5>Required Experience</h5>
                                <input type="range" class="custom-range" id="customRange3" name="experienceInput" min="1" max="5" step="1" value="0">
                                <label id="rangeValue3">1</label>
                            </div>
                            <div>
                                <h5>Landscape Beauty</h5>
                                <input type="range" class="custom-range" id="customRange4" name="landscapeInput" min="1" max="5" step="1" value="0">
                                <label id="rangeValue4">1</label>
                            </div>
                        </div>
                        <%--for loop for months--%>
                        <div class="input-fields-group">
                            <h3>Optimal Season</h3>
                            <div class="form-check form-check-inline" id="monthContainer">
                            </div>
                            <small class="text-muted"><br>* Required</small><br>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-route" role="tabpanel" aria-labelledby="pills-route-tab" tabindex="0">
                        <div class="input-fields-group">
                            <h3>Route Description</h3>
                            <textarea class="form-control" id="RouteDescriptionInput" name="RouteDescriptionInput" rows="8" placeholder="Enter route description here (max. 1000 characters)" required maxlength="1000"></textarea>
                            <small class="text-muted">* Required</small>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-poi" role="tabpanel" aria-labelledby="pills-poi-tab" tabindex="0">
                        <div class="input-fields-group less-width">
                            <h3>Start</h3>
                            <input type="text" class="form-control" id="startID" name="startInput" placeholder="Enter start Coordinates here" required maxlength="50" pattern="-?(\d+(\.\d{1,7})?),\-?(\d+(\.\d{1,7})?)">
                            <small class="text-muted">* Required.Format:-XX.XXXXXX,YY.YYYYYY (negative sign optional)</small>
                        </div>
                        <div class="input-fields-group less-width">
                            <h3>Destination</h3>
                            <input type="text" class="form-control" id="destinationID" name="destinationInput" placeholder="Enter destination Coordinates here" required maxlength="50" pattern="-?(\d+(\.\d{1,7})?),\-?(\d+(\.\d{1,7})?)">
                            <small class="text-muted">* Required.Format:-XX.XXXXXX,YY.YYYYYY (negative sign optional)</small>
                        </div>
                        <div>
                            <!-- Add Points of Interest Button -->
                            <button type="button" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#pointsOfInterestModal">
                                <i class="fa fa-plus"></i> Add Points of Interest
                            </button>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-getting-there" role="tabpanel" aria-labelledby="pills-getting-there-tab" tabindex="0">
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <button type="button" id="cancelButton" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                            <div class="col text-end">
                                <button type="submit" id="saveButton" class="btn btn-success" onclick="saveInput()">Save</button>
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
                            <!-- Content for adding Points of Interest goes here -->
                            <!-- For example: a form to input Points of Interest -->
                            <form id="poiForm">
                                <div class="input-fields-group">
                                    <h5>Name</h5>
                                    <input type="text" class="form-control" id="poiName" name="poiName" placeholder="Enter Point of Interest Name" required maxlength="100">
                                    <small class="text-muted">* Required</small>
                                </div>
                                <div class="input-fields-group">
                                    <h5>Coordinates</h5>
                                    <input type="text" class="form-control" id="poiCoordinates" name="poiCoordinates" placeholder="Enter Coordinates here" required maxlength="50" pattern="-?(\d+(\.\d{1,7})?),\-?(\d+(\.\d{1,7})?)">
                                    <small class="text-muted">* Required. Format:-XX.XXXXXX, YY.YYYYYY  </small>
                                </div>
                                <!-- Error message for required fields -->
                                <div id="poiErrorMessage" class="alert alert-danger mt-2" style="display: none">
                                    Please fill out all required fields.
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
        <script>
            let shouldPromptBeforeUnload = true; // Variable to track whether to prompt before unload

            // JavaScript code to activate the modal
            var pointsOfInterestModal = new bootstrap.Modal(document.getElementById("pointsOfInterestModal"));

            function savePointOfInterest() {
                // Get values from the form
                var poiName = document.getElementById('poiName').value;
                var poiCoordinates = document.getElementById('poiCoordinates').value;

                // Check if required fields are empty
                if (!poiName || !poiCoordinates) {
                    var errorMessage = document.getElementById('poiErrorMessage');
                    errorMessage.style.display = 'block';
                    return;
                }
                // Do something with the values, e.g., save to a list, update UI, etc.

                // Close the modal
                pointsOfInterestModal.hide();
            }

            function cancelCancel(){
            }

            function confirmCancel() {
                var myModal = new bootstrap.Modal(document.getElementById('cancelConfirmationModal'), {
                    keyboard: false
                });
                myModal.show();
            }

            function cancelProcess() {
                shouldPromptBeforeUnload = false;
                window.location.href = "search_results";
            }

            function saveInput() {
                var requiredInputs = document.querySelectorAll("[required]");
                var allInputsFilled = true;

                for (var i = 0; ((i < requiredInputs.length) && (allInputsFilled === true)); i += 1) {
                    if (!requiredInputs[i].value.trim()) {
                        allInputsFilled = false;
                    }
                }

                var checkboxes = document.querySelectorAll('form-check-input[id="optimalSeason"]:checked');
                var atLeastOneCheckbox = checkboxes.length > 0;

                if (!atLeastOneCheckbox) {
                    alert("Please select at least one optimal season.");
                }

                if (allInputsFilled && atLeastOneCheckbox) {
                    shouldPromptBeforeUnload = false;
                    window.location.href = "search_results";
                }
            }

            window.onbeforeunload = function () {
                if (shouldPromptBeforeUnload) {
                    return 'Do you really want to leave this page?';
                }
            }


            function rangeCount(id, labelId){
                var rangeInput = document.getElementById(id);
                var rangeValue = document.getElementById(labelId);

                rangeInput.addEventListener('input', function () {
                    rangeValue.textContent = rangeInput.value;
                });
            }

            rangeCount('customRange1', 'rangeValue1');
            rangeCount('customRange2', 'rangeValue2');
            rangeCount('customRange3', 'rangeValue3');
            rangeCount('customRange4', 'rangeValue4');


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
                                handleCoverImage(file, preview);
                            } else {
                                input.classList.add("is-invalid");
                                preview.style.display = "none";
                            }
                        }
                    );
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
                                // Example: uploadImageToServer(compressedDataURL);
                            };

                            img.src = e.target.result;
                        };

                        reader.readAsDataURL(file);
                    }
                });
            }

            // Setup für das Vorschaubild
            previewImage('coverImageInput', 'previewCoverImage');
            // previewImage('optionalImageInput1', 'previewOptionalImage1');
            // previewImage('optionalImageInput2', 'previewOptionalImage2');

            //Checkboxes
            // Array of month names
            var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

            var container = document.getElementById("monthContainer");

            for (var i = 0; i < months.length; i++) {
                // Create the month div
                var monthDiv = document.createElement("div");
                monthDiv.className = "form-check form-check-inline";

                // Create the checkbox input
                var checkboxInput = document.createElement("input");
                checkboxInput.className = "form-check-input months";
                checkboxInput.type = "checkbox";
                checkboxInput.id = "optimalSeason" + months[i];
                checkboxInput.value = "true";
                checkboxInput.name = "monthCheckbox" + months[i]; // Added name attribute

                // Create the label for the checkbox
                var label = document.createElement("label");
                label.className = "form-check-label";
                label.setAttribute("for", "monthCheckbox" + i);
                label.innerText = months[i];

                // Append the input and label to the month div
                monthDiv.appendChild(checkboxInput);
                monthDiv.appendChild(label);

                // Append the month div to the container
                container.appendChild(monthDiv);
            }

            document.getElementById('distanceID').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^0-9.]/g, '');
            });

            document.getElementById('hoursID').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^0-9]/g, '');
            });

            document.getElementById('minutesID').addEventListener('input', function() {
                let value = this.value;
                this.value = value.replace(/[^0-9]/g, '');
            });

            document.getElementById('altitudeID').addEventListener('input', function() {
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

