<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Agrupa cuentas Estado de Resultados</title>
    <meta name="layout" content="main">
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-11">
        <div class="panel-completo" style="margin-left: 10px;min-height: 100px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Empresa
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <label>
                        Empresa
                    </label>
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control input-sm" value="${session.empresa?.descripcion}">
                </div>
                <div class="col-md-1">
                    <label>
                        Ruc
                    </label>
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control input-sm" value="${session.empresa?.ruc}">
                </div>
                <div class="col-md-1">
                    <label>
                        Teléfono
                    </label>
                </div>
                <div class="col-md-2">
                    <input type="text" class="form-control input-sm" value="${session.empresa?.telefono}">
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <label>
                        Representante
                    </label>
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control input-sm"  value="${session.empresa?.representante}">
                </div>
                <div class="col-md-1">
                    <label>
                        Dirección
                    </label>
                </div>
                <div class="col-md-3">
                    <input type="text" class="form-control input-sm"  value="${session.empresa?.direccion}">
                </div>
                <div class="col-md-3 text-right">
                    <a href="#" class="btn btn-verde btn-sm"><i class="fa fa-save"></i> Guardar</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-11">
        <div class="panel-completo" style="margin-left: 10px;min-height: 100px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Grupos
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <table class="table table-darkblue table-bordered table-hover table-sm">
                        <thead>
                        <tr>
                            <th>Empresa</th>
                            <th>Secuencial</th>
                            <th style="width: 80%">Nombre Grupo</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${contable.core.GrupoResultado.list()}" var="g">
                            <tr>
                                <td style="text-align: center">${g.empresa.codigo}</td>
                                <td style="text-align: center">${g.id}</td>
                                <td>${g.nombre}</td>
                                <td style="text-align: center">
                                    <a href="#" class="btn btn-verde btn-xs ver" title="Ver" id="${g.id}"><i class="fa fa-search"></i></a>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12" id="detalle">
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(".ver").click(function(){
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'grupoEstadoDeResultados', action:'detalle_ajax')}",
            data: {
                id:$(this).attr("id")
            },
            success: function (msg) {
                closeLoader()
                $("#detalle").html(msg)
            } //success
        }); //ajax
    });
</script>
</body>
</html>