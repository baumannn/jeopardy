<%-- 
    Document   : login
    Created on : Apr 21, 2015, 2:21:46 PM
    Author     : TonyMiguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id = "datos" scope= "session"
   class = "juego.DBhandler" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body id="center">
        <%
            if(request.getSession(false) == null){
                int in = (int) session.getAttribute("intentos");
                if(in!=0){
        %>
        <p>Llevas <%=in%> intentos.</p>
        <%}}%>
        <h1>¡Bienvenido!</h1>    
        <form name="forma" method="POST" action="Controlador?operacion=login">        
            User: <input type="text" name="user"><br/>
            <br/>
            Password : <input type="password" name="pass"><br/>
            <br/>
            
            <input type="submit" name="Submit" value="Login">
            <input type="reset" value="Reset">      
        </form>
        <h3>Crear cuenta nueva</h3>
        <form method="GET" action="crearCuenta.jsp">
            <input type="submit" name="Submit" value="Sign up">
        </form>
    </body>
</html>
