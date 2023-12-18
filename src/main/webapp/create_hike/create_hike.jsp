<%@ page import="hibernate.model.Hike" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Create Hike Overview</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <%-- basic leaflet css and js --%>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
        <script src="https://unpkg.com/axios/dist/axios.min.js"></script>


        <link href="/css/style.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <outventure:navbar/>
        </header>

        <%
            Hike hike = (Hike) request.getAttribute("hike");

            String hoursString = "";
            String minutesString = "";

            int strength = 1;
            int stamina = 1;
            int experience = 1;
            int landscape = 1;

            if (hike != null) {
                double duration = hike.getDuration();
                int hours = (int)duration;
                int minutes = (int)((duration - hours)*60);

                hoursString = Integer.toString(hours);
                minutesString = Integer.toString(minutes);

                strength = hike.getStrength();
                stamina = hike.getStamina();;
                experience = hike.getExperience();
                landscape = hike.getLandscape();
            }
        %>

        <div class="container-sm mt-5 mb-5">
            <div class="progress mb-5">
                <div class="progress-bar bg-success" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                    20%
                </div>
            </div>

            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-overview-tab" data-bs-toggle="pill" data-bs-target="#pills-overview" type="button" role="tab" aria-controls="pills-overview" aria-selected="true" onclick="updateProgressBar()">Overview</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-details-tab" data-bs-toggle="pill" data-bs-target="#pills-details" type="button" role="tab" aria-controls="pills-details" aria-selected="false" onclick="updateProgressBar()">Details</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-route-tab" data-bs-toggle="pill" data-bs-target="#pills-route" type="button" role="tab" aria-controls="pills-route" aria-selected="false" onclick="updateProgressBar()">Route Description</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-poi-tab" data-bs-toggle="pill" data-bs-target="#pills-poi" type="button" role="tab" aria-controls="pills-poi" aria-selected="false" onclick="updateProgressBar()">Points of Interest</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-getting-there-tab" data-bs-toggle="pill" data-bs-target="#pills-getting-there" type="button" role="tab" aria-controls="pills-getting-there" aria-selected="false" onclick="updateProgressBar()">Getting There</button>
                </li>
            </ul>

            <hr>

            <form class="needs-validation" id="createHikeOverview" action="/save_data" method="post" novalidate>
                <% if (hike != null) { %>
                <input type="hidden" id="hiddenEditInput" name="edit" value="true">
                <input type="hidden" id="hiddenHikeIDInput" name="hikeID" value="<%= hike.getHikeID() %>">
                <input type="hidden" id="hiddenMonthsInput" name="months" value="<%= Arrays.toString(hike.monthsAsArray()) %>">
                <input type="hidden" id="hiddenPictureIDInput" name="pictureID" value="<%= hike.getPreviewPicture() %>">
                <% } %>
                <div class="tab-content mt-4" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-overview" role="tabpanel" aria-labelledby="pills-overview-tab" tabindex="0">
                        <div class="input-fields-group">
                            <label for="titleInput" class="form-label">Title *</label>
                            <input type="text" class="form-control" id="titleInput" name="titleInput" placeholder="Title"
                                   <%
                                if(hike != null){
                                    %>
                                    value="<%=hike.getTitle()%>"
                                   <% } %>
                                   required maxlength="100" aria-describedby="titleHelpText">
                            <small id="titleHelpText" class="form-text text-muted">
                                The maximum length is 100 characters.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a title.
                            </div>
                        </div>
                        <div class="input-fields-group">
                            <label for="descriptionInput" class="form-label">Description *</label>
                            <textarea class="form-control" id="descriptionInput" name="descriptionInput" rows="8"
                                      placeholder="Description" required maxlength="1000"
                                      aria-describedby="descriptionHelpText"><%
                                if (hike != null) {
                                    %><%=hike.getDescription()%><%
                                }
                            %></textarea>
                            <small id="descriptionHelpText" class="form-text text-muted">
                                Describe your hike in a few sentences to provide an overview of the route. The maximum length is 1000 characters.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a description.
                            </div>
                        </div>
                        <div class="input-fields-group">
                            <label for="coverImageInput" class="form-label">Cover Image *</label><br>
                            <input onchange="handleCoverImage()" type="file" class="form-control" id="coverImageInput" name="coverImage" accept=".png, .jpg" required>
                            <div class="invalid-feedback alert alert-danger mt-2">
                                Invalid file type. Please provide a .png or.jpg.
                            </div>
                            <img src="" id="previewCoverImage" width="250" alt="Hike Preview Image">
                            <input type="hidden" id="hiddenImageId" name="hiddenField">
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="button" id="nextButtonOverview" class="btn btn-success" onclick="nextTab()">Next</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonOverview" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-details" role="tabpanel" aria-labelledby="pills-details-tab" tabindex="0">
                        <div class="input-fields-group less-width">
                            <label for="distanceInput" class="form-label">Distance *</label>
                            <input type="text" class="form-control" id="distanceInput" name="distanceInput"
                                <% if (hike != null) { %>
                                   value="<%=hike.getDistance()%>"
                                <% } %>
                                   placeholder="Distance" required maxlength="7" aria-describedby="distanceHelpText" pattern="\d+(\.\d{1,2})">
                            <small id="distanceHelpText" class="form-text text-muted">
                                The value must be specified as a decimal number in kilometers.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a valid distance.
                            </div>
                        </div>
                        <div class="input-fields-group less-width">
                            <fieldset>
                                <legend class="form-label">Duration *</legend>
                                <div class="row">
                                    <div class="col">
                                        <input type="text" class="form-control" id="hoursInput" name="hoursInput" value="<%=hoursString%>" placeholder="Hours" required maxlength="2" pattern="[0-9]{1,2}" aria-label="Duration Hours">
                                        <div class="invalid-feedback">
                                            Please enter a valid duration.
                                        </div>
                                    </div>
                                    <div class="col">
                                        <input type="text" min="0" max="59" class="form-control" id="minutesInput" name="minutesInput" value="<%=minutesString%>" placeholder="Minutes" required maxlength="2" aria-describedby="minutesHelpText" pattern="[0-5]?[0-9]" aria-label="Duration Minutes">
                                        <small id="minutesHelpText" class="form-text text-muted">
                                            The value must be between 0 and 59.
                                        </small>
                                        <div class="invalid-feedback">
                                            Please enter a valid duration.
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div class="input-fields-group less-width">
                            <label for="altitudeInput" class="form-label">Altitude metres *</label>
                            <input type="text" class="form-control" id="altitudeInput" name="altitudeInput"
                                <%
                                if(hike != null){
                                    %>
                                   value="<%=hike.getAltitude()%>"
                                <% } %>
                                   placeholder="Altitude" required maxlength="10" aria-describedby="altitudeHelpText" pattern="\d{1,10}">
                            <small id="altitudeHelpText" class="form-text text-muted">
                                The value must be specified in meters.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a valid altitude.
                            </div>
                        </div>
                        <div class="input-fields-group less-width">
                            <div>
                                <label for="conditionInput" class="form-label">Required Stamina *</label>
                                <input type="range" class="custom-range" id="conditionInput" name="conditionInput" min="1" max="5" step="1" value="<%=stamina%>" oninput="updateLabel('conditionInput', 'rangeValue1')">
                                <label id="rangeValue1"><%=stamina%></label>
                            </div>
                            <div>
                                <label for="difficultyInput" class="form-label">Required Strength *</label>
                                <input type="range" class="custom-range" id="difficultyInput" name="difficultyInput" min="1" max="5" step="1" value="<%=strength%>" oninput="updateLabel('difficultyInput', 'rangeValue2')">
                                <label id="rangeValue2"><%=strength%></label>
                            </div>
                            <div>
                                <label for="experienceInput" class="form-label">Required Experience *</label>
                                <input type="range" class="custom-range" id="experienceInput" name="experienceInput" min="1" max="5" step="1" value="<%=experience%>" oninput="updateLabel('experienceInput', 'rangeValue3')">
                                <label id="rangeValue3"><%=experience%></label>
                            </div>
                            <div>
                                <label for="landscapeInput" class="form-label">Beauty of Landscape *</label>
                                <input type="range" class="custom-range" id="landscapeInput" name="landscapeInput" min="1" max="5" step="1" value="<%=landscape%>" oninput="updateLabel('landscapeInput', 'rangeValue4')">
                                <label id="rangeValue4"><%=landscape%></label>
                            </div>
                        </div>
                        <%--for loop for months--%>
                        <div class="input-fields-group">
                            <label class="form-label">Optimal Season *</label>
                            <div class="form-check form-check-inline" id="monthContainer">
                            </div>
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="button" id="nextButtonDetails" class="btn btn-success" onclick="nextTab()">Next</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="previousButtonDetails" class="btn btn-secondary" onclick="prevTab()">Previous</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonDetails" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-route" role="tabpanel" aria-labelledby="pills-route-tab" tabindex="0" >
                        <div class="input-fields-group">
                            <label for="routeDescriptionInput" class="form-label">Route Description *</label>
                            <textarea class="form-control" id="routeDescriptionInput" name="routeDescriptionInput" rows="8"
                                      placeholder="Route Description" aria-describedby="routeHelpText"
                                      required maxlength="1000"><%
                                if(hike != null){
                                    %><%=hike.getRouteDescription()%><%
                                }
                            %></textarea>
                            <small id="routeHelpText" class="form-text text-muted">
                                Describe the route of your hike in detail. The maximum length is 1000 characters.
                            </small>
                            <div class="invalid-feedback">
                                Please enter a route description.
                            </div>
                        </div>
                        <div class="input-fields-group">
                            <p class="form-label">Map</p>
                            <p>
                                <a class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" href="#collapseTutorial" role="button" aria-expanded="false" aria-controls="collapseTutorial">
                                    Tutorial
                                </a>
                            </p>
                            <div class="collapse mb-3" id="collapseTutorial">
                                <div class="card card-body">
                                    <p>With this feature, you can easily set start and destination points on the map. Here's how it works:</p>
                                    <ul>
                                        <li>
                                            <strong>Set Markers:</strong>
                                            <ul>
                                                <li>Start Point: Click on the map to set the start point.</li>
                                                <li>Destination Point: Click on the map again to set the destination point.</li>
                                                <li>Enter Names: After clicking on the map to place a marker, a modal appears in which you have to enter the name of the point.</li>
                                                <li>The route appears automatically when two markers are set.</li>
                                            </ul>
                                        </li>
                                        <li>
                                            <strong>Edit Markers:</strong>
                                            <ul>
                                                <li>Move Markers: Hold and drag the marker to reposition it.</li>
                                                <li>Delete Markers: Remove any marker if needed using the delete button in the pop-up.</li>
                                            </ul>
                                        </li>
                                    </ul>
                                    <p>That's it! With these steps, you can set your route, mark start and destination points, and customize the map to suit your needs.</p>
                                </div>
                            </div>
                            <div id="map" class="map-create-hike" onfocus="initializeMap()"></div>
                            <div>
                                <button type="button" class="btn btn-outline-secondary" id="showRouteButton">Show route</button>
                            </div>
                        </div>
                        <div>
                            <button type="button" onclick="importGpxButton()" class="btn btn-outline-secondary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up" viewBox="0 0 16 16" style="vertical-align: text-top;">
                                    <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"></path>
                                </svg>
                                Import GPX
                            </button>
                            <input type="file" onchange="handleGpxFile(this)" class="form-control" id="gpxInput" name="gpxInput" accept=".gpx" hidden>
                            <div class="invalid-feedback alert alert-danger mt-2">
                                Invalid file type. Please provide a .gpx.
                            </div>
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="button" id="nextButtonRoute" class="btn btn-success" onclick="nextTab()">Next</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="previousButtonRoute" class="btn btn-secondary" onclick="prevTab()">Previous</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonRoute" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="pills-poi" role="tabpanel" aria-labelledby="pills-poi-tab" tabindex="0">
                        <div class="input-fields-group less-width">
                            <fieldset>
                                <legend class="form-label">Start *</legend>
                                <input type="text" class="form-control" id="startNameInput" name="startNameInput"
                                    <% if(hike != null){ %>
                                        value="<%=hike.getStart().getName()%>"
                                    <% } %>
                                    placeholder="Name" aria-describedby="startLatitudeHelpText" required maxlength="100" aria-label="Start Name">
                                <div class="invalid-feedback">
                                    Please enter a name for the starting point.
                                </div>
                                <input type="number" min="-90.000000" max="90.000000" step="0.000001" class="form-control mt-3" id="latitudeStartCoordinateInput" name="latitudeStartCoordinateInput"
                                    <% if(hike != null) { %>
                                       value="<%=hike.getStart().getLatitude()%>"
                                    <% } %>
                                    placeholder="Latitude" required maxlength="10" aria-label="Start Latitude">
                                <small id="startLatitudeHelpText" class="form-text text-muted">
                                    The value must be in the format XX.XXXXXX (negative sign optional).
                                </small>
                                <div class="invalid-feedback">
                                    Please enter a valid latitude between -90.000000 and 90.000000.
                                </div>
                                <input type="number" min="-180.000000" max="180.000000" step="0.000001" class="form-control mt-3" id="longitudeStartCoordinateInput" name="longitudeStartCoordinateInput"
                                    <% if(hike != null){ %>
                                       value="<%=hike.getStart().getLongitude()%>"
                                    <% } %>
                                    placeholder="Longitude" aria-describedby="startLongitudeHelpText" required maxlength="11" aria-label="Start Longitude">
                                <small id="startLongitudeHelpText" class="form-text text-muted">
                                    The value must be in the format XX.XXXXXX (negative sign optional).
                                </small>
                                <div class="invalid-feedback">
                                    Please enter a valid longitude between -180.000000 and 180.000000.
                                </div>
                            </fieldset>
                        </div>
                        <div class="input-fields-group less-width">
                            <fieldset>
                                <legend class="form-label">Destination *</legend>
                                <input type="text" class="form-control" id="destinationNameInput" name="destinationNameInput"
                                    <% if(hike != null) { %>
                                       value="<%=hike.getDestination().getName()%>"
                                    <% } %>
                                    placeholder="Name" required maxlength="100" aria-label="Destination Name">
                                <div class="invalid-feedback">
                                    Please enter a name for the destination point.
                                </div>
                                <input type="number" min="-90.000000" max="90.000000" step="0.000001" class="form-control mt-3" id="latitudeDestinationCoordinateInput" name="latitudeDestinationCoordinateInput"
                                    <% if(hike != null) { %>
                                       value="<%=hike.getDestination().getLatitude()%>"
                                    <% } %>
                                    placeholder="Latitude" aria-describedby="destinationLatitudeHelpText" required maxlength="10" aria-label="Destination Latitude">
                                <small id="destinationLatitudeHelpText" class="form-text text-muted">
                                    The value must be in the format XX.XXXXXX (negative sign optional).
                                </small>
                                <div class="invalid-feedback">
                                    Please enter a valid latitude between -90.000000 and 90.000000.
                                </div>
                                <input type="number" min="-180.000000" max="180.000000" step="0.000001" class="form-control mt-3" id="longitudeDestinationCoordinateInput" name="longitudeDestinationCoordinateInput"
                                    <% if(hike != null) { %>
                                       value="<%=hike.getDestination().getLongitude()%>"
                                    <% } %>
                                    placeholder="Longitude" aria-describedby="destinationLongitudeHelpText" required maxlength="11" aria-label="Destination Longitude">
                                <small id="destinationLongitudeHelpText" class="form-text text-muted">
                                    The value must be in the format XX.XXXXXX (negative sign optional).
                                </small>
                                <div class="invalid-feedback">
                                    Please enter a valid longitude between -180.000000 and 180.000000.
                                </div>
                            </fieldset>
                        </div>
                        <div>
                            <!-- List of Points of Interest -->
                            <div id="poiContainer" class="row">
                                <template id="poiTemplate">
                                    <div class="pointOfInterest col-lg-6">
                                        <div class="card my-2">
                                            <div class="card-body">
                                                <h4 class="poiTempName card-title text-center"></h4>
                                                <input type="hidden" class="poiNameInput" name="poiNameInput" value="">
                                                <div class="d-flex justify-content-between align-items-center flex-wrap">
                                                    <div>
                                                        <p class="poiTempType">
                                                            <strong>Type: </strong>
                                                        </p>
                                                        <input type="hidden" class="poiTypeInput" name="poiTypeInput" value="">
                                                        <p class="poiTempDescription text-break">
                                                            <strong>Description: </strong>
                                                        </p>
                                                        <input type="hidden" class="poiDescriptionInput" name="poiDescriptionInput">
                                                        <p class="poiTempCoordinates">
                                                            <strong>GPS Coordinates: </strong>
                                                        </p>
                                                        <input type="hidden" class="poiLatitudeInput" name="poiLatitudeInput" value="">
                                                        <input type="hidden" class="poiLongitudeInput" name="poiLongitudeInput" value="">
                                                    </div>
                                                    <!-- edit and delete buttons with icons -->
                                                    <div class="d-flex gap-2">
                                                        <!-- edit button with pencil icon -->
                                                        <span class="input-group-text pointer" id="editCoordinates" onclick="editPointOfInterest(this)">
                                                             <i class="fa fa-pencil"></i>
                                                        </span>
                                                        <!-- delete button with bin icon -->
                                                        <span class="input-group-text pointer" onclick="deletePointOfInterest(this)">
                                                             <i class="fa fa-trash"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="poiDivider w-100"></div>
                                </template>
                            </div>
                            <!-- Add Points of Interest Button -->
                            <button type="button" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#pointsOfInterestModal">
                                <i class="fa fa-plus"></i> Add Points of Interest
                            </button>
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <div class="p-2 bd-highlight">
                                <button type="button" id="nextButtonPOI" class="btn btn-success" onclick="nextTab()">Next</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="previousButtonPOI" class="btn btn-secondary" onclick="prevTab()">Previous</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonPOI" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-getting-there" role="tabpanel" aria-labelledby="pills-getting-there-tab" tabindex="0">
                        <div class="input-fields-group">
                            <label for="gettingThereInput" class="form-label">Getting There</label>
                            <textarea class="form-control" id="gettingThereInput" name="gettingThereInput" rows="8"
                                      placeholder="Getting There" aria-describedby="gettingThereHelpText"
                                      maxlength="1000"><%
                                if (hike != null) {
                                    String hikeArrivalInformation = hike.getArrivalInformation();
                                    %><%=hikeArrivalInformation != null ? hikeArrivalInformation : ""%><%
                                }
                            %></textarea>
                            <small id="gettingThereHelpText" class="form-text text-muted">
                                Provide information on the best way to get to the starting point of your hike. The maximum length is 1000 characters.
                            </small>
                        </div>
                        <div class="input-fields-group">
                            <label for="parkingInput" class="form-label">Parking</label>
                            <textarea class="form-control" id="parkingInput" name="parkingInput" rows="8"
                                      placeholder="Parking" aria-describedby="parkingHelpText"
                                      maxlength="1000"><%
                                if (hike != null) {
                                    String hikeParkingInformation = hike.getParkingInformation();
                                    %><%=hikeParkingInformation != null ? hikeParkingInformation : ""%><%
                                }
                            %></textarea>
                            <small id="parkingHelpText" class="form-text text-muted">
                                Provide information about the best parking options near the starting point of the hike. The maximum length is 1000 characters.
                            </small>
                        </div>
                        <div class="d-flex flex-row-reverse bd-highlight">
                            <%
                                if (hike == null) {
                            %>
                            <div class="p-2 bd-highlight">
                                <button type="submit" id="saveButtonNewHike" class="btn btn-success" onclick="saveInput(false)">Save</button>
                            </div>
                            <%
                                } else {
                            %>
                            <div class="p-2 bd-highlight">
                                <button type="submit" id="saveButtonEditHike" class="btn btn-success" onclick="saveInput(true)">Save</button>
                            </div>
                            <% } %>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="previousButtonGettingThere" class="btn btn-secondary" onclick="prevTab()">Previous</button>
                            </div>
                            <div class="p-2 bd-highlight">
                                <button type="button" id="cancelButtonGettingThere" class="btn btn-danger" onclick="confirmCancel()">Cancel</button>
                            </div>
                        </div>
                        <div class="toast position-fixed bottom-0 end-0 align-items-center text-white bg-danger border-0" id="validationToast" role="alert" aria-live="assertive" aria-atomic="true">
                            <div class="d-flex">
                                <div class="toast-body">
                                    Validation failed! Please check your input.
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <!-- Modal for Cancel -->
            <div class="modal fade" id="cancelConfirmationModal" tabindex="-1" role="dialog" aria-labelledby="cancelConfirmationModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="cancelConfirmationModalLabel">Confirm Cancel</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Do you really want to cancel? You will lose all the data you have entered.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="cancelCancel()" data-bs-dismiss="modal">No</button>
                            <button type="button" class="btn btn-success" onclick="cancelProcess()">Yes</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal for Points of Interest -->
            <div class="modal fade" id="pointsOfInterestModal" tabindex="-1" role="dialog" aria-labelledby="pointsOfInterestModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="pointsOfInterestModalLabel">Add Points of Interest</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="poiForm">
                                <div class="input-fields-group">
                                    <label for="poiName" class="form-label">Name *</label>
                                    <input type="text" class="form-control exclude-from-validation" id="poiName" name="poiName" placeholder="Enter Point of Interest Name" required maxlength="100">
                                    <small class="text-muted">* Required</small>
                                </div>
                                <div class="input-fields-group">
                                    <label for="poiType" class="form-label">Type *</label>
                                    <div class="dropdown">
                                        <select id="poiType" name="poiType" class="form-select" aria-label="POI Type" required>
                                            <option selected>Select type</option>
                                            <option value="Hut">Hut</option>
                                            <option value="Refreshment Point">Refreshment Point</option>
                                            <option value="Viewpoint">Viewpoint</option>
                                            <option value="Sight">Sight</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="input-fields-group">
                                    <div class="coordinates-container">
                                        <div class="row">
                                            <label for="poiLongitude" class="form-label">Coordinates *</label>
                                            <div class="col">
                                                <input type="text" class="form-control exclude-from-validation" id="poiLatitude" name="latitude" placeholder="Latitude" required maxlength="20" aria-describedby="POILatitudeHelpText" pattern="-?\d+(\.\d{1,7})?">
                                                <small id="POILatitudeHelpText" class="form-text text-muted">
                                                    The value must be in the format XX.XXXXXX (negative sign optional).
                                                </small>
                                            </div>
                                            <div class="col">
                                                <input type="text" class="form-control exclude-from-validation" id="poiLongitude" name="longitude" placeholder="Longitude" required maxlength="20" aria-describedby="POILongitudeHelpText" pattern="-?\d+(\.\d{1,7})?">
                                                <small id="POILongitudeHelpText" class="form-text text-muted">
                                                    The value must be in the format XX.XXXXXX (negative sign optional).
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="input-fields-group">
                                    <label for="poiDescription" class="form-label">Description</label>
                                    <textarea class="form-control exclude-from-validation" id="poiDescription"
                                              name="poiDescription" placeholder="Enter Point of Interest Description"
                                              maxlength="255"></textarea>
                                </div>
                                <!-- Error message for required fields -->
                                <div id="poiErrorMessage" class="alert alert-danger mt-2" style="display: none">
                                    Please fill out all required fields marked with *.
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="savePointOfInterest()">Save</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal for entering names -->
            <div class="modal fade" id="nameModal" tabindex="-1" role="dialog" aria-labelledby="nameModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="nameModalLabel">Enter Name</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label for="nameInput">Name:</label>
                            <input type="text" class="form-control" id="nameInput">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="saveName">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Input Modal for Markernames -->
        <div id="markerModal" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 id="markerModalHeader" class="modal-title">Enter a name for the start point</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="input-fields-group">
                            <label for="markerModalNameInput" class="form-label">Name *</label>
                            <input type="text" id="markerModalNameInput" name="markerModalNameInput" class="form-control exclude-from-validation" placeholder="Enter Start Name" maxlength="100" required>
                        </div>
                        <div id="markerNameErrorMessage" class="alert alert-danger mt-2" style="display: none">
                            Please provide a valid name.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        <button type="button" id="markerModalSaveButton" class="btn btn-success">Save</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="/globalJS/toasts.js"></script>
        <script src="/create_hike/create_hike.js"></script>
        <script src="/tagJavaScript/navbar.js"></script>
    </body>
</html>

