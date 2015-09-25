<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Historial de prestamos y anticipos</title>
    <meta name="layout" content="main">
</head>
<body>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Prestamos
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="pestania">
                            <a href="#anticipo" class="tipo primero"  aria-controls="anticipo" tipo="ANTC" role="tab" data-toggle="tab">Anticipos</a>
                        </li>
                        <li role="presentation" class="pestania">
                            <a href="#emergentes" class="tipo "  aria-controls="emergentes"  tipo="EMRG" role="tab" data-toggle="tab">Prestamos emergentes</a>
                        </li>
                        <li role="presentation" class="pestania">
                            <a href="#consumo" class="tipo "  aria-controls="consumo" role="tab"  tipo="CSMO" data-toggle="tab">Prestamos de consumo</a>
                        </li>
                    </ul>
                    <div class="tab-content" style="margin-top: 10px" id="contenedor">
                        <div role="tabpanel" class="tab-pane fade" id="anticipo"></div>
                        <div role="tabpanel" class="tab-pane fade" id="emergentes"></div>
                        <div role="tabpanel" class="tab-pane fade" id="consumo"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(".tipo").click(function(){
        var div = $($(this).attr("href"))
        var mes = $(this).attr("mes")
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'prestamo', action:'historialTipo_ajax')}",
            data: {
                tipo:$(this).attr("tipo")
            },
            success: function (msg) {
                closeLoader()
                div.html(msg)
            } //success
        }); //ajax
    })
    $(".primero").click()
</script>
</body>
</html>