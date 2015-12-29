<%@ page import="contable.core.Tabla" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Nuevo comprobante de ${tipoString} Cash</title>
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
        padding-left: 3px !important;
        padding-right: 3px !important;
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
    select.input-sm{
        height: 20px;
    }
    .fila{
        margin-top: 8px;
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
    <div class="col-md-4 titulo-panel" style="margin-top: -6px;text-align: right">
        <a href="#" class="btn btn-verde" id="guardar">
            <i class="fa fa-save"></i> Guardar
        </a>
        <a href="#" id="volver" class="btn btn-default">
            <i class="fa fa-arrow-left"></i> Volver
        </a>
    </div>
</div>
<g:form name="frm" class="frm-comprobante" action="saveCash" controller="comprobantes">
    <input type="hidden" id="data" name="data">
    <input type="hidden" id="data2" name="data2">
    <input type="hidden" name="mes" value="${mes}">
    <input type="hidden" name="mesSolo" value="${mesSolo}">
    <input type="hidden" name="tipo" value="${tipo}">
%{--<input type="hidden" name="numero" value="${comp?.numero}">--}%
    <div class="row fila">
        <div class="col-md-1">
            <label>Número:</label>
        </div>
        <div class="col-md-1">
            <input type="text" name="numero-txt" id="numero"  disabled class="form-control input-sm"  value="${g.formatNumber(number: siguiente,maxFractionDigits: 0)}">
            <input type="hidden" name="numero" id="numero_manual" value="${g.formatNumber(number: siguiente,maxFractionDigits: 0)}">
        </div>
        <div class="col-md-1">
            <label>Tipo:</label>
        </div>
        <div class="col-md-1">
            <input type="hidden" name="tipoProcesamiento" value="4" id="modo">
            Transferencia
        </div>
        <div class="col-md-1">
            <label>Fecha: </label>
        </div>
        <div class="col-md-2">
            <elm:datepicker name="fecha" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${fecha}"></elm:datepicker>
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
    <div class="row fila">
        <div class="col-md-1">
            <label>Concepto:</label>
        </div>
        <div class="col-md-6">
            <input type="text" name="concepto" maxlength="255" id="concepto" class="form-control input-sm" value="${comp?.concepto}">
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-verde btn-sm" id="crearCliente"><i class="fa fa-plus"></i> Nuevo cliente</a>
        </div>
    </div>
    <div class="row fila" style="">
        <div class="col-md-1">
            <label>Beneficiario:</label>
        </div>
        <div class="col-md-4" >
            <g:select name="cheque.cliente" id="cliente" from="${clientes}"  noSelection="['':'']"
                      class="form-control input-sm select"    optionKey="codigo" optionValue="cp" value="${cliente?.codigo}"/>
        </div>
        <div class="col-md-2">
            <label>Cuenta del beneficiario:</label>
        </div>
        <div class="col-md-2">
            <g:select name="bancoCliente" id="bancoCliente" noSelection="['':'Seleccione']" from="${contable.core.BancoOcp.list([sort: 'descripcion'])}"
            optionValue="descripcion" optionKey="codigo" class="form-control input-sm" value="${comp?.bancoCliente?.codigo}"
            />
        </div>
        <div class="col-md-1">
            <g:select name="tipoCuenta" id="tipoCuenta" from="${tipos}" class="form-control  input-sm "
                      optionValue="value" optionKey="key" value="${comp?.tipoCuenta}"/>
        </div>
        <div class="col-md-2">
            <input type="text" id="cuentaCliente" class="form-control input-sm digits" style="text-align: right" value="${comp?.cuentaTransferencia}" name="cuentaTransferencia">
        </div>
    </div>
    <div class="row fila">
        <div class="col-md-1">
            <label>Banco:</label>
        </div>
        <div class="col-md-2" >
            <select name="cheque.banco" id="banco_cheque" class="form-control input-sm" style="padding: 2px">
                <option value="-1">Seleccione..</option>
                <g:each in="${contable.core.Banco.list()}" var="b">
                    <g:if test="${b.codigo==cheque?.banco?.codigo}">
                        <option value="${b.codigo}" cuenta="${b.cuenta.numero.trim()}" cheque="${b.ultimoCheque}" selected>${b.descripcion} - ${b.numero}</option>
                    </g:if>
                    <g:else>
                        <option value="${b.codigo}" cuenta="${b.cuenta.numero.trim()}" cheque="${b.ultimoCheque}">${b.descripcion} - ${b.numero}</option>
                    </g:else>
                </g:each>
            </select>
        </div>
        <div class="col-md-1" >
            <label>Cuenta PYS:</label>
        </div>
        <div class="col-md-1" >
            <input type="text" class="form-control input-sm" id="cuenta_cheque" readonly value="${cheque?.cuenta}">
        </div>
        <div class="col-md-1" >
            <label>Cheque:</label>
        </div>
        <div class="col-md-1">
            <input type="text" name="cheque.numero" class="form-control input-sm" id="cheque_cheque" value="${cheque?.numero}" readonly>
        </div>
        <div class="col-md-2">
            <elm:datepicker name="chequefecha" class="form-control input-sm" minDate="${inicio}" maxDate="${fin}" value="${cheque?.entrega?:fecha}"></elm:datepicker>
        </div>
        <div class="col-md-1">
            <label>Valor:</label>
        </div>
        <div class="col-md-2">
            <input type="text" name="cheque.valor" id="valor_cheque" class="form-control input-sm num number" value="${cheque?.valor}" >
        </div>
    </div>
</g:form>
<div class="row fila" style="margin-top: 15px">
    <div class="col-md-12">
        <table class="table table-darkblue table-bordered table-hover table-striped table-sm">
            <thead>
            <tr>
                <th style="width: 110px">Tipo doc.</th>
                <th style="width: 110px">Num. doc.</th>
                <th  style="width: 100px !important;">Fec. doc</th>
                <th style="width: 100px !important;">Valor</th>
                <th style="width: 120px">Tipo retención</th>
                <th style="width: 120px !important;">Retención</th>
                <th  style="width: 80px !important;">IVA grabado</th>
                <th style="width: 100px !important;">Tipo IVA</th>
                <th  style="width: 100px !important;">Valor IVA</th>
                <th  style="width: 100px !important;">A pagar</th>
                <th style="width: 50px !important;"></th>
            </tr>
            </thead>
            <tbody id="detalles-doc">
            <tr>
                <td>
                    <g:select name="tipoDoc" id="tipoDoc" from="${tipoComp}"
                              optionValue="descripcion"  optionKey="codigo" class="form-control input-sm"/>
                </td>
                <td><input type="text" class="form-control input-sm" id="numDoc"></td>
                <td><elm:datepicker name="fechaDoc" class="form-control input-sm" value="${inicio}"></elm:datepicker></td>
                <td><input type="text" class="form-control input-sm number num change" id="valorDoc"></td>
                <td>
                    <select name="tipoRet" id="tipoRet" class="form-control input-sm change" style="padding: 2px">
                        <option value=""></option>
                        <g:each in="${tiposRet}" var="t">
                            <option value="${t.codigo}" cuenta="${t.cuenta?.numero?.trim()}" porcentaje="${t.porcentaje}">${t.descripcion}</option>
                        </g:each>
                    </select>
                </td>
                <td><input type="text" class="form-control input-sm number num  " readonly  id="retDoc"></td>
                <td style="text-align: center">
                    <input type="checkbox" class="chk-iva change" id="graba" name="iva" value="1" checked>
                </td>
                <td>
                    <select name="tipoIva" id="tipoIva" class="form-control input-sm change" style="padding: 2px">
                        <option value=""></option>
                        <g:each in="${tipoIva}" var="t">
                            <option value="${t.codigo}" cuenta="${t.cuenta?.numero?.trim()}" porcentaje="${t.porcentaje}">${t.descripcion}</option>
                        </g:each>
                    </select>
                </td>
                <td><input type="text" class="form-control input-sm num number "  readonly id="ivaDoc"></td>
                <td><input type="text" class="form-control input-sm num number  "  readonly id="pagarDoc"></td>
                <td style="text-align: center">
                    <a href="#" class="btn btn-verde btn-sm" id="agregarDoc" title="agregar">
                        <i class="fa fa-plus"></i>
                    </a>
                </td>
            </tr>
            <g:each in="${rets}" var="r">
                <tr class="tr-info-doc" tipo-doc="${r.tipoDocumento.codigo}" num-doc="${r.numeroFactura}"
                    fecha-doc="${r.fechaDocumento?.format('dd-MM-yyyy')}" valor-doc="${r.valor}" tiporet-doc="${r.tipoRetencion}"
                    valorret-doc="${r.retencion}" graba-doc="${r.retencionIva}" tipoiva-doc="${r.tipoIva}  "
                    valoriva-doc="${r.valorIva}" pagar-doc="${r.pagar}">
                    <td class="tipo-doc">${r.tipoDocumento.descripcion}</td>
                    <td class="num-doc">${r.numeroFactura}</td>
                    <td class="fecha-doc" style="text-align: center">${r.fechaDocumento?.format("dd-MM-yyyy")}</td>
                    <td class="valor-doc num" style="text-align: right">${r.valor}</td>
                    <td class="tipoRet-doc">${Tabla.findByCodigo(r.tipoRetencion)?.descripcion}</td>
                    <td class="valorRet-doc num" style="text-align: right">${r.retencion}</td>
                    <td  class="graba-doc" style="text-align: center">${r.retencionIva==1?'Si':'No'}</td>
                    <td class="tipoIva-doc ">${Tabla.findByCodigo(r.tipoIva)?.descripcion}</td>
                    <td class="valorIva-doc num" style="text-align: right">${r.valorIva}</td>
                    <td class="pagar-doc num" style="text-align: right">${r.pagar}</td>
                    <td style="text-align: center">
                        <a href="#" class="btn btn-danger btn-sm borrar"><i class="fa fa-trash"></i></a>
                    </td>
                </tr>
            </g:each>
            </tbody>
            <tfoot>
            <tr style="font-weight: bold !important;">
                <td colspan="3">TOTALES</td>
                <td class="num" id="tot_valor"></td>
                <td></td>
                <td class="num" id="tot_ret"></td>
                <td></td>
                <td></td>
                <td class="num" id="tot_iva"></td>
                <td class="num" id="tot_pagar"></td>

            </tr>
            </tfoot>
        </table>
    </div>

</div>
<div class="row fila">
    <div class="col-md-1" style="margin-top: -5px">
        <a href="#" class="btn btn-info btn-sm" id="asientos" title="Generar asientos de las retenciones">
            <i class="fa fa-list"></i> Asientos
        </a>
    </div>
    <div class="col-md-1">
        <label>Cuenta:</label>
    </div>
    <div class="col-md-4">
        <g:select name="cuenta" from="${cuentas}" optionKey="numero"
                  id="cuenta"  class="form-control input-sm select select-cnta " noSelection="['':'']" ></g:select>
    </div>
    <div class="col-md-2">
        <input type="checkbox" class="chk" id="signo" name="signo" value="1" checked>
    </div>
    <div class="col-md-1" style="width: 40px">
        <label>Valor:</label>
    </div>
    <div class="col-md-2">
        <input type="text" id="valor" class="form-control input-sm num number">
    </div>
    <div class="col-md-1" style="margin-top: -3px">
        <a href="#" class="btn btn-verde btn-sm" id="agregar" title="agregar">
            <i class="fa fa-plus"></i>
        </a>
    </div>
</div>
<div class="row fila" style="margin-top: 10px">
    <div class="col-md-12">
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

    var id = null;
    function submitFormCliente() {
        var $form = $("#frmCliente");
        var $btn = $("#dlgCreateEditCliente").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando Cliente");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    closeLoader()
                    if(msg!="error"){
                        var parts = msg.split(";");
                        $("#cliente").append("<option value='"+parts[0]+"'>"+parts[1]+"</option>")
                        $('#cliente').data('combobox').refresh();
                        $("#cliente").val(parts[0])
                    }else{
                        bootbox.alert("Ha ocurrido un error al registrar el cliente")
                    }

                },
                error: function() {
                    log("Ha ocurrido un error interno", "Error");
                    closeLoader();
                }
            });
        } else {
            return false;
        } //else
    }


    function createEditCliente(id) {
        openLoader()
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'cliente', action:'form_id_ajax')}",
            data    : data,
            success : function (msg) {
                closeLoader()
                var b = bootbox.dialog({
                    id      : "dlgCreateEditCliente",
                    title   : title + " Cliente",

                    class   : "modal-lg",

                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormCliente();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit
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
        $("#tot_debe").html(number_format(debe,2,".",""))
        $("#tot_debe").attr("valor",debe.toFixed(2))
        $("#tot_haber").attr("valor",haber.toFixed(2))
        $("#tot_haber").html(number_format(haber,2,".",""))
    }
    function calcularTotalesDoc(){
        var totIva = 0
        var totRet = 0
        var totPagar = 0
        var totValor=0
        $(".tr-info-doc").each(function(){
            totIva+=$(this).attr("valorIva-doc")*1
            totRet+=$(this).attr("valorRet-doc")*1
            totPagar+=$(this).attr("pagar-doc")*1
            totValor+=$(this).attr("valor-doc")*1
        })
        $("#tot_iva").html(number_format(totIva,2,".",""))
        $("#tot_ret").html(number_format(totRet,2,".",""))
        $("#tot_pagar").html(number_format(totPagar,2,".",""))
        $("#tot_valor").html(number_format(totValor,2,".",""))
        $("#valor_cheque").val(number_format(totPagar,2,".",""))
    }
    $(".chk").bootstrapSwitch({
        size:'mini',
        onText:"Debe",
        offText:"Haber",
        offColor:"primary"
    });
    $(".chk-iva").bootstrapSwitch({
        size:'mini',
        onText:"Si",
        offText:"No"
    });

    $('.select').combobox();
    $("#valor").keydown(function (ev) {
        if (ev.keyCode == 13) {
            $("#agregar").click()
            return false;
        }
        return true;
    });
    $("#agregar").click(function(){
        var cuenta = $("#cuenta").val()
        var desc = $("#cuenta option:selected").text().split("-")[1];
        var signo = $("#signo").bootstrapSwitch("state")
        var valor = $("#valor").val()
        var msg=""
        if(cuenta==""){
            msg+="<br/>Por favor, seleccione una cuenta"
        }else{


            if(desc.length>35){
                desc =desc.substr(0,30)
            }
        }
        if(valor==""){
            msg+="<br/>Por favor, ingrese un valor"
        }

        if(msg==""){
            var tr = $("<tr class='tr-info'>")
            tr.append("<td style='text-align: center' class='secuencial'>"+secuencial+"</td>")
            tr.append("<td class=' cuenta "+cuenta+"'>"+cuenta+"</td>")
            tr.append("<td><input type='text' class='desc allCaps form-control input-sm' maxlength='35' value='"+desc+"'></td>")
            var btn = $("<a href='#' class='btn btn-danger btn-sm borrar'><i class='fa fa-trash'></i></a>")
            if(signo) {
                tr.attr("debe",valor)
                tr.attr("haber",0)
                tr.append("<td class='num debe'>" +  number_format(valor,2,'.','')  + "</td>")
                tr.append("<td class='num haber'>" + number_format(0,2,'.','') + "</td>")
            }else{
                tr.attr("debe",0)
                tr.attr("haber",valor)
                tr.append("<td class='num debe'>" +  number_format(0,2,'.','')  + "</td>")
                tr.append("<td class='num haber'>" +  number_format(valor,2,'.','')  + "</td>")
            }
            tr.append($("<td style='text-align: center'>").append(btn))
            btn.click(function(){
                $(this).parent().parent().remove()
                calcularTotales()
            })
            $("#detalles").append(tr)
            calcularTotales()
            $("#cuenta").val("")
            $(".select-cnta").val("")

        }else{
            bootbox.alert({
                message:msg,
                title:"Errores",
                className:"modal-error"
            })
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
        var graba = 0
        var valor = $("#valor_cheque").val()
        var numero = $("#numero").val()
        var cliente = $("#cliente").val()
        var cuenta = $("#cuentaCliente").val()
        if($("#graba").bootstrapSwitch("state"))
            graba=1
        if(concepto==""){
            msg+="<br>Ingrese un concepto"
        }
        if(cuenta==""){
            msg+="<br>Ingrese una cuenta para efectuar la transferencia"
        }
        if(debe=="0" && haber=="0"){
            msg+="<br>Ingrese cuentas en la sección de detalle"
        }
        if(debe!=haber){
            msg+="<br>El total del debe y haber difiere"
        }
        if(isNaN(valor) || valor==""){
            msg+="<br>El valor del egreso debe ser un número positivo"
        }else{
            if(valor*1<0)
                msg+="<br>El valor del egreso debe ser un número positivo"
        }
        if(isNaN(numero) || valor==""){
            msg+="<br>El número del comprobante debe ser un entero"
        }
        if(cliente==""){
            msg+="<br>Seleccione un beneficiario"
        }
        if(msg==""){
            var data =""
            $(".tr-info").each(function(){
                data+=$(this).find(".secuencial").html()+";"+$(this).find(".cuenta").html()+";"+$(this).attr("debe")+";"+$(this).attr("haber")+";"+$(this).find(".desc").val()+"|"
            });
            $("#data").val(data)
            var data2 =""
            $(".tr-info-doc").each(function(){
                data2+=$(this).attr("tipo-doc")+";"+$(this).attr("num-doc")+";"+$(this).attr("fecha-doc")+";"+$(this).attr("valor-doc")+";"+$(this).attr("tipoRet-doc")+";"+$(this).attr("valorRet-doc")+";"+$(this).attr("tipoIva-doc")+";"+$(this).attr("valorIva-doc")+";"+graba+";"+$(this).attr("pagar-doc")+"W"
            })
            $("#data2").val(data2)
            $(".frm-comprobante").submit()
        }else{
            bootbox.alert({
                message:msg,
                title:"Errores",
                className:"modal-error"
            })
        }
    })
    $("#banco_cheque").change(function(){
        $("#cuenta_cheque").val($("#banco_cheque option:selected").attr("cuenta"))
        $("#cheque_cheque").val($("#banco_cheque option:selected").attr("cheque")*1+1)
        if($("#modo").val()==1)
            $("#numero").val($("#cheque_cheque").val())
    })
    $("#modo").change(function(){
        if($(this).val()==1)
            $("#numero").val($("#cheque_cheque").val())
        else
            $("#numero").val($("#numero_manual").val())
    });
    //    $("#tipoRet").change(function(){
    //        $("#retDoc").val($("#tipoRet option:selected").attr("porcentaje"))
    //    })
    $(".change").change(function(){
        var p = $("#tipoIva option:selected").attr("porcentaje")*1
        var valor = $("#valorDoc").val()*1
        var ret = $("#tipoRet option:selected").attr("porcentaje")*1
        var graba =0
        if( $("#graba").bootstrapSwitch("state"))
            graba=1
        var apagar = 0
        var iva = 0
        if(isNaN(ret))
            ret=0
        if(isNaN(p))
            p=0
        apagar=valor*(1-ret/100)
        iva = valor*0.12*(1-p/100)*graba
        var ivaRetenido = valor*0.12*(p/100)*graba

        $("#retDoc").val(number_format(valor*ret/100,2,'.',''))
        $("#ivaDoc").val(number_format(ivaRetenido,2,'.',''))
        $("#pagarDoc").val(number_format(iva+apagar,2,'.',''))

    })
    $('.chk-iva').on('switchChange.bootstrapSwitch', function(event, state) {
        $(".change").change()
    });

    $("#agregarDoc").click(function(){
        var tipoDoc = $("#tipoDoc").val()
        var tipoDocDesc = $("#tipoDoc option:selected").text()
        var numDoc = $("#numDoc").val()
        var fecha = $("#fechaDoc_input").val()
        var valor = $("#valorDoc").val()
        var tipoRetencion = $("#tipoRet").val()
        var tipoRetDesc = $("#tipoRet option:selected").text()
        var retencion = $("#retDoc").val()
        var graba =0
        if( $("#graba").bootstrapSwitch("state"))
            graba=1
        var tipoIva = $("#tipoIva").val()
        var tipoIvaDesc = $("#tipoIva option:selected").text()
        var iva = $("#ivaDoc").val()
        var apagar = $("#pagarDoc").val()
        var msn =""
        if(tipoDoc.trim()==""){
            msn+="Seleccione el tipo de documento"
        }
        if(graba==1){
            if(tipoIva=="")
                msn+="<br/>Seleccione el tipo de retención del IVA"
        }
        if(numDoc.trim()==""){
            msn+="<br/>Ingrese el número de documento"
        }
        if(fecha.trim()==""){
            msn+="<br/>Ingrese la fecha de emisión del documento"
        }
        if(isNaN(valor) || valor==""){
            msn+="<br/>Ingrese el valor del documento"
        }
        if(msn==""){
            var tr = $("<tr class='tr-info-doc'>")
            tr.attr("tipo-doc",tipoDoc)
            tr.attr("num-doc",numDoc)
            tr.attr("fecha-doc",fecha)
            tr.attr("valor-doc",valor)
            tr.attr("tipoRet-doc",tipoRetencion)
            tr.attr("valorRet-doc",retencion)
            tr.attr("graba-doc",graba)
            tr.attr("tipoIva-doc",tipoIva)
            tr.attr("valorIva-doc",iva)
            tr.attr("pagar-doc",apagar)
            var btn = $("<a href='#' class='btn btn-danger btn-sm borrar'><i class='fa fa-trash'></i></a>")
            tr.append("<td class='tipo-doc'>"+tipoDocDesc+"</td>")
            tr.append("<td class='num-doc'>"+numDoc+"</td>")
            tr.append("<td class='fecha-doc'>"+fecha+"</td>")
            tr.append("<td class='valor-doc num'>"+valor+"</td>")
            tr.append("<td class='tipoRet-doc'>"+tipoRetDesc+"</td>")
            tr.append("<td class='valorRet-doc num'>"+retencion+"</td>")
            tr.append("<td style='text-align: center' class='graba-doc'>"+(graba==0?'No':'Si')+"</td>")
            tr.append("<td class='tipoIva-doc '>"+tipoIvaDesc+"</td>")
            tr.append("<td class='valorIva-doc num'>"+iva+"</td>")
            tr.append("<td class='pagar-doc num'>"+apagar+"</td>")
            tr.append($("<td style='text-align: center'>").append(btn))
            btn.click(function(){
                $(this).parent().parent().remove()
                calcularTotalesDoc()
            })
            $("#detalles-doc").append(tr)
            calcularTotalesDoc()
            $("#numDoc").val("")
            $("#fechaDoc_input").val("")
            $("#valorDoc").val("")
            $("#tipoRet").val("")
            $("#retDoc").val("")
            $("#tipoIva").val("")
            $("#ivaDoc").val("")
            $("#pagarDoc").val("")
        }else{
            bootbox.alert({
                message:msn,
                title:"Errores",
                className:"modal-error"
            })
        }

    });
    $("#asientos").click(function(){

        var data = ""
        var msn=""
        if($("#banco_cheque").val()=="-1"){
            msn+="<br/>Seleccione un banco"
        }
        if($("#valor_cheque").val()==""){
            msn+="<br/>Ingrese el valor del cheque"
        }
        $(".tr-info-doc").each(function(){
            data+=$(this).attr("tipoRet-doc")+";"+$(this).attr("valorRet-doc")+";"+$(this).attr("tipoIva-doc")+";"+$(this).attr("valorIva-doc")+"W"
        })

        if(msn!=""){
            bootbox.alert({
                message:msn,
                title:"Errores",
                className:"modal-error"
            })
        }else{
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'comprobantes', action:'asientosEgreso')}",
                data: {
                    data:data,
                    banco:$("#banco_cheque").val(),
                    valor:$("#valor_cheque").val()
                },
                success: function (msg) {
                    closeLoader()
                    $("#detalles").append(msg)
                    calcularTotales()
                } //success
            }); //ajax
        }

    })
    $("#cliente").change(function(){

        if($("#cliente").val()!=""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'comprobantes', action:'getDatosCliente_ajax')}",
                data: {
                    cliente:$("#cliente").val()
                },
                success: function (msg) {
                    closeLoader()
                    if(msg=="null;null;null"){
                        $("#bancoCliente").val("")
                        $("#tipoCuenta").val("")
                        $("#cuentaCliente").val("")
                        bootbox.alert("El cliente seleccionado no tiene una cuenta bancaria registrada en el sistema. Asegurese de ingresarla.")
                    }else{
                        var parts = msg.split(";")
                        $("#bancoCliente").val(parts[0].trim())
                        $("#tipoCuenta").val(parts[1].trim())
                        $("#cuentaCliente").val(parts[2].trim())
                    }

                } //success
            }); //ajax
        }else{
            $("#bancoCliente").val("")
            $("#tipoCuenta").val("")
            $("#cuentaCliente").val("")
        }

    })
    calcularTotales()
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
    $("#crearCliente").click(function(){
        createEditCliente()
    })
</script>
</body>
</html>