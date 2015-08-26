<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Rol de pagos</title>
    <meta name="layout" content="main">
</head>
<body>
<div class="row fila">
    <div class="col-md-11" >
        <div class="panel-completo" style="margin-left: 10px;min-height: 20px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Rol de pagos
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <label>Mes</label>
                </div>
                <div class="col-md-2">
                    <g:select name="mes" id="mes" from="${meses}" value="${mes?.id}" class="form-control input-sm select" optionKey="id" optionValue="descripcion"/>
                </div>
                <div class="col-md-1">
                    <label>Empleado</label>
                </div>
                <div class="col-md-2">
                    <g:select name="empleado" id="empleado" from="${empleados}" value="${empleado?.id}" noSelection="['0':'TODOS']" class="form-control input-sm select" optionKey="id" />
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

            <div class="row fila">
                <div class="col-md-12" id="detalle">

                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $("#ver").click(function(){
        if($("#empleados").val()!=""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rol', action:'getRolMes_ajax')}",
                data: "id="+$("#mes").val()+"&empleado="+$("#empleado").val(),
                success: function (msg) {
                    closeLoader()
                    $("#detalle").html(msg)
                } //success
            }); //ajax
        }
    })

</script>
</body>
</html>