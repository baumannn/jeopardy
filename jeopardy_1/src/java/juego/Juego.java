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
public class Juego {
    private int nombre;
    private ArrayList equipos;

    public Juego(int nombre, ArrayList equipos) {
        this.nombre = nombre;
        this.equipos = equipos;
    }
    public Juego() {
        this.nombre = 0;
        this.equipos = new ArrayList();
    }

    public int getNombre() {
        return nombre;
    }

    public void setNombre(int nombre) {
        this.nombre = nombre;
    }

    public ArrayList getEquipos() {
        return equipos;
    }

    public void setEquipos(ArrayList equipos) {
        this.equipos = equipos;
    }
    
}
