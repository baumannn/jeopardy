<%-- 
    Document   : crearCuenta
    Created on : Apr 28, 2015, 2:36:45 AM
    Author     : dgm1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Sign up!</h1>
        <form method="GET" action="Controlador?operacion=crearCuenta">
            Ingresa el nombre de tu cuenta: <input type="text" name="nombre" placeholder="Nombre de cuenta"><br>
            Ingresa tu cuenta de correos: <input type="text" name="correo" placeholder="Cuenta de correos"><br>
        </form>
    </body>
</html>
