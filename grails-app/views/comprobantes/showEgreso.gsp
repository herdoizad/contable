<%@ page import="contable.core.Tabla" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>${comp.tipo==2?'Egreso':'Diario'} PS-${comp.mes}-${comp.tipo}-<g:formatNumber number="${comp.numero}" maxFractionDigits="0"/></title>
    <meta name="layout" content="main">
    <style>
    .pestania{
        width: 85px;
    }
    .num{
        text-align: right;
    }

    </style>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row">
    <div class="col-md-9">
        <div class="panel-completo" style="margin-left: 10px;min-height: 60px">
            <div class="row">
                <div class="col-md-8 titulo-panel">
                    Comprobande de ${comp.tipo==2?'Egreso':'Diario'} PS-${comp.mes}-${comp.tipo}-<g:formatNumber number="${comp.numero}" maxFractionDigits="0"/>
                </div>
                <div class="col-md-4 titulo-panel" style="margin-top: -12px;padding-bottom:7px;text-align: right">
                    <a href="#" id="imprimir" class="btn btn-verde">
                        <i class="fa fa-print"></i> Imprimir
                    </a>
                    <a href="${g.createLink(action: 'nuevoCash',params: [mes:comp.mes,tipo:comp.tipo])}" id="nuevo" class="btn btn-verde">
                        <i class="fa fa-file"></i> Nuevo
                    </a>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <input type="hidden" id="mes"  name="mes" value="${comp.mes}">
                    <input type="hidden" id="numero" name="numero" value="${comp.numero}">
                    <input type="hidden" id="empresa" name="empresa" value="${comp.empresa.codigo}">
                    <input type="hidden" id="tipo" name="tipo" value="${comp.tipo}">
                    <div class="row">
                        <div class="col-md-2">
                            <label>Número: </label>
                            <g:formatNumber number="${comp.numero}" maxFractionDigits="0"/>
                        </div>
                        <div class="col-md-2">
                            <label>Fecha: </label>
                            ${comp.fecha.format("dd-MM-yyyy")}
                        </div>
                        <div class="col-md-2">
                            <label>Tipo: </label>
                            ${comp.getTipoString()}
                        </div>
                        <div class="col-md-6">
                            <label>Concepto: </label>
                            ${comp.concepto}
                        </div>
                    </div>
                    <div class="row"  style="overflow-y: auto;margin-top: 10px">
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
                                <g:each in="${detComp}" var="d">
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
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-9">
        <div class="panel-completo" style="margin-left: 10px;min-height: 60px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Cheque Número: ${cheque?.numero}
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Banco: </label>
                    ${cheque?.banco?.descripcion}
                </div>
                <div class="col-md-2">
                    <label>Cuenta: </label>
                    ${cheque?.cuenta}
                </div>
                <div class="col-md-2">
                    <label>Número: </label>
                    ${cheque?.numero}
                </div>
                <div class="col-md-2">
                    <label>Fecha: </label>
                    ${cheque?.emision?.format("dd-MM-yyyy")}
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Valor: </label>
                    <g:formatNumber number="${cheque?.valor}" type="currency" currencySymbol="\$"/>
                </div>
                <div class="col-md-5">
                    <label>Beneficiario: </label>
                    ${cheque?.beneficiario}
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-9">
        <div class="panel-completo" style="margin-left: 10px;min-height: 60px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Retenciones
                </div>
            </div>
            <div class="row fila">
                <table class="table table-darkblue table-bordered table-hover table-striped table-sm">
                    <thead>
                    <tr>
                        <th style="width: 110px">Tipo doc.</th>
                        <th style="width: 110px">Num. doc.</th>
                        <th  style="width: 80px !important;">Fec. doc</th>
                        <th style="width: 100px !important;">Valor</th>
                        <th style="width: 140px">Tipo retención</th>
                        <th style="width: 80px !important;">Retención</th>
                        <th style="width: 140px !important;">Tipo IVA</th>
                        <th  style="width: 80px !important;">Valor IVA</th>
                        <th  style="width: 100px !important;">A pagar</th>
                    </tr>
                    </thead>
                    <tbody id="detalles-doc">
                    <g:set var="totValor" value="${0}"></g:set>
                    <g:set var="totRet" value="${0}"></g:set>
                    <g:set var="totIva" value="${0}"></g:set>
                    <g:set var="tot" value="${0}"></g:set>
                    <g:each in="${detFac}" var="d">
                        <g:set var="totValor" value="${totValor+d.valor}"></g:set>
                        <g:set var="totRet" value="${totRet+(d.retencion?d.retencion:0)}"></g:set>
                        <g:set var="totIva" value="${totIva+(d.valorIva?d.valorIva:0)}"></g:set>
                        <g:set var="tot" value="${tot+d.pagar}"></g:set>
                        <tr>
                            <td>${d.tipoDocumento.descripcion}</td>
                            <td>${d.numeroFactura}</td>
                            <td style="text-align: center">${d.fechaDocumento?.format("dd-MM-yyyy")}</td>
                            <td style="text-align: right"><g:formatNumber number="${d.valor}" type="currency" currencySymbol=""/></td>
                            <td>${Tabla.findByCodigo(d.tipoRetencion)?.descripcion}</td>
                            <td style="text-align: right"><g:formatNumber number="${d.retencion}" type="currency" currencySymbol=""/></td>
                            <td>${Tabla.findByCodigo(d.tipoIva)?.descripcion}</td>
                            <td style="text-align: right"><g:formatNumber number="${d.valorIva}" type="currency" currencySymbol=""/></td>
                            <td style="text-align: right"><g:formatNumber number="${d.pagar}" type="currency" currencySymbol=""/></td>
                        </tr>
                    </g:each>
                    </tbody>
                    <tfoot>
                    <tr style="font-weight: bold !important;">
                        <td colspan="3">TOTALES</td>
                        <td class="num" id="tot_valor"><g:formatNumber number="${totValor}" type="currency" currencySymbol="\$"/></td>
                        <td></td>
                        <td class="num" id="tot_ret"><g:formatNumber number="${totRet}" type="currency" currencySymbol="\$"/></td>
                        <td></td>
                        <td class="num" id="tot_iva"><g:formatNumber number="${totIva}" type="currency" currencySymbol="\$"/></td>
                        <td class="num" id="tot_pagar"><g:formatNumber number="${tot}" type="currency" currencySymbol="\$"/></td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
$("#imprimir").click(function(){
    openLoader()
    location.href="${g.createLink(controller: 'reportesComprobantes',action:'imprimeComprobante')}?empresa="+$("#empresa").val()+"&mes="+$("#mes").val()+"&numero="+$("#numero").val()+"&tipo="+$("#tipo").val()
    closeLoader()
})
</script>
</body>
</html>