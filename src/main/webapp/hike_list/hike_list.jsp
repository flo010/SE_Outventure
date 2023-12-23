<%@ page import="hibernate.model.Hike" %>
<%@ page import="java.util.List" %>
<%@ page import="hibernate.facade.FacadeJPA" %><%--
  Created by IntelliJ IDEA.
  User: Betül Kulac
  Date: 03.12.23
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>
<%
    HttpSession userSession = request.getSession();
    String loggedInUser =  (String) userSession.getAttribute("username");
    String email = (String) userSession.getAttribute("email");
    String testUser = "John Doe";
    List<Hike> hikeList = FacadeJPA.getInstance().getHikesByAuthorLazy(testUser);
%>

<html>
<head>
    <title>Erstellte Wanderungen</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="../css/profile.css" rel="stylesheet">
</head>
<body class="pale-background">
<header>
    <outventure:navbar/>
</header>
<div class="container">
    <div class="login-container">
        <div class="left-box">
            <ul>
                <li>
                    <a href="/profile/profile.jsp" class="active">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                            <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z"></path>
                        </svg>
                        Profil
                    </a>
                </li>
                <li>
                    <a href="/hike_list/hike_list.jsp" class="active">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard" viewBox="0 0 16 16">
                            <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z"></path>
                            <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z"></path>
                        </svg>
                        Erstellte Wanderungen
                    </a>
                </li>
            </ul>
        </div>

        <div class="right-box" style="background: beige">
            <div class="container mt-3">
                <% for (Hike hike: hikeList) { %>
                <%double durationMinutes = (hike.getDuration() % 1) * 60;%>
                <a class="card text-decoration-none hike-card mt-3" style="width: 100%" href="../hike_detail?id=<%=hike.getHikeID()%>">
                    <div class="hike-content row">
                        <div class="col-md-3">
                            <img class="cover-image " style="width: 180px; height: 100px" src="/api/image/<%=hike.getPreviewPicture()%>" alt="mountain picture">
                        </div>
                        <div class="col-md-6 d-flex flex-column align-items-start justify-content-center">
                            <h5 class="card-title text-truncate"><%=hike.getTitle()%></h5>
                            <div class="details text-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                    <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"></path>
                                </svg>
                                <strong class="card-text"><%=hike.getDistance()%></strong>
                                km&nbsp;&nbsp;
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                                    <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"></path>
                                    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"></path>
                                </svg>
                                <strong class="card-text"><%=(int)hike.getDuration()%></strong>
                                h
                                <% if (durationMinutes > 0) { %>
                                <strong class="card-text"><%=(int)durationMinutes%></strong>
                                min
                                <% } %>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-short" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 .5.5z"></path>
                                </svg>
                                <strong class="card-text"><%=hike.getAltitude()%></strong>
                                m
                            </div>
                        </div>
                        <div class="buttons col-md-3 d-flex justify-content-center align-items-center">
                            <button id="editHikeButton" type="button" class="fa fa-edit hike-button" onclick="goToCreateHike(<%=hike.getHikeID()%>)"></button>
                            <button id="deleteHikeButton" type="button" class="fa fa-trash-o hike-button" style="color: red"></button>

                        </div>
                    </div>

                </a>
                <% } %>
            </div>
        </div>
    </div>
</div>

<style>
    .hike-button {
        background-color: transparent;
        border: none;
        font-size: 30px;
    }
    .hike-button:hover {
        background-color: #e0e0e0;
    }
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="/hike_detail/hike_detail.js"></script>
<script src="/tagJavaScript/navbar.js"></script>

</body>
</html>
