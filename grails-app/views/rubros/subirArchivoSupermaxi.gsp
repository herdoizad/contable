<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Descuentos tarjeta Supermmaxi</title>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px;min-height: 50px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Archivo Excel
                </div>
            </div>
            <g:form action="procesarchivoSupermaxi_ajax" enctype="multipart/form-data" class="frm">
                <div class="row fila">
                    <div class="col-md-1">
                        <label>Archivo:</label>
                    </div>
                    <div class="col-md-4">
                        <input type="file" name="file" class="form-control input-sm required">
                    </div>
                    <div class="col-md-1">
                        <a href="#" id="subir" class="btn btn-verde btn-sm">
                            <i class="fa fa-upload"></i> Subir
                        </a>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>
<script>
    $("#subir").click(function(){
        $(".frm").submit()
    })
</script>
</body>
</html>