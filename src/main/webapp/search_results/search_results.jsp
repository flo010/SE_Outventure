<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="hibernate.model.Hike" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search Results</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="../css/style.css" rel="stylesheet">
    </head>
    <body style="background-color: #F8F7EF">
        <header>
            <outventure:navbar/>
        </header>
        <div class="row">
        <div class="col-3">
            <outventure:filter name="Duration" min="1" max="10000" valueLow="1" valueHigh="10000"></outventure:filter>
            <outventure:filter name="Distance" min="1" max="10000" valueLow="1" valueHigh="10000"></outventure:filter>
            <outventure:filter name="Altitude" min="1" max="10000" valueLow="1" valueHigh="10000"></outventure:filter>
            <outventure:filter name="Stamina" min="1" max="5" valueLow="1" valueHigh="5"></outventure:filter>
            <outventure:filter name="Power" min="1" max="5" valueLow="1" valueHigh="5"></outventure:filter>
            <outventure:filter name="Experience" min="1" max="5" valueLow="1" valueHigh="5"></outventure:filter>
            <outventure:filter name="Landscape" min="1" max="5" valueLow="1" valueHigh="5"></outventure:filter>

            <div
                    class="row border border-2 rounded text-center px-1 pt-1 pb-2 g-1"
            >
                <div>
                    <input class="but" id="monthSwitch" type="checkbox" />
                    <label class="simp" for="monthSwitch">
                        Months
                        <svg
                                xmlns="http://www.w3.org/2000/svg"
                                width="16"
                                height="16"
                                fill="currentColor"
                                class="bi bi-arrow-down"
                                viewBox="0 0 16 16"
                                id="monthArrowDown"
                        >
                            <path
                                    fill-rule="evenodd"
                                    d="M8 1a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L7.5 13.293V1.5A.5.5 0 0 1 8 1"></path>
                        </svg>
                        <svg
                                xmlns="http://www.w3.org/2000/svg"
                                width="16"
                                height="16"
                                fill="currentColor"
                                class="bi bi-arrow-up"
                                viewBox="0 0 16 16"
                                style="display: none"
                                id="monthArrowUp"
                        >
                            <path
                                    fill-rule="evenodd"
                                    d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"></path>
                        </svg>
                    </label>
                </div>

                <div id="months" style="display: none; flex-wrap: wrap;">
                <div
                        id="Jan"
                        class="col-lg-6 col-xl-6 clickable"
                        onclick="addsearchMonth(0)"
                >
                    <div class="border border-2 rounded fw-bold">JAN</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(1)">
                    <div class="border border-2 rounded fw-bold">FEB</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(2)">
                    <div class="border border-2 rounded fw-bold">MAR</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(3)">
                    <div class="border border-2 rounded fw-bold">APR</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(4)">
                    <div class="border border-2 rounded fw-bold">MAY</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(5)">
                    <div class="border border-2 rounded fw-bold">JUNE</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(6)">
                    <div class="border border-2 rounded fw-bold">JULY</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(7)">
                    <div class="border border-2 rounded fw-bold">AUG</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(8)">
                    <div class="border border-2 rounded fw-bold">SEPT</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(9)">
                    <div class="border border-2 rounded fw-bold">OCT</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(10)">
                    <div class="border border-2 rounded fw-bold">NOV</div>
                </div>

                <div class="col-lg-6 col-xl-6 clickable" onclick="addsearchMonth(11)">
                    <div class="border border-2 rounded fw-bold">DEC</div>
                </div>
            </div>
        </div>
            <div
                    class="row border border-2 rounded text-center px-1 pt-1 pb-2 g-1"
            >
                <div class="d-flex justify-content-between align-items-center px-1">
                    <button type="button" class="btn btn-primary" onclick="resetFilters()">Reset</button>
                    <button id="filter" class="btn btn-success" onclick="getFiltered()">Apply</button>
                </div>
            </div>
        </div>
        <div class="col-9">
        <div class="container py-3">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3">
                <%
                    List<Hike> hikeList = (List<Hike>) session.getAttribute("hikeList");

                    for (Hike hike : hikeList) {
                        if (hike.isVisible()){
                            double durationMinutes = (hike.getDuration() % 1) * 60;
                %>
                            <div class="col">
                                <outventure:card_search_results hikeID="<%=hike.getHikeID()%>"
                                                                hikePicture="<%=hike.getPreviewPicture()%>"
                                                                hikeTitle="<%=hike.getTitle()%>"
                                                                hikeDistance="<%=hike.getDistance()%>"
                                                                hikeDurationHours="<%=(int) hike.getDuration()%>"
                                                                hikeDurationMinutes="<%=(int) durationMinutes%>"
                                                                hikeAltitude="<%=hike.getAltitude()%>">
                                </outventure:card_search_results>
                            </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
        </div>
        </div>
        <div id="toastData"
             data-hike-created="<%= request.getAttribute("hikeCreated") %>"
             data-hike-deleted="<%= request.getAttribute("hikeDeleted") %>">
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="/search_results/search_results.js"></script>
        <script src="/tagJavaScript/navbar.js"></script>
        <script src="/globalJS/toasts.js"></script>
    </body>
</html>
