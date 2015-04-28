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
        <title>JSP Page</title>
    </head>
    <body>
        <%@ page import="juego.Categoria" %>
        <%@ page import="juego.Pista" %>
      
        
        
        <div id="center">
            
            <h3>Escoje la clase</h3>
            
            <table>
            
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
                    
                    
                <td><form name="forma" method="POST" action="Controlador?operacion=usarClase"><input type="hidden" name="nomClase" value="<%=strclase%>"></form></td>
                    
                </tr>
                

            <%}%>
            
            
            
                <tr>
                    <td colspan="4">
                        <form name="forma" method="POST" action="Controlador?operacion=addClase">NUEVO
                            <input name="nomClase" id="nomclasenueva" value="nombre"/>
                            <input type="submit" name="Submit" value="+">
                        </form>
                    </td>
                </tr>
            
            
            </table>             
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
