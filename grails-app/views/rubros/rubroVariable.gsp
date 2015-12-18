<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Rubros variables</title>
    <meta name="layout" content="main">
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<g:form action="guardarRubroVariable_ajax" class="frm">
    <input type="hidden" id="data" name="data">
    <div class="row fila">
        <div class="col-md-12">
            <div class="panel-completo" style="margin-left: 10px">
                <div class="row">
                    <div class="col-md-12 titulo-panel">
                        Rubros variables
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-1">
                        <label>Rubro</label>
                    </div>
                    <div class="col-md-3">
                        <g:select name="rubro" id="rubro" from="${rubros}"  class="form-control input-sm" optionKey="id" optionValue="nombre"/>
                    </div>

                    <div class="col-md-1">
                        <label>
                            Mes
                        </label>
                    </div>
                    <div class="col-md-2">
                        <g:select name="mes" from="${meses}" id="mes" optionValue="descripcion"
                                  class="form-control input-sm" optionKey="id"/>
                    </div>
                    <div class="col-md-1">
                        <a href="#" id="ver"  class="btn btn-info btn-sm">
                            <i class="fa fa-search"></i> Ver
                        </a>
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-8" id="datos">

                    </div>
                </div>

            </div>
        </div>
    </div>
</g:form>
<script>

    $("#ver").click(function(){
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'rubros', action:'getValoresRubroVariable_ajax')}",
            data:{
                rubro:$("#rubro").val(),
                mes:$("#mes").val()
            },
            success: function (msg) {
                closeLoader()
                $("#datos").html(msg)
            } //success
        }); //ajax
    })
</script>
</body>
</html>