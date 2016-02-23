<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Solicitar préstamo o anticipo</title>
    <meta name="layout" content="main">
</head>
<body>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Solicitud
                </div>
            </div>
            <g:if test="${puede}">
                <div class="row fila">
                    <div class="col-md-2">
                        <label>Tipo de prestamo:</label>
                    </div>
                    <div class="col-md-2" style="margin-left: -15px">
                        <g:select name="tipo" id="tipo" from="${contable.nomina.TipoPrestamo.list()}"
                                  noSelection="['':'']" class="form-control input-sm select" optionKey="id"/>
                    </div>
                    <div class="col-md-1">
                        <a href="#" id="solicitar" class="btn btn-verde btn-sm"><i class="fa fa-list-alt"></i> Solicitar</a>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="row fila">
                    <div class="col-md-12">
                        Usted podrá solicitar un nuevo prestamo el ${fecha.format("dd-MM-yyyy")}
                    </div>
                </div>
            </g:else>
        </div>
    </div>
</div>
<div class="row fila" id="content" style="display: none">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">

            <div class="row fila">
                <div class="col-md-12" id="detalle">

                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $("#solicitar").click(function(){
        if($("#tipo").val()!=""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'prestamo', action:'formSolicitud_ajax')}",
                data: "id="+$("#tipo").val(),
                success: function (msg) {
                    closeLoader()
                    $("#content").show()
                    $("#detalle").html(msg)
                } //success
            }); //ajax
        }
    })
</script>
</body>
</html>