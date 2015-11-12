<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Contabilización</title>
    <meta name="layout" content="main">
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-11">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Contabilización
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <label>Fecha</label>
                </div>
                <div class="col-md-2">
                    <elm:datepicker name="fecha" class="form-control input-sm" maxDate="${new Date()}"></elm:datepicker>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12" style="height: 350px;overflow-y: auto" id="data">

                </div>
            </div>
            <div class="row fila">
                <div class="col-md-6">
                    <fieldset>
                        <legend>Estaciones</legend>
                        <a href="#" id="procesar_cliente" class="btn btn-verde btn-sm">
                            <i class="fa fa-cogs"></i> Procesar
                        </a>
                        <a href="#" class="btn btn-danger btn-sm">
                            <i class="fa fa-trash"></i> Borrar asiento
                        </a>
                        <a href="#" class="btn btn-info btn-sm">
                            <i class="fa fa-list"></i> Diario
                        </a>
                    </fieldset>

                </div>
                <div class="col-md-6">
                    <fieldset>
                        <legend>Industrias</legend>
                        <a href="#" id="procesar_industria" class="btn btn-verde btn-sm">
                            <i class="fa fa-cogs"></i> Procesar
                        </a>
                        <a href="#" class="btn btn-danger btn-sm">
                            <i class="fa fa-trash"></i> Borrar asiento
                        </a>
                        <a href="#" class="btn btn-info btn-sm">
                            <i class="fa fa-list"></i> Diario
                        </a>
                    </fieldset>

                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $("#procesar_cliente").click(function(){
        openLoader("");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'procesaEstaciones_ajax')}",
            data    : "fecha="+$("#fecha_input").val(),
            success : function (msg) {
                closeLoader()
                $("#data").html(msg)
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");
                closeLoader();
            }
        });
    });
    $("#procesar_industria").click(function(){
        openLoader("");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'procesaIndustrias_ajax')}",
            data    : "fecha="+$("#fecha_input").val(),
            success : function (msg) {
                closeLoader()
                $("#data").html(msg)
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");
                closeLoader();
            }
        });
    });
    $("#borrar_cliente").click(function(){
        openLoader("");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'borrarDiario_ajax')}",
            data    : "fecha="+$("#fecha_input").val()+"&tipo=1",
            success : function (msg) {
                closeLoader()
                $("#data").html(msg)
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");
                closeLoader();
            }
        });
    });
    $("#borrar_industria").click(function(){
        openLoader("");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'borrarDiario_ajax')}",
            data    : "fecha="+$("#fecha_input").val()+"&tipo=2",
            success : function (msg) {
                closeLoader()
                $("#data").html(msg)
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");
                closeLoader();
            }
        });
    });
</script>
</body>
</html>