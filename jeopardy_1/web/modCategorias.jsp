<%-- 
    Document   : modCategorias
    Created on : Apr 28, 2015, 12:45:56 AM
    Author     : dgm1
--%>

<%@page import="juego.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/jquery-1.11.1.js"></script>
        <script src="js/main.js"></script>
        <link rel="stylesheet" type="textcss" href="main.css">
    </head>
    <body>
        <div id="center">
            
            <h3>Modifica la categoria</h3>
            <table>
                <th>Categoria</th>
                <th>Clase</th>
                <th>Editar</th>
                <th>Eliminar</th>
            <% 
                ArrayList categorias = (ArrayList) request.getAttribute("categorias");

                for (int i = 0; i < categorias.size(); i++) {
                        Categoria cat = (Categoria) categorias.get(i);
                        String strCat = cat.getCategoria();
                        String strClase = cat.getTema();
            %>
                <tr data-categoria="<%=strCat%>" data-clase="<%=strClase%>">
                    <td><%=strCat%></td>
                    <td><%=strClase%></td>
                    <td><button class="editarcategoria" data-categoria="<%=strCat%>">editar</button></td>
                    <td>
                        <form name="forma" method="POST" action="Controlador?operacion=eliminarCategoria">
                            <input type="hidden" name="nomCategoria" value="<%=strCat%>"><input type="submit" name="Submit" value="eliminar">
                        </form>
                    </td>
                </tr>
            <%}%>
                <tr>
                    <td colspan="4">
                        <form name="forma" method="POST" action="Controlador?operacion=addCategoria">Crear
                            <input name="nomCategoria" id="nomcategorianueva" placeholder="Nombre"/>
                             <input name="claseCategoria" id="nomclasedecategorianueva" placeholder="Clase"/>
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
            var categoria;

            $(document).ready(function() {
                $(".editarcategoria").on("click", function(){

                    var fila = $(this).parent().parent();
                    var newhtmla = '<td colspan="4"><form name="editarcategoria" method="POST" action="Controlador?operacion=editarCategoria">';

                    var newhtmlb = 
                        'nuevo: ' +
                        '<input type="hidden" name="nomCategoriaOld" value="'+ fila.data("categoria") + '"/>'+
                        '<input name="nomCategoriaNew" id="nomcategoriaeditado" value="'+fila.data("categoria")+'"/>'+
                        '<input name="nomClaseNew" id="nomclaseeditado" value="'+fila.data("clase")+
                        '"/><input type="submit" name="Submit" value="aceptar">';
                    var end = '</form></td>';
//                                console.log(newhtml);
                    fila.html("");
                    fila.append(newhtmla + newhtmlb + end);


                });
            });
        </script>
    </body>
</html>
