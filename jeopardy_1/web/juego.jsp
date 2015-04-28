<%-- 
    Document   : juego
    Created on : Apr 24, 2015, 8:19:09 AM
    Author     : dgm1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="textcss" href="main.css">
        <title>Jeopardy | Juego</title>
        <script src="js/jquery-1.11.1.js"></script>
        <script src="js/main.js"></script>
    </head>
    <body>
        
        <% 
               
                
                String clase = request.getParameter("clase");
                String categoria = request.getParameter("categorias");
                String pista = request.getParameter("pistas");
                String jugador = request.getParameter("jugadores");
                
                
                String[] jugadores = jugador.split(", ");
                
                String[] cats = categoria.split(", ");
                String[] pistas = pista.split("&");
                String[][] pistasss = new String[pistas.length][]; 
                
                
            %>
        
        <div id="center">
            <table id="game">
                <tr id="category">
                    
                    
                    <%
                    for(int i = 0; i < cats.length; i++){ %>
                      
                      <th id="category<%=i%>"><%=cats[i]%></th>  
                        
                    <%
                    }
                    
                    for(int i = 0; i < pistas.length; i++){
                        pistasss[i] = pistas[i].split("@");
                    
                    
                    %>
                         <tr id="level<%=i%>">
                
                        <%
                    }
                        for(int i = 0; i < pistas.length; i++){
                        for(int j = 0; j < pistasss[i].length; j++){
                            
                            

                        %>

                        <td id="category<%=j%>-<%=i%>"><button   data-pista='<%=pistasss[j][i].split("%")[0]%>'  data-respuesta='<%=pistasss[j][i].split("%")[1]%>'  data-puntos="<%=pistasss[j][i].split("%")[2]%>"  class="selpregunta"><%=pistasss[j][i].split("%")[2]%></button></td>
                             

                        <%

                        }
                        %>
                
                
                
                
                        </tr>
                         
                        
                     <%   
                    }
                    %>
                    
                    
                    
                </tr>
                
            </table>
                    
                    
                    
                    <br>
                    
                    <div id="activo"><span id="spuntos"></span><br><span id="spista"></span><br> <span id="srespuesta"></span><br>
                        
                        <button id="mostrarresp">mostrar respuesta</button>
                    
                     <select id="ganador">
                         
                         <%   for(int i = 0; i < jugadores.length; i++) {%>
                         
                        <option data-num="<%=i%>" value="<%=jugadores[i]%>"><%=jugadores[i]%></option>
                        
                        <%}%>
                        
                     </select> <button id="ganar">Seleccionar ganador</button>
                    
                    
                    
                    
                    </div>
                        
                        
                        
                        <br>
                        <button id="terminar">Terminar</button>
        </div>
                    
                        
                        
                        
                        <!--<form method="POST" action="Controlador?operacion=ganarpuntos" id="formsubmit">  <input type="hidden" name="ganador"/> <input type="hidden" name="puntos"/></form>-->
                        
    </body>
    
    
    
    
    
    <script>
        
        
        var puntos;
        var pista;
        var respuesta;
        
        var obj;
        
        var jugadoresarr = [];
        var resultadosarr = [];
        
        $(document).ready(function() {
            
            
            
            $("#activo").hide();
            
            
            
            $("#ganador option" ).each(function(index){
                jugadoresarr[index] = $(this).val();
                resultadosarr[index] = 0;
            });
            
            
            $(".selpregunta").on("click", function(){
                pista = $(this).data("pista");
                
                puntos = $(this).data("puntos");
                
                respuesta = $(this).data("respuesta");
                obj = $(this);
                
                
                $("#activo").show();
                
                $("#srespuesta").html("Respuesta: " + respuesta).hide();
                
                
                
                $("#spuntos").html("Puntos: " + puntos);
                $("#spista").html("Pista: " + pista);
                
                
            });
            
            $("#ganar").on("click", function(){
                
                var pos = parseInt($("#ganador").find(":selected").data("num"));
                
                obj.parent().html(puntos);
                $("#activo").hide();
                
                alert($("#ganador").val() +" gano " + puntos + " puntos!");
                
                resultadosarr[pos] += parseInt(puntos);
                
                $("#formsubmit").children().each(function(index){
                    
                    switch(index){
                            
                            case 0:
                                $(this).val($("#ganador").val());
                                break;
                            case 1:
                                $(this).val(puntos);
                                break;
                                
                            default:
                                break;
                            
                        }
                    
                }).submit();
                
            });
            
            $("#mostrarresp").on("click", function(){
                
                $("#srespuesta").show();
            });
            
            
            $("#terminar").on("click", function(){
                
                var str = "";
                
                for(var i = 0; i < resultadosarr.length; i++){
                    
                    if(i == 0)
                        str+= jugadoresarr[i] + ": " + resultadosarr[i]+ " puntos";
                    else
                        str+= ", " + jugadoresarr[i] + ": " + resultadosarr[i];
                    
                }
                
                alert(str);
                
            });
            
            
            
            
        })
        
    </script>
</html>
