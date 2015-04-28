<%-- 
    Document   : modPistas
    Created on : Apr 28, 2015, 12:46:05 AM
    Author     : dgm1
--%>

<%@page import="juego.Pista"%>
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
            <h3>Modifica la pista</h3>
            <table>
                <th>Pista</th>
                <th>Respuesta</th>
                <th>Valor</th>
                <th>Categoria</th>
                <th>Editar</th>
                <th>Eliminar</th>
            <% 
                ArrayList pistas = (ArrayList) request.getAttribute("pistas");

                for (int i = 0; i < pistas.size(); i++) {
                        Pista pista = (Pista) pistas.get(i);
                        String strPista = pista.getPista();
                        String strRespuesta = pista.getRespuesta();
                        int valor = pista.getValor();
                        String strCategoria = pista.getCategoria();
            %>
                <tr data-pista="<%=strPista%>" data-respuesta="<%=strRespuesta%>" data-valor="<%=valor%>" data-categoria="<%=strCategoria%>">
                    <td><%=strPista%></td>
                    <td><%=strRespuesta%></td>
                    <td><%=valor%></td>
                    <td><%=strCategoria%></td>
                    <td><button class="editarpista" data-pista="<%=strPista%>">editar</button></td>
                    <td>
                        <form name="forma" method="POST" action="Controlador?operacion=eliminarPista">
                            <input type="hidden" name="nomPista" value="<%=strPista%>"><input type="submit" name="Submit" value="eliminar">
                        </form>
                    </td>
                </tr>
            <%}%>
                <tr>
                    <td colspan="4">
                        <form name="forma" method="POST" action="Controlador?operacion=addPista">Crear
                            <input name="nomPista" id="nompistanueva" placeholder="Nombre"/>
                            <input name="respuestaPista" id="respuestaPista" placeholder="Respuesta"/>
                            <input name="valorPista" id="valorPista" placeholder="Valor"/>
                            <input name="categoriaPista" id="nomcategoriadepistanueva" placeholder="Categoria"/>
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
            var pista;

            $(document).ready(function() {
                $(".editarpista").on("click", function(){

                    var fila = $(this).parent().parent();
                    var newhtmla = '<td colspan="4"><form name="editarpista" method="POST" action="Controlador?operacion=editarPista">';

                    var newhtmlb = 
                        'nuevo: ' +
                        '<input type="hidden" name="nomPistaOld" value="'+ fila.data("pista") + '"/>'+
                        '<input name="nomPistaNew" id="nompistaeditado" value="'+fila.data("pista")+ '"/>'+
                        '<input type="hidden" name="nomRespuestaOld" value="'+ fila.data("respuesta") + '"/>'+
                        '<input name="nomRespuestaNew" id="nomrespuestaeditado" value="'+fila.data("respuesta")+ '"/>'+
                        '<input type="hidden" name="nomValorOld" value="'+ fila.data("valor") + '"/>'+
                        '<input name="nomValorNew" id="nomrespuestaeditado" value="'+fila.data("valor")+ '"/>'+
                        '<input type="hidden" name="nomCategoriaOld" value="'+ fila.data("categoria") + '"/>'+
                        '<input name="nomCategoriaNew" id="nomrespuestaeditado" value="'+fila.data("categoria")+
                        '"/><input type="submit" name="Submit" value="Aceptar">';
                    var end = '</form></td>';
//                                console.log(newhtml);
                    fila.html("");
                    fila.append(newhtmla + newhtmlb + end);


                });
            });
        </script>
    </body>
</html>
