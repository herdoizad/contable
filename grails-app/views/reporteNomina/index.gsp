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
                    <g:select name="reportenomina"  id="reportenomina" from="${reportesnomina}" noSelection="['-1':'Seleccione...']"
                              class="form-control input-sm" optionKey="key" optionValue="value"   />
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row fila">
    <div class="col-md-4 reporte 10">
        <div class="panel-completo"  style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                   Listado Acreditación Bancos
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
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm" id="esf-btn">
                        <i class="fa fa-file-pdf-o"></i> PDF
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm" id="esf-btn-ex">
                        <i class="fa fa-file-pdf-o"></i> Excel
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-4 reporte 4">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                   Detalle Descuentos
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
                        <i class="fa fa-file-pdf-o"></i> PDF
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm" id="eri-btn-ex">
                        <i class="fa fa-file-excel-o"></i> Excel
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 reporte 1" >
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Reporte Provisiones
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
                        <i class="fa fa-file-pdf-o"></i> Pdf
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm" id="bc-btn-ex">
                        <i class="fa fa-file-excel-o"></i> Excel
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 reporte 2" >
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Detalle Horas Extras
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
                        <i class="fa fa-file-pdf-o"></i> PDF
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm" id="aux-btn-ex">
                        <i class="fa fa-file-excel-o"></i> Excel
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
            <img src="${resource(dir: 'images/spinners',file: 'loader_2.GIF')}" width="50px">
        </div>
    </div>
</div>
<script type="text/javascript">

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
    $("#esf-btn-ex").click(function(){
        if($("#esf-inicio_input").val()!="" && $("#esf-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'estadoDeSituacionFinancieraExcel',action: 'index')}?inicio="+$("#esf-inicio_input").val()+"&fin="+$("#esf-fin_input").val()+"&nivel="+$("#esf-nivel").val()
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
    $("#eri-btn-ex").click(function(){
        if($("#eri-inicio_input").val()!="" && $("#eri-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'estadoIntegralExcel',action: 'index')}?inicio="+$("#eri-inicio_input").val()+"&fin="+$("#eri-fin_input").val()+"&nivel="+$("#eri-nivel").val()
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
    $("#bc-btn-ex").click(function(){
        if($("#bc-inicio_input").val()!="" && $("#bc-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'balanceExcel',action: 'reporte')}?inicio="+$("#bc-inicio_input").val()+"&fin="+$("#bc-fin_input").val()+"&nivel="+$("#bc-nivel").val()
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
    $("#aux-btn-ex").click(function(){
        if($("#aux-inicio_input").val()!="" && $("#aux-fin_input").val()!="" && $("#aux-cuenta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'auxiliarExcel',action: 'index')}?inicio="+$("#aux-inicio_input").val()+"&fin="+$("#aux-fin_input").val()+"&cuenta="+$("#aux-cuenta").val()
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
    $("#may-btn-ex").click(function(){
        if($("#may-inicio_input").val()!="" && $("#may-fin_input").val()!="" && $("#may-cuenta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'mayorGeneralExcel',action: 'index')}?inicio="+$("#may-inicio_input").val()+"&fin="+$("#may-fin_input").val()+"&cuenta="+$("#may-cuenta").val()
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
    $("#chq-btn-ex").click(function(){
        if($("#chq-inicio_input").val()!="" && $("#chq-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'chequesExcel',action: 'index')}?inicio="+$("#may-inicio_input").val()+"&fin="+$("#may-fin_input").val()+"&banco="+$("#chq-banco").val()
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
    $("#dg-btn-ex").click(function(){
        if($("#dg-inicio_input").val()!="" && $("#dg-fin_input").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'diarioGeneralExcel',action: 'index')}?inicio="+$("#dg-inicio_input").val()+"&fin="+$("#dg-fin_input").val()
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
    $("#mas-btn-ex").click(function(){
        if($("#mas-inicio_input").val()!="" && $("#mas-fin_input").val()!="" && $("#mas-cuenta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'mayorAuxiliarExcel',action: 'index')}?inicio="+$("#mas-inicio_input").val()+"&fin="+$("#mas-fin_input").val()+"&cuenta="+$("#mas-cuenta").val()
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
    $("#auxv-btn-ex").click(function(){
        if($("#auxv-inicio_input").val()!="" && $("#auxv-fin_input").val()!="" && $("#auxv-cuenta").val()!="" && $("#auxv-desde").val()!=""  && $("#auxv-hasta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'auxiliarRangoExcel',action: 'index')}?inicio="+$("#auxv-inicio_input").val()+"&fin="+$("#auxv-fin_input").val()+"&cuenta="+$("#auxv-cuenta").val()+"&desde="+$("#auxv-desde").val()+"&hasta="+$("#auxv-hasta").val()
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
    $("#cv-btn-ex").click(function(){
        if($("#auxv-inicio_input").val()!="" && $("#cv-fin_input").val()!="" && $("#cv-cuenta").val()!="" && $("#cv-desde").val()!=""  && $("#cv-hasta").val()!=""){
            var b =  bootbox.alert({
                message:$("#msn").html(),
                title:"Generando reporte"
            })
            setTimeout(function(){b.modal("hide") }, 10000);
            location.href="${createLink(controller: 'carteraVencidaExcel',action: 'index')}?inicio="+$("#cv-inicio_input").val()+"&fin="+$("#cv-fin_input").val()+"&cuenta="+$("#cv-cuenta").val()+"&desde="+$("#cv-desde").val()+"&hasta="+$("#cv-hasta").val()+"&dias="+$("#cv-dias").val()
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