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
            <form>
                <div class="input-fields-group">
                    <h3>Title</h3>
                    <input type="text" class="form-control" id="titleInput" placeholder="Enter title here (max. 100 characters)" required maxlength="100">
                    <small class="text-muted">* Required</small>
                </div>
                <div class="input-fields-group">
                    <h3>Description</h3>
                    <textarea class="form-control" id="descriptionInput" rows="8" placeholder="Enter description here (max. 1000 characters)" required maxlength="1000"></textarea>
                    <small class="text-muted">* Required</small>
                </div>
                <div class="input-fields-group">
                    <div class="input-fields-group">
                        <h3>Images</h3>
                        <label for="coverImageInput" class="form-label">Cover Image</label><br>
                        <input type="file" class="form-control" id="coverImageInput" name="coverImage" accept=".png, .jpg" required>
                        <small class="text-muted">* Required</small><br>
                        <div class="invalid-feedback alert alert-danger mt-2">Invalid file type. Please provide a .png or.jpg.</div>
                        <img id="previewCoverImage" width="250">
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

                </div>

                <div class="input-fields-group less-width">
                    <h3>Distance</h3>
                    <input type="text" class="form-control" id="distanceID" placeholder="Enter distance here (decimal in km)" required maxlength="7" pattern="\d+(\.\d{1,2})">
                    <small class="text-muted">* Required</small>
                </div>
                <div class="input-fields-group less-width">
                    <h3>Duration</h3>
                    <div>
                        <input type="text" class="form-control" id="hoursID" placeholder="Enter hours here" required maxlength="2" pattern="[0-9]{1,2}">
                        <small class="text-muted">* Required</small>
                    </div>
                    <div>
                        <input type="text" class="form-control" id="minutesID" placeholder="Enter minutes here" required maxlength="2" pattern="[0-5]?[0-9]">
                        <small class="text-muted">* Required. Must be between 0 and 59.</small>
                    </div>
                </div>
                <div class="input-fields-group less-width">
                    <h3>Altitude</h3>
                    <input type="text" class="form-control" id="altitudeID" placeholder="Enter altitude here (in meters)" required maxlength="10" pattern="[0-9]?[0-9]?0-9]?0-9]">
                    <small class="text-muted">* Required</small>
                </div>
               


                <div class="row mt-4">
                    <div class="col">
                        <button type="button" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                    </div>
                    <div class="col text-end">
                        <button type="submit" class="btn btn-success" onclick="continueFunction(); return false;">Continue</button>
                    </div>
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


<<<<<<< HEAD
=======
            function cancelProcess() {
                window.location.href = "/SE_Outventure_war_exploded/search_results";
            }
>>>>>>> 9d01a378dde38c0cf9174cf14f33a9e64a3c095f
            function setupImagePreview(inputId, previewId) {
                const input = document.getElementById(inputId);
                const preview = document.getElementById(previewId);

                if (input && preview) {
<<<<<<< HEAD
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

            window.onbeforeunload = function () {
                if (shouldPromptBeforeUnload) {
                    return 'Do you really want to leave this page?';
                }
            };

=======
                    input.onchange = evt => {
                        const [file] = input.files;

                        if (file) {
                            preview.src = URL.createObjectURL(file);
                        }
                    };
                }
            }
>>>>>>> 9d01a378dde38c0cf9174cf14f33a9e64a3c095f

            // Setup für das Vorschaubild
            setupImagePreview('coverImageInput', 'previewCoverImage');
            setupImagePreview('optionalImageInput1', 'previewOptionalImage1');
            setupImagePreview('optionalImageInput2', 'previewOptionalImage2');

            window.onbeforeunload = function() {
                return 'Do you really want to leave this page?';
            };

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



        </script>
    </body>
</html>

