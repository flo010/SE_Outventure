<%@ page isErrorPage="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String errorCode = Integer.toString(response.getStatus());
    String errorText = "";
    String errorDescription = "";

    switch (errorCode) {
        case "404":
            errorText = "We are sorry, the page you requested cannot be found.";
            errorDescription = "The URL may be misspelled or the page you're looking for is no longer available.";
            break;
        case "500":
            errorText = "We are sorry, an internal error occured.";
            errorDescription = "The server unexpectedly failed to process the request.";
            break;
    }
%>
<html>
<head>
    <title>Error <%= errorCode %></title>
    <link href="/css/error.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
    <body>
        <div class="h-100 text-center">
            <p class="error fw-bold"><%= errorCode %></p>
            <p class="errorText fw-bold"><%= errorText %></p>
            <p class="errorDescription fw-bold"><%= errorDescription %></p>
        </div>
    </body>
</html>
