<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search Results</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    </head>
    <body style="background-color: #F8F7EF">
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

        <div class="container py-3">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3">
                <%
                    FacadeJPA facadeJPA = FacadeJPA.getInstance();
                    List<Hike> hikeList = facadeJPA.getAllHikes();

                    for (Hike hike : hikeList) {
                        Integer hikeID = hike.getHikeID();
                        %>
                            <div class="col">
                                <a class="card text-decoration-none" href="hike_detail.jsp?id=<%=hikeID%>">
                                    <div class="card-body">
                                        <h5 class="card-title"><%=hike.getTitle()%></h5>
                                    </div>
                                </a>
                            </div>
                        <%
                    }
                %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>