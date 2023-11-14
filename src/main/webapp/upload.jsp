<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Upload pictures</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body style="font-family: 'Roboto', sans-serif; margin: 10px">
<b>Upload picture</b><br/><br/>

<div style="display: block; margin-bottom: 24pt">
    <div style="display: block; margin-bottom: 12pt">Last uploaded image:</div>
    <%
        Object lastImage = request.getSession().getAttribute("last_image");
        String output;
        if (lastImage == null) {
            output = "(None)";
        } else {
            output = "<img src=\"data:image/png;base64," + lastImage + "\">";
        }
    %>
    <%=output%>
</div>

<div>
    <%
        String errorMessage = request.getParameter("error");
        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
    <div class="alert alert-danger" role="alert"><%=errorMessage %>
    </div>
    <%
        }
    %>
</div>

<div style="margin-top: 24pt">
    <form action="imageupload" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="fileToUpload" class="form-label">File to upload:</label>
            <input class="form-control" type="file" id="fileToUpload" name="fileToUpload">
        </div>
        <div class="mb-3">
            <%
                String description = request.getParameter("description");
                if (description == null)
                    description = "";
            %>
            <label for="description" class="form-label">Description:</label>
            <input class="form-control" type="text" id="description" name="description" value="<%=description%>">
        </div>
        <input type="submit" value="Upload File" name="submit" class="btn btn-primary">
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>
</html>