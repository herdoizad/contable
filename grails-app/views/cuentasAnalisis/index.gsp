<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Fórmulas Análisis Financiero</title>
    <meta name="layout" content="main">
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-7">
        <div class="panel-completo" style="margin-left: 10px;min-height: 100px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Fórmula
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    Fórmula
                </div>
                <div class="col-md-9">
                    <g:select name="formula" from="${formulas}"
                              class="form-control input-sm" id="formula" optionValue="nombre" optionKey="id"  />
                </div>
                <div class="col-md-1">
                    <a href="#" id="ver" class="btn btn-sm btn-verde"><i class="fa fa-search"></i> Ver</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card-naranja" style="min-height: 105px;padding: 10px">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h2 style="margin-top: 0px;font-size: 16px" id="titulo">${formula?.nombre}</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                   ${formula?.descripcionDividendo}
                </div>
            </div>
            <div class="row">
                <div class="col-md-10 col-md-offset-1 text-center"  style="border-top: 2px solid #ffffff">
                    ${formula?.descripcionDivisor}
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-10">
        <div class="panel-completo" style="margin-left: 10px;min-height: 100px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Cuentas para el dividendo
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <g:select name="cuenta1" from="${cuentas}"
                              class="form-control input-sm select" id="cuenta1"  optionKey="numero"
                              noSelection="['':'']" value="${det1?.getCampo1Pad()}"
                    />
                </div>
                <div class="col-md-1">
                    <g:select name="signo1" from="${signos}"
                              class="form-control input-sm " id="signo1"  value="${det1?.signo1}" noSelection="['':'']"
                              optionKey="key" optionValue="value" ></g:select>
                </div>
                <div class="col-md-3">
                    <g:select name="cuenta2" from="${cuentas}"
                              class="form-control input-sm select" id="cuenta2"
                              noSelection="['':'']"  optionKey="numero"  value="${det1?.getCampo2Pad()}"  />
                </div>
                <div class="col-md-1">
                    <g:select name="signo2" from="${signos}" noSelection="['':'']"
                              class="form-control input-sm" id="signo2" value="${det1?.signo2}"
                              optionKey="key" optionValue="value"></g:select>
                </div>
                <div class="col-md-3">
                    <g:select name="cuenta3" from="${cuentas}" noSelection="['':'']"
                              class="form-control input-sm select" id="cuenta3"  optionKey="numero"   value="${det1?.getCampo3Pad()}" />
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-10">
        <div class="panel-completo" style="margin-left: 10px;min-height: 100px">
            <div class="row ">
                <div class="col-md-12 titulo-panel">
                    Cuentas para el divisor
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <g:select name="cuenta1" from="${cuentas}" noSelection="['':'']"  value="${det2?.getCampo1Pad()}"
                              class="form-control input-sm select" id="cuenta4" optionKey="numero"  />
                </div>
                <div class="col-md-1">
                    <g:select name="signo1" from="${signos}" noSelection="['':'']"
                              class="form-control input-sm" id="signo3" value="${det2?.signo1}"
                              optionKey="key" optionValue="value"></g:select>
                </div>
                <div class="col-md-3">
                    <g:select name="cuenta2" from="${cuentas}" noSelection="['':'']"  value="${det2?.getCampo2Pad()}"
                              class="form-control input-sm select" id="cuenta5"  optionKey="numero"  />
                </div>
                <div class="col-md-1">
                    <g:select name="signo2" from="${signos}" noSelection="['':'']"
                              class="form-control input-sm" id="signo4" value="${det2?.signo2}"
                              optionKey="key" optionValue="value"></g:select>
                </div>
                <div class="col-md-3">
                    <g:select name="cuenta3" from="${cuentas}" noSelection="['':'']"  value="${det2?.getCampo3Pad()}"
                              class="form-control input-sm select" id="cuenta6" optionKey="numero"  />
                </div>
            </div>

        </div>
    </div>
</div>
<div class="row fila" style="margin-left: 0px">
    <div class="col-md-12">
        <a href="#" class="btn btn-verde" id="guardar"><i class="fa fa-save"></i> Guardar</a>
    </div>
</div>
<script>
    $('.select').combobox();
    $("#ver").click(function(){
        location.href="${g.createLink(action: 'index')}/"+$("#formula").val()
    })
    $("#guardar").click(function(){
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'cuentasAnalisis', action:'save_ajax')}",
            data: {
                formula:"${formula?.id}",
                campo1:$("#cuenta1").val(),
                campo2:$("#cuenta2").val(),
                campo3:$("#cuenta3").val(),
                signo1:$("#signo1").val(),
                signo2:$("#signo2").val(),
                campo4:$("#cuenta4").val(),
                campo5:$("#cuenta5").val(),
                campo6:$("#cuenta6").val(),
                signo3:$("#signo3").val(),
                signo4:$("#signo4").val()
            },
            success: function (msg) {
                closeLoader()
                log("Datos guardados","success")
            } //success
        }); //ajax
    })
</script>
</body>
</html>