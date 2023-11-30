<%--
  Created by IntelliJ IDEA.
  User: Betül Kulac
  Date: 29.11.23
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    </head>
    <body class="pale-background">
        <header>
            <outventure:navbar/>
        </header>
        <div class="container">
            <div class="login-container">
                <div class="left-box">
                    <!-- Hier kannst du den Inhalt der linken Box platzieren -->
                </div>
                <div class="right-box">
                    <div class="right-box-header"></div>
                    <div class="right-box-body">
                        <span class="bold"><%=loggedInUser%></span><br>
                        Email: <%=email%>
                    </div>
                    <div class="right-box-bottom"></div>
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>
