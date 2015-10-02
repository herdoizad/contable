<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Revisar solicitud de prestamo</title>
    <meta name="layout" content="main">
</head>
<body>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Solicitud de ${sol.tipo} del empleado: ${sol.empleado}
                </div>
            </div>
            <div class="row fila" style="font-size: 14px">
                <div class="col-md-1">
                    <label>Solicitante:</label>
                </div>
                <div class="col-md-5">
                    ${sol.empleado}
                </div>
                <div class="col-md-1">
                    <label>Tipo:</label>
                </div>
                <div class="col-md-2">
                    ${sol.tipo}
                </div>
                <div class="col-md-1" style="font-size: 14px">
                    <label>RBU:</label>
                </div>
                <div class="col-md-1" style="font-size: 14px">
                    <g:formatNumber number="${sueldo.sueldo}" type="currency" currencySymbol="\$"/>
                </div>
            </div>
            <div class="row fila" style="font-size: 14px">
                <div class="col-md-1">
                    <label>Monto:</label>
                </div>
                <div class="col-md-1">
                    <g:formatNumber number="${sol.monto}" type="currency" currencySymbol="\$"/>
                </div>
                <div class="col-md-1">
                    <label>Plazo:</label>
                </div>
                <div class="col-md-1">
                    ${sol.plazo} Meses
                </div>
                <div class="col-md-1">
                    <label>Taza:</label>
                </div>
                <div class="col-md-1">
                    ${sol.interes}%
                </div>
                <div class="col-md-1">
                    <label>Cuota:</label>
                </div>
                <div class="col-md-1">
                    <g:formatNumber number="${sol.valorCuota}" type="currency" currencySymbol="\$"/>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Últimos dos roles de pago
                </div>
            </div>
            <div class="row fila">
                <g:each in="${roles}" var="r">
                    <div class="col-md-6">
                        <g:set var="total" value="${0}"></g:set>
                        <g:set var="band" value="${true}"></g:set>
                        <div class="panel panel-success" style="position: relative">
                            <div class="panel-heading " style="font-size: 10px;line-height: 10px;padding: 5px">
                                ${r?.mes.descripcion}
                            </div>
                            <div class="panel-body" style="padding-bottom: 0px">
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
                                    <g:each in="${contable.nomina.DetalleRol.findAllByRol(r,[sort:'signo',order:'desc'])}" var="d">
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
                                        <td style="text-align: right;font-weight: bold"  class="total-${r.id}">
                                            <g:formatNumber number="${total}" type="currency" currencySymbol="" />
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </g:each>

            </div>
        </div>
    </div>
</div>
<g:if test="${sol.tipo.codigo=='CSMO'}">
    <div class="row fila">
        <div class="col-md-11" >
            <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
                <div class="row">
                    <div class="col-md-12 titulo-panel">
                        Tabla de amortización provisional
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-12" id="tabla"></div>
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
                    Historial de prestamos
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
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${prestamos}" var="p">
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
        </div>
    </div>
</div>
<div class="row fila" style="margin-bottom: 100px">
    <div class="col-md-11">
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-2">
                    <label>Observaciones:</label>
                </div>
                <div class="col-md-10">
                    <textarea name="observaciones" class="form-control input-sm" maxlength="255" style="height: 100px;resize: none" disabled>${sol.observaciones}</textarea>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-2">
                    <label>Fecha del primer pago:</label>
                </div>
                <div class="col-md-2">
                  ${sol.inicio?.format("dd-MM-yyyy")}
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <a href="#" id="aprobar" class="btn btn-success "><i class="fa fa-check"></i> Aprobar</a>
                </div>
                <div class="col-md-1">
                    <a href="#" id="negar" class="btn btn-danger "><i class="fa fa-times"></i> Negar</a>
                </div>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript">
    $(".panel-heading").css({cursor:"pointer"}).click(function(){
        $(this).parent().find(".panel-body").toggle()
    })
    function cargarTabla(){
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'prestamo', action:'tabla_ajax')}",
            data: "monto=${sol.monto}&plazo=${sol.plazo}&interes=${sol.interes}",
            success: function (msg) {
                closeLoader()
                $("#tabla").html(msg)
            } //success
        }); //ajax
    }
    <g:if test="${sol.tipo.codigo=='CSMO'}">
    cargarTabla()
    </g:if>
    $("#aprobar").click(function(){
        if($("#inicio_input").val()!="") {
            bootbox.confirm("Está seguro?", function (result) {
                if (result) {
                    $.ajax({
                        type: "POST",
                        url: "${createLink(controller:'prestamo', action:'aprobar_ajax')}",
                        data: "id=${sol.id}",
                        success: function (msg) {
                            closeLoader()
                            location.href = "${g.createLink(controller: 'prestamo',action: 'historial')}"
                        } //success
                    }); //ajax
                }
            });
        }else{
            bootbox.alert("Seleccione la fecha del pago")
        }
        return false
    })
    $("#revisar").click(function(){
        if($("#inicio_input").val()!="") {
            bootbox.confirm("Está seguro?", function (result) {
                if (result) {
                    $.ajax({
                        type: "POST",
                        url: "${createLink(controller:'prestamo', action:'revisar_ajax')}",
                        data: "id=${sol.id}&inicio=" + $("#inicio_input").val(),
                        success: function (msg) {
                            closeLoader()
                            location.href = "${g.createLink(controller: 'prestamo',action: 'historial')}"
                        } //success
                    }); //ajax
                }
            });
        }else{
            bootbox.alert("Seleccione la fecha del pago")
        }
        return false
    })
    $("#negar").click(function(){

        bootbox.confirm("Está seguro?", function (result) {
            if (result) {
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'prestamo', action:'negar_ajax')}",
                    data: "id=${sol.id}",
                    success: function (msg) {
                        closeLoader()
                        location.href = "${g.createLink(controller: 'prestamo',action: 'historial')}"
                    } //success
                }); //ajax
            }
        });

        return false
    })
</script>
</body>
</html>