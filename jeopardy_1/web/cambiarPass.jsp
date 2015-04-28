<%-- 
    Document   : cambiarPass
    Created on : Apr 23, 2015, 9:56:35 PM
    Author     : TonyMiguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id = "datos" scope= "session"
   class = "juego.DBhandler" />

<!DOCTYPE html>
<html>
<body>
    

<center>
<br/><br/>

<h1>Cambio de Contraseña</h1>


<form name="forma" method="POST" action="Controlador?operacion=cambiar">
            
           Modifique su contraseña : <input type="password" name="pN"><br/>
<br/>            
            <input type="submit" name="Submit" value="Cambiar">
            <input type="reset" value="Reset">
            
        </form>




</center>
</body>
</html>