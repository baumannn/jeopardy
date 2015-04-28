/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juego;

import java.util.ArrayList;

/**
 *
 * @author dgm1
 */
public class Perfil {
    private String clase;
    private String categoria;
    private ArrayList pistas;

    public Perfil(String clase, String categoria, ArrayList pistas) {
        this.clase = clase;
        this.categoria = categoria;
        this.pistas = pistas;
    }
    
    public Perfil() {
        this.clase = "";
        this.categoria = "";
        this.pistas = new ArrayList();
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public ArrayList getPistas() {
        return pistas;
    }

    public void setPistas(ArrayList pistas) {
        this.pistas = pistas;
    }
    
    
}
