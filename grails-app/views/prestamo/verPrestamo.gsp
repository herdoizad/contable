<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Detalle del prestamo</title>
    <meta name="layout" content="main">
</head>
<body>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Detalles del prestamo
                </div>
            </div>
            <div class="row fila" style="font-size: 14px">
                <div class="col-md-1">
                    <label>Solicitante:</label>
                </div>
                <div class="col-md-5">
                    ${prestamo.empleado}
                </div>
                <div class="col-md-1">
                    <label>Tipo:</label>
                </div>
                <div class="col-md-2">
                    ${prestamo.tipo}
                </div>

            </div>
            <div class="row fila" style="font-size: 14px">
                <div class="col-md-1">
                    <label>Monto:</label>
                </div>
                <div class="col-md-1">
                    <g:formatNumber number="${prestamo.monto}" type="currency" currencySymbol="\$"/>
                </div>
                <div class="col-md-1">
                    <label>Plazo:</label>
                </div>
                <div class="col-md-1">
                    ${prestamo.plazo} Meses
                </div>
                <div class="col-md-1">
                    <label>Taza:</label>
                </div>
                <div class="col-md-1">
                    ${prestamo.interes}%
                </div>
                <div class="col-md-1">
                    <label>Cuota:</label>
                </div>
                <div class="col-md-1">
                    <g:formatNumber number="${prestamo.valorCuota}" type="currency" currencySymbol="\$"/>
                </div>
            </div>
        </div>
    </div>
</div>
<g:if test="${det.size()>0}">
    <g:set var="saldo" value="${det?.last()?.saldo}"/>
</g:if>
<g:else>
    <g:set var="saldo" value="${prestamo.monto}"/>
</g:else>

<g:if test="${saldo>0}">
    <g:set var="valor" value="${(saldo*((new Date()-lastCuota)+1)*((taza/100)/360)).toDouble().round(2)}"/>
    <div class="row fila">
        <div class="col-md-11" >
            <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
                <div class="row">
                    <div class="col-md-12 titulo-panel">
                        Registrar pago
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-1">
                        <label>Fecha de pago:</label>
                    </div>
                    <div class="col-md-1">
                        ${new Date().format("dd-MM-yyyy")}
                    </div>
                    <div class="col-md-1">
                        <label>Valor:</label>
                    </div>
                    <div class="col-md-2">
                        <input type="text" style="text-align: right" class="form-control input-sm number required" value="${valor}" saldo="${saldo}" max="${saldo+valor}" id="valor" >
                    </div>

                    <div class="col-md-1">
                        <label>Taza:</label> ${taza}%
                        <input type="hidden" id="taza" value="${taza}">
                    </div>
                    <div class="col-md-1">
                        <label>Interes:</label>
                    </div>
                    <div class="col-md-1">
                        <input type="text" style="text-align: right" class="form-control input-sm number required"
                               value="${valor}" id="interes" disabled >
                    </div>
                    <div class="col-md-1">
                        <label>Capital:</label>
                    </div>
                    <div class="col-md-2">
                        <input type="text" style="text-align: right" class="form-control input-sm number required"
                               value="0.00" id="capital" disabled >
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">

                        <a href="#" class="btn btn-verde btn-sm" id="pagar">
                            <i class="fa fa-usd"></i> Registrar pago
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>
</g:if>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Detalle de pagos
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <table class="table table-darkblue table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Generado por</th>
                            <th>Fecha de pago</th>
                            <th>Taza</th>
                            <th>Interes</th>
                            <th>Pago</th>
                            <th>Capital</th>
                            <th>Saldo</th>
                            <th>Recaudado</th>
                            <th>Forma de pago</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:set var="ti" value="${0}"/>
                        <g:set var="tp" value="${0}"/>
                        <g:set var="tc" value="${0}"/>
                        <g:set var="tr" value="${0}"/>


                        <g:each in="${det}" var="d">
                            <g:set var="saldo" value="${d.saldo}"/>
                            <tr>
                                <g:set var="ti" value="${ti+d.interes}"/>
                                <g:set var="tp" value="${tp+d.cuota}"/>
                                <g:set var="tc" value="${tc+d.capital}"/>

                                <td>${d.usuario}</td>
                                <td  style="text-align: center">${d.fechaDePago?.format("dd-MM-yyyy")}</td>
                                <td style="text-align: right"><g:formatNumber number="${d.taza}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                <td style="text-align: right"><g:formatNumber number="${d.interes}" type="currency" currencySymbol="\$"/></td>
                                <td style="text-align: right"><g:formatNumber number="${d.cuota}" type="currency" currencySymbol="\$"/></td>
                                <td style="text-align: right"><g:formatNumber number="${d.capital}" type="currency" currencySymbol="\$"/></td>
                                <td style="text-align: right"><g:formatNumber number="${d.saldo}" type="currency" currencySymbol="\$"/></td>
                                <g:if test="${d.mes}">
                                    <g:set var="dr" value="${contable.nomina.DetalleRol.findByDetallePrestamo(d)}"/>
                                    <td style="text-align: right">
                                        <g:if test="${dr}">
                                            <g:set var="tr" value="${tr+d.cuota}"/>
                                            <g:formatNumber number="${d.cuota}" type="currency" currencySymbol="\$"/>
                                        </g:if>
                                        <g:else>
                                            0.00
                                        </g:else>
                                    </td>
                                    <td>
                                        <g:if test="${dr}">
                                            Rol del pagos: ${dr.rol.mes.descripcion}
                                        </g:if>
                                        <g:else>
                                            Pendiente
                                        </g:else>
                                    </td>
                                </g:if>
                                <g:else>
                                    <td style="text-align: right">
                                        <g:set var="tr" value="${tr+d.cuota}"/>
                                        <g:formatNumber number="${d.cuota}" type="currency" currencySymbol="\$"/>
                                    </td>
                                    <td>
                                        Pago directo
                                    </td>
                                </g:else>
                            </tr>
                        </g:each>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="3"></td>
                            <td style="text-align: right"><g:formatNumber number="${ti}" type="currency" currencySymbol="\$"/></td>
                            <td style="text-align: right"><g:formatNumber number="${tp}" type="currency" currencySymbol="\$"/></td>
                            <td style="text-align: right"><g:formatNumber number="${tc}" type="currency" currencySymbol="\$"/></td>
                            <td></td>
                            <td style="text-align: right"><g:formatNumber number="${tr}" type="currency" currencySymbol="\$"/></td>

                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    $("#valor").blur(function(){
        var valor = $(this).val()
        var saldo = $(this).attr("saldo")*1
        var max = $(this).attr("max")*1
        var min = $("#interes").val()*1
        var msg=""
        if(isNaN(valor)){
            valor=-1
            msg+="El valor del pago debe ser un número<br/>"
        }else{
            valor=valor*1
        }

        if(valor<min)
            msg+="El valor no puede ser menor a: "+min+"<br/>"
        if(valor>max)
            msg+="El valor no puede ser mayor a: "+max+"<br/>"

        if(msg=="" && valor>0){
            $("#capital").val(valor-min)
        }else{
            bootbox.alert(msg)
        }
    })
    $("#pagar").click(function(){
        bootbox.confirm("Está seguro?",function(result){
            if(result){
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'prestamo', action:'savePago_ajax')}",
                    data: {
                        valor:$("#valor").val(),
                        interes:$("#interes").val(),
                        capital:$("#capital").val(),
                        prestamo:"${prestamo.id}"
                    },
                    success: function (msg) {
                        closeLoader()
                        window.location.reload(true)
                    } //success
                }); //ajax
            }
        })
    })
</script>
</body>
</html>