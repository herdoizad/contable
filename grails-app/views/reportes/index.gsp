<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Reportes</title>
    <meta name="layout" content="main">
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
    <style>
    .panel-completo{
        min-height: 250px;
    }
    .reporte{
        display: none;
    }
    </style>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-10">
        <div class="panel-completo"  style="margin-left: 10px;min-height: 40px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Seleccione un reporte
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-4">
                    <g:select name="reporte"  id="reporte" from="${reportes}" noSelection="['-1':'Seleccione...']"
                    class="form-control input-sm" optionKey="key" optionValue="value"   />
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
<div class="col-md-3 reporte 10">
    <div class="panel-completo"  style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Estado situación financiera
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="esf-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="esf-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Nivel:</label>
            </div>
            <div class="col-md-4">
                <input type="number" class="form-control input-sm number" max="5" min="1" value="3" id="esf-nivel">
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="esf-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>

<div class="col-md-3 reporte 4">
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Estado de resultado integral
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="eri-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="eri-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Nivel:</label>
            </div>
            <div class="col-md-4">
                <input type="number" class="form-control input-sm number" max="5" min="1" value="3" id="eri-nivel">
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="eri-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>

<div class="col-md-3 reporte 1" >
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Balance de comprobación
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="bc-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="bc-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Nivel:</label>
            </div>
            <div class="col-md-4">
                <input type="number" class="form-control input-sm number" max="5" min="1" value="3" id="bc-nivel">
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="bc-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>
<div class="col-md-3 reporte 2" >
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Auxiliar
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="aux-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="aux-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Cuenta:</label>
            </div>
            <div class="col-md-10">
                <g:select name="cuenta" from="${cuentas}" optionKey="numero"
                          id="aux-cuenta"  class="form-control input-sm select select-cnta " noSelection="['':'']" ></g:select>
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="aux-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>
<div class="col-md-3 reporte 8" >
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Mayor general
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="may-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="may-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Cuenta:</label>
            </div>
            <div class="col-md-10">
                <g:select name="maycuenta" from="${cuentasMayor}" optionKey="numero"
                          id="may-cuenta"  class="form-control input-sm select select-cnta " noSelection="['':'']" ></g:select>
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="may-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>
<div class="col-md-3 reporte 6">
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Cheques emitidos
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="chq-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="chq-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Banco:</label>
            </div>
            <div class="col-md-10">
                <g:select name="chqbanco" from="${bancos}" optionKey="codigo"
                          id="chq-banco"  optionValue="descripcion" class="form-control input-sm  select-banco " ></g:select>
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="chq-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>



<div class="col-md-3 reporte 7">
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Diario general
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="dg-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="dg-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>

        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="dg-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>
<div class="col-md-3 reporte 9">
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Mayor auxiliar saldos
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="mas-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="mas-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Cuenta:</label>
            </div>
            <div class="col-md-10">
                <g:select name="mascuenta" from="${cuentas4}" optionKey="numero"
                          id="mas-cuenta"  class="form-control input-sm select select-cnta " noSelection="['':'']" ></g:select>
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="mas-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>




<div class="col-md-3 reporte 5">
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Cartera vencida
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="cv-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="cv-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Cuenta:</label>
            </div>
            <div class="col-md-10">
                <g:select name="cuenta" from="${cuentasMayor}" optionKey="numero"
                          id="cv-cuenta"  class="form-control input-sm select select-cnta " noSelection="['':'']" ></g:select>
            </div>
        </div>

        <div class="row fila">
            <div class="col-md-2">
                <label>Días:</label>
            </div>
            <div class="col-md-10">
                <g:select name="dias" from="${dias}" optionKey="key" optionValue="value"
                          id="cv-dias"  class="form-control input-sm  " noSelection="['':'']" ></g:select>
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="cv-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>
<div class="col-md-3 reporte 3">
    <div class="panel-completo" style="margin-left: 10px">
        <div class="row">
            <div class="col-md-12 titulo-panel">
                Auxiliar varias cuentas
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Inicio:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="auxv-inicio" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${inicio}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Fin:</label>
            </div>
            <div class="col-md-10">
                <elm:datepicker name="auxv-fin" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fin}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Cuenta:</label>
            </div>
            <div class="col-md-10">
                <g:select name="cuenta" from="${cuentas4}" optionKey="numero"
                          id="auxv-cuenta"  class="form-control input-sm select select-cnta " noSelection="['':'']" ></g:select>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Desde:</label>
            </div>
            <div class="col-md-10">
                <input type="text" id="auxv-desde" class="form-control input-sm number digits" value="001">
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2">
                <label>Hasta:</label>
            </div>
            <div class="col-md-10">
                <input type="text" id="auxv-hasta" class="form-control input-sm number digits" value="300">
            </div>
        </div>
        <div class="row fila">
        </div>
        <div class="row fila">
            <div class="col-md-3">
                <a href="#" class="btn btn-verde btn-sm" id="auxv-btn">
                    <i class="fa fa-file-pdf-o"></i> Generar
                </a>
            </div>
        </div>
    </div>
</div>
</div>





<div id="msn" style="display: none">
    <div class="row" >
        <div class="col-md-12">
            Su reporte se está generando, por favor espere. Cuando el sistema finalice se iniciará una descarga con el reporte en formato PDF.
        </div>
        <div class="col-md-6 col-md-offset-3" style="text-align: center">
            <img src="${resource(dir: 'images/spinners',file: 'dolar.GIF')}" width="80px">
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#esf-btn").click(function(){
        if($("#esf-inicio_input").val()!="" && $("#esf-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'estadoDeSituacionFinanciera',action: 'estado')}?inicio="+$("#esf-inicio_input").val()+"&fin="+$("#esf-fin_input").val()+"&nivel="+$("#esf-nivel").val()
            return false
        }
    })
    $("#eri-btn").click(function(){
        if($("#eri-inicio_input").val()!="" && $("#eri-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'resultadoIntegral',action: 'reporte')}?inicio="+$("#eri-inicio_input").val()+"&fin="+$("#eri-fin_input").val()+"&nivel="+$("#eri-nivel").val()
            return false
        }
    })
    $("#bc-btn").click(function(){
        if($("#bc-inicio_input").val()!="" && $("#bc-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'balanceComprobacion',action: 'reporte')}?inicio="+$("#bc-inicio_input").val()+"&fin="+$("#bc-fin_input").val()+"&nivel="+$("#bc-nivel").val()
            return false
        }
    })
    $("#aux-btn").click(function(){
        if($("#aux-inicio_input").val()!="" && $("#aux-fin_input").val()!="" && $("#aux-cuenta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'auxiliar',action: 'reporte')}?inicio="+$("#aux-inicio_input").val()+"&fin="+$("#aux-fin_input").val()+"&cuenta="+$("#aux-cuenta").val()
            return false
        }
    })
    $("#may-btn").click(function(){
        if($("#may-inicio_input").val()!="" && $("#may-fin_input").val()!="" && $("#may-cuenta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'mayoGeneral',action: 'reporte')}?inicio="+$("#may-inicio_input").val()+"&fin="+$("#may-fin_input").val()+"&cuenta="+$("#may-cuenta").val()
            return false
        }
    })
    $("#chq-btn").click(function(){
        if($("#chq-inicio_input").val()!="" && $("#chq-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'cheques',action: 'reporte')}?inicio="+$("#may-inicio_input").val()+"&fin="+$("#may-fin_input").val()+"&banco="+$("#chq-banco").val()
            return false
        }
    })
    $("#dg-btn").click(function(){
        if($("#dg-inicio_input").val()!="" && $("#dg-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'diarioGeneral',action: 'index')}?inicio="+$("#dg-inicio_input").val()+"&fin="+$("#dg-fin_input").val()
            return false
        }
    })
    $("#mas-btn").click(function(){
        if($("#mas-inicio_input").val()!="" && $("#mas-fin_input").val()!="" && $("#mas-cuenta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'mayorAuxiliar',action: 'index')}?inicio="+$("#mas-inicio_input").val()+"&fin="+$("#mas-fin_input").val()+"&cuenta="+$("#mas-cuenta").val()
            return false
        }
    })
    $("#auxv-btn").click(function(){
        if($("#auxv-inicio_input").val()!="" && $("#auxv-fin_input").val()!="" && $("#auxv-cuenta").val()!="" && $("#auxv-desde").val()!=""  && $("#auxv-hasta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'auxiliarRango',action: 'index')}?inicio="+$("#auxv-inicio_input").val()+"&fin="+$("#auxv-fin_input").val()+"&cuenta="+$("#auxv-cuenta").val()+"&desde="+$("#auxv-desde").val()+"&hasta="+$("#auxv-hasta").val()
            return false
        }
    })
    $("#cv-btn").click(function(){
        if($("#auxv-inicio_input").val()!="" && $("#cv-fin_input").val()!="" && $("#cv-cuenta").val()!="" && $("#cv-desde").val()!=""  && $("#cv-hasta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'carteraVencida',action: 'index')}?inicio="+$("#cv-inicio_input").val()+"&fin="+$("#cv-fin_input").val()+"&cuenta="+$("#cv-cuenta").val()+"&desde="+$("#cv-desde").val()+"&hasta="+$("#cv-hasta").val()+"&dias="+$("#cv-dias").val()
            return false
        }
    })
    $('.select').combobox();
    $("#reporte").change(function(){
        $(".reporte").hide()
        $("."+$("#reporte").val()).show()
    })

</script>
</body>
</html>