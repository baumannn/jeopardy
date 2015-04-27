/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juego;

/**
 *
 * @author dgm1
 */
public class Categoria {
    private String categoria, tema;

    public Categoria(String categoria, String tema) {
        this.categoria = categoria;
        this.tema = tema;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getTema() {
        return tema;
    }

    public void setTema(String tema) {
        this.tema = tema;
    }

    @Override
    public String toString() {
        return categoria; //To change body of generated methods, choose Tools | Templates.
    }
    
    
    
    
}
