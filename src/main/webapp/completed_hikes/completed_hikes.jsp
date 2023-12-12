<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="java.util.List" %>
<%@ page import="hibernate.model.Hiker" %>
<%@ page import="hibernate.broker.HikerBroker" %>
<%@ page import="java.sql.Date" %><%--
  Created by IntelliJ IDEA.
  User: Betül Kulac
  Date: 09.12.23
  Time: 18:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<%
  FacadeJPA facadeJPA = FacadeJPA.getInstance();
  int hikerID = Integer.parseInt(session.getAttribute("hikerID").toString());
  Hiker hiker = facadeJPA.getHikerByID(hikerID);
  List<Hike> completedHikes =  hiker.getCompletedHikes();
  List<Date> timestamps = new HikerBroker().getTimestamps(hikerID);
  int n = 0;
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
          <div class="container mt-3">
            <% if (completedHikes.isEmpty()) { %>
            <div class="empty-list-message mt-5 text-center">
              <p>Your list is empty.</p>
              <p>Click on the heart button in the hike detail page to add a hike to your favorite list.</p>
            </div>
            <%
            }
            else {
              for (Hike hike: completedHikes) {
                double durationMinutes = (hike.getDuration() % 1) * 60;
            %>
            <outventure:card_completed_hike hikeID="<%=hike.getHikeID()%>" hikerID="<%=hikerID%>" hikePicture="<%=hike.getPreviewPicture()%>" hikeTitle="<%=hike.getTitle()%>" hikeDistance="<%=hike.getDistance()%>" hikeDurationHours="<%=(int)hike.getDuration()%>" hikeDurationMinutes="<%=(int)durationMinutes%>" hikeAltitude="<%=hike.getAltitude()%>" timestamp="<%=timestamps.get(n).toString()%>"></outventure:card_completed_hike>
            <% n++;}} %>
          </div>
        </div>
      </div>
    </div>

  </body>
</html>
