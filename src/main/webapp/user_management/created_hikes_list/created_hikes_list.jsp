<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<%
    List<Hike> hikeList = (List<Hike>) request.getAttribute("createdHikes");
%>

<html>
    <head>
        <title>Created Hikes</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="../../css/profile.css" rel="stylesheet">
        <link href="../../css/style.css" rel="stylesheet">
    </head>
    <body class="pale-background">
        <header>
            <outventure:navbar/>
        </header>
        <div class="container">
            <div class="login-container">
                <outventure:profile_left_box currentPage="hike_list"/>
                <div class="right-box overflow-auto">
                    <div class="right-box-header">
                        <h3>Your Created Hikes</h3>
                    </div>
                    <div class="mt-3">
                        <% boolean is_visible = false;
                            for (Hike hike: hikeList) {
                                if (hike.isVisible()) {
                                    is_visible = true;
                                    break;
                                }
                        }if(!is_visible){ %>
                            <div class="empty-list-message mt-5 text-center">
                                <p>Your list is empty.</p>
                                <p>Click <a href="../../hike/create_hike/create_hike.jsp">here</a> to create your first hike.</p>
                            </div>
                        <%
                        }
                        else {
                            for (Hike hike: hikeList) { if(hike.isVisible()){
                                double durationMinutes = (hike.getDuration() % 1) * 60;
                        %>
                            <outventure:card_created_hike
                                    hikeID="<%=hike.getHikeID()%>"
                                    hikePicture="<%=hike.getPreviewPicture()%>"
                                    hikeTitle="<%=hike.getTitle()%>"
                                    hikeDistance="<%=hike.getDistance()%>"
                                    hikeDurationHours="<%=(int)hike.getDuration()%>"
                                    hikeDurationMinutes="<%=(int)durationMinutes%>"
                                    hikeAltitude="<%=hike.getAltitude()%>">
                            </outventure:card_created_hike>
                        <% }}} %>
                    </div>
                </div>

            </div>

            <div class="modal fade" id="deleteHikeModal" tabindex="-1" role="dialog" aria-labelledby="deleteHikeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteHikeModalLabel">Delete Hike with</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete this hike?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="deleteHike(selectedHikeID)">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="toastData" data-hike-deleted="<%= session.getAttribute("hikeDeleted") %>"></div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="/user_management/created_hikes_list/created_hikes_list.js"></script>
        <script src="../../global_java_script/navbar.js"></script>
        <script src="../../global_java_script/toasts.js"></script>
    </body>
</html>
