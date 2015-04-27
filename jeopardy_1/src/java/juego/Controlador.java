/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juego;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
            
            url="/perfil.jsp";
            
            ArrayList clases, pistas, categorias;
            clases = DBhandler.getClases();
            categorias = DBhandler.getCategorias();
            pistas = DBhandler.getPistas();
            request.setAttribute("clases", clases);
            request.setAttribute("categorias", categorias);
            request.setAttribute("pistas", pistas);
        }
        
        
        
        if(op.equals("eliminarClase")){
            
            
            String clase = request.getParameter("nomClase");
            
            DBhandler.deleteClase(clase);
            
            url="/perfil.jsp";
            
            ArrayList clases, pistas, categorias;
            clases = DBhandler.getClases();
            categorias = DBhandler.getCategorias();
            pistas = DBhandler.getPistas();
            request.setAttribute("clases", clases);
            request.setAttribute("categorias", categorias);
            request.setAttribute("pistas", pistas);
        }
        
        
        if(op.equals("editarClase")){
            
            
            String clase = request.getParameter("nomClaseOld");
            String clasenew = request.getParameter("nomClaseNew");
            
            DBhandler.editClase(clase, clasenew);
            
            url="/perfil.jsp";
            
            ArrayList clases, pistas, categorias;
            clases = DBhandler.getClases();
            categorias = DBhandler.getCategorias();
            pistas = DBhandler.getPistas();
            request.setAttribute("clases", clases);
            request.setAttribute("categorias", categorias);
            request.setAttribute("pistas", pistas);
        }
        
        
        if(op.equals("usarClase")){
            String clase = request.getParameter("nomClase");
            
            System.out.println(clase);
            
            url="/selcategorias.jsp";
            
            ArrayList categorias;
            categorias = DBhandler.getCategorias(clase);
//            pistas = DBhandler.getPistas();
            request.setAttribute("clase", clase);
            request.setAttribute("categorias", categorias);
//            request.setAttribute("pistas", pistas);
        }
        
        if(op.equals("addCategoria")){
            String categoria = request.getParameter("nomCategoria");   
            DBhandler.addCategoria(categoria);
            
            url="/selcategorias.jsp";
            
            ArrayList clases, pistas, categorias;
            clases = DBhandler.getClases();
            categorias = DBhandler.getCategorias();
            pistas = DBhandler.getPistas();
            request.setAttribute("clases", clases);
            request.setAttribute("categorias", categorias);
            request.setAttribute("pistas", pistas);
        }
        
        
        
        if(op.equals("eliminarCategoria")){
            String categoria = request.getParameter("nomCategoria");
            DBhandler.deleteCategoria(categoria);
            
            url="/selcategorias.jsp";
            
            ArrayList clases, pistas, categorias;
            clases = DBhandler.getClases();
            categorias = DBhandler.getCategorias();
            pistas = DBhandler.getPistas();
            request.setAttribute("clases", clases);
            request.setAttribute("categorias", categorias);
            request.setAttribute("pistas", pistas);
        }
        
        
        if(op.equals("editarCategoria")){
            String categoria = request.getParameter("nomCategoriaOld");
            String categoriaNew = request.getParameter("nomCategoriaNew");
            
            DBhandler.editCategoria(categoria, categoriaNew);
            
            url="/selcategorias.jsp";
            
            ArrayList clases, pistas, categorias;
            clases = DBhandler.getClases();
            categorias = DBhandler.getCategorias();
            pistas = DBhandler.getPistas();
            request.setAttribute("clases", clases);
            request.setAttribute("categorias", categorias);
            request.setAttribute("pistas", pistas);
        }
        
        
        if(op.equals("usarCategoria")){
            String clase = request.getParameter("nomCategoria");
            
            System.out.println(clase);
            
            url="/selcategorias.jsp";
            
            ArrayList categorias;
            categorias = DBhandler.getCategorias(clase);
//            pistas = DBhandler.getPistas();
            request.setAttribute("clase", clase);
            request.setAttribute("categorias", categorias);
//            request.setAttribute("pistas", pistas);
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
