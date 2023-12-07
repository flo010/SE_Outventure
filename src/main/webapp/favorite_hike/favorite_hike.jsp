<%--
  Created by IntelliJ IDEA.
  User: Betül Kulac
  Date: 07.12.23
  Time: 19:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<html>
<head>
    <title>Favorite - Hike</title>
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
            <outventure:profile_left_box currentPage="favorite_hike"/>
            <div class="right-box">
                <div class="right-box-header"></div>
                <div class="right-box-body"></div>
                <div class="right-box-bottom"></div>
            </div>
        </div>
    </div>

</body>
</html>
