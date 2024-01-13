<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="poiName" required="true" type="java.lang.String" %>
<%@ attribute name="poiType" required="true" type="java.lang.String" %>
<%@ attribute name="poiDescription" required="true" type="java.lang.String" %>
<%@ attribute name="poiLatitude" required="true" type="java.lang.Double" %>
<%@ attribute name="poiLongitude" required="true" type="java.lang.Double" %>

<div class="card">
    <div class="card-body">
        <h4 class="card-title text-center">${poiName}</h4>
        <hr>
        <p>
            <strong> Type: </strong>${poiType}
        </p>
        <p>
            <%
                if ((poiDescription != null) && (!poiDescription.isEmpty())) {
            %>
                    <strong>Description: </strong>
                    ${poiDescription}
            <%
                }
            %>
        </p>
        <p>
            <strong>GPS Coordinates: </strong>
            ${poiLatitude} N, ${poiLongitude} E
        </p>
        <p>
            <a href="http://www.google.com/maps/place/${poiLatitude},
                                            ${poiLongitude}" , target="_blank">Auf Google Maps anzeigen</a>
        </p>
    </div>
</div>