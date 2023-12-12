<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="hikeID" required="true" type="java.lang.Integer" %>
<%@ attribute name="hikerID" required="true" type="java.lang.Integer" %>
<%@ attribute name="hikePicture" required="true" type="java.lang.Integer" %>
<%@ attribute name="hikeTitle" required="true" type="java.lang.String" %>
<%@ attribute name="hikeDistance" required="true" type="java.lang.Double" %>
<%@ attribute name="hikeDurationHours" required="true" type="java.lang.Integer" %>
<%@ attribute name="hikeDurationMinutes" required="true" type="java.lang.Integer" %>
<%@ attribute name="hikeAltitude" required="true" type="java.lang.Integer" %>
<%@ attribute name="timestamp" required="true" type="java.lang.String" %>


<div class="card hike-card mt-3" style="width: 100%">
    <div class="row">
        <div class="col-md-9">
            <a class="text-decoration-none" style="color: black" href="../hike_detail?id=${hikeID}">
                <div class="row">
                    <div class="col-md-3">
                        <img class="cover-image" style="width: 180px; height: 100px" src="/api/image/${hikePicture}" alt="mountain picture">
                    </div>
                    <div class="col-md-9 d-flex flex-column align-items-center justify-content-center">
                        <h5 class="card-title text-truncate">${hikeTitle}</h5>
                        <div class="details text-center">
                            <div class="details text-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                    <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"></path>
                                </svg>
                                <strong class="card-text">${hikeDistance}</strong>
                                km&nbsp;&nbsp;
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                                    <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"></path>
                                    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"></path>
                                </svg>
                                <strong class="card-text">${hikeDurationHours}</strong>
                                h
                                <% if (hikeDurationMinutes > 0) { %>
                                <strong class="card-text">${hikeDurationMinutes}</strong>
                                min
                                <% } %>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-short" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 .5.5z"></path>
                                </svg>
                                <strong class="card-text">${hikeAltitude}</strong>
                                m
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-3 d-flex flex-column justify-content-center align-items-center">
            <form  id="removeForm" action="/completed_hike?hikeID=${hikeID}&hikerID=${hikerID}&completionDate=${timestamp}&page=profile" method="post">
                <p style="text-align: right" name="timestamp">${timestamp}</p>
                <button type="submit" class="btn btn-outline-danger" id="removeCompletedButton">
                    <i class="fa fa-times"></i>
                    Remove
                </button>
            </form>
        </div>
    </div>
</div>