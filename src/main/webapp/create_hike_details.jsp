<%--
  Created by IntelliJ IDEA.
  User: kulac
  Date: 14.11.23
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Hike - Page 2</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    <style>
        .form-group {
            margin-bottom: 1em;
        }

        .form-group img {
            margin-top: 1em;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="navbar.jsp"/>
    </header>
    <h2>Title</h2>
    <p> <%= session.getAttribute("title")%></p>
</body>
</html>
