<div class="row">
    <input type="hidden" id="mes"  name="mes" value="${com.mes}">
    <input type="hidden" id="numero" name="numero" value="${com.numero}">
    <input type="hidden" id="empresa" name="empresa" value="${com.empresa.codigo}">
    <input type="hidden" id="tipo" name="tipo" value="${com.tipo}">
    <div class="col-md-4">
        <label>PS-${com.mes}-${com.tipo}</label>
    </div>
</div>
<div class="row">
    <div class="col-md-4">
        <label>Número: </label>
        <g:formatNumber number="${com.numero}" maxFractionDigits="0"></g:formatNumber>
    </div>
    <div class="col-md-4">
        <label>Fecha: </label>
        ${com.fecha.format("dd-MM-yyyy")}
    </div>
    <div class="col-md-4">
        <label>Tipo: </label>
        ${com.getTipoString()}
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <label>Concepto: </label>
        ${com.concepto}
    </div>
</div>
<g:if test="${com.tipo==1}">
    <div class="row">
        <div class="col-md-12">
            <label>Recibí: </label>
            ${ing?.recibi}
        </div>
    </div>
    <div class="row">
        <div class="col-md-3">
            <label>Efectivo: </label>
            ${ing?.efectivo}
        </div>
        <div class="col-md-3">
            <label>Cheque: </label>
            ${ing?.cheques}
        </div>
        <div class="col-md-3">
            <label>N. crédito: </label>
            ${ing?.notas}
        </div>
        <div class="col-md-3">
            <label>Total: </label>
            ${ing?.total}
        </div>
    </div>
</g:if>
<div class="row"  style="height: 385px;overflow-y: auto;margin-top: 10px">
    <div class="col-md-12">
        <table class="table table-darkblue table-bordered table-hover table-striped table-sm" style="font-size: 10px !important;">
            <thead>
            <tr>
                <th>Cuenta</th>
                <th>Descripción</th>
                <th>Debe</th>
                <th>Haber</th>
            </tr>
            </thead>
            <tbody>
            <g:set var="debe" value="${0}"></g:set>
            <g:set var="haber" value="${0}"></g:set>
            <g:each in="${detalles}" var="d">
                <tr>
                    <td style="text-align: center">${d.cuenta.numero}</td>
                    <td style="text-align: center">${d.descripcion}</td>
                    <g:if test="${d.signo>0}">
                        <g:set var="debe" value="${debe+d.valor}"></g:set>
                        <td style="text-align: right"><g:formatNumber number="${d.valor}" currencySymbol=""  type="currency"/></td>
                        <td style="text-align: right">0.00</td>
                    </g:if>
                    <g:else>
                        <g:set var="haber" value="${haber+d.valor}"></g:set>
                        <td style="text-align: right">0.00</td>
                        <td style="text-align: right"><g:formatNumber number="${d.valor}" currencySymbol=""  type="currency"/></td>
                    </g:else>
                </tr>
            </g:each>
            </tbody>
            <tfoot>
            <tr style="font-weight: bold">
                <td colspan="2">TOTAL</td>
                <td style="text-align: right"><g:formatNumber number="${debe}" currencySymbol="\$"  type="currency"/></td>
                <td style="text-align: right"><g:formatNumber number="${haber}" currencySymbol="\$"  type="currency"/></td>
            </tr>
            </tfoot>
        </table>
    </div>

</div>
