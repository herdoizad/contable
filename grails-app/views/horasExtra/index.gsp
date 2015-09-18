<%@ page import="contable.nomina.Empleado" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Horas extra</title>
    <style>
    .hora{
        width: 45px;
    }
    .form-control{
        display: inline-table;
    }
    .factor{
        margin-right: 5px;
    }
    </style>
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<div class="row fila">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px;min-height: 10px">
            <div class="row">
                <div class="col-md-7 titulo-panel">
                    Registro de horas extra
                </div>
                <div class="col-md-1 titulo-panel" style="margin-top: -5px">
                    <label>Empleado:</label>
                </div>
                <div class="col-md-3 titulo-panel" style="margin-top: -11px">
                    <g:select name="empleado" id="empleado" from="${Empleado.findAllByEstado('A',[sort: 'apellido'])}" value="${empleado}" noSelection="['0':'TODOS']" class="select form-control input-sm select" optionKey="id" />
                </div>
                <div class="col-md-1 titulo-panel" style="margin-top: -11px">
                    <a href="#" class="btn btn-verde btn-sm" id="ver"><i class="fa fa-search"></i> Ver</a>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <table class="table table-bordered table-sm table-darkblue table-hover table-condensed">
                        <thead>
                        <tr>
                            <th>Empleado</th>
                            <g:each in="${meses}" var="m">
                                <th>${m.descripcion}</th>
                            </g:each>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${empleados}" var="e">
                            <tr>
                                <td> ${e.apellido} <br/>${e.nombre}</td>
                                <g:each in="${meses}" var="m">
                                    <g:set var="hora" value="${contable.nomina.HorasExtra.findByMesAndEmpleado(m,e)}"></g:set>
                                    <td style="text-align: center" class=" hora-container h-${e.id}" mes="${m.id}" emp="${e.id}">
                                        <label class="factor">0.25</label><input type="number" class="form-control input-sm hora f-2  ${e.id} m-${m.id}" max="10"  value="${hora?.horas2x?.toInteger()}" min="0" mes="${m.id}" emp="${e.id}" ><br/>
                                        <label class="factor">1.00</label><input type="number" class="form-control input-sm hora f-1  ${e.id} m-${m.id} " value="${hora?.horas1x?.toInteger()}" max="10" min="0" mes="${m.id}" emp="${e.id}" ><br/>
                                        <label class="factor">1.50</label><input type="number" class="form-control input-sm hora f-15  ${e.id} m-${m.id}"  value="${hora?.horas15x?.toInteger()}" max="10" min="0" mes="${m.id}" emp="${e.id}" ><br/>

                                    </td>
                                </g:each>
                            </tr>
                            <g:if test="${e.sistemaDeFacturacion=='S'}">
                                <tr>
                                    <td>
                                        ${e.apellido} <br/>${e.nombre}<br/>
                                        <span style="font-weight: bold;color:#006EB7">
                                            Sistema de facturación
                                        </span>
                                    </td>
                                    <g:each in="${meses}" var="m">
                                        <g:set var="horaf" value="${contable.nomina.HorasExtraFacturacion.findByMesAndEmpleado(m,e)}"></g:set>
                                        <td style="text-align: center" class=" hora-container-f h-${e.id}" mes="${m.id}" emp="${e.id}">
                                            <label class="factor">0.25</label><input type="number" class="form-control input-sm hora f-2  ${e.id} m-${m.id}" max="10"  value="${horaf?.horas2x?.toInteger()}" min="0" mes="${m.id}" emp="${e.id}" ><br/>
                                            <label class="factor">1.00</label><input type="number" class="form-control input-sm hora f-1  ${e.id} m-${m.id} " value="${horaf?.horas1x?.toInteger()}" max="10" min="0" mes="${m.id}" emp="${e.id}" ><br/>
                                            <label class="factor">1.50</label><input type="number" class="form-control input-sm hora f-15  ${e.id} m-${m.id}"  value="${horaf?.horas15x?.toInteger()}" max="10" min="0" mes="${m.id}" emp="${e.id}" ><br/>

                                        </td>
                                    </g:each>
                                </tr>
                            </g:if>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-1">
                    <a href="#" class="btn btn-verde " id="guardar">
                        <i class="fa fa-save"></i> Guadar
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    $("#ver").click(function(){
        location.href="${g.createLink(action: 'index')}/?empleado="+$("#empleado").val()
    })
    $('.select').combobox();
    $("#guardar").click(function(){
        openLoader();
        var data =""
        var dataf=""
        $(".hora-container").each(function(){
            var h1 = $(this).find(".f-1").val()*1
            var h15= $(this).find(".f-15").val()*1
            var h2 = $(this).find(".f-2").val()*1
            if(isNaN(h1))
                h1=0
            if(isNaN(h15))
                h15=0
            if(isNaN(h2))
                h2=0
            data+=$(this).attr("mes")+";"+$(this).attr("emp")+";"+h1+";"+h15+";"+h2+"W"

        })
        $(".hora-container-f").each(function(){
            var h1 = $(this).find(".f-1").val()*1
            var h15= $(this).find(".f-15").val()*1
            var h2 = $(this).find(".f-2").val()*1
            if(isNaN(h1))
                h1=0
            if(isNaN(h15))
                h15=0
            if(isNaN(h2))
                h2=0
            dataf+=$(this).attr("mes")+";"+$(this).attr("emp")+";"+h1+";"+h15+";"+h2+"W"

        })

        $.ajax({
            type    : "POST",
            url     : '${createLink(controller:'horasExtra', action:'save_ajax')}',
            data    : {
                data : data,
                dataf:dataf
            },
            success : function (msg) {
                location.reload(true)
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");
                closeLoader();
            }
        });
    })
</script>

</body>
</html>