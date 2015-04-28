<%-- 
    Document   : inscrito
    Created on : Apr 28, 2015, 3:10:18 AM
    Author     : dgm1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String nombre = request.getParameter("nombre");
            String password = request.getParameter("password");
            %>
        <h1>¡Bienvenido!</h1>
        <p>Gracias por inscribirte, pronto te llegara un mail con tu contraseña</p>
        <br>
        <p>Tu cuenta es: <%=nombre%></p>
        <br>
        <p>Tu password es: <%=password%></p>
        <br>
        <form method="GET" action="login.jsp">
            <input type="submit" value="Login">
        </form>
    </body>
</html>
