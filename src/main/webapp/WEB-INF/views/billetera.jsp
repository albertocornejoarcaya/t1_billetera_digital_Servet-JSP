<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>



<%@ include file="layout-header.jsp" %>

<div class="container" style="margin-top: 50px;">

    <div class="bg-dark text-white p-3 mb-4">
        <h2 class="h5 mb-0">
            Transacciones
        </h2>
    </div>


    <div class="card mb-4" style="max-width: 350px;">

        <div class="card-body">

            <p class="text-center fw-bolder fs-3">
                Saldo actual
            </p>

            <h3 class="text-success text-center">

                S/ <fmt:formatNumber
                    value="${saldo}"
                    pattern="#,##0.00"/>

            </h3>

        </div>

    </div>

    <%--Mostrar movimeinto recientes--%>
    <h5 class="mb-3">
        Movimientos recientes
    </h5>
    <c:if test="${empty movimientos}">

        <div class="alert alert-secondary">
            No existen movimientos registrados.
        </div>

    </c:if>


    <c:if test="${not empty movimientos}">

        <table class="table table-bordered table-striped">

            <thead class="table-dark">

                <tr>
                    <th>Fecha y Hora</th>
                    <th>Tipo</th>
                    <th>Monto</th>
                </tr>

            </thead>

            <tbody>
                <%-- Bucle para recorrer la cola registros de transacciones--%>

                <c:forEach
                    var="movimiento"
                    items="${movimientos}">

                    <tr>

                        <td>
                            ${movimiento.fechaFormateada}
                        </td>

                        <td>

                            <c:choose>

                                <c:when test="${movimiento.tipo == 'Recarga'}">

                                    <span class="badge bg-success">
                                        Recarga
                                    </span>

                                </c:when>

                                <c:otherwise>

                                    <span class="badge bg-danger">
                                        Gasto
                                    </span>

                                </c:otherwise>

                            </c:choose>

                        </td>

                        <td>

                            <c:choose>

                                <c:when test="${movimiento.tipo == 'Recarga'}">

                                    <span class="text-success fw-bolder">
                                        + S/
                                        <fmt:formatNumber
                                            value="${movimiento.monto}"
                                            pattern="#,##0.00"/>
                                    </span>

                                </c:when>

                                <c:otherwise>

                                    <span class="text-danger fw-bolder">
                                        - S/
                                        <fmt:formatNumber
                                            value="${movimiento.monto}"
                                            pattern="#,##0.00"/>
                                    </span>

                                </c:otherwise>

                            </c:choose>

                        </td>

                    </tr>

                </c:forEach>

            </tbody>

        </table>

    </c:if>


    <div class="card mt-5">

        <div class="card-body">

            <h5 class="card-title">
                Nuevo movimiento
            </h5>


            <c:if test="${not empty error}">

                <c:choose>

                    <c:when test="${error == 'El monto debe ser mayor que cero.'}">

                        <div class="alert alert-warning">
                            ${error}
                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="alert alert-danger">
                            ${error}
                        </div>

                    </c:otherwise>

                </c:choose>

            </c:if>


            <form
                action="${pageContext.request.contextPath}/billetera"
                method="post">

                <div class="row">

                    <div class="col-md-4 mb-3">

                        <label class="form-label">
                            Tipo
                        </label>

                        <select
                            name="tipo"
                            class="form-select"
                            required>

                            <option
                                value=""
                                disabled
                                selected>

                                Seleccione un tipo

                            </option>

                            <c:forEach
                                var="tipo"
                                items="${tiposMovimiento}">

                                <option value="${tipo}">
                                    ${tipo}
                                </option>

                            </c:forEach>

                        </select>

                    </div>


                    <div class="col-md-4 mb-3">

                        <label class="form-label">
                            Monto (S/)
                        </label>

                        <input
                            type="text"
                            name="monto"
                            class="form-control"
                            placeholder="Ingrese monto"
                            required>

                    </div>


                    <div class="col-md-4 mb-3 d-flex align-items-end">

                        <button
                            type="submit"
                            class="btn btn-primary w-100">

                            Registrar movimiento

                        </button>

                    </div>

                </div>

            </form>

        </div>

    </div>

</div>

<%@ include file="layout-footer.jsp" %>