<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Prototipos</title>
    <meta name="layout" content="main">
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row">
    <div class="col-md-10">
        <div class="panel-completo" style="margin-left: 10px;min-height: 100px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Prototipos
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <g:select name="prototipo" from="${contable.core.Prototipo.list([sort: 'descripcion'])}"
                              class="form-control input-sm" id="prototipo" optionValue="descripcion" optionKey="id" value="${id}"
                    />
                </div>
                <div class="col-md-2">
                    <a href="#" id="ver" class="btn btn-sm btn-verde"><i class="fa fa-search"></i> Ver</a>
                    <a href="#" id="nuevo" class="btn btn-sm btn-verde"><i class="fa fa-file"></i> Crear nuevo</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila" id="div-nuevo" style="display: none">
    <div class="col-md-10">
        <div class="panel-completo" style="margin-left: 10px;min-height: 100px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Nuevo prototipo
                </div>
            </div>
            <div class="row fila">
                <g:form action="save_ajax" class="frm-prototipo">
                    <div class="col-md-1">
                        <label>Descripción:</label>
                    </div>
                    <div class="col-md-7">
                        <input type="text" class="form-control input-sm" id="descripcion" name="descripcion" maxlength="50">
                    </div>
                    <div class="col-md-1">
                        <a href="#" class="btn btn-sm btn-verde" id="guardar"><i class="fa fa-save"></i> Guardar</a>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
<div class="row fila" id="row-detalle" style="display: none">
    <div class="col-md-10">
        <div class="panel-completo" style="margin-left: 10px;min-height: 100px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Detalle
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <g:select name="cuenta" from="${cuentas}" class="form-control input-sm select"
                        optionKey="numero" id="cuenta" noSelection="['':'']" placeholder="Cuenta" />
                </div>
                <div class="col-md-3">
                    <input type="text" id="desc" class="form-control input-sm" placeholder="Descripción" maxlength="35">
                </div>
                <div class="col-md-2">
                    <input type="checkbox" class="chk" id="signo" name="signo" value="1" checked>
                </div>
                <div class="col-md-1" style="width: 40px">
                    <label>Valor:</label>
                </div>
                <div class="col-md-2">
                    <input type="text" id="valor" style="text-align: right" class="form-control input-sm num number" value="0.00">
                </div>
                <div class="col-md-1" style="margin-top: -3px">
                    <a href="#" class="btn btn-verde btn-sm" id="agregar" title="agregar">
                        <i class="fa fa-plus"></i>
                    </a>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12" id="detalle">

                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    $("#ver").click(function(){
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'prototipo', action:'getDetalle_ajax')}",
            data: {
                id:$("#prototipo").val()
            },
            success: function (msg) {
                closeLoader()
                $("#row-detalle").show()
                $("#detalle").html(msg)

            } //success
        }); //ajax
    })
    <g:if test="${id}">
    $("#ver").click()
    </g:if>
    $("#nuevo").click(function(){
        $("#div-nuevo").show("slide")
    })
    $("#guardar").click(function(){
        if($("#descripcion").val()!=""){
            $(".frm-prototipo").submit()
        }

    })
    $('.select').combobox();
    $(".chk").bootstrapSwitch({
        size:'mini',
        onText:"Debe",
        offText:"Haber"
    });
    $("#agregar").click(function(){
        var cuenta = $("#cuenta").val()
        var desc = $("#desc").val();
        var signo = $("#signo").bootstrapSwitch("state")
        var valor = $("#valor").val()
        var msg=""
        if(cuenta==""){
            msg+="<br/>Por favor, seleccione una cuenta"
        }else{

            if($("."+cuenta).length>0){
                msg+="<br/>La cuenta "+cuenta+" ya esta presente en la tabla de detalle, seleccione otra o primero elimine la cuenta de la tabla."
            }
            if(desc.length>35){
                desc =desc.substr(0,30)
            }
        }
        if(valor==""){
            msg+="<br/>Por favor, ingrese un valor"
        }
        if(desc==""){
            msg+="<br/>Por favor, ingrese una descripción"
        }
        if(msg==""){
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'prototipo', action:'addCuenta_ajax')}",
                data: {
                    id:$("#prototipo").val(),
                    cuenta:cuenta,
                    descripcion:desc,
                    signo:signo,
                    valor:valor
                },
                success: function (msg) {
                    closeLoader()
                    $("#row-detalle").show()
                    $("#detalle").html(msg)

                } //success
            }); //ajax
        }else{
            bootbox.alert({
                message:msg,
                title:"Errores",
                className:"modal-error"
            })
        }
    })
</script>
</body>
</html>