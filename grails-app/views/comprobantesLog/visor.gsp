<%@ page import="contable.seguridad.Usuario" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Log de comprobantes</title>
    <meta name="layout" content="main">
    <style>
        .hg{
            background: #fff5ad !important;
        }
    </style>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px;min-height: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Parámetros
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <label>Desde</label>
                </div>
                <div class="col-md-2">
                    <elm:datepicker name="desde" class="form-control input-sm"></elm:datepicker>
                </div>
                <div class="col-md-1">
                    <label>Hasta</label>
                </div>
                <div class="col-md-2">
                    <elm:datepicker name="hasta" class="form-control input-sm"></elm:datepicker>
                </div>
                <div class="col-md-1">
                    <label>Operación</label>
                </div>
                <div class="col-md-2">
                    <g:select name="operacion"  id="operacion" from="${operaciones}" class="form-control input-sm " optionValue="value" optionKey="key"/>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <label>Usuario</label>
                </div>
                <div class="col-md-2">
                    <g:select name="usuario" id="usuarios" class="form-control input-sm" from="${Usuario.findAllByEstado('A',[sort: 'nombre'])}"
                              optionKey="login" optionValue="nombre" style="font-weight:normal" noSelection="['':'TODOS']"/>
                </div>
                <div class="col-md-1 col-md-offset-5" style="text-align: right">
                    <a href="#" class="btn btn-verde btn-sm" id="ver">
                        <i class="fa fa-search"></i> Ver
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-7">
        <div class="panel-completo" style="margin-left: 10px;min-height: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Log
                </div>
            </div>
            <div class="row fila" id="detalle">

            </div>
        </div>
    </div>
    <div class="col-md-5" >
        <div class="panel-completo drag" style="margin-left: 10px;min-height: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Comprobante
                </div>
            </div>
            <div class="row fila" id="info">
            </div>
        </div>
    </div>
</div>
<script>
    $("#ver").click(function(){
        openLoader()
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'comprobantesLog', action:'getDetalle_ajax')}",
            data    : {
                usuario : $("#usuarios").val(),
                desde :$("#desde_input").val(),
                hasta:$("#hasta_input").val(),
                operacion:$("#operacion").val()
            },
            success : function (msg) {
                closeLoader()
                $("#detalle").html(msg);

            }
        });
        return false
    })
    $(".drag").draggable()
</script>
</body>
</html>