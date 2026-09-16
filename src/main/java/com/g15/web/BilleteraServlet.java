package com.g15.web;

import com.g15.model.Billetera;
import com.g15.model.TipoMovimiento;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/billetera/*")
public class BilleteraServlet extends HttpServlet {

        // Objeto billetera
        private final Billetera billetera = new Billetera();

        @Override
        protected void doGet(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                // Enviar saldo a la vista
                request.setAttribute(
                                "saldo",
                                billetera.getSaldo());

                // Enviar movimientos a la vista
                request.setAttribute(
                                "movimientos",
                                billetera.getListaMovimientos());

                // Enviar tipos de movimiento a la vista
                request.setAttribute(
                                "tiposMovimiento",
                                TipoMovimiento.values());

                // Mostrar billetera.jsp
                request.getRequestDispatcher(
                                "/WEB-INF/views/billetera.jsp").forward(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                String montoTexto = request.getParameter("monto");
                String tipoTexto = request.getParameter("tipo");

                try {
                        double monto = Double.parseDouble(montoTexto);
                        TipoMovimiento tipo = TipoMovimiento.valueOf(tipoTexto);

                        billetera.registrarMovimiento(tipo, monto);
                        
                        response.sendRedirect(request.getContextPath() + "/billetera");

                } catch (NumberFormatException e) {

                        request.setAttribute(
                                        "error","El monto debe ser un número válido.");

                        doGet(request, response);

                } catch (IllegalArgumentException e) {

                        request.setAttribute(
                                        "error",
                                        e.getMessage());

                        doGet(request, response);
                }
        }
}