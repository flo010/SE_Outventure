<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Outventure</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="/css/style.css" rel="stylesheet">
    </head>
    <body class="index-background">
        <header>
            <outventure:navbar/>
        </header>
        <%
            String loggedInUser = (String) session.getAttribute("loggedInUser");
            if (loggedInUser != null) {
        %>
        <div class="d-flex justify-content-center align-items-end">
            <div style="height: 200px;"></div>
            <h2 class="display-1" style="font-size: 55px"><strong> <%=loggedInUser%>, welcome to Outventure!</strong></h2>
        </div>
        <%
            } else {
        %>
        <div class="d-flex justify-content-center align-items-end">
            <div style="height: 200px;"></div>
            <h2 class="display-1"><strong>Welcome to Outventure!</strong></h2>
        </div>
        <%
            }
        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="/tagJavaScript/navbar.js"></script>
    </body>
</html>
