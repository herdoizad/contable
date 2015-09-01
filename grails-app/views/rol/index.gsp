<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Rol de pagos</title>
    <meta name="layout" content="main">
    <style>
    .pestania{
        width: 82px;
    }
    .pestania a{
        background: #EFEFF0;
    }


    </style>
</head>
<body>
<input type="hidden" id="activo">
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
                    <label>Empleado</label>
                </div>
                <div class="col-md-4">
                    <g:select name="empleado" id="empleado" from="${empleados}" value="${emp}" noSelection="['0':'TODOS']" class="form-control input-sm select" optionKey="id" />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <g:each in="${meses}" var="m">
                            <li role="presentation" class="pestania">
                                <a href="#${m.id}" class="mes m-${m.id}" mes="${m.id}" aria-controls="${m.id}" role="tab" data-toggle="tab">${m.descripcion}</a>
                            </li>
                        </g:each>
                    </ul>
                    <div class="tab-content" style="margin-top: 20px" id="contenedor">
                        <g:each in="${meses}" var="m">
                            <div role="tabpanel" class="tab-pane fade" id="${m.id}"></div>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    $(".mes").click(function(){
        $("#activo").val($(this).attr("href"))
        var div = $($(this).attr("href"))
        var mes = $(this).attr("mes")

        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'rol', action:'getRolMes_ajax')}",
            data: "id="+mes+"&empleado="+$("#empleado").val(),
            success: function (msg) {
                closeLoader()
                div.html(msg)
            } //success
        }); //ajax
    })

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