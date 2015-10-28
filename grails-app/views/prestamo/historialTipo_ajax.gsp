<div class="row fila">
    <div class="col-md-12">
        <table class="table  table-sm table-darkblue table-condensed table-hover table-bordered">
            <thead>
            <tr>
                <th colspan="9">
                    Solicitados
                </th>
            </tr>
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
            </tr>
            </thead>
            <tbody>
            <g:each in="${solicitados}" var="p">
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

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
<div class="row fila">
    <div class="col-md-12">
        <table class="table  table-sm table-darkblue table-condensed table-hover table-bordered">
            <thead>
            <tr>
                <th colspan="10">
                    Aprobados
                </th>
            </tr>
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
            <g:each in="${aprobados}" var="p">
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
                    <td style="text-align: center;width: 40px">
                        <g:link action="verPrestamo" id="${p.id}" class="btn btn-verde btn-xsm">
                            <i class="fa fa-search"></i>
                        </g:link>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
<div class="row fila">
    <div class="col-md-12">
        <table class="table table-sm table-darkblue table-condensed table-hover table-bordered">
            <thead>
            <tr>
                <th colspan="8">
                    Negados
                </th>
            </tr>
            <tr>
                <th>Empleado</th>
                <th>Tipo</th>
                <th>Estado</th>
                <th>Monto</th>
                <th>Interes</th>
                <th>Plazo</th>
                <th>Cuota</th>
                <th>Fecha negación</th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${negados}" var="p">
                <tr>
                    <td>${p.empleado}</td>
                    <td>${p.tipo}</td>
                    <td  style="text-align: center">${p.getEstadoString()}</td>
                    <td style="text-align: right"><g:formatNumber number="${p.monto}" type="currency"/></td>
                    <td style="text-align: right"><g:formatNumber number="${p.interes}" type="currency"/></td>
                    <td  style="text-align: right">${p.plazo}</td>
                    <td  style="text-align: right"><g:formatNumber number="${p.valorCuota}" type="currency"/></td>
                    <td style="text-align: center">${p.fechaRevision?.format("dd-MM-yyyy")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>