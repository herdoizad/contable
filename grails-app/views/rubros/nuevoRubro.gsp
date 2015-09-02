<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Registro de rubros</title>
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

<div class="row fila">
    <div class="col-md-7" >
        <div class="panel-completo" style="margin-left: 10px;height: 478px">
            <g:form class="frm-rubro" action="save_ajax">
                <input type="hidden" name="id" value="${rubro?.id}">
                <div class="row">
                    <div class="col-md-12 titulo-panel">
                        Rubros
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <label>Nombre</label>
                    </div>
                    <div class="col-md-10">
                        <input type="text" id="nombre" class="form-control input-sm required" name="nombre" value="${rubro?.nombre}">
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <label>Valor</label>
                    </div>
                    <div class="col-md-3">
                        <input type="text" id="valor" class="form-control input-sm number " name="valor" style="text-align: right" value="${rubro?.valor}">
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <label>Fórmula</label>
                    </div>
                    <div class="col-md-10">
                        <div class="input-group">
                            <input type="text" id="formula" class="form-control input-sm" name="formula" value="${rubro?.formula}">
                            <span class="input-group-btn">
                                <a href="#" class="btn btn-warning btn-sm" title="Probar" id="probar">
                                    <i class="fa fa-check"></i>
                                </a>
                            </span>
                        </div><!-- /input-group -->

                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <label>Tipo</label>
                    </div>
                    <div class="col-md-3">
                        <input type="checkbox" class="chk" id="signo" name="signo_chk" value="1" checked>
                        <input type="hidden" name="signo" id="signo-txt" value="1">
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <label>Cuenta</label>
                    </div>
                    <div class="col-md-10">
                        <g:select name="cuenta" from="${contable.core.Cuenta.findAllByAgrupa(1)}" optionKey="numero" value="${rubro?.cuenta?.getNumeroPad()}"
                                  id="cuenta"  class="form-control input-sm select " noSelection="['':'']" ></g:select>
                    </div>
                </div>
            </g:form>
            <div class="row fila">
                <div class="col-md-2">
                    <a href="#" class="btn btn-verde btn-sm" id="guardar">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Variables
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12" style="height: 400px;overflow-y: auto">
                    <table class="table table-darkblue table-sm">
                        <thead>
                        <tr>
                            <th>Variable</th>
                            <th>Descripción</th>
                            <th style="width: 40px"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${contable.nomina.Variable.list([sort: 'nombre'])}" var="v">
                            <tr>
                                <td>${v.codigo}</td>
                                <td>${v.nombre}</td>
                                <td style="text-align: center">
                                    <a href="#" class="btn-xs btn btn-info copiar " title="Usar" codigo="${v.codigo}" >
                                        <i class="fa fa-copy"></i>
                                    </a>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $("#guardar").click(function(){
        var nombre = $("#nombre").val()
        var valor = $("#valor").val()
        var formula = $("#formula").val()
        var msg =""
        if(nombre==""){
            msg="Ingrese un nombre<br/>"
        }
        if(valor == "" && formula==""){
            msg="Ingrese un vlaor o una fórmula<br/>"
        }
        if(msg==""){
            if( $("#signo").bootstrapSwitch("state"))
                $("#signo-txt").val("1")
            else
                $("#signo-txt").val("-1")
            $(".frm-rubro").submit()
        }else{
            bootbox.alert(msg)
        }
    })
    $(".chk").bootstrapSwitch({
        size:'',
        onText:"+",
        offText:"-",
        offColor:"primary"
    });
    <g:if test="${rubro?.signo==1}">
    $("#signo").bootstrapSwitch("state",true)
    </g:if>
    <g:else>
    $("#signo").bootstrapSwitch("state",false)
    </g:else>
    $('.select').combobox();
    $(".copiar").click(function(){
        $("#formula").val($("#formula").val()+$(this).attr("codigo"))
    })
    $("#probar").click(function(){
        if($("#formula").val()!=""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rubros', action:'getEmpleados_ajax')}",
                data: "",
                success: function (msg) {
                    closeLoader()
                    bootbox.dialog({
                        id: "dlgEmpleados",
                        title: "Seleccione un empleado y un mes para probar la fórmula",
                        message: msg
                    });
                } //success
            }); //ajax
        }
    })
</script>
</body>
</html>