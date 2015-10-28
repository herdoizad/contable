<table class="table table-condensed table-hover  table-darkblue table-sm">
    <thead>
    <tr>
        <th>Número</th>
        <th>Estado</th>
        <th>Acreditación</th>
        <th>Venta</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${datos}" var="f">
        <tr>
            <td>${f["NUMERO_FACTURA"]}</td>
            <td>${f["ESTADO_CONCILIACION"]}</td>
            <td>${f["FECHA_ACREDITACION"].format("dd-MM-yyyy")}</td>
            <td>${f["FECHA_VENTA"].format("dd-MM-yyyy")}</td>
            %{--<td>${f["CODIGO_CONDICION"]}</td>--}%
            %{--<td>${f["ESTADO_CONCILIACION"]}</td>--}%
        </tr>
    </g:each>
    </tbody>
</table>