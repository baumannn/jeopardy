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
    private ArrayList categorias;
    private ArrayList pistas;

    public Perfil(String clase, ArrayList categorias, ArrayList pistas) {
        this.clase = clase;
        this.categorias = categorias;
        this.pistas = pistas;
    }
    
    public Perfil() {
        this.clase = "";
        this.categorias = new ArrayList();
        this.pistas = new ArrayList();
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public ArrayList getCategorias() {
        return categorias;
    }

    public void setCategorias(ArrayList categorias) {
        this.categorias = categorias;
    }

    public ArrayList getPistas() {
        return pistas;
    }

    public void setPistas(ArrayList pistas) {
        this.pistas = pistas;
    }
    
    
}
