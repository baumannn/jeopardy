<%-- 
    Document   : perfil
    Created on : Apr 24, 2015, 10:58:06 AM
    Author     : dgm1
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id = "datos" scope= "request"
   class = "juego.DBhandler" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Jeopardy | Clases</title>
        <script src="js/jquery-1.11.1.js"></script>
        <script src="js/main.js"></script>
        <link rel="stylesheet" type="textcss" href="main.css">
      
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
                    
                    <form name="forma" method="POST" action="Controlador?operacion=eliminarClase">
                        <td><input type="hidden" name="nomClase" value="<%=strclase%>"><input type="submit" name="Submit" value="eliminar"></td>
                    </form>
                    
                    
                <td><form name="forma" method="POST" action="Controlador?operacion=usarClase"><input type="hidden" name="nomClase" value="<%=strclase%>"><input type="submit" name="Submit" value="-->" ></button></form></td>
                    
                </tr>
                

            <%}%>
            
            
            <form name="forma" method="POST" action="Controlador?operacion=addClase">
                <tr>
                    <td>NUEVO</td>
                    <td colspan="2"><input name="nomClase" id="nomclasenueva" value="nombre"/> </td>
                    
                    <td><input type="submit" name="Submit" value="+"></td>
                </tr>
            </form>
            
            </table>

            
            
<!--            
            
            
            
            
            
            <form method="post" action='CrearPerfil'>
                <h3>Escoje la clase</h3>
                <% 
                    clases = (ArrayList) request.getAttribute("clases");

                    for (int i = 0; i < clases.size(); i++) {
                            String tema = (String) clases.get(i);
                %>
                <input type="radio" value="<%=tema%>" name="tema" onClick="mostrarCategoria()"> <%=tema%></input>
                    <%}%>
                    <br><br>
                    
                    <button id="addclass">Agregar clase</button>
                    
                    <br><br>
                    <input type="submit" value='Continuar'>
            </form>
                    -->
                    
                    
                    
                    
                    
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
