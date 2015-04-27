/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package juego;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBhandler {

    private static Connection connection;

    public DBhandler() {
        try { 
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/jeopardy", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static boolean getLogin(User usuario) {
        //ArrayList list = new ArrayList();
        
        
        boolean valido = false;
        try {
            Statement statement = connection.createStatement();
            
            String us = usuario.getUser();
            String pass = usuario.getPassword();
            
            ResultSet results = statement.executeQuery("SELECT * FROM usuarios where users= BINARY '"+us+"' AND passwords= BINARY '"+pass+"' ");
            if (results.next()) { 
                valido=true;
            } else {
                
                
                
            }
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return valido;
    }
    
    
    public static boolean getCambio(User usuario, String password) {
        //ArrayList list = new ArrayList();
        boolean valido = false;
        try {
            Statement statement = connection.createStatement();
            
            String us = usuario.getUser();
            String pass = usuario.getPassword();
            String pass2 = password;
            
            statement.executeUpdate("UPDATE usuarios SET passwords='"+pass2+"' WHERE users='"+us+"' AND passwords='"+pass+"'");
            valido=true;
            
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return valido;
    }
    
    
    
    public static ArrayList getClases(){
        ArrayList clases = new ArrayList();
        try{
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery("SELECT * FROM clases");
            while (results.next()) {
                clases.add(results.getString(1));
            }
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return clases;
    }
    
    
    
    public static ArrayList getPistas(){
        
        
            System.out.println("entra3");
            
        ArrayList pistas = new ArrayList();
        try{
            Statement statement = connection.createStatement();
            
            ResultSet resultsC = statement.executeQuery("SELECT * FROM categorias");
            while (resultsC.next()) {
                ResultSet resultsP = statement.executeQuery("SELECT * FROM pistas WHERE categoria='"+resultsC.getString(1)+"'");
                while(resultsP.next()){
                    Pista aux = new Pista(resultsC.getString(1),resultsP.getString(1),resultsP.getString(2),resultsP.getInt(3));
                    
                    System.out.println(aux.getPista());
                    
                    pistas.add(aux);
                }
            }
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
            System.out.println("entra4");
        return pistas;
    }
    
    
    
    
    public static ArrayList getCategorias(){
        ArrayList categorias = new ArrayList();
        try{
            Statement statement = connection.createStatement();
            
            ResultSet resultsT = statement.executeQuery("SELECT * FROM clases");
            while (resultsT.next()) {
                String clase = resultsT.getString(1);
                ResultSet resultsC = statement.executeQuery("SELECT * FROM categorias WHERE clase='"+clase+"'");
                while(resultsC.next()){
                    Categoria aux = new Categoria(resultsC.getString(1), clase);
                    categorias.add(aux);
                }
            }
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categorias;
    }
    
    public static ArrayList getCategorias(String c){
        ArrayList categorias = new ArrayList();
        try{
            Statement statement = connection.createStatement();
            
            ResultSet resultsC = statement.executeQuery("SELECT * FROM categorias WHERE clase='"+c+"'");
            while(resultsC.next()){
                Categoria aux = new Categoria(resultsC.getString(1), c);
                categorias.add(aux);
            }
            
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
            System.out.println("entra2");
        return categorias;
    }
    
    
    public static void addClase(String s){
        
        try {
            
            
            System.out.println("se agrego " + s);
            
            Statement statement = connection.createStatement();
            
            statement.executeUpdate("INSERT INTO clases (clase) VALUES ('" + s + "')");
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);

        }
    }
    
    
    public static void deleteClase(String s) {
        
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("DELETE FROM clases WHERE clase='" + s + "'");
            
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);

        }
    }
    
    public static void editClase(String s, String nw) {
        
        
            System.out.println("se edito " + s + " a " + nw);
        
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("UPDATE clases SET clase='" + nw +"' WHERE clase='" + s + "'");
            
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);

        }
    }
    
    
}
