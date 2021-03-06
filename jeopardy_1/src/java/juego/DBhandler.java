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
    
    
    public static boolean exQuery(String s) {
        
        
        boolean valido = false;
        try {
            Statement statement = connection.createStatement();
            
            
            ResultSet results = statement.executeQuery(s);
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
    
    public static boolean exUpdate(String s) {
      
        boolean valido = false;
        try {
            Statement statement = connection.createStatement();
            
            statement.executeUpdate(s);
            valido=true;
            
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return valido;
        
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
    
    public static ArrayList getJuegos(String usuario) {
        ArrayList juegos = new ArrayList();
        try {
            Statement statement = connection.createStatement();
            Statement statement2 = connection.createStatement();
            ResultSet results = statement.executeQuery("SELECT * FROM juegos WHERE usuario='"+usuario+"'");
            while(results.next()){
                int j = Integer.parseInt(results.getString(1));
                ResultSet results2 = statement2.executeQuery("SELECT * FROM equipos WHERE juego="+results.getString(1)+"");
                Juego juego = new Juego();
                ArrayList equipos = new ArrayList();
                juego.setNombre(j);
                while(results2.next()) {
                    Equipo equipo = new Equipo();
                    equipo.setNombre(results2.getString(1));
                    equipo.setPuntuaje(Integer.parseInt(results2.getString(2)));
                    equipos.add(equipo);
                }
                juego.setEquipos(equipos);
                juegos.add(juego);
            }
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return juegos;
    }
    
    public static int agregarIntento(String usuario) {
        int intentos = 0;
        try {
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery("SELECT intentos FROM usuarios WHERE users='"+usuario+"'");
            results.next();
            intentos = Integer.parseInt(results.getString(1))+1;
            statement.executeUpdate("UPDATE usuarios SET intentos='"+intentos+"' WHERE users='"+usuario+"'");
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return intentos;
    }
    
    public static int getCheck(String usuario) {
        int ret = 0;
        try {
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery("SELECT * FROM usuarios WHERE users='"+usuario+"'");
            results.next();
            ret = Integer.parseInt(results.getString(3));
            System.out.println(ret);
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }
    
    public static void addUsuario(String nombre, String pass) {
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("INSERT INTO usuarios (users, passwords, login, intentos) VALUES ('" + nombre + "', '"+pass+"', 0, 0)");
            statement.close();
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void agregarPuntos(String usuario, String jugadores, String resultados) {
        try {
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery("SELECT COUNT(juego) FROM juegos");
            results.next();
            int juego = Integer.parseInt(results.getString(1))+1;
            statement.close();
            Statement statement2 = connection.createStatement();
            statement2.executeUpdate("INSERT INTO juegos (juego, usuario) VALUES ('" + juego + "', '"+usuario+"')");
            statement2.close();
            String [] j = jugadores.split(", ");
            String [] r = resultados.split(", ");
            for(int i=0; i<j.length; i++){
                Statement statement3 = connection.createStatement();
                statement3.executeUpdate("INSERT INTO equipos (nombre, puntos, juego) VALUES ('" + j[i] + "', "+r[i]+", "+juego+")");
                statement3.close();
            }
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    public static boolean getCambio(User usuario, String password) {
        //ArrayList list = new ArrayList();
        boolean valido = false;
        try {
            Statement statement = connection.createStatement();
            
            String us = usuario.getUser();
            String pass = usuario.getPassword();
            String pass2 = password;
            
            statement.executeUpdate("UPDATE usuarios SET passwords='"+pass2+"', login=1 WHERE users='"+us+"' AND passwords='"+pass+"'");
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
            
            ResultSet resultsC = statement.executeQuery("SELECT * FROM pistas");
            while (resultsC.next()) {
                    Pista aux = new Pista(resultsC.getString(4),resultsC.getString(1),resultsC.getString(2),resultsC.getInt(3));
                    
                    System.out.println(aux.getPista());
                    
                    pistas.add(aux);
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
            
            ResultSet resultsT = statement.executeQuery("SELECT * FROM categorias");
            while (resultsT.next()) {
                Categoria aux = new Categoria(resultsT.getString(1), resultsT.getString(2));
                categorias.add(aux);
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
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("UPDATE clases SET clase='" + nw +"' WHERE clase='" + s + "'");
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void addCategoria(String s, String c){  
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("INSERT INTO categorias (categoria, clase) VALUES ('" + s + "', '" + c + "')");
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void deleteCategoria(String s) {
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("DELETE FROM categorias WHERE categoria='" + s + "'");
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void editCategoria(String s, String nw, String nc) {
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("UPDATE categorias SET categoria='" + nw +"', clase='"+nc+"' WHERE categoria='" + s + "'");
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void addPista(String p, String r, String valor, String categoria) {
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("INSERT INTO pistas (pista, respuesta, valor, categoria) VALUES ('" + p + "', '" + r + "', " + valor + ", '" + categoria + "')");
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void deletePista(String p) {
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("DELETE FROM pistas WHERE pista='" + p + "'");
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void editPista(String pOld, String pNew, String rOld, String rNew, String vOld, String vNew, String cOld, String cNew) {
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("UPDATE pistas SET pista='" + pNew +"', respuesta='" + rNew+"', valor="+vNew+", categoria='"+cNew+"' WHERE pista='" + pOld + "'");
        } catch (SQLException ex){
                        Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
