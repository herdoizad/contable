<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Rol de pagos</title>
    <meta name="layout" content="main">
    <style>
    .pestania{
        width: 70px;
        font-size: 10px !important;
    }
    .link-tab{
        background: #EFEFF0;
    }
    .nav>li>a{
        padding-left: 3px !important;
    }


    </style>
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<input type="hidden" id="activo">
<div class="row fila">
    <div class="col-md-12" >
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
                    <g:select name="empleado" id="empleado" from="${empleados}" value="${emp}" noSelection="['0':'TODOS']" class="select form-control input-sm select" optionKey="id" />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <g:each in="${meses}" var="m">
                            <li role="presentation" class="pestania">
                                <a href="#${m.id}" class="mes m-${m.id} link-tab" mes="${m.id}" aria-controls="${m.id}" role="tab" data-toggle="tab">${m.descripcion}</a>
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

        $($("#activo").val()).html("")
        $("#activo").val($(this).attr("href"))
        var div = $($(this).attr("href"))
        var mes = $(this).attr("mes")
        if($("#empleado").val()!="null" && $("#empleado").val()!=null ){
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
        }

    })
    $('.select').combobox();
    $(".select").change(function(){
        var div =  $($("#activo").val())
        div.html("")
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