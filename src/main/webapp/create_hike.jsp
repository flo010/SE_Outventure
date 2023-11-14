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
        <title>Create Hike</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <style>
            .form-group {
                margin-bottom: 1em;
            }

            .form-group img {
                margin-top: 1em;
            }
        </style>

    </head>
    <body>
        <header>
            <jsp:include page="navbar.jsp"/>
        </header>

        <div class="container-sm create-hike mt-5 mb-5">
            <form>
                <div class="form-group">
                    <h3>Title</h3>
                    <input type="text" class="form-control" id="titleInput" placeholder="Enter title here (max. 100 characters)" required maxlength="100">
                    <small class="required-text text-muted">* Required</small>
                </div>
                <div class="form-group">
                    <h3>Description</h3>
                    <textarea class="form-control" id="descriptionInput" rows="8" placeholder="Enter description here (max. 1000 characters)" required maxlength="1000"></textarea>
                    <small class="required-text text-muted">* Required</small>
                </div>
                <div class="form-group">
                    <div class="form-group">
                        <h3>Images</h3>
                        <label for="coverImageInput" class="form-label required">Cover Image</label><br>
                        <input type="file" class="form-control" id="coverImageInput" name="coverImage" accept="image/*">
                        <small class="required-text text-muted">* Required</small><br>
                        <img id="previewCoverImage" src="" width="250">
                    </div>
                    <div class="form-group">
                        <label for="optionalImageInput1" class="form-label">Optional Image</label><br>
                        <input type="file" class="form-control" id="optionalImageInput1" name="optionalImage1" accept="image/*">
                        <img id="previewOptionalImage1" src="" width="250">
                    </div>
                    <div class="form-group">
                        <label for="optionalImageInput2" class="form-label">Optional Image</label><br>
                        <input type="file" class="form-control" id="optionalImageInput2" name="optionalImage2" accept="image/*">
                        <img id="previewOptionalImage2" src="" width="250">
                    </div>
                </div>
            </form>
        </div>

        <div class="container-sm create-hike mt-5 mb-5">
            <form>
                <div class="row mt-4">
                    <div class="col">
                        <button type="button" class="btn btn-warning">Abbrechen</button>
                    </div>
                    <div class="col text-end">
                        <button type="submit" class="btn btn-success">Weiter</button>
                    </div>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script>
            function setupImagePreview(inputId, previewId) {
                const input = document.getElementById(inputId);
                const preview = document.getElementById(previewId);

                if (input && preview) {
                    input.onchange = evt => {
                        const [file] = input.files;

                        if (file) {
                            preview.src = URL.createObjectURL(file);
                        }
                    };
                }
            }

            // Setup for cover image
            setupImagePreview('coverImageInput', 'previewCoverImage');

            // Setup for optional image 1
            setupImagePreview('optionalImageInput1', 'previewOptionalImage1');

            // Setup for optional image 2
            setupImagePreview('optionalImageInput2', 'previewOptionalImage2');
        </script>
    </body>
</html>
