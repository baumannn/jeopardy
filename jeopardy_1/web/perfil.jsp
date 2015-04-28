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
            
            
            <span class="pickedinfo" ><b>Clase: </b></span> <span id="pickedclase" class="pickedinfo"></span>
            <br class="pickedinfo">
            <span class="pickedinfo"><b>Categorías: </b></span> <span id="pickedcat" class="pickedinfo"></span>
            
            
            <h3 class="selclase">Escoje la clase</h3>
            <table class="selclase">
            
            <% 
                ArrayList clases = (ArrayList) request.getAttribute("clases");
                ArrayList<Categoria> categorias = (ArrayList) request.getAttribute("categorias");
                ArrayList<Pista> pistas = (ArrayList) request.getAttribute("pistas");
                
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
            <button id="getpistas">Siguiente -></button>

                
                
            
            <div id="preguntas">
                
                <% for(int i = 0; i < 5; i++){  %>

                <h3 id="t<%=i%>"><span class="ttl"></span> (<span class="ttlnum"></span>)</h3>
                    <table class="p<%=i%>">
                        
                        <%for (int j = 0; j < pistas.size(); j++) {
                            String pista = pistas.get(j).getPista();
                            String respuesta = pistas.get(j).getRespuesta();
                            String valor = "" + pistas.get(j).getValor();
                            String str = pista + "%" + respuesta + "%" + valor;
                        %>
                        
                            <tr data-cat="<%=pistas.get(j).getCategoria()%>">
                                
                                <td><%=pista%></td>
                                <td><%=respuesta%></td>
                                <td><%=valor%></td>
                                <td><button class="addpista" data-num="<%=i%>" data-val="<%=valor%>" data-string="<%=str%>">+</button></td>
                                
                                
                            </tr>
                           
                        <% } %>
                        
                    </table>

                <% } %>
                
            </div>
                
                
                <br>
                
                <div id="players">
                    <input type="text" id="playername" value="nombre"/> 
                    <button id="addplayer">Agregar usuario</button>
                    <span></span>
                </div>
                
                <br>
                
                <form method="POST" action="juego.jsp" id="formsubmit">  <input type="hidden" name="clase"/> <input type="hidden" name="categorias"/> <input type="hidden" name="pistas"/> <input type="hidden" name="jugadores"/> </form>
                <button id="start">comenzar</button>
                
                
                
                
                
                
                
                
        </div> 
        <script>
            var clase;
            var cats;
            var catsarr = [];
            var catsout;
            
            var parr0 = [];
            var parr1 = [];
            var parr2 = [];
            var parr3 = [];
            var parr4 = [];
            
            var pstr0 = "";
            var pstr1 = "";
            var pstr2 = "";
            var pstr3 = "";
            var pstr4 = "";
            
            var jugadores = "";
            
            $(document).ready(function() {
                
                
                $(".pickedinfo").hide();
                $(".selcat").hide();
                $(".actcats").hide();
                $("#getpistas").hide();
                $("#preguntas").hide();
                $("#start").hide();
                
                $("#players").hide();
                
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
                    
                    
                    if(catsarr.length >= 4) {
                        $(".agregarcat").hide();
                        $("#getpistas").show();
                    }
                    
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
                    
                    $(".agregarcat").show();
                    $("#getpistas").hide();
                   
                });
                
                
                $("#getpistas").on("click",function(){
                    $(".selclase").hide();
                    $(".selcat").hide();
                    $(".actcats").hide();
                    $("#getpistas").hide();
                    
                    catsout = "";
                    
                    for(var i = 0; i < catsarr.length; i++){
                        
                        if(catsout == ""){
                            catsout += catsarr[i] ;
                        } else {
                            catsout += ", " + catsarr[i] ;
                        }
                    }
                    
                    $("#pickedclase").html(clase);
                    $("#pickedcat").html(catsout);
                    
                    $(".pickedinfo").show();
                    
                    $("#preguntas").show();
                    
                    for(var i = 0; i < 5; i++){
                        
                        $("#t"+ i + " .ttl").html(catsarr[i]);
                        $("#t"+ i + " .ttlnum").html("0");
                        
                        
                        $("#preguntas .p" + i + " tr").each(function(index){
                            
                            
                            if($(this).data("cat") == catsarr[i]){
                                $(this).show();
                            }
                            else {
                                $(this).hide();
                            }
                        });
                    }
                });
                
                
                
                $(document).on("click", ".addpista", function(){
                    
                    var str = $(this).data("string");
                    var pos = 0;
                    var flag = 0;
                    
                    
                    switch($(this).data("num")){
                        
                        case 0:
                            if(parr0.length != 5){
                                flag = 1;
                            }
                            break;  
                        case 1:
                            if(parr1.length != 5){
                                flag = 1;
                            }
                            break;  
                        case 2:
                            if(parr2.length != 5){
                                flag = 1;
                            }
                            break;  
                        case 3:
                            if(parr3.length != 5){
                                flag = 1;
                            }
                            break;  
                        case 4:
                            if(parr4.length != 5){
                                flag = 1;
                            }
                            break;  
                        default:
                            break;
                        
                    }
                    
                    
                    if(flag==1){

                        switch($(this).data("num")){

                            case 0:
                                pos = parr0.length;
                                parr0[parr0.length] = str;
                                break;  
                            case 1:
                                pos = parr1.length;
                                parr1[parr1.length] = str;
                                break;  
                            case 2:
                                pos = parr2.length;
                                parr2[parr2.length] = str;
                                break;  
                            case 3:
                                pos = parr3.length;
                                parr3[parr3.length] = str;
                                break;  
                            case 4:
                                pos = parr4.length;
                                parr4[parr4.length] = str;
                                break;
                            default:
                                break;

                        }

                        $(this).parent().html("<button class='rempista' data-pos='" + pos + "' data-num='" + $(this).data("num") + "' data-val='" + $(this).data("val") + "' data-string='" + str + "'>eliminar</button>");
                        updatePistas();



                        if(parr0.length + parr1.length + parr2.length + parr3.length + parr4.length == 25){
                            $("#start").show();
                            $("#players").show();
                        }







                    }
                    
                });
                
                
                $(document).on("click", ".rempista", function(){
                    
                    $("#start").hide();
                    
                    
                    var pos = parseInt($(this).data("pos"));
                        
                    switch($(this).data("num")){
                        

                        case 0:
                            parr0.splice(pos, 1);
                            break;  
                        case 1:
                            parr1.splice(pos, 1);
                            break;  
                        case 2:
                            parr2.splice(pos, 1);
                            break;  
                        case 3:
                            parr3.splice(pos, 1);
                            break;  
                        case 4:
                            parr4.splice(pos, 1);
                            break;
                        default:
                            break;
                        
                    }
                    
                    $(this).parent().html("<button class='addpista' data-num='" + $(this).data("num") + "' data-val='" + $(this).data("val") + "' data-string='" + $(this).data("string") + "'>+</button>");
                    updatePistas();
                    
                
                });
                
                
                function updatePistas(){
                    $("#t0 .ttlnum").html("" + parr0.length);
                    $("#t1 .ttlnum").html("" + parr1.length);
                    $("#t2 .ttlnum").html("" + parr2.length);
                    $("#t3 .ttlnum").html("" + parr3.length);
                    $("#t4 .ttlnum").html("" + parr4.length);
                    
                    
                    var es = "";
                    
                    pstr0 = "";
                    pstr1 = "";
                    pstr2 = "";
                    pstr3 = "";
                    pstr4 = "";
                    
                    
                    for(var i = 0; i < parr0.length; i++){
                        if(i == 4){
                            pstr0+=parr0[i]
                        }else{
                            pstr0+=parr0[i] + "@";
                        }
                    }
                    
                    for(var i = 0; i < parr1.length; i++){
                        if(i == 4){
                            pstr1+=parr1[i]
                        }else{
                            pstr1+=parr1[i] + "@";
                        }
                    }
                    
                    for(var i = 0; i < parr2.length; i++){
                        if(i == 4){
                            pstr2+=parr2[i]
                        }else{
                            pstr2+=parr2[i] + "@";
                        }
                    }
                    
                    for(var i = 0; i < parr3.length; i++){
                        if(i == 4){
                            pstr3+=parr3[i]
                        }else{
                            pstr3+=parr3[i] + "@";
                        }
                    }
                    
                    for(var i = 0; i < parr4.length; i++){
                        if(i == 4){
                            pstr4+=parr4[i]
                        }else{
                            pstr4+=parr4[i] + "@";
                        }
                    }
                    
                    
                    es = pstr0 + "&" + pstr1 + "&" + pstr2 + "&" + pstr3 + "&" + pstr4; 
                    
                    
                    
//                    $("#epicstring").html(es);
                }
                
                
                $("#addplayer").on("click", function(){
                    
                    if(jugadores == "")
                        jugadores += $("#playername").val();
                    else
                        jugadores += ", " + $("#playername").val();
                    
                    
                    $("#players span").html("Jugadores: " + jugadores);
                    
                    
                })
                
                
                $("#start").on("click",function(){
                    
                    $("#formsubmit input").each(function(index){
                        
                        switch(index){
                            
                            case 0:
                                $(this).val(clase);
                                break;
                            case 1:
                                $(this).val(catsout);
                                break;
                            case 2:
                                $(this).val(pstr0 + "&" + pstr1 + "&" + pstr2 + "&" + pstr3 + "&" + pstr4);
                                break;
                                
                            case 3:
                                $(this).val(jugadores);
                                break;
                            default:
                                break;
                            
                        }
                        
                        
                    });
                    
                    $("#formsubmit").submit();
                    
//                    $.post( "juego.jsp", { clase: clase, categorias: catsout, categorias: pstr0 + "&" + pstr1 + "&" + pstr2 + "&" + pstr3 + "&" + pstr4 } );
                    
                    
                    
                });
                
                

                
                
            });
        </script>
    </body>
</html>