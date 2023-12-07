<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Betül Kulac
  Date: 03.12.23
  Time: 14:11
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
        <title>Created Hikes</title>
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
                <outventure:profile_left_box currentPage="hike_list"/>
                <div class="right-box" style="background: beige">
                    <div class="container mt-3">
                        <% if(hikeList.isEmpty()) { %> Your Hike List is empty
                        <% }else{ for (Hike hike: hikeList) { if(hike.isVisible()){ %>
                        <% double durationMinutes = (hike.getDuration() % 1) * 60; %>
                        <div class="card hike-card mt-3" style="width: 100%">
                            <div class="row">
                                <div class="col-md-9">
                                    <a class="text-decoration-none" style="color: black" href="../hike_detail?id=<%=hike.getHikeID()%>">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <img class="cover-image" style="width: 180px; height: 100px" src="/api/image/<%=hike.getPreviewPicture()%>" alt="mountain picture">
                                            </div>
                                            <div class="col-md-9 d-flex flex-column align-items-center justify-content-center">
                                                <h5 class="card-title text-truncate"><%=hike.getTitle()%></h5>
                                                <div class="details text-center">
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
                                                    </div>                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-3 d-flex justify-content-center align-items-center">
                                    <button id="editHikeButton" type="button" class="fa fa-edit hike-button"></button>
                                    <button id="deleteHikeButton" type="button" class="fa fa-trash-o hike-button" style="color: red" onclick="prepareDeleteHike(<%=hike.getHikeID()%>)"></button>
                                </div>
                            </div>
                        </div>
                        <% }}} %>
                    </div>
                </div>

            </div>

            <div class="modal fade" id="deleteHikeModal" tabindex="-1" role="dialog" aria-labelledby="deleteHikeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteHikeModalLabel">Delete Hike with</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete this hike?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="deleteHike(selectedHikeID)">Delete</button>
                        </div>
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
        <script src="/profile_hike_list/profile_hike_list.js"></script>
    </body>
</html>
