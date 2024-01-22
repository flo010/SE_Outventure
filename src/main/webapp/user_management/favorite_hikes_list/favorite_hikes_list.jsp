<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="hibernate.model.Hiker" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<%
    List<Hike> favoriteHikes = (List<Hike>) request.getAttribute("favoriteHikes");
%>

<html>
<head>
    <title>Favorite - Hike</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="../../css/profile.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body class="pale-background">
    <header>
        <outventure:navbar/>
    </header>
    <div class="container">
        <div class="login-container">
            <outventure:profile_left_box currentPage="favorite_hike"/>
            <div class="right-box">
                <div class="right-box-header">
                    <h3>Your Favorite Hikes</h3>
                </div>
                <div class="mt-3">
                    <% if (favoriteHikes.isEmpty()) { %>
                    <div class="empty-list-message mt-5 text-center">
                        <p>Your list is empty.</p>
                        <p>Click on the heart button in the hike detail page to add a hike to your favorite list.</p>
                    </div>
                    <%
                    }
                    else {
                        for (Hike hike: favoriteHikes) {
                            double durationMinutes = (hike.getDuration() % 1) * 60;
                    %>
                    <outventure:card_favorite_hike
                            hikeID="<%=hike.getHikeID()%>"
                            hikePicture="<%=hike.getPreviewPicture()%>"
                            hikeTitle="<%=hike.getTitle()%>"
                            hikeDistance="<%=hike.getDistance()%>"
                            hikeDurationHours="<%=(int)hike.getDuration()%>"
                            hikeDurationMinutes="<%=(int)durationMinutes%>"
                            hikeAltitude="<%=hike.getAltitude()%>">
                    </outventure:card_favorite_hike>
                    <% }} %>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="../../global_java_script/navbar.js"></script>
    <script src="../../global_java_script/toasts.js"></script>
    <script src="favorite_hikes_list.js"></script>
</body>
</html>
