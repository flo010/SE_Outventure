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
            .required:after {
                content:" *";
            }
        </style>

    </head>
    <body>
        <header>
            <jsp:include page="navbar.jsp"/>
        </header>

        <div class="container-sm create-hike mt-5">
            <form>
                <h3>Title</h3>
                <div class="input-group mb-3">
                    <input type="text" class="form-control" id="titleInput" placeholder="Enter title here (max. 100 characters)" required maxlength="100">
                    <span class="input-group-text">*</span>
                </div>

                <h3>Description</h3>
                <div class="form-group">
                    <textarea class="form-control" id="descriptionTextArea" rows="8" placeholder="Enter your description here (max. 1000 characters)"></textarea>
                </div>
                <h3 class="mb-3">Images</h3>
                <div class="form-group mb-3">
                    <label for="coverImageInput" class="form-label required">Cover Image</label><br>
                    <input type="file" class="form-control mb-3" id="coverImageInput" name="coverImage" accept="image/*">
                    <img id="previewCoverImage" src="" width="250">
                </div>
                <div class="form-group mb-3">
                    <label for="optionalImageInput1" class="form-label">Optional Image</label><br>
                    <input type="file" class="form-control mb-3" id="optionalImageInput1" name="optionalImage1" accept="image/*">
                    <img id="previewOptionalImage1" src="" width="250">
                </div>
                <div class="form-group mb-3">
                    <label for="optionalImageInput2" class="form-label">Optional Image</label><br>
                    <input type="file" class="form-control mb-3" id="optionalImageInput2" name="optionalImage2" accept="image/*">
                    <img id="previewOptionalImage2" src="" width="250">
                </div>
            </form>

            <h3 class="mt-5 mb-3 required">Description</h3>
            <form>
                <textarea class="form-control" id="descriptionTextArea" rows="8" placeholder="Enter your description here (max. 1000 characters)"></textarea>
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
