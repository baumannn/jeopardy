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
            
            
            <h3 class="selcat">Agrega categorias</h3>
            <span id="nocat" style="display:none">No hay categorias</span>
            <table class="selcat" id="tabcats">
            
                <%    for (int i = 0; i < categorias.size(); i++) {
                            String strcat = categorias.get(i).toString();
                %>


                    <tr  data-categoria="<%=strcat%>" data-clase="<%=categorias.get(i).getTema()%>">

                        <td><%=strcat%></td>
                        <td><button class="agregarcat" data-categoria="<%=strcat%>" data-clase="<%=categorias.get(i).getTema()%>">+</button></td>

                    </tr>


                <%}%>
            
            </table>     
                
                
                <h3 class="actcats">Categorias activas:</h3>
                <div id="actcatsshow" class="actcats"></div>
                
                
                <br>
                <button id="getpistas"></button>
                
                
                
        </div> 
        <script>
            var clase;
            var cats;
            var catsarr = [];
            $(document).ready(function() {
                
                $(".selcat").hide();
                $(".actcats").hide();
                
                
                $(".usarclase").on("click", function(){
                    
                    cats = "";
                    catsarr = [];
                    
                    clase = $(this).data("clase");
                    
                    $(".selcat").show();
                    $("#nocat").hide();
                    $(".actcats").hide();
                    
                    var cnt = 0;
                    
                    $("#tabcats tr").hide().each(function(index){
                        if($(this).data("clase") == clase){
                            $(this).show();
                            cnt++;
                        }
                    });
                    
                    if(cnt == 0) {
                        $("#nocat").show();
                    }
                    
                });
                
                
                $(".agregarcat").on("click", function(){
                    
                    $(".actcats").show();
                    
                    
                    catsarr[catsarr.length] = $(this).data("categoria");
                    
                    cats = "<table>";
                    
                    for(var i = 0; i < catsarr.length; i++){
                        
                        cats +=
                            "<tr class='actcats'  >" +
                                "<td>" +
                                    catsarr[i] +
                                "</td>" +
                                "<td>" +
                                    "<button class='elimcat' data-num='" + i + "' > eliminar</button>" +
                                "</td>" +
                            "</tr>";
                            
                    }
                    
                    cats += "<table>";
                    
                    $("#actcatsshow").html(cats);
                   
                });
                
                
                $(document).on("click", ".elimcat", function(){
                   catsarr.splice(parseInt($(this).data("num")), 1);
                   
                   
                   cats = "<table>";
                    
                    for(var i = 0; i < catsarr.length; i++){
                        
                        cats +=
                            "<tr class='actcats' >" +
                                "<td>" +
                                    catsarr[i] +
                                "</td>" +
                                "<td>" +
                                    "<button class='elimcat'  data-num='" + i + "'> eliminar</button>" +
                                "</td>" +
                            "</tr>";
                            
                    }
                    
                    cats += "<table>";
                    
                    $("#actcatsshow").html(cats);
                    
                    if($("#actcatsshow tr").length == 0) {
                        $(".actcats").hide();
                    }
                   
                });
                
                
                
                
                
                
                
            });
        </script>
    </body>
</html>