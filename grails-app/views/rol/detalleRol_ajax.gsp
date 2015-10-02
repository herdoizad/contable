<g:set var="total" value="${0}"></g:set>
<g:set var="band" value="${true}"></g:set>
<table class="table table-sm table-darkblue" style="margin-bottom: 0px">
    <thead>
    <tr>
        <th>Rubro</th>
        <th>Tipo</th>
        <th style="width: 150px">Valor</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th colspan="3" style="color: #ffffff">Ingresos</th>
    </tr>
    <g:each in="${contable.nomina.DetalleRol.findAllByRol(rol,[sort:'signo',order:'desc'])}" var="d">
        <g:if test="${d.signo==-1 && band}">
            <tr style="color: #ffffff">
                <th colspan="3">Egresos</th>
            </tr>
            <g:set var="band" value="${false}"></g:set>
        </g:if>
        <tr>
            <g:set var="total" value="${total+(d.signo*d.valor)}"></g:set>
            <td>
                ${d.descripcion}
            </td>
            <td style="text-align: center">
                ${d.signo==1?'Ingreso':'Egreso'}
            </td>
            <td style="text-align: right">
                <g:formatNumber number="${d.valor}" type="currency" currencySymbol="" />
            </td>
        </tr>
    </g:each>
    <tr>
        <td colspan="2" style="text-align: right">
            <label>Total a recibir</label>
        </td>
        <td style="text-align: right;font-weight: bold"  class="total-${rol.id}">
            <g:formatNumber number="${total}" type="currency" currencySymbol="" />
        </td>
        <td></td>
        <td></td>
    </tr>
    </tbody>
</table>