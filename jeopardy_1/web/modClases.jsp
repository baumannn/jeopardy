<%-- 
    Document   : modClases
    Created on : Apr 28, 2015, 12:45:50 AM
    Author     : dgm1
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.11.1.js"></script>
        <script src="js/main.js"></script>
        <link rel="stylesheet" type="textcss" href="main.css">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ page import="juego.Categoria" %>
        <%@ page import="juego.Pista" %>
      
        
        
        <div id="center">
            
            <h3>Modifica la clase</h3>
            
            <table>
            <th>Clase</th>
            <th>Editar</th>
            <th>Eliminar</th>
            <% 
                ArrayList clases = (ArrayList) request.getAttribute("clases");

                for (int i = 0; i < clases.size(); i++) {
                        String strclase = (String) clases.get(i);
            %>
                <tr data-clase="<%=strclase%>">
                    <td><%=strclase%></td>
                    <td><button class="editarclase" data-clase="<%=strclase%>">editar</button></td>
                    
                    <td>
                        <form name="forma" method="POST" action="Controlador?operacion=eliminarClase">
                            <input type="hidden" name="nomClase" value="<%=strclase%>"><input type="submit" name="Submit" value="eliminar">
                        </form>
                    </td>
                </tr>
            <%}%>
                <tr>
                    <td colspan="4">
                        <form name="forma" method="POST" action="Controlador?operacion=addClase">Crear
                            <input name="nomClase" id="nomclasenueva" placeholder="nombre"/>
                            <input type="submit" name="Submit" value="+">
                        </form>
                    </td>
                </tr>
            </table>
                <form method="GET" action="inicio.jsp">
                    <input type="submit" value="Menu">
                </form>
        </div> 
        <script>
            var clase;

            $(document).ready(function() {
                $(".editarclase").on("click", function(){

                    var fila = $(this).parent().parent();
                    var newhtmla = '<td colspan="4"><form name="editarclase" method="POST" action="Controlador?operacion=editarClase">';

                    var newhtmlb = 
                        'nuevo: ' +
                        '<input type="hidden" name="nomClaseOld" value="'+ fila.data("clase") + '"/>'+
                        '<input name="nomClaseNew" id="nomclaseeditado" value="'+fila.data("clase")+'"/><input type="submit" name="Submit" value="aceptar">';
                    var end = '</form></td>';
//                                console.log(newhtml);
                    fila.html("");
                    fila.append(newhtmla + newhtmlb + end);


                });
            });
        </script>
    </body>
</html>
