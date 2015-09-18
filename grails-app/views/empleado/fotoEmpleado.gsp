<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Foto</title>
</head>
<body>
<div class="row fila" style="padding-bottom: 200px">
    <div class="col-md-5">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Empleado: ${empleado}
                </div>
            </div>
            <g:form class="frm" action="saveFoto_ajax"  enctype="multipart/form-data" >
                <input type="hidden" name="id" value="${empleado.id}">
                <div class="row fila">
                    <div class="col-md-2">
                        <label>Archivo:</label>
                    </div>
                    <div class="col-md-10">
                        <input type="file" id="file" name="file" class="form-control input-sm">
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <a href="#" class="btn btn-verde btn-sm" id="subir">
                            <i class="fa fa-upload"></i> Subir
                        </a>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
    <div class="col-md-5">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Foto
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12" id="foto-container">
                    <g:if test="${empleado.foto}">
                        <img src="${g.resource(file: empleado.foto)}" width="200px"/>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#subir").click(function(){
        if($("#file").val()!="")
            $(".frm").submit()
    })
</script>
</body>
</html>