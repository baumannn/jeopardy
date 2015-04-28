/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juego;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.websocket.Session;
import javax.mail.*;

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
                url="/inicio.jsp";
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
            }
            else
                url="/login.jsp";
        }
        
        if(op.equals("crearCuenta")) {
            String to = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            
            String password = UUID.randomUUID().toString();
            
            String from = "dgarza.m93@gmail.com";

            // Assuming you are sending email from localhost
            String host = "localhost";

            // Get system properties
            Properties properties = System.getProperties();

            // Setup mail server
            properties.setProperty("mail.smtp.host", host);

            // Get the default Session object.
            Session session = Session.getDefaultInstance(properties);

            try{
               // Create a default MimeMessage object.
               MimeMessage message = new MimeMessage(session);

               // Set From: header field of the header.
               message.setFrom(new InternetAddress(from));

               // Set To: header field of the header.
               message.addRecipient(Message.RecipientType.TO,
                                        new InternetAddress(to));

               // Set Subject: header field
               message.setSubject("This is the Subject Line!");

               // Now set the actual message
               message.setText("This is actual message");

               // Send message
               Transport.send(message);
               System.out.println("Sent message successfully....");
            }catch (MessagingException mex) {
               mex.printStackTrace();
            }
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
