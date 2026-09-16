package com.g15.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Movimiento implements Serializable {

    private TipoMovimiento tipo;
    private double monto;
    private LocalDateTime fechaHora;

    public Movimiento(
            TipoMovimiento tipo,
            double monto) {

        if (monto <= 0) {
            throw new IllegalArgumentException(
                    "El monto debe ser mayor que cero.");
        }

        this.tipo = tipo;
        this.monto = monto;
        this.fechaHora = LocalDateTime.now();
    }

    //getter

    public TipoMovimiento getTipo() {
        return tipo;
    }

    public double getMonto() {
        return monto;
    }

    public LocalDateTime getFechaHora() {
        return fechaHora;
    }

    public String getFechaFormateada() {

        DateTimeFormatter formato = DateTimeFormatter.ofPattern(
                "dd/MM/yyyy HH:mm");

        return fechaHora.format(formato);
    }

    public double calcularSaldoActual(double saldoAnterior) {
        double nuevoSaldo;

        if (tipo == TipoMovimiento.Recarga) {

            nuevoSaldo = saldoAnterior + monto;

        } else {

            nuevoSaldo = saldoAnterior - monto;
        }

        if (nuevoSaldo < 0) {

            throw new IllegalArgumentException(
                    "El monto del gasto no puede ser mayor que el saldo actual.");
        }

        return nuevoSaldo;
    }
}