<%-- 
    Document   : selcategorias
    Created on : Apr 26, 2015, 8:48:53 PM
    Author     : baumann
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
            
            <!--<table>-->
                <%
                    
                    
                    ArrayList categorias = (ArrayList) request.getAttribute("categorias");
                    
                    for(int i = 0; i < categorias.size(); i++) {
                        
                        String strcat = categorias.get(i).toString();
                        
                    %>
                    
                    <div><%=strcat%></div>
                    
                    
                    <%}%>
                
                
                
                
                
            <!--</table>-->
            
            
            
            
        </div>
        
        
        
    </body>
</html>
