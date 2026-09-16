package com.g15.model;

import java.io.Serializable;
import java.util.Deque;
import java.util.LinkedList;

public class Billetera implements Serializable {

    private double saldo;

    private final Deque<Movimiento> listaMovimientos = new LinkedList<>();

    // Constructor
    public Billetera() {

        saldo = 2500.00;
    }

    // Getter
    public double getSaldo() {

        return saldo;
    }

    // Método para mostrar movimientos
    public Deque<Movimiento> getListaMovimientos() {

        return listaMovimientos;
    }

    // Método para registrar movimientos
    public void registrarMovimiento(TipoMovimiento tipo, double monto) {

        Movimiento movimiento = new Movimiento(tipo, monto);

        saldo = movimiento.calcularSaldoActual(saldo);

        // Agregar el movimiento al inicio
        listaMovimientos.offerFirst(movimiento);
    }
}