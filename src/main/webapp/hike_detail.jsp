<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.model.Picture" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="hibernate.model.PointOfInterest" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: learo
  Date: 03.11.2023
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Hike Detail</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <style>
            .container-sm.hike-detail.mt-5 .nav .nav-item .nav-link {
                color: black;
            }

            .container-sm.hike-detail.mt-5 .nav .nav-item .nav-link.active {
                background-color: #B6FC9D !important;
                color: black !important;

            }

            .container-sm.hike-detail.mt-5 .card.mb-5.mt-5 {
                width: 50%;
            }

            table {
                width: 400px;
            }

            td, th {
                padding: 10px;
            }
        </style>
    </head>
    <body>
        <header>
            <jsp:include page="navbar.jsp"/>
        </header>

        <%
            Hike hike = (Hike) request.getAttribute("hike");
            double durationMinutes = (hike.getDuration() % 1) * 60;

            List<PointOfInterest> pointsOfInterest = (List<PointOfInterest>) request.getAttribute("pointsOfInterest");

            HashMap<Integer, String> demoImages = new HashMap<Integer, String>();
            demoImages.put(1, "https://www.bergwelten.com/files/tour/images/niederkaiserkamm-14871-0.jpg?impolicy=gallerie_pictures");
            demoImages.put(2, "https://vcdn.bergfex.at/images/resized/profiles/detail/986/1af6fc7b24cc5b2ff8a32e1953d53986.jpg?1283172909");
            demoImages.put(3, "https://img.oastatic.com/img2/70761600/max/t.jpg?revbust=468c8c45");
            demoImages.put(4, "https://www.steiermark.com/Alpstein/Images/67091283/1306941/image-thumb__1306941__lightbox/bad-mitterndorf-mit-grimming-25240459.jpg");
            demoImages.put(5, "https://www.almenrausch.at/uploads/tx_webxhousingv2/trips/352/DSC_2340_9461.jpg");
            demoImages.put(6, "https://www.bodensee.de/extension/portal-bodensee/var/storage/images/media/bibliothek/ausflugsziele/pfaenderbahn/pfaenderbahn-mit-ausblick/46348-1-ger-DE/pfaenderbahn-mit-ausblick_front_large.jpg");
            demoImages.put(7, "https://vcdn.bergfex.at/images/resized/7c/fc07758d6a2af77c_20a169d014543ab0@2x.jpg");
            demoImages.put(8, "https://d2exd72xrrp1s7.cloudfront.net/www/000/1k4/a8/a8mx6d7f7cpz17bjyys8lhlle3eto5gp1-uhi15367968/0?width=3072&height=2304&crop=false&q=70");
//                  demoImages.put(13, "https://challenge8.com/wp-content/uploads/2019/05/Der-ultimative-Patagonien-Trekking-Guide-1024x685.jpg");
//                  demoImages.put(14, "https://jakobsweg-lebensweg.de/wp-content/uploads/2019/10/Jakobsweg-Route-alte-Br%C3%BCcke.jpg");
        %>

        <div class="container-sm hike-detail mt-5">
            <h1 class="mb-3"><%=hike.getTitle()%></h1>
            <img src="<%=demoImages.get(hike.getHikeID())%>" alt="mountain picture" style="width: 500px; height: auto">
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
            <div class="tab-content mt-4 mb-5" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-overview" role="tabpanel" aria-labelledby="pills-overview-tab" tabindex="0">
                    <h3>Description</h3>
                    <p><%=hike.getDescription()%></p>
                </div>

                <div class="tab-pane fade" id="pills-details" role="tabpanel" aria-labelledby="pills-details-tab" tabindex="0">
                    <h3>Details</h3>
                    <table>
                        <tr>
                            <td><b>Required Condition</b></td>
                            <td>
                                <span class="fa fa-circle" id="colored-circle-1"></span>
                                <span class="fa fa-circle" id="colored-circle-2"></span>
                                <span class="fa fa-circle" id="colored-circle-3"></span>
                                <span class="fa fa-circle" id="colored-circle-4"></span>
                                <span class="fa fa-circle" id="colored-circle-5"></span>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Level of Difficulty</b></td>
                            <td>
                                <span class="fa fa-circle" id="colored-circle-6"></span>
                                <span class="fa fa-circle" id="colored-circle-7"></span>
                                <span class="fa fa-circle" id="colored-circle-8"></span>
                                <span class="fa fa-circle" id="colored-circle-9"></span>
                                <span class="fa fa-circle" id="colored-circle-10"></span>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Required Experience</b></td>
                            <td>
                                <span class="fa fa-circle" id="colored-circle-11"></span>
                                <span class="fa fa-circle" id="colored-circle-12"></span>
                                <span class="fa fa-circle" id="colored-circle-13"></span>
                                <span class="fa fa-circle" id="colored-circle-14"></span>
                                <span class="fa fa-circle" id="colored-circle-15"></span>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Landscape Beauty</b></td>
                            <td>
                                <span class="fa fa-circle" id="colored-circle-16"></span>
                                <span class="fa fa-circle" id="colored-circle-17"></span>
                                <span class="fa fa-circle" id="colored-circle-18"></span>
                                <span class="fa fa-circle" id="colored-circle-19"></span>
                                <span class="fa fa-circle" id="colored-circle-20"></span>
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
                        <h3 class="mt-5 mb-3">Points Of Interest</h3>
                        <div class="row justify-content-start">
                            <div class="col">
                                <div class="card" style="width: 38rem;">
                                    <div class="card-body">
                                        <h5 class="card-title text-center">Start</h5>
                                        <p class="card-text">
                                            <strong>Name: </strong>
                                            <%=hike.getStart().getName()%>
                                        </p>
                                        <p>
                                            <strong>GPS Coordinates: </strong>
                                            <%=hike.getStart().getLongitude()%> E, <%=hike.getStart().getLatitude()%> N
                                        </p>
                                        <p>
                                            <strong>Google Maps Link: </strong>
                                            <a href="http://www.google.com/maps/place/<%=hike.getStart().getLatitude()%>,
                                            <%=hike.getStart().getLongitude()%>">http://www.google.com/maps/place/<%=hike.getStart().getLatitude()%>,
                                            <%=hike.getStart().getLongitude()%></a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card" style="width: 38rem;">
                                    <div class="card-body">
                                        <h4 class="card-title text-center">Destination</h4>
                                        <p>
                                            <strong>Name: </strong>
                                            <%=hike.getDestination().getName()%>
                                        </p>
                                        <p>
                                            <strong>GPS Coordinates: </strong>
                                            <%=hike.getDestination().getLongitude()%> E, <%=hike.getStart().getLatitude()%> N
                                        </p>
                                        <p>
                                            <strong>Google Maps Link: </strong>
                                            <a href="http://www.google.com/maps/place/<%=hike.getDestination().getLatitude()%>,
                                            <%=hike.getDestination().getLongitude()%>">http://www.google.com/maps/place/<%=hike.getDestination().getLatitude()%>,
                                            <%=hike.getDestination().getLongitude()%></a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="pills-getting-there" role="tabpanel" aria-labelledby="pills-getting-there-tab" tabindex="0">
                    <div class="getting-there">
                        <h3 class="mt-5 mb-3">Start</h3>
                        <div class="row justify-content-start">
                            <div class="col">
                                <div class="card" style="width: 38rem;">
                                    <div class="card-body">
                                        <h5 class="card-title text-center">Start</h5>
                                        <p class="card-text">
                                            <strong>Name: </strong>
                                            <%=hike.getStart().getName()%>
                                        </p>
                                        <p>
                                            <strong>GPS Coordinates: </strong>
                                            <%=hike.getStart().getLongitude()%> E, <%=hike.getStart().getLatitude()%> N
                                        </p>
                                        <p>
                                            <strong>Google Maps Link: </strong>
                                            <a href="http://www.google.com/maps/place/<%=hike.getStart().getLatitude()%>,
                                            <%=hike.getStart().getLongitude()%>">http://www.google.com/maps/place/<%=hike.getStart().getLatitude()%>,
                                                <%=hike.getStart().getLongitude()%></a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let circles = document.getElementsByClassName("fa fa-circle");
            for (let i = 0; i<<%=hike.getStamina()%>; i++){
                circles[i].style.color = "#B6FC9D";
            }
            for (let i = 0; i<<%=hike.getStrength()%>; i++){
                circles[i+5].style.color = "#B6FC9D";
            }
            for (let i = 0; i<<%=hike.getExperience()%>; i++){
                circles[i+10].style.color = "#B6FC9D";
            }
            for (let i = 0; i<<%=hike.getLandscape()%>; i++){
                circles[i+15].style.color = "#B6FC9D";
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>