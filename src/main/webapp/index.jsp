<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Simulate a user being already logged in
    String username = "TestUser";

    // Set the username attribute in the session
    HttpSession userSession = request.getSession();
    session.setAttribute("username", username);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Outventure</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet">
    </head>
    <body class="index-background">
        <header>
            <jsp:include page="navbar.jsp"/>
        </header>

        <%
            String loggedInUser = (String) userSession.getAttribute("username");
            if (loggedInUser != null) {
        %>
        <div class="d-flex justify-content-center align-items-end">
            <div style="height: 200px;"></div>
            <h1 class="display-1"><strong> <%=loggedInUser%>, welcome to Outventure!</strong></h1>
        </div>
        <%
            } else {
        %>
        <div class="d-flex justify-content-center align-items-end">
            <div style="height: 200px;"></div>
            <h1 class="display-1"><strong>Nobody, welcome to Outventure!</strong></h1>
        </div>
        <%
            }
        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>
