<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="destinationName" required="true" type="java.lang.String" %>
<%@ attribute name="destinationLatitude" required="true" type="java.lang.Double" %>
<%@ attribute name="destinationLongitude" required="true" type="java.lang.Double" %>

<div class="card">
    <div class="card-body">
        <h4 class="card-title text-center">Destination</h4>
        <hr>
        <p>
            <strong>Name: </strong>
            ${destinationName}
        </p>
        <p>
            <strong>GPS Coordinates: </strong>
            ${destinationLatitude} N, ${destinationLongitude} E
        </p>
        <p>
            <a href="https://www.google.com/maps/place/${destinationLatitude},
                                            ${destinationLongitude}" target="_blank">Auf Google Maps anzeigen</a>
        </p>
    </div>
</div>