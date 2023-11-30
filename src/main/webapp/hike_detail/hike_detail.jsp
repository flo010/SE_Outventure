<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.model.PointOfInterest" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%--
  Created by IntelliJ IDEA.
  User: learo
  Date: 03.11.2023
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Hike Detail</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="../css/style.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <outventure:navbar/>
        </header>

        <%
            Hike hike = (Hike) request.getAttribute("hike");
            double durationMinutes = (hike.getDuration() % 1) * 60;

            LocalDate localDate = hike.getDate(); // Retrieve the LocalDate object
            String pattern = "dd/MM/yyyy"; // Define the desired date pattern
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern); // Create a DateTimeFormatter using the specified pattern
            String formattedDate = localDate.format(formatter); // Format the LocalDate into a String using the DateTimeFormatter

            List<PointOfInterest> pointsOfInterest = hike.getPointsOfInterest();
        %>

        <div class="container-sm mt-5 mb-5">
            <div class="d-flex flex-row-reverse bd-highlight">
                <div class="p-2 bd-highlight">
                    <button id="deleteHikeButton" type="button" class="btn btn-outline-secondary" onclick="showDeleteHikeModal()">Delete</button>
                </div>
            </div>

            <h1 class="mb-3"><%=hike.getTitle()%></h1>
            <img class="cover-image" src="/api/image/<%=hike.getPreviewPicture()%>" alt="mountain picture">
            <div class="paragraph-container mt-3" style="width: 50%">
                <span class="author">Author: <%= hike.getAuthor() %></span>
                <span class="created-at">Created at: <%= formattedDate %></span>
            </div>
            <div class="card mb-5 mt-5">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <%-- icon distance --%>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"/>
                            </svg>
                            <strong class="card-text"><%=hike.getDistance()%></strong>
                            km
                        </div>
                        <div class="col-md-3">
                            <%-- icon duration --%>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                                <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"/>
                                <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"/>
                            </svg>
                            <strong class="card-text"><%=(int) hike.getDuration()%></strong>
                            h
                            <% if (durationMinutes > 0) { %>
                            <strong class="card-text"><%=(int) durationMinutes%></strong>
                            min
                            <% } %>
                        </div>
                        <div class="col-md-3">
                            <%-- icon altitude --%>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-short" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 .5.5z"/>
                            </svg>
                            <strong class="card-text"><%=hike.getAltitude()%></strong>
                            m
                        </div>
                    </div>
                </div>
            </div>

            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist"> <!-- insert nav-fill in class, when adding all tabs-->
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-overview-tab" data-bs-toggle="pill" data-bs-target="#pills-overview" type="button" role="tab" aria-controls="pills-overview" aria-selected="true">Overview</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-details-tab" data-bs-toggle="pill" data-bs-target="#pills-details" type="button" role="tab" aria-controls="pills-details" aria-selected="false">Details</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-route-tab" data-bs-toggle="pill" data-bs-target="#pills-route" type="button" role="tab" aria-controls="pills-route" aria-selected="false">Route Description</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-poi-tab" data-bs-toggle="pill" data-bs-target="#pills-poi" type="button" role="tab" aria-controls="pills-poi" aria-selected="false">Points of Interest</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-getting-there-tab" data-bs-toggle="pill" data-bs-target="#pills-getting-there" type="button" role="tab" aria-controls="pills-getting-there" aria-selected="false">Getting There</button>
                </li>
            </ul>

            <hr>
            <div class="tab-content mt-4" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-overview" role="tabpanel" aria-labelledby="pills-overview-tab" tabindex="0">
                    <h3>Description</h3>
                    <p><%=hike.getDescription()%></p>
                </div>

                <div class="tab-pane fade" id="pills-details" role="tabpanel" aria-labelledby="pills-details-tab" tabindex="0">
                    <h3>Details</h3>
                    <table>
                        <tr>
                            <td><b>Required Stamina</b></td>
                            <td>
                                <span class="fa fa-circle-o" id="colored-circle-1"></span>
                                <span class="fa fa-circle-o" id="colored-circle-2"></span>
                                <span class="fa fa-circle-o" id="colored-circle-3"></span>
                                <span class="fa fa-circle-o" id="colored-circle-4"></span>
                                <span class="fa fa-circle-o" id="colored-circle-5"></span>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Required Strength</b></td>
                            <td>
                                <span class="fa fa-circle-o" id="colored-circle-6"></span>
                                <span class="fa fa-circle-o" id="colored-circle-7"></span>
                                <span class="fa fa-circle-o" id="colored-circle-8"></span>
                                <span class="fa fa-circle-o" id="colored-circle-9"></span>
                                <span class="fa fa-circle-o" id="colored-circle-10"></span>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Required Experience</b></td>
                            <td>
                                <span class="fa fa-circle-o" id="colored-circle-11"></span>
                                <span class="fa fa-circle-o" id="colored-circle-12"></span>
                                <span class="fa fa-circle-o" id="colored-circle-13"></span>
                                <span class="fa fa-circle-o" id="colored-circle-14"></span>
                                <span class="fa fa-circle-o" id="colored-circle-15"></span>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Beauty of Landscape</b></td>
                            <td>
                                <span class="fa fa-circle-o" id="colored-circle-16"></span>
                                <span class="fa fa-circle-o" id="colored-circle-17"></span>
                                <span class="fa fa-circle-o" id="colored-circle-18"></span>
                                <span class="fa fa-circle-o" id="colored-circle-19"></span>
                                <span class="fa fa-circle-o" id="colored-circle-20"></span>
                            </td>
                        </tr>
                    </table>

                    <div>
                        <h3 class="my-3 mt-5">Optimal Season</h3>
                        <div class="row border border-2 rounded text-center px-1 pt-1 pb-2 g-1 w-50">
                            <%
                                String[] months = {"JAN", "FEB", "MAR", "APR", "MAY", "JUNE", "JULY", "AUG", "SEPT", "OCT", "NOV", "DEC"};
                                Boolean[] hikeMonths = {
                                        hike.isJanuary(), hike.isFebruary(), hike.isMarch(), hike.isApril(), hike.isMay(), hike.isJune(), hike.isJuly(),
                                        hike.isAugust(), hike.isSeptember(), hike.isOctober(), hike.isNovember(), hike.isDecember()
                                };

                                for (int i = 0; i < 12; i++) {
                            %>
                            <div class="col-6 col-md-4 col-lg-2 col-xl-2">
                                <div class="border border-2 rounded fw-bold" <% if (hikeMonths[i]) { %> style="background-color: #B6FC9D" <% } %>>
                                    <%=months[i]%>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="pills-route" role="tabpanel" aria-labelledby="pills-route-tab" tabindex="0">
                    <div class="route-description">
                        <h3>Route Description</h3>
                        <p><%=hike.getRouteDescription()%></p>
                    </div>
                </div>

                <div class="tab-pane fade" id="pills-poi" role="tabpanel" aria-labelledby="pills-poi-tab" tabindex="0">
                    <div class="points-of-interest">
                        <h3 class="mb-3">Points of Interest</h3>
                        <div class="row justify-content-start">
                            <div class="col mb-5">
                                <outventure:card_start
                                        startName="<%=hike.getStart().getName()%>"
                                        startLatitude="<%=hike.getStart().getLatitude()%>"
                                        startLongitude="<%=hike.getStart().getLongitude()%>">
                                </outventure:card_start>
                            </div>
                            <div class="col mb-5">
                                <outventure:card_destination
                                        destinationName="<%=hike.getDestination().getName()%>"
                                        destinationLatitude="<%=hike.getStart().getLatitude()%>"
                                        destinationLongitude="<%=hike.getDestination().getLongitude()%>">
                                </outventure:card_destination>
                            </div>

                            <%
                                for (PointOfInterest pointOfInterest: pointsOfInterest) {
                            %>
                                    <div class="col">
                                        <outventure:card_poi
                                                poiName="<%=pointOfInterest.getName()%>"
                                                poiType="<%=pointOfInterest.getType()%>"
                                                poiDescription="<%=pointOfInterest.getDescription()%>"
                                                poiLatitude="<%=pointOfInterest.getLatitude()%>"
                                                poiLongitude="<%=pointOfInterest.getLongitude()%>">
                                        </outventure:card_poi>
                                    </div>
                            <%}%>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="pills-getting-there" role="tabpanel" aria-labelledby="pills-getting-there-tab" tabindex="0">
                    <div class="getting-there">
                        <h3 class="mb-3">Getting There</h3>
                        <div class="row justify-content-start">
                            <div class="col">
                                <outventure:card_start
                                        startName="<%=hike.getStart().getName()%>"
                                        startLatitude="<%=hike.getStart().getLatitude()%>"
                                        startLongitude="<%=hike.getStart().getLongitude()%>"
                                        arrivalInformation="<%=hike.getArrivalInformation()%>"
                                        parkingInformation="<%=hike.getParkingInformation()%>">
                                </outventure:card_start>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal for Delete Hike -->
            <div class="modal fade" id="deleteHikeModal" tabindex="-1" role="dialog" aria-labelledby="deleteHikeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteHikeModalLabel">Delete Hike</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete this hike?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="deleteHike(<%=hike.getHikeID()%>)">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="dataForCircles"
             data-stamina="<%= hike.getStamina() %>"
             data-strength="<%= hike.getStrength() %>"
             data-experience="<%= hike.getExperience() %>"
             data-landscape="<%= hike.getLandscape() %>">
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="/hike_detail/hike_detail.js"></script>
    </body>
</html>