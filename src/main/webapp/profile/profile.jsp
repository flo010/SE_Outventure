<%--
  Created by IntelliJ IDEA.
  User: Betül Kulac
  Date: 29.11.23
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>
<%
    HttpSession userSession = request.getSession();
    String loggedInUser =  (String) userSession.getAttribute("username");
    String email = (String) userSession.getAttribute("email");
%>

<html>
    <head>
        <title>Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="" rel="stylesheet">
        <link href="../css/profile.css" rel="stylesheet">
        <link href="../css/style.css" rel="stylesheet">
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
                        <span class="bold"><%=loggedInUser%></span><br>
                        <span class="text">Email: <%=email%></span>
                        <img src="https://static.vecteezy.com/ti/gratis-vektor/p1/27448973-benutzerbild-konto-symbol-standard-sozial-medien-profil-foto-vektor.jpg" alt="profile picture" class="rounded-circle-profile-image">
                    </div>
                    <div class="right-box-bottom">
                        <span class="text"><strong>Created Hikes:</strong></span><br>
                        <button type="button" class="btn btn-outline-secondary" onclick="window.location.href='/profile_hike_list/profile_hike_list.jsp'">View my created hikes</button>
                    </div>
                </div>
             </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>
