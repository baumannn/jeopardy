/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juego;

import com.sun.mail.smtp.SMTPMessage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.ArrayList;
import java.util.Properties;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.http.Cookie;

/**
 *
 * @author TonyMiguel
 */
public class Controlador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User usuario = new User();
        String url = null;
        String op = request.getParameter("operacion");
        
        if(op.equals("login")){
            String user = request.getParameter("user");
            String password = request.getParameter("pass");
            boolean valido = false;
            usuario = new User(user,password);
            valido = DBhandler.getLogin(usuario);
            
            if(valido){
                if(DBhandler.getCheck(user) == 1) {
                    url="/inicio.jsp";
                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usuario);
                    Cookie userIdCookie = new Cookie("userIdCookie", user);
                    userIdCookie.setMaxAge(60*60*24*365*2);
                                                     //set the age to 2 years
                    userIdCookie.setPath("/");
                                    // allow access by the entire application
                    response.addCookie(userIdCookie);
                }
                else {
                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usuario);
                    url="/cambiarPass.jsp";
                }
            }
            else{
                HttpSession session = request.getSession();
                int intentos = DBhandler.agregarIntento(user);
                session.setAttribute("intentos", intentos);
                url="/login.jsp"; 
            }
        }
        
        if(op.equals("logout")) {
            url="/login.jsp";
            Cookie[] cookies = request.getCookies();
            for (int i=0; i<cookies.length; i++)
            {
                Cookie cookie = cookies[i];
                cookie.setMaxAge(0); //delete the cookie
                cookie.setPath("/");
                          //allow the entire application to access it
                response.addCookie(cookie);
            }
            HttpSession session = request.getSession();
            session.invalidate();
        }
        
        if(op.equals("ganarpuntos")) {
            url = "/inicio.jsp";
            String jugadores = request.getParameter("jugadores");
            String resultados = request.getParameter("resultados");
            Cookie[] cookies = request.getCookies(); 
            String cookieName = "userIdCookie";
            String cookieValue = "";
            for (int i=0; i<cookies.length; i++)
            {
                Cookie cookie = cookies[i];
                if (cookieName.equals(cookie.getName()))
                    cookieValue = cookie.getValue();
            }
            DBhandler.agregarPuntos(cookieValue, jugadores, resultados);
        }
        
        if(op.equals("verJuegos")) {
            Cookie[] cookies = request.getCookies(); 
            String cookieName = "userIdCookie";
            String cookieValue = "";
            for (int i=0; i<cookies.length; i++)
            {
                Cookie cookie = cookies[i];
                if (cookieName.equals(cookie.getName()))
                    cookieValue = cookie.getValue();
            }
            ArrayList juegos = DBhandler.getJuegos(cookieValue);
            request.setAttribute("juegos", juegos);
            url="/verJuegos.jsp";
        }
        
        if(op.equals("crearCuenta")) {
            String nombre = request.getParameter("nombre");
            String to = request.getParameter("correo");
            
            String password = UUID.randomUUID().toString().substring(0,15);
            System.out.println(nombre + password);
            url = "/inscrito.jsp";
            
            DBhandler.addUsuario(nombre, password);
            request.setAttribute("nombre", nombre);
            request.setAttribute("password", password);
        }
        
        
        if(op.equals("cambiar")){
            HttpSession session = request.getSession();
            String passNueva = request.getParameter("pN");
            //User uno= new User();
            //session.getAttribute("usuario");
                                
            boolean validoF = false;
            
            User usuarioNuevo = (User) session.getAttribute("usuario"); 
            /*
            if(usuarioNuevo!=null){
                validoF=true;
            }
            */
            validoF = DBhandler.getCambio(usuarioNuevo,passNueva);
            
            if(validoF){
                url="/inicio.jsp";
                session.setAttribute("usuario", usuario);
                Cookie userIdCookie = new Cookie("userIdCookie", usuario.getUser());
                userIdCookie.setMaxAge(60*60*24*365*2);
                                                 //set the age to 2 years
                userIdCookie.setPath("/");
                                // allow access by the entire application
                response.addCookie(userIdCookie);
            }
            else
                url="/cambiarPass.jsp";
    
        }
        
        if(op.equals("modClases")){
            url="/modClases.jsp";
            ArrayList clases;
            clases = DBhandler.getClases();
            request.setAttribute("clases", clases);
        }
        
        if(op.equals("modCategorias")){
            url="/modCategorias.jsp";
            ArrayList categorias;
            categorias = DBhandler.getCategorias();
            request.setAttribute("categorias", categorias);
        }
        
        if(op.equals("modPistas")){
            url="/modPistas.jsp";
            ArrayList pistas;
            pistas = DBhandler.getPistas();
            request.setAttribute("pistas", pistas);
        }
        
        if(op.equals("iniciarJuego")){
            url="/perfil.jsp";
            ArrayList clases, pistas, categorias;
            clases = DBhandler.getClases();
            categorias = DBhandler.getCategorias();
            pistas = DBhandler.getPistas();
            
            request.setAttribute("clases", clases);
            request.setAttribute("categorias", categorias);
            request.setAttribute("pistas", pistas);
        }
        
        if(op.equals("addClase")){
            String clase = request.getParameter("nomClase");
            DBhandler.addClase(clase);
            url="/modClases.jsp";
            
            ArrayList clases;
            clases = DBhandler.getClases();
            request.setAttribute("clases", clases);
        }
        
        
        
        if(op.equals("eliminarClase")){
            String clase = request.getParameter("nomClase");
            DBhandler.deleteClase(clase);
            url="/modClases.jsp";
            
            ArrayList clases;
            clases = DBhandler.getClases();
            request.setAttribute("clases", clases);
        }
        
        
        if(op.equals("editarClase")){
            String clase = request.getParameter("nomClaseOld");
            String clasenew = request.getParameter("nomClaseNew");
            DBhandler.editClase(clase, clasenew);
            url="/modClases.jsp";
            
            ArrayList clases;
            clases = DBhandler.getClases();
            request.setAttribute("clases", clases);
        }
        
        if(op.equals("addCategoria")){
            String categoria = request.getParameter("nomCategoria");   
            String clase = request.getParameter("claseCategoria");
            DBhandler.addCategoria(categoria, clase);
            
            url="/modCategorias.jsp";
            
            ArrayList categorias;
            categorias = DBhandler.getCategorias();
            request.setAttribute("categorias", categorias);
        }

        if(op.equals("eliminarCategoria")){
            String categoria = request.getParameter("nomCategoria");
            DBhandler.deleteCategoria(categoria);
            
            url="/modCategorias.jsp";
            
            ArrayList categorias;
            categorias = DBhandler.getCategorias();
            request.setAttribute("categorias", categorias);
        }
        
        
        if(op.equals("editarCategoria")){
            String categoria = request.getParameter("nomCategoriaOld");
            String categoriaNew = request.getParameter("nomCategoriaNew");
            String claseNew = request.getParameter("nomClaseNew");
            
            DBhandler.editCategoria(categoria, categoriaNew, claseNew);
            
            url="/modCategorias.jsp";
            
            ArrayList categorias;
            categorias = DBhandler.getCategorias();
            request.setAttribute("categorias", categorias);
        }
        
        if(op.equals("addPista")){
            String pista = request.getParameter("nomPista");   
            String categoria = request.getParameter("categoriaPista");
            String valor = request.getParameter("valorPista");
            String respuesta = request.getParameter("respuestaPista");
            DBhandler.addPista(pista, respuesta, valor, categoria);
            
            url="/modPistas.jsp";
            
            ArrayList pistas;
            pistas = DBhandler.getPistas();
            request.setAttribute("pistas", pistas);
        }
        
        if(op.equals("eliminarPista")){
            String pista = request.getParameter("nomPista");
            DBhandler.deletePista(pista);
            
            url="/modPistas.jsp";
            
            ArrayList pistas;
            pistas = DBhandler.getPistas();
            request.setAttribute("pistas", pistas);
        }
        
        if(op.equals("editarPista")){
            String pista = request.getParameter("nomPistaOld");
            String pistaNew = request.getParameter("nomPistaNew");
            String respuesta = request.getParameter("nomRespuestOld");
            String respuestaNew = request.getParameter("nomRespuestaNew");
            String valor = request.getParameter("nomValorOld");
            String valorNew = request.getParameter("nomValorNew");
            String categoria = request.getParameter("nomCategoriaOld");
            String categoriaNew = request.getParameter("nomCategoriaNew");
            
            
            DBhandler.editPista(pista, pistaNew, respuesta, respuestaNew, valor, valorNew, categoria, categoriaNew);
            
            url="/modPistas.jsp";
            
            ArrayList pistas;
            pistas = DBhandler.getPistas();
            request.setAttribute("pistas", pistas);
        }

        
        //forward
        ServletContext sc=this.getServletContext();
        
        System.out.println(url);
        RequestDispatcher rd=sc.getRequestDispatcher(url);
        rd.forward(request, response);
        
        
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
