<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Certificados</title>
    <meta name="layout" content="main">
</head>
<body>
<div class="row fila">
    <div class="col-md-11">
        <div class="panel-completo" style="margin-left: 10px;min-height: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Generación de certificados
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <label>Empleado:</label>
                </div>
                <div class="col-md-3">
                    <g:select name="empleado" id="empleado"
                              from="${empleados}"  optionKey="id" class="form-control input-sm" />
                </div>
                <div class="col-md-1">
                    <a href="#" id="generar" class="btn btn-verde btn-sm">
                        <i class="fa fa-file-pdf-o"></i> Generar
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-11">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-7" id="detalle">

                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#generar").click(function(){
        openLoader()
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'generarTexto_ajax')}",
            data    : "id="+$("#empleado").val(),
            success : function (msg) {
                closeLoader();
                $("#detalle").html(msg)
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");

            }
        });
    })
</script>
</body>
</html>