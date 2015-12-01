<div class="row fila">
    <div class="col-md-12">
        ${mensaje}
    </div>
</div>
<div class="row fila">
    <div class="col-md-12">
        <table class="table table-striped table-sm">
            <thead>
            <th>Numero</th>
            <th>Mes</th>
            <th>Tipo</th>
            <th>Cuenta</th>
            <th>Debe</th>
            <th>Haber</th>
            </thead>
            <tbody>
            <g:each in="${detalles}" var="d">
                <tr>
                    <td>${d.numero.toInteger()}</td>
                    <td style="text-align: center">${d.mes}</td>
                    <td style="text-align: center">${d.tipo}</td>
                    <td>${d.cuenta}</td>
                    <g:if test="${d.signo==1}">
                        <td style="text-align: right"><g:formatNumber number="${d.valor}" type="currency" currencySymbol=""/></td>
                        <td style="text-align: right">0.00</td>
                    </g:if>
                    <g:else>
                        <td style="text-align: right">0.00</td>
                        <td  style="text-align: right"><g:formatNumber number="${d.valor}" type="currency" currencySymbol=""/></td>
                    </g:else>


                </tr>
            </g:each>

            </tbody>
        </table>
    </div>
</div>