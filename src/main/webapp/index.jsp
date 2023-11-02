<%@ page import="hibernate.broker.HikeBroker" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP - Hello World</title>
    </head>
    <body>
        <h1>Hello World</h1>
        <br/>
        <%
            HikeBroker hb = new HikeBroker();
            String hikeName = hb.get(3).getTitle();
        %>
        <p>
            Hike with ID = 3: <%=hikeName%>!
        </p>
    </body>
</html>