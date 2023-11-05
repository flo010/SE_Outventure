<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.model.Picture" %><%--
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
        <link href="style.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    </head>
    <body>
        <header>
            <nav class="navbar bg-dark navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.jsp">Navbar</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav">
                            <a class="nav-link active" aria-current="page" href="#"></a>
                            <a class="nav-link" href="#"></a>
                            <a class="nav-link" href="#"></a>
                            <a class="nav-link" href="#"></a>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

        <%
            int hikeID = Integer.parseInt(request.getParameter("id"));
            FacadeJPA facadeJPA = FacadeJPA.getInstance();
            Hike hike = facadeJPA.getHikeByID(hikeID);
            String title = hike.getTitle();
            String description = hike.getDescription();
            Picture picture = hike.getPicture();
            double duration = hike.getDuration();
            double distance = hike.getDistance();
            int altitude = hike.getAltitude();
        %>

        <div class="container hike-datail mt-5">
            <h1><%=title%></h1>

            <p>
                <br>
                Placeholder for picture
            </p>

            <div class="card mb-5 mt-5">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <%-- icon distance --%>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"/>
                            </svg>
                            <b class="card-text"><%=distance%></b>
                            km
                        </div>
                        <div class="col-md-3">
                            <%-- icon duration --%>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                                <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"/>
                                <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"/>
                            </svg>
                            <b class="card-text"><%=duration%></b>
                            h
                        </div>
                        <div class="col-md-3">
                            <%-- icon altitude --%>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-short" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 .5.5z"/>
                            </svg>
                            <b class="card-text"><%=altitude%></b>
                            m
                        </div>
                    </div>
                </div>
            </div>

            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist"> <!-- insert nav-fill in class, when adding all tabs-->
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">Overview</button>
                </li>
                <!-- preparation for other tabs (detail, hike description, getting there)
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">Details</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">Hike Description</button>
                </li>
            
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-disabled-tab" data-bs-toggle="pill" data-bs-target="#pills-disabled" type="button" role="tab" aria-controls="pills-disabled" aria-selected="false">Getting There</button>
                </li>
                -->
            </ul>

            <hr>
            <div class="tab-content mt-4" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
                    <h3>Description</h3>
                    <a><%=description%></a>
                </div>
                <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
                    Placeholder for content
                </div>
                <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab" tabindex="0">
                    Placeholder for content
                </div>
                <div class="tab-pane fade" id="pills-disabled" role="tabpanel" aria-labelledby="pills-disabled-tab" tabindex="0">
                    Placeholder for content
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>
