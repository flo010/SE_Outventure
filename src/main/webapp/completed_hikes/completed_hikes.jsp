<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Betül Kulac
  Date: 09.12.23
  Time: 18:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<%
  HttpSession userSession = request.getSession();
  String loggedInUser =  (String) userSession.getAttribute("loggedInUser");
  List<Hike> hikeList = FacadeJPA.getInstance().getHikesByAuthorLazy(loggedInUser);
%>
<html>
  <head>
      <title>Completed Hikes</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
      <link href="../css/profile.css" rel="stylesheet">
      <link href="../css/style.css" rel="stylesheet">
  </head>
  <body class="pale-background">
    <header>
      <outventure:navbar/>
    </header>
    <div class="container">
      <div class="login-container">
        <outventure:profile_left_box currentPage="completed_hikes"/>
        <div class="right-box">
          <div class="right-box-header">
            <h3>Completed Hikes</h3>
          </div>
          <div class="right-box-body"></div>
          <div class="right-box-bottom"></div>
        </div>
      </div>
    </div>

  </body>
</html>
