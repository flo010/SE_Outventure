<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>
<%
    String hikerUsername = (String) session.getAttribute("hikerUsername");
    String hikerEmail = (String) session.getAttribute("hikerEmail");
%>

<html>
    <head>
        <title>Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="" rel="stylesheet">
        <link href="../../css/profile.css" rel="stylesheet">
        <link href="../../css/style.css" rel="stylesheet">
    </head>
    <body class="pale-background">
        <header>
            <outventure:navbar/>
        </header>
        <div class="container">
            <div class="login-container">
                <outventure:profile_left_box currentPage="profile"/>
                <div class="right-box">
                    <div class="right-box-header"></div>
                    <div class="right-box-body">
                        <span class="bold"><%=hikerUsername%></span><br>
                        <span class="text">E-Mail: <%=hikerEmail%></span>
                        <img src="https://static.vecteezy.com/ti/gratis-vektor/p1/27448973-benutzerbild-konto-symbol-standard-sozial-medien-profil-foto-vektor.jpg" alt="profile picture" class="rounded-circle-profile-image">
                    </div>
                    <div class="right-box-bottom">
                        <span class="text"><strong>Created Hikes:</strong></span><br>
                        <button type="button" class="btn btn-outline-secondary" onclick="goToProfileHikeList()">View my created hikes</button>
                    </div>
                </div>
             </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="../../global_java_script/navbar.js"></script>
        <script src="../../global_java_script/toasts.js"></script>
        <script src="profile.js"></script>
    </body>
</html>
