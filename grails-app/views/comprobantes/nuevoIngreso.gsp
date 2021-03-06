<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Nuevo comprobante de ${tipoString}</title>
    <meta name="layout" content="main">

    <style>
    .pestania{
        width: 85px;
    }
    .btn-xsm{
        padding: 2px;
        font-size: 6px;
    }
    .resaltado{
        background: rgba(246, 240, 0, 0.49) !important;
    }
    .num{
        text-align: right;
    }
    .input-sm{
        font-size: 11px;
        padding: 1px !important;
        padding-left: 5px !important;
        padding-right: 5px !important;
        line-height: 11px !important;
        height: 20px;
    }
    .input-group-sm{
        height: 20px !important;
    }
    .input-group-sm > .form-control, .input-group-sm > .input-group-addon, .input-group-sm > .input-group-btn > .btn{
        height: 20px;
        line-height: 11px;
    }
    .input-group{
        height: 20px !important;
    }
    .input-group > .form-control, .input-group > .input-group-addon, .input-group > .input-group-btn > .btn{
        height: 20px;
        line-height: 11px;
        font-size: 11px;
        padding: 2px;
        padding-right: 3px;
    }
    .total-hover{
        position: absolute;
        right: 210px;
        top: 30px;
        width: 160px;
        height: 50px;
        background: #F8AC59;
        border-radius: 5px;
        color: #ffffff;
        font-weight: bold;
        padding: 10px;
        line-height: 30px;
    }
    </style>
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>

<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px;min-height: 600px">
            <div class="row ">
                <div class="col-md-8 titulo-panel">
                    <h1 style="color:  #2F4050;margin-top: 0px;margin-bottom: 0px">PS-${mes}-${tipo}</h1>
                </div>
                <div class="col-md-4 titulo-panel" style="margin-top: -6px">
                    <a href="#" class="btn btn-verde" id="guardar">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                    <a href="#" id="volver" class="btn btn-default">
                        <i class="fa fa-arrow-left"></i> Volver
                    </a>
                </div>
            </div>
            <g:form name="frm" class="frm-comprobante" action="save" controller="comprobantes">
                <input type="hidden" id="data" name="data">
                <input type="hidden" name="mes" value="${mes}">
                <input type="hidden" name="mesSolo" value="${mesSolo}">
                <input type="hidden" name="tipo" value="${tipo}">
                <input type="hidden" name="numero" value="${comp?.numero}">
                <div class="row fila">
                    <div class="col-md-1">
                        <label>Número:</label>
                    </div>
                    <div class="col-md-1">
                        <label>${g.formatNumber(number: siguiente,maxFractionDigits: 0)}</label>
                    </div>
                    <div class="col-md-1">
                        <label>Fecha:</label>
                    </div>
                    <div class="col-md-2">
                        <elm:datepicker name="fecha" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${comp?.fecha?comp.fecha:inicio}"></elm:datepicker>
                    </div>
                    <div class="col-md-1">
                        <label>Usar prototipo:</label>
                    </div>
                    <div class="col-md-3">
                        <g:select name="prototipo" id="prototipo" from="${contable.core.Prototipo.list([sort: 'descripcion'])}"
                                  optionKey="id" optionValue="descripcion" class="form-control input-sm"
                        />
                    </div>
                    <div class="col-md-1">
                        <a href="#" class="btn btn-verde btn-sm" id="usar">
                            <i class="fa fa-check"></i>
                        </a>
                    </div>
                </div>
                <div class="row fila" style="position:relative;">
                    <div class="col-md-1">
                        <label>Concepto:</label>
                    </div>
                    <div class="col-md-9">
                        <input type="text" name="concepto" id="concepto" class="form-control input-sm" value="${comp?.concepto}">
                    </div>
                    <div class="total-hover">
                        <div class="row">
                            <div class="col-xs-4">
                                <i class="fa fa-usd  fa-3x"></i>
                            </div>
                            <div class="col-xs-8 text-right">
                               <span id="total-rec" style="font-size: 14px">0.00</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-1">
                        <label>Recibido:</label>
                    </div>
                    <div class="col-md-6">
                        <input type="text" name="recibi" id="recibido" class="form-control input-sm" value="${ingreso?.recibi}">
                    </div>
                </div>
                <div class="row fila">
                        <div class="col-md-1">
                            <label>Efectivo:</label>
                        </div>
                        <div class="col-md-1" style="width: 128px">
                            <input type="text"  style="text-align: right" class=" valores form-control input-sm number" name="efectivo" value="${ingreso?.efectivo?:'0.00'}" >
                        </div>
                    <div class="col-md-1">
                        <label>Cheques:</label>
                    </div>
                    <div class="col-md-1" style="width: 128px">
                        <input type="text"  style="text-align: right" class=" valores form-control input-sm number" name="cheques" value="${ingreso?.cheques?:'0.00'}" >
                    </div>
                    <div class="col-md-1">
                        <label>N. Crédito:</label>
                    </div>
                    <div class="col-md-1" style="width: 128px">
                        <input type="text"  style="text-align: right" class=" valores form-control input-sm number" name="notas" value="${ingreso?.notas?:'0.00'}" >
                    </div>


                </div>
            </g:form>
            <div class="row fila">
                <div class="col-md-1">
                    <label>Cuenta:</label>
                </div>
                <div class="col-md-5">
                    <g:select name="cuenta" from="${contable.core.Cuenta.findAllByAgrupa(1)}" optionKey="numero"
                              id="cuenta"  class="form-control input-sm select " noSelection="['':'']" ></g:select>
                </div>
                <div class="col-md-1">
                    <input type="checkbox" class="chk" id="signo" name="signo" value="1" checked>
                </div>
                <div class="col-md-1" style="width: 40px">
                    <label>Valor:</label>
                </div>
                <div class="col-md-2">
                    <input type="text" id="valor" class="form-control input-sm number"  style="text-align: right" >
                </div>
                <div class="col-md-1">
                    <a href="#" class="btn btn-verde btn-sm" id="agregar" title="agregar">
                        <i class="fa fa-plus"></i>
                    </a>
                </div>
            </div>
            <div class="row fila" style="margin-top: 10px">
                <div class="col-md-10">
                    <table class="table table-darkblue table-bordered table-hover table-striped table-sm">
                        <thead>

                        <tr>
                            <th style="width: 3%">#</th>
                            <th style="width: 10%">Cuenta</th>
                            <th style="width: 50%">Descripción</th>
                            <th style="width: 15%">Debe</th>
                            <th style="width: 15%">Haber</th>
                            <th style="width: 3%"></th>
                        </tr>
                        </thead>
                        <tbody id="detalles">
                        <g:each in="${detalles}" var="d">
                            <tr class="tr-info" debe="${d.signo>0?d.valor:0}" haber="${d.signo<0?d.valor:0}">
                                <td style="text-align: center" class='secuencial'>${d.secuencial}</td>
                                <td class="cuenta ${d.cuenta}">${d.cuenta.numero}</td>
                                <td  class=''>
                                    <input type='text' class='desc allCaps form-control input-sm readOnly' disabled  maxlength='35' value='${d.descripcion}'>
                                </td>
                                <g:if test="${d.signo>0}">
                                    <td style="text-align: right" class="num debe" debe="${d.valor}">${d.valor}</td>
                                    <td class="num haber" haber="0"></td>
                                </g:if>
                                <g:else>
                                    <td style="text-align: right" class="num debe" debe="0"></td>
                                    <td style="text-align: right"  class="num haber" haber="${d.valor}">${d.valor}</td>
                                </g:else>

                                <td style="text-align: center">
                                    <a href='#' class='btn btn-danger btn-sm borrar'><i class='fa fa-trash'></i></a>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="3">
                                <label>Total</label>
                            </td>
                            <td class="num" style="font-weight: bold" id="tot_debe" valor="0">0.00</td>
                            <td class="num" style="font-weight: bold" id="tot_haber" valor="0">0.00</td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var secuencial = 0


    function calcularTotales(){
        var debe = 0
        var haber = 0
        var cont = 1
        $(".tr-info").each(function(){
            $(this).find(".secuencial").html(cont)
            cont++
            debe+=$(this).attr("debe")*1
            haber+=$(this).attr("haber")*1
        })
        $("#tot_debe").html(number_format(debe,2,".",","))
        $("#tot_debe").attr("valor",debe.toFixed(2))
        $("#tot_haber").attr("valor",haber.toFixed(2))
        $("#tot_haber").html(number_format(haber,2,".",","))
    }

    $(".chk").bootstrapSwitch({
        size:'mini',
        onText:"Debe",
        offText:"Haber",
        offColor:"primary"
    });

    $('.select').combobox();
    $("#valor").keydown(function (ev) {
        if (ev.keyCode == 13) {
            $("#agregar").click()
            return false;
        }
        return true;
    });
    $(".valores").blur(function(){
        var total=0
        $(".valores").each(function(){
            total+=$(this).val()*1
        })
        $("#total-rec").html(number_format(total,2,'.',' '))
    })
    $("#agregar").click(function(){
        var cuenta = $("#cuenta").val()
        var desc = $("#cuenta option:selected").text().split("-")[1];
        var signo = $("#signo").bootstrapSwitch("state")
        var valor = $("#valor").val()
        var msg=""
        if(cuenta==""){
            msg+="<br/>Por favor, seleccione una cuenta"
        }else{

            if($("."+cuenta).length>0){
                msg+="<br/>La cuenta "+cuenta+" ya esta presente en la tabla de detalle, seleccione otra o primero elimine la cuenta de la tabla."
            }
        }
        if(valor==""){
            msg+="<br/>Por favor, ingrese un valor"
        }
        if(desc.length>35){
            desc =desc.substr(0,30)
        }
        if(msg==""){
            var tr = $("<tr class='tr-info'>")
            tr.append("<td style='text-align: center' class='secuencial'>"+secuencial+"</td>")
            tr.append("<td class=' cuenta "+cuenta+"'>"+cuenta+"</td>")
            tr.append("<td><input type='text' class='desc allCaps form-control input-sm' maxlength='35' value='"+desc+"'></td>")
            var btn = $("<a href='#' class='btn btn-danger btn-sm borrar'><i class='fa fa-trash'></a>")
            if(signo) {
                tr.attr("debe",valor)
                tr.attr("haber",0)
                tr.append("<td class='num debe'>" +  number_format(valor,2,'.',',')  + "</td>")
                tr.append("<td class='num haber'>" + number_format(0,2,'.',',') + "</td>")
            }else{
                tr.attr("debe",0)
                tr.attr("haber",valor)
                tr.append("<td class='num debe'>" +  number_format(0,2,'.',',')  + "</td>")
                tr.append("<td class='num haber'>" +  number_format(valor,2,'.',',')  + "</td>")
            }
            tr.append($("<td style='text-align: center'>").append(btn))
            btn.click(function(){
                $(this).parent().parent().remove()
                calcularTotales()
            })
            $("#detalles").append(tr)
            calcularTotales()
            $("#cuenta").val("")
            $(".select").val("")

        }else{
            bootbox.alert(msg)
        }

    })

    $("#volver").click(function(){
        window.history.back();
        return false
    })
    $("#guardar").click(function(){
        var concepto = $("#concepto").val()
        var fecha= $("#fecha").val()
        var debe =  $("#tot_debe").attr("valor")
        var haber =  $("#tot_haber").attr("valor")
        var msg =""
        if(concepto==""){
            msg+="<br>Ingrese un concepto"
        }
        if(debe=="0" && haber=="0"){
            msg+="<br>Ingrese cuentas en la sección de detalle"
        }
        if(debe!=haber){
            msg+="<br>El total del debe y haber difiere"
        }
        if(msg==""){
            var data =""
            $(".tr-info").each(function(){
                data+=$(this).find(".secuencial").html()+";"+$(this).find(".cuenta").html()+";"+$(this).attr("debe")+";"+$(this).attr("haber")+";"+$(this).find(".desc").val()+"|"
            });
            $("#data").val(data)
            $(".frm-comprobante").submit()
        }else{
            bootbox.alert(msg)
        }
    })
    calcularTotales()
    $(".valores").blur()
    $("#usar").click(function(){
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'comprobantes', action:'aplicarPrototipo_ajax')}",
            data: {
                id:$("#prototipo").val()
            },
            success: function (msg) {
                closeLoader()
                $("#detalles").append(msg)
                calcularTotales()
            } //success
        }); //ajax
    })
</script>
</body>
</html>