<table class="table table-bordered table-condensed table-hover">
    <thead>
        <tr>
            <th>Fecha</th>
            <th>Taza</th>
            <th>Interes</th>
            <th>Pago</th>
            <th>Capital</th>
            <th>Saldo</th>
        </tr>
    </thead>
    <tbody>
    <g:set var="totalI" value="${0}"/>
    <g:set var="totalP" value="${0}"/>
    <g:set var="totalK" value="${0}"/>
        <g:each in="${datos}" var="d">
            <tr>
                <td>${d["fecha"].format("dd-MM-yyyy")}</td>
                <td style="text-align: right">${d["taza"]}%</td>
                <td style="text-align: right"><g:formatNumber number="${d["interes"]}" type="currency" currencySymbol=""/></td>
                <td style="text-align: right"><g:formatNumber number="${d['cuota']}" type="currency" currencySymbol=""/></td>
                <td style="text-align: right"><g:formatNumber number="${d['capital']}" type="currency" currencySymbol=""/></td>
                <td style="text-align: right"><g:formatNumber number="${d['saldo']}" type="currency" currencySymbol=""/></td>
                <g:set var="totalI" value="${totalI+d['interes']}"/>
                <g:set var="totalP" value="${totalP+d['cuota']}"/>
                <g:set var="totalK" value="${totalK+d['capital']}"/>
            </tr>
        </g:each>
    </tbody>
    <tfoot>
    <tr>
        <td colspan="2"></td>
        <td style="text-align: right;font-weight: bold"><g:formatNumber number="${totalI}" type="currency" currencySymbol=""/></td>
        <td style="text-align: right;font-weight: bold"><g:formatNumber number="${totalP}" type="currency" currencySymbol=""/></td>
        <td style="text-align: right;font-weight: bold"><g:formatNumber number="${totalK}" type="currency" currencySymbol=""/></td>
        <td></td>
    </tr>
    </tfoot>
</table>