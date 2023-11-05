<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="java.util.HashMap" %>
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
                    <a class="navbar-brand" href="index.jsp">
                        <img src="mountain.png" width="70" height="70">
                        Outventure
                    </a>
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

                    HashMap<Integer, String> demoImages = new HashMap<Integer, String>();
                    demoImages.put(3, "https://vcdn.bergfex.at/images/resized/38/b094b68b1586f438_55bfb405af9d276b@2x.jpg");
                    demoImages.put(6, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn0_cwGmM3_rxI4QphxaAWPkeB-xo1lGAFCiEBRHHvOA&s");
                    demoImages.put(7, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVbziyOBh9vSiQff6OMX561A7LJL_ZJ9nrtl57CKOEkw&s");
                    demoImages.put(8, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUxN-S3j2MXb_T7XjaVz6Fc0n2Cm0HxkbUaub79hlWTA&s");
                    demoImages.put(9, "https://image.geo.de/30123758/t/i2/v4/w1440/r0/-/inka-pfad-m-05821470-jpg--69964-.jpg");
                    demoImages.put(10, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQkqmsLIREF_Nf6Qd_TwzDI-oChNaQjBs4i4vLJw6crQ&s");
                    demoImages.put(11, "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Kibo_summit_of_Mt_Kilimanjaro_001.JPG/324px-Kibo_summit_of_Mt_Kilimanjaro_001.JPG");
                    demoImages.put(12, "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/The_Twelve_Apostles_Victoria_Australia_2006.JPG/1200px-The_Twelve_Apostles_Victoria_Australia_2006.JPG");
                    demoImages.put(13, "https://challenge8.com/wp-content/uploads/2019/05/Der-ultimative-Patagonien-Trekking-Guide-1024x685.jpg");
                    demoImages.put(14, "https://jakobsweg-lebensweg.de/wp-content/uploads/2019/10/Jakobsweg-Route-alte-Br%C3%BCcke.jpg");

                    for (Hike hike : hikeList) {
                        Integer hikeID = hike.getHikeID();
                        %>
                            <div class="col">
                                <a class="card text-decoration-none" href="hike_detail.jsp?id=<%=hikeID%>">
                                    <img class="card-image-top" style="height: 150px" src="<%=demoImages.get(hikeID)%>" alt="hike picture">
                                    <div class="card-body">
                                        <h5 class="card-title text-truncate"><%=hike.getTitle()%></h5>
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
