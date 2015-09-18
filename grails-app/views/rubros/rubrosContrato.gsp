<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Rubros por tipo de contrato</title>
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Tipo de contrato
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-2">
                    <label>Tipo de contrato</label>
                </div>
                <div class="col-md-4">
                    <g:select name="tipos" id="tipos" from="${tipos}" value="${tipo?.id}"
                              noSelection="['':'']" class="form-control input-sm select" optionKey="id" optionValue="descripcion"/>
                </div>
                <div class="col-md-1">
                    <a href="#" id="ver" class="btn btn-verde btn-sm"><i class="fa fa-search"></i>Ver</a>
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
                    Rubros
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
    $('.select').combobox();
    $("#ver").click(function(){
        if($("#empleados").val()!=""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rubros', action:'detalleContrato_ajax')}",
                data: "id="+$("#tipos").val(),
                success: function (msg) {
                    closeLoader()
                    $("#detalle").html(msg)
                } //success
            }); //ajax
        }
    })
    <g:if test="${empleado}">
    $("#ver").click()
    </g:if>
</script>
</body>
</html>