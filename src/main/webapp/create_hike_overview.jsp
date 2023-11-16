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

        <div class="container-sm create-hike mt-5 mb-5">
            <form id="createHikeOverview" action="save_data" method="post">
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
                    <h3>Images</h3>
                    <label for="coverImageInput" class="form-label">Cover Image</label><br>
                    <input type="file" class="form-control" id="coverImageInput" name="coverImageInput" accept=".png, .jpg" onchange="previewImage()">
                    <small class="text-muted">* Required</small><br>
                    <img id="previewCoverImage" src="" width="250">
                </div>
<%--                    <div class="input-fields-group">--%>
<%--                        <label for="optionalImageInput1" class="form-label">Optional Image</label><br>--%>
<%--                        <input type="file" class="form-control" id="optionalImageInput1" name="optionalImage1" accept=".png, .jpg">--%>
<%--                        <img id="previewOptionalImage1" src="" width="250">--%>
<%--                    </div>--%>
<%--                    <div class="input-fields-group">--%>
<%--                        <label for="optionalImageInput2" class="form-label">Optional Image</label><br>--%>
<%--                        <input type="file" class="form-control" id="optionalImageInput2" name="optionalImage2" accept=".png, .jpg">--%>
<%--                        <img id="previewOptionalImage2" src="" width="250">--%>
<%--                    </div>--%>

                <div class="custom-input-container">
                    <h3>Distance</h3>
                    <div class="input-group">
                        <input type="text" class="form-control"  placeholder="Enter Distance" required maxlength="75">
                    </div>
                    <small class="text-muted">* Required</small><br><br>
                    <h3>Duration</h3>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Enter Duration" required maxlength="75">
                    </div>
                    <small class="text-muted">* Required</small><br><br>
                    <h3>Altitude</h3>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Enter Altitude" required maxlength="75">
                    </div>
                    <small class="text-muted">* Required</small><br>
                </div>
                <div class="custom-input-container">
                    <div>
                        <h5>Required Condition</h5>
                        <input type="range" class="custom-range" id="customRange1" min="0" max="5" step="1"value="0">
                        <label id="rangeValue1">0</label>
                    </div>
                    <div>
                        <h5>Level of Difficulty</h5>
                        <input type="range" class="custom-range" id="customRange2" min="0" max="5" step="1" value="0">
                        <label id="rangeValue2">0</label>
                    </div>
                    <div>
                        <h5>Required Experience</h5>
                        <input type="range" class="custom-range" id="customRange3" min="0" max="5" step="1" value="0">
                        <label id="rangeValue3">0</label>
                    </div>
                    <div>
                        <h5>Landscape Beauty</h5>
                        <input type="range" class="custom-range" id="customRange4" min="0" max="5" step="1" value="0">
                        <label id="rangeValue4">0</label>
                    </div>
                </div>
                <%--for loop for months--%>
                <div class="input-fields-group">
                    <h3>Optimal Season</h3>
                    <div class="form-check form-check-inline" id="monthContainer">
                    </div>
                    <small class="text-muted"><br>* Required</small><br>
                </div>

                <div class="row mt-4">
                    <div class="col">
                        <button type="button" id="cancelButton" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                    </div>
                    <div class="col text-end">
                        <button type="submit" id="saveButton" class="btn btn-success">Save</button>
                    </div>
<%--                    <div class="col text-end">--%>
<%--                        <button type="submit" class="btn btn-success" onclick="continueFunction(); return false;">Continue</button>--%>
<%--                    </div>--%>
                </div>
            </form>

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
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script>
            let shouldPromptBeforeUnload = true; // Variable to track whether to prompt before unload

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
                window.location.href = "/search_results";
            }

            function cancelProcess() {
                window.location.href = "/search_results";
            }

            function setupImagePreview(inputId, previewId) {
                const input = document.getElementById(inputId);
                const preview = document.getElementById(previewId);

                if (input && preview) {
                    input.addEventListener("change",
                        () => {
                            const [file] = input.files;

                            if (file && (file.type === "image/png" || file.type === "image/jpeg")) {
                                input.classList.remove("is-invalid");
                                preview.src = URL.createObjectURL(file);
                                preview.style.display = "block";
                            } else {
                                input.classList.add("is-invalid");
                                preview.style.display = "none";
                            }
                        }
                    );
                }
            }

            // Setup für das Vorschaubild
            setupImagePreview('coverImageInput', 'previewCoverImage');
            setupImagePreview('optionalImageInput1', 'previewOptionalImage1');
            setupImagePreview('optionalImageInput2', 'previewOptionalImage2');

            window.onbeforeunload = function () {
                if (shouldPromptBeforeUnload) {
                    return 'Do you really want to leave this page?';
                }
            }

            window.onbeforeunload = function() {
                return 'Do you really want to leave this page?';
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

            
            function previewImage() {
                const input = document.getElementById('coverImageInput');
                const preview = document.getElementById('previewCoverImage');
                const invalidFeedback = document.querySelector('.invalid-feedback');

                const file = input.files[0];

                // Check if a file is selected
                if (file) {
                    // Check if the file type is valid (you can modify this check based on your requirements)
                    if (file.type === 'image/png' || file.type === 'image/jpeg') {
                        invalidFeedback.style.display = 'none';

                        // Create a FileReader to read the image
                        const reader = new FileReader();

                        // Set up the FileReader onload event
                        reader.onload = function (e) {
                            const img = new Image();

                            // Set up the Image onload event
                            img.onload = function () {
                                // Resize the image using a canvas
                                const canvas = document.createElement('canvas');
                                const ctx = canvas.getContext('2d');

                                canvas.width = 250; // Set the desired width
                                canvas.height = (250 * img.height) / img.width; // Maintain aspect ratio

                                ctx.drawImage(img, 0, 0, canvas.width, canvas.height);

                                // Update the preview image source with the resized image
                                preview.src = canvas.toDataURL('image/jpeg'); // Use 'image/png' for PNG format
                            };

                            // Set the Image source to the FileReader result (base64 data URL)
                            img.src = e.target.result;
                        };

                        // Read the file as a data URL
                        reader.readAsDataURL(file);
                    } else {
                        // Display an error message for invalid file types
                        invalidFeedback.style.display = 'block';
                        invalidFeedback.textContent = 'Invalid file type. Please provide a .png or .jpg.';
                        preview.src = ''; // Clear the preview image
                    }
                } else {
                    // Clear the preview image if no file is selected
                    preview.src = '';
                }
            }


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
                checkboxInput.className = "form-check-input";
                checkboxInput.type = "checkbox";
                checkboxInput.id = "monthCheckbox" + i;
                checkboxInput.value = months[i];
                checkboxInput.name = "optimalSeason"; // Added name attribute

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

            var form = document.getElementById("createHikeOverview");

            form.addEventListener("submit", function (event) {
                var checkboxes = document.querySelectorAll('input[name="optimalSeason"]:checked');

                if (checkboxes.length === 0) {
                    alert("Please select at least one optimal season.");
                    event.preventDefault(); // Prevent form submission
                }
            });

        </script>
    </body>
</html>

