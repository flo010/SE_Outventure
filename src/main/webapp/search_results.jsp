<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.util.Objects" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search Results</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet">
    </head>
    <body style="background-color: #F8F7EF">
        <header>
            <jsp:include page="navbar.jsp"/>
        </header>

        <div class="container py-3">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3">
                <%
                    HashMap<Integer, String> demoImages = new HashMap<Integer, String>();
                    demoImages.put(101, "https://www.bergwelten.com/files/tour/images/niederkaiserkamm-14871-0.jpg?impolicy=gallerie_pictures");
                    demoImages.put(102, "https://vcdn.bergfex.at/images/resized/profiles/detail/986/1af6fc7b24cc5b2ff8a32e1953d53986.jpg?1283172909");
                    demoImages.put(103, "https://img.oastatic.com/img2/70761600/max/t.jpg?revbust=468c8c45");
                    demoImages.put(104, "https://www.steiermark.com/Alpstein/Images/67091283/1306941/image-thumb__1306941__lightbox/bad-mitterndorf-mit-grimming-25240459.jpg");
                    demoImages.put(105, "https://www.almenrausch.at/uploads/tx_webxhousingv2/trips/352/DSC_2340_9461.jpg");
                    demoImages.put(106, "https://www.bodensee.de/extension/portal-bodensee/var/storage/images/media/bibliothek/ausflugsziele/pfaenderbahn/pfaenderbahn-mit-ausblick/46348-1-ger-DE/pfaenderbahn-mit-ausblick_front_large.jpg");
                    demoImages.put(107, "https://vcdn.bergfex.at/images/resized/7c/fc07758d6a2af77c_20a169d014543ab0@2x.jpg");
                    demoImages.put(108, "https://d2exd72xrrp1s7.cloudfront.net/www/000/1k4/a8/a8mx6d7f7cpz17bjyys8lhlle3eto5gp1-uhi15367968/0?width=3072&height=2304&crop=false&q=70");

                    List<Hike> hikeList = (List<Hike>) request.getAttribute("hikeList");

                    for (Hike hike : hikeList) {
                        double durationMinutes = (hike.getDuration() % 1) * 60;
                %>
                <div class="col">
                    <a class="card text-decoration-none" href="hike_detail?id=<%=hike.getHikeID()%>">
                        <img class="card-image-top" src="/api/image/<%=hike.getPreviewPicture()%>" alt="hike picture">
                        <div class="card-body">
                            <h5 class="card-title text-truncate"><%=hike.getTitle()%></h5>
                            <div class="col">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                    <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"></path>
                                </svg>
                                <strong class="card-text"><%=hike.getDistance()%></strong>
                                km&nbsp;&nbsp;
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
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-short" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 .5.5z"></path>
                                </svg>
                                <strong class="card-text"><%=hike.getAltitude()%></strong>
                                m
                            </div>
                        </div>
                    </a>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script>
            function createToast(headerMessage, bodyMessage) {
                // Create a new toast element
                var toast = document.createElement("div");
                toast.className = "toast position-fixed top-0 start-50 translate-middle-x";
                toast.setAttribute("id", "saveHikeToast")
                toast.setAttribute("role", "alert");
                toast.setAttribute("aria-live", "assertive");
                toast.setAttribute("aria-atomic", "true");

                // Create toast header
                var toastHeader = document.createElement("div");
                toastHeader.className = "toast-header";

                var strongElement = document.createElement("strong");
                strongElement.className = "me-auto";
                strongElement.innerText = headerMessage;
                var buttonElement = document.createElement("button");
                buttonElement.className = "btn-close";
                buttonElement.setAttribute("data-bs-dismiss", "toast");
                buttonElement.setAttribute("aria-label", "Close");

                toastHeader.appendChild(strongElement);
                toastHeader.appendChild(buttonElement);
                toast.appendChild(toastHeader);

                // Create toast body
                var toastBody = document.createElement("div");
                toastBody.className = "toast-body";
                toastBody.innerText = bodyMessage;
                toast.appendChild(toastBody);

                // Append the toast to the body
                document.body.appendChild(toast);
            }

            function showSaveHikeToast() {
                var toast = new bootstrap.Toast(document.getElementById("saveHikeToast"));
                toast.show();
            }

            if (<%=request.getAttribute("hikeCreated")%>) {
                createToast("Successful saving", "Your hike was successfully saved!");
                showSaveHikeToast();
            }
        </script>
    </body>
</html>
