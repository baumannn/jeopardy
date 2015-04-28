<%-- 
    Document   : verJuegos
    Created on : Apr 28, 2015, 10:24:24 AM
    Author     : dgm1
--%>

<%@page import="juego.Equipo"%>
<%@page import="juego.Juego"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="center">
            
            <h3>Lista de Juegos</h3>
            <% 
                ArrayList juegos = (ArrayList) request.getAttribute("juegos");
                
                for (int i = 0; i < juegos.size(); i++) {
                        Juego juego = (Juego) juegos.get(i);
                        ArrayList equipos = juego.getEquipos();
                        %>
                <h3>Juego <%=juego.getNombre()%></h3>
                <table>
                    <th>Equipo</th>
                    <th>Puntuaje</th>
                        <%
                        for(int j=0; j<equipos.size(); j++) {
                            Equipo equipo = (Equipo) equipos.get(j);
                            String strEquipo = equipo.getNombre();
                            int strPuntuaje = equipo.getPuntuaje();
            %>
                <tr>
                    <td><%=strEquipo%></td>
                    <td><%=strPuntuaje%></td>
                </tr>

            <%}%></table><%}%>
        </div>
    </body>
</html>
