/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juego;

/**
 *
 * @author TonyMiguel
 */
public class User {
    
    private String user, password;

    public User(String user, String password) {
        this.user = user;
        this.password = password;
    }
    
    public User(){
        this.user="";
        this.password="";
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }   
}
