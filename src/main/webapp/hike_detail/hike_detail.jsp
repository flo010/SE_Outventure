<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.model.PointOfInterest" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="hibernate.model.Comment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<%
    Hike hike = (Hike) request.getAttribute("hike");
    double durationMinutes = (hike.getDuration() % 1) * 60;

    LocalDate localDate = hike.getDate();
    String pattern = "dd/MM/yyyy";
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
    String formattedDate = localDate.format(formatter);

    List<PointOfInterest> pointsOfInterest = hike.getPointsOfInterest();

    FacadeJPA facadeJPA = FacadeJPA.getInstance();
    int hikerID = (session.getAttribute("hikerID") != null) ? Integer.parseInt(session.getAttribute("hikerID").toString()) : -1;
    boolean isFavorite = hikerID != -1 && facadeJPA.isFavoriteHikeExists(hikerID, hike.getHikeID());
    Hike hikeWithComment = (Hike) request.getAttribute("hikeWithComment");
    List<Comment> comments = hikeWithComment.getComments();
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Hike Detail</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <%-- basic leaflet css and js --%>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
        <script src="https://unpkg.com/leaflet-gpx/gpx.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <%-- fullscreen leaflet css and js --%>
        <link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css' rel='stylesheet' />
        <script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js'></script>
        <%-- custom css --%>
        <link href="/css/style.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <outventure:navbar/>
        </header>
        <div class="container-sm mt-5 mb-5">
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight">
                    <button id="backToSearchButton" type="button" class="btn btn-outline-secondary" onclick="showLastSearchResults()">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 18 18">
                            <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"></path>
                        </svg>
                        Return to the search results
                    </button>
                </div>
                <%
                    if (hikerID != -1) {
                %>
                <div class="p-2 bd-highlight">
                    <button type="button" class="btn btn-outline-success" onclick="showHikeCompletedModal()">
                        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-check-square" viewBox="0 0 16 16">
                            <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"></path>
                            <path d="M10.97 4.97a.75.75 0 0 1 1.071 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.235.235 0 0 1 .02-.022z"></path>
                        </svg>
                        Mark as completed
                    </button>
                </div>
                <div class="p-2 bd-highlight">
                    <% if (!isFavorite) { %>
                    <button type="button" class="btn btn-outline-danger" id="removeFavoriteButton" onclick="updateFavorites(<%=hike.getHikeID()%>, <%=session.getAttribute("hikerID")%>)">
                        <svg class="heart-icon bi bi-heart" xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" viewBox="0 0 16 16">
                            <path class="heart-path" d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"></path>
                        </svg>
                        Add to Favorites
                    </button>
                    <% } else { %>
                    <button type="button" class="btn btn-danger" id="removeFavoriteButton" onclick="updateFavorites(<%=hike.getHikeID()%>, <%=session.getAttribute("hikerID")%>)">
                        <svg class="heart-icon bi bi-heart" xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" viewBox="0 0 16 16">
                            <path class="heart-path" d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"></path>
                        </svg>
                        Remove from Favorites
                    </button>
                    <% } %>
                </div>
                <%}%>
            </div>
            <div class="row">
                <div class="col-8">
                    <h1 class="mb-3"><%=hike.getTitle()%></h1>
                    <img class="cover-image w-75" src="/api/image/<%=hike.getPreviewPicture()%>" alt="mountain picture">
                    <div class="paragraph-container mt-3" style="width: 70%">
                        <span class="author">Author: <%= hike.getAuthor() %></span>
                        <span class="created-at">Created at: <%= formattedDate %></span>
                    </div>
                    <div class="card mb-5 mt-5">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <%-- icon distance --%>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                        <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"></path>
                                    </svg>
                                    <strong class="card-text"><%=hike.getDistance()%></strong>
                                    km
                                </div>
                                <div class="col-md-3">
                                    <%-- icon duration --%>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                                        <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"></path>
                                        <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"></path>
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
                                        <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 .5.5z"></path>
                                    </svg>
                                    <strong class="card-text"><%=hike.getAltitude()%></strong>
                                    m
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="comment-container col">
                    <h3>Comments</h3>
                    <div class="container-body">
                        <%for (Comment comment : comments) {%>
                        <div class="comment-box">
                            <div style="display: flex;justify-content: space-between">
                                <strong style="font-size: small">@<%=comment.getHiker().getUsername()%></strong>
                                <small ><%=comment.getTimestamp()%></small>
                            </div>
                            <div class="mt-2">
                                <p><%=comment.getCommentText()%></p>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <%
                        if (hikerID != -1) {
                    %>
                    <form id="commentForm" action="/comment?hikeID=<%=hike.getHikeID()%>&hikerID=<%=session.getAttribute("hikerID")%>" method="post">
                        <div class="container-footer">
                            <textarea class="text-form-control" id="commentInput" name="commentInput" placeholder="Add Comment" maxlength="1000" rows="2"></textarea>
                            <button class="add-comment-button" type="submit">
                                <i class="fa fa-plus"></i>
                            </button>
                        </div>
                    </form>
                    <% } %>
                </div>
            </div>
            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
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
                    <h3 class="mt-5">Region</h3>
                    <p><%=hike.getRegion().getRegion()%></p>
                    <h3 class="mt-5">Map</h3>
                    <div id="map" class="map-hike-detail"></div>
                    <div class="mt-5">
                        <button type="button" id="exportButton" class="btn btn-outline-secondary">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-upside-down" viewBox="0 0 16 16" style="vertical-align: text-top;">
                                <path fill-rule="evenodd" d="M8 1.5a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 1 1 .708-.708L7.5 13.293V2a.5.5 0 0 1 .5-.5z"/>
                            </svg>
                            Export GPX
                        </button>
                    </div>
                    <h3 class="mt-5">Weather</h3>
                    <div class="row">
                        <div class="col-8">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row row-cols-4">
                                        <%
                                            ArrayList<ArrayList<String>> weatherList = (ArrayList<ArrayList<String>>) request.getAttribute("weatherList");

                                            for (ArrayList<String> weatherInfo : weatherList) {
                                        %>
                                        <div class="col">
                                            <div class="card">
                                                <div class="card-body d-flex flex-column align-items-center">
                                                    <img src="<%= weatherInfo.get(1) %>" alt="weather icon">
                                                    <div class="text-center">
                                                        <p class="m-0 fw-bold"><%= weatherInfo.get(0) %> °C</p>
                                                        <p class="m-0 form-text"><%= weatherInfo.get(2) %></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                                List<Map<String, Object>> poiDataList = new ArrayList<>();

                                for (PointOfInterest pointOfInterest : pointsOfInterest) {
                                    Map<String, Object> poiData = new HashMap<>();
                                    poiData.put("poiName", pointOfInterest.getName());
                                    poiData.put("poiType", pointOfInterest.getType());
                                    poiData.put("poiDescription", pointOfInterest.getDescription());
                                    poiData.put("poiLatitude", pointOfInterest.getLatitude());
                                    poiData.put("poiLongitude", pointOfInterest.getLongitude());

                                    poiDataList.add(poiData);
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
                            <%
                                }
                                String poiDataListJson = new Gson().toJson(poiDataList);
                            %>
                            <div id="poiDataList" data-poi-data='<%= poiDataListJson %>'></div>
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
        </div>
        <%-- hike completed modal --%>
        <div class="modal fade" id="hikeCompletedModal" tabindex="-1" aria-labelledby="hikeCompletedModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="hikeCompletedModalLabel">Enter Date</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="dateForm" action="/completed_hike?hikeID=<%=hike.getHikeID()%>&hikerID=<%=session.getAttribute("hikerID")%>&page=detail" method="post">
                            <div class="mb-3">
                                <label for="completionDate" class="form-label">Completion Date (DD.MM.YYYY)</label>
                                <input type="date" class="form-control" id="completionDate" name="completionDate" placeholder="Completion Date" required>
                                <div class="invalid-feedback">Please enter a valid date in DD.MM.YYYY format.</div>
                            </div>
                            <div class="d-flex justify-content-end">
                                <button type="button" class="btn btn-danger me-2" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-success">Mark as completed</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="mapData"
             start-latitude="<%= hike.getStart().getLatitude() %>"
             start-longitude="<%= hike.getStart().getLongitude() %>"
             start-name="<%= hike.getStart().getName() %>"
             destination-latitude="<%= hike.getDestination().getLatitude() %>"
             destination-longitude="<%= hike.getDestination().getLongitude() %>"
             destination-name="<%= hike.getDestination().getName() %>"
        >
        </div>
        <div id="dataForCircles"
             data-stamina="<%= hike.getStamina() %>"
             data-strength="<%= hike.getStrength() %>"
             data-experience="<%= hike.getExperience() %>"
             data-landscape="<%= hike.getLandscape() %>">
        </div>

        <div id="toastData" data-hike-edited="<%= request.getAttribute("hikeEdited") %>"></div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="/hike_detail/hike_detail.js"></script>
        <script src="/create_hike/create_hike.js"></script>
        <script src="/tagJavaScript/navbar.js"></script>
        <script src="/globalJS/toasts.js"></script>
    </body>
</html>