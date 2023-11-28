<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.util.Objects" %>
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

        <div class="container py-3">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3">
                <%
                    List<Hike> hikeList = (List<Hike>) request.getAttribute("hikeList");

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

        <div id="toastData"
             data-hike-created="<%= request.getAttribute("hikeCreated") %>"
             data-hike-deleted="<%= request.getAttribute("hikeDeleted") %>">
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="/search_results/search_results.js"></script>
    </body>
</html>
