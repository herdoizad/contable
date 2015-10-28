<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Conciliación</title>
    <meta name="layout" content="main">
    <style>
        .conciliado{
            background: #d6d0cf;
        }
    </style>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-11">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Facturas
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-2">
                    <label>Fecha:</label>
                </div>
                <div class="col-md-2">
                    <elm:datepicker name="facturas" class="form-control input-sm"/>
                </div>
                <div class="col-md-1">
                    <a href="#" class="btn btn-verde btn-sm" id="ver-facturas">
                        <i class="fa fa-search"></i> Ver
                    </a>
                </div>
                %{--<div class="col-md-2">--}%
                    %{--<label>Fecha:</label>--}%
                %{--</div>--}%
                %{--<div class="col-md-2">--}%
                    %{--<elm:datepicker name="concilia" class="form-control input-sm"/>--}%
                %{--</div>--}%
            </div>
            <div class="row fila" id="tabla-facturas">

            </div>
        </div>
    </div>

</div>
<script type="text/javascript">
    $("#ver-facturas").click(function(){
        if($("#facturas_input").val()!=""){
            openLoader("");
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(action: 'cargaTablaFacturas_ajax')}",
                data    : "fecha="+$("#facturas_input").val(),
                success : function (msg) {
                    closeLoader()
                    $("#tabla-facturas").html(msg)
                },
                error: function() {
                    log("Ha ocurrido un error interno", "Error");
                    closeLoader();
                }
            });
        }
    })

</script>
</body>
</html>