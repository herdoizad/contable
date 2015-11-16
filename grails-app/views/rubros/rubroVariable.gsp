<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Rubros variables</title>
    <meta name="layout" content="main">
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<g:form action="guardarRubroVariable_ajax" class="frm">
    <input type="hidden" id="data" name="data">
    <div class="row fila">
        <div class="col-md-12">
            <div class="panel-completo" style="margin-left: 10px">
                <div class="row">
                    <div class="col-md-12 titulo-panel">
                        Rubros variables
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-1">
                        <label>Rubro</label>
                    </div>
                    <div class="col-md-3">
                        <input type="text" name="rubro" id="rubro" class="form-control input-sm">
                    </div>
                    <div class="col-md-1">
                        <label>
                            Tipo
                        </label>
                    </div>
                    <div class="col-md-2">
                        <g:select name="tipo" from="${tipos}" id="tipo" optionValue="value"
                                  class="form-control input-sm" optionKey="key"/>
                    </div>
                    <div class="col-md-1">
                        <label>
                            Mes
                        </label>
                    </div>
                    <div class="col-md-2">
                        <g:select name="mes" from="${meses}" id="mes" optionValue="descripcion"
                                  class="form-control input-sm" optionKey="id"/>
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-8">
                        <table class="table table-condensed table-striped">
                            <tbody>
                            <g:each in="${empleados}" var="e">
                                <tr class="tr-info">
                                    <td>${e.apellido} ${e.nombre}</td>
                                    <td style="width: 150px">
                                        <input type="text" empleado="${e.id}" style="text-align: right" class="val form-control input-sm number" >
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td><label>Total</label></td>
                                <td id="total" style="text-align: right;font-weight: bold"></td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-1">
                        <a href="#" id="guardar" class="btn btn-verde btn-sm">
                            <i class="fa fa-save"></i> Guardar
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</g:form>
<script>
    $(".val").blur(function(){
        var total = 0
        $(".val").each(function(){
            var valor = $(this).val()
            if(isNaN(valor)) {
                valor = 0
                $(this).val("0")
            }
            total+=valor*1
        })
        $("#total").html(number_format(total,2,".",""))
    })
    $("#guardar").click(function(){
        bootbox.confirm("Está seguro?",function(result){
            if(result){
                var rubro = $("#rubro").val()
                var msg =""
                if(rubro==""){
                    msg+="Ingrese el nombre del rubro<br/>"
                }
                var total = $("#total").html()
                if(isNaN(total))
                    msg="Ingrese valores para el rubro"
                var tipo = $("#tipo").val()
                if(msg==""){
                    var data =""
                    $(".val").each(function(){
                        var valor = $(this).val()
                        if(!isNaN(valor) && valor!="") {
                            data+=$(this).attr("empleado")+";"+$(this).val()+"W"
                        }
                    })
                    $("#data").val(data)
                    $(".frm").submit()
                }else{
                    bootbox.alert(msg)
                }
            }
        })

    });
</script>
</body>
</html>