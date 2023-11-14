<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Outventure</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet">

        <style>
            body {
                background-image: url(https://images-ext-2.discordapp.net/external/UWRt0WHHZy54pEdlIqTygMTM65xW8SmqjeHoKumSW3M/https/i.pinimg.com/originals/5c/33/76/5c337658742096493147ed99544534e4.jpg?width=1498&height=936);
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
    </head>
    <body>
        <header>
            <jsp:include page="navbar.jsp"/>
        </header>
        <div class="d-flex justify-content-center align-items-end">
            <div style="height: 200px;"></div>
            <h1 class="display-1"><strong>Welcome to Outventure!</strong></h1>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>
