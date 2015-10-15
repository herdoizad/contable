<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Facturas</title>
    <meta name="layout" content="main">
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Subir archivo de facturas
                </div>
            </div>
            <div class="row fila">
                <g:form enctype="multipart/form-data" action="subirArchivo_ajax" class="frm">

                    <div class="col-md-1">
                        <label>Archivo</label>
                    </div>
                    <div class="col-md-4">
                        <input type="file" class="form-control input-sm" name="file" id="file">
                    </div>
                    <div class="col-md-1">
                        <a href="#" class="btn btn-verde btn-sm" id="subir"><i class="fa fa-upload"></i> Subir</a>
                    </div>
                </g:form>
            </div>
            <div class="row fila">
                <g:if test="${mensajes}">
                    <g:each in="${mensajes}" var="m">
                        <div class="col-md-12">
                            <label>${m}</label>
                        </div>
                    </g:each>

                </g:if>
            </div>
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