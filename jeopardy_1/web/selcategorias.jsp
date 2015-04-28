<%-- 
    Document   : selcategorias
    Created on : Apr 26, 2015, 8:48:53 PM
    Author     : baumann
--%>

<%@page import="juego.Perfil"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id = "datos" scope= "request"
   class = "juego.DBhandler" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Jeopardy | Categorias</title>
        <script src="js/jquery-1.11.1.js"></script>
        <script src="js/main.js"></script>
        <link rel="stylesheet" type="textcss" href="main.css">
    </head>
    <body>
        <%@ page import="juego.Categoria" %>
        <%@ page import="juego.Pista" %>
        
        <div id="center">
            
            <h3>Agrega una categoria</h3>
            
            <table>
                <%
                    ArrayList categorias = (ArrayList) request.getAttribute("categorias");
                    Perfil perfil = (Perfil) request.getAttribute("perfil");
                    request.setAttribute("perfil", perfil);
                    for(int i = 0; i < categorias.size(); i++) {        
                        String strcat = categorias.get(i).toString();  
                    %>
                    
                    <tr data-categoria="<%=strcat%>">
                    
                    <td><%=strcat%></td>
                    <td><button class="editarcategoria" data-categoria="<%=strcat%>">editar</button></td>
                    
                    <form name="forma" method="POST" action="Controlador?operacion=eliminarCategoria">
                        <td><input type="hidden" name="nomCategoria" value="<%=strcat%>"><input type="submit" name="Submit" value="eliminar"></td>
                    </form>
                    
                    
                <td><form name="forma" method="POST" action="Controlador?operacion=usarCategoria"><input type="hidden" name="nomCategoria" value="<%=strcat%>"><input type="submit" name="Submit" value="-->" ></button></form></td>
                    
                </tr>
                    
                    <%}%>
                
                <form name="forma" method="POST" action="Controlador?operacion=addCategoria">
                <tr>
                    <td>NUEVO</td>
                    <td colspan="2"><input type="hidden" name="claseCategoria" value="<%=request.getAttribute("clase")%>"/><input name="nomCategoria" id="nomcategorianueva" value="nombre"/> </td>
                    
                    <td><input type="submit" name="Submit" value="+"></td>
                </tr>
                </form>                 
            </table>
            
            <script>
                var categoria;

                $(document).ready(function() {
                    $(".editarcategoria").on("click", function(){

                        var fila = $(this).parent().parent();
                        var newhtmla = '<td colspan="4"><form name="editarcategoria" method="POST" action="Controlador?operacion=editarCategoria">';

                        var newhtmlb = 
                            'nuevo: ' +
                            '<input type="hidden" name="nomCategoriaOld" value="'+ fila.data("categoria") + '"/>'+
                            '<input name="nomCategoriaNew" id="nomcategoriaeditado" value="'+fila.data("categoria")+'"/><input type="submit" name="Submit" value="aceptar">';

                        var end = '</form></td>';
//                                console.log(newhtml);
                        fila.html("");
                        fila.append(newhtmla + newhtmlb + end);
                    });                  
                });      
            </script>    
        </div>
    </body>
</html>
