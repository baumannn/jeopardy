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
            
            <h3 class="selclase">Escoje la clase</h3>
            <table class="selclase">
            
            <% 
                ArrayList clases = (ArrayList) request.getAttribute("clases");
                ArrayList<Categoria> categorias = (ArrayList) request.getAttribute("categorias");
                ArrayList pistas = (ArrayList) request.getAttribute("pistas");
                

                for (int i = 0; i < clases.size(); i++) {
                        String strclase = (String) clases.get(i);
            %>
            
              
                <tr>
                    
                    <td><%=strclase%></td>
                    <td><button class="usarclase" data-clase="<%=strclase%>">--></button></td>
                   
                </tr>
                

            <%}%>
            
            </table>
            
            
            <h3 class="selcat">Escoje la categoria</h3>
            <table class="selcat" id="tabcats">
            
                <%    for (int i = 0; i < categorias.size(); i++) {
                            String strcat = categorias.get(i).toString();
                %>


                    <tr  data-categoria="<%=strcat%>" data-clase="<%=categorias.get(i).getTema()%>">

                        <td><%=strcat%></td>
                        <td><button class="usarclase" data-clase="<%=categorias.get(i).getTema()%>">--></button></td>

                    </tr>


                <%}%>
            
            
            
            </table>             
        </div> 
        <script>
            var clase;

            $(document).ready(function() {
                
                $(".selcat").hide();
                
                $(".usarclase").on("click", function(){
                    
                    clase = $(this).data("clase");
                    
                    $(".selcat").show();
                    
                    alert($("#tabcats tr").length);
                    
                    if($("#tabcats tr").length > 0){
                    
                        $("#tabcats tr").show().each(function(index){
                            if($(this).data("clase") != clase){
                                $(this).hide();
                            }
                        })
                    } else {
                           $(".selcat").hide();     
                    }
                    


                });
            });
        </script>
    </body>
</html>
