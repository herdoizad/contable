<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Solicitudes pendientes de prestamos de consumo</title>
    <meta name="layout" content="main">
</head>
<body>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Solicitudes pendientes
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <table class="table table-condensed table-hover table-bordered">
                        <thead>
                        <tr>
                            <th>Empleado</th>
                            <th>Tipo</th>
                            <th>Estado</th>
                            <th>Monto</th>
                            <th>Interes</th>
                            <th>Plazo</th>
                            <th>Cuota</th>
                            <th>Inicio</th>
                            <th>Fin</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${sol}" var="p">

                            <tr>
                                <td>${p.empleado}</td>
                                <td>${p.tipo}</td>
                                <td  style="text-align: center">${p.getEstadoString()}</td>
                                <td style="text-align: right"><g:formatNumber number="${p.monto}" type="currency"/></td>
                                <td style="text-align: right"><g:formatNumber number="${p.interes}" type="currency"/></td>
                                <td  style="text-align: right">${p.plazo}</td>
                                <td  style="text-align: right"><g:formatNumber number="${p.valorCuota}" type="currency"/></td>
                                <td style="text-align: center">${p.inicio?.format("dd-MM-yyyy")}</td>
                                <td style="text-align: center">${p.fin?.format("dd-MM-yyyy")}</td>
                                <td style="text-align: center">
                                    <a href="${g.createLink(controller: 'prestamo',action: 'revisar')}/${p.id}" id="revisar" class="btn btn-verde btn-sm">
                                        <i class="fa fa-check"></i>
                                    </a>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>