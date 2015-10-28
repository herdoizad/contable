<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Rubros por empleado</title>
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Empleado
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <label>Empleado</label>
                </div>
                <div class="col-md-4">
                    <g:select name="empleados" id="empleados" from="${empleados}" value="${empleado?.id}" noSelection="['':'']" class="form-control input-sm select" optionKey="id"/>
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
    $(".select").change(function(){
        $("#detalle").html("")
    })
    $("#ver").click(function(){
        if($("#empleados").val()!=""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rubros', action:'detalleEmpleado_ajax')}",
                data: "id="+$("#empleados").val(),
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