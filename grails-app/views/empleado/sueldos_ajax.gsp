<table class="table table-condensed table-striped table-darkblue">
    <thead>
    <tr>
        <th>Inicio</th>
        <th>Fin</th>
        <th>Sueldo</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${sueldos}" var="s">
        <tr>
            <td style="text-align: center">${s.inicio?.format("dd-MM-yyyy")}</td>
            <td style="text-align: center">${s.fin?.format("dd-MM-yyyy")}</td>
            <td style="text-align: right"><g:formatNumber number="${s.sueldo}" type="currency" currencySymbol=""/></td>
        </tr>
    </g:each>
    </tbody>
</table>