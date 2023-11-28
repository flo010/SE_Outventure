<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="startName" required="true" type="java.lang.String" %>
<%@ attribute name="startLatitude" required="true" type="java.lang.Double" %>
<%@ attribute name="startLongitude" required="true" type="java.lang.Double" %>
<%@ attribute name="arrivalInformation" type="java.lang.String" %>
<%@ attribute name="parkingInformation" type="java.lang.String" %>

<div class="card">
    <div class="card-body">
        <h4 class="card-title text-center">Start</h4>
        <hr>
        <p class="card-text">
            <strong>Name: </strong>
            ${startName}
        </p>
        <p>
            <strong>GPS Coordinates: </strong>
            ${startLatitude} N, ${startLongitude} E
        </p>
        <%
            if (arrivalInformation != null) {
        %>
            <p>
                <strong>Arrival: </strong>
                ${arrivalInformation}
            </p>
        <% } %>
        <%
            if (parkingInformation != null){
        %>
        <p>
            <strong>Parking: </strong>
            ${parkingInformation}
        </p>
        <% } %>
        <p>
            <a href="http://www.google.com/maps?saddr=My+Location&daddr=${startLatitude},
                                            ${startLongitude}", target="_blank">Auf Google Maps anzeigen</a>
        </p>
    </div>
</div>