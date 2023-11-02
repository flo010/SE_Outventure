<%@ page import="hibernate.broker.HikeBroker" %>
<%@ page import="hibernate.model.Hike" %>
<%@ page import="hibernate.facade.FacadeJPA" %>
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
            FacadeJPA facadeJPA = FacadeJPA.getInstance();
            String hikeName = facadeJPA.getHikeByID(10).getTitle();
        %>
        <p>
            Hike with ID = 10: <%=hikeName%>!
        </p>
    </body>
</html>