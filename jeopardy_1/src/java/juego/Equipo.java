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
public class Equipo {
    private String nombre;
    private int puntuaje;

    public Equipo(String nombre, int puntuaje) {
        this.nombre = nombre;
        this.puntuaje = puntuaje;
    }

    public Equipo() {
        this.nombre = "";
        this.puntuaje = 0;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPuntuaje() {
        return puntuaje;
    }

    public void setPuntuaje(int puntuaje) {
        this.puntuaje = puntuaje;
    }
    
}
