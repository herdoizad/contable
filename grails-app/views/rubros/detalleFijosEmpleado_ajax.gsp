<div class="row fila">
    <div class="col-md-1">
        <label>Rubro:</label>
    </div>
    <div class="col-md-3">
        <input type="text" class="form-control input-sm" name="rubro" id="rubro">
    </div>
    <div class="col-md-1">
        <label>Valor:</label>
    </div>
    <div class="col-md-2">
        <input type="text" class="form-control input-sm number" style="text-align: right" id="valor" name="valor">
    </div>
    <div class="col-md-1">
        <label>Tipo:</label>
    </div>
    <div class="col-md-1">
        <input type="checkbox" class="chk" id="signo" name="signo_chk" value="1" checked>
        <input type="hidden" name="signo" id="signo-txt" value="1">
    </div>

    <div class="col-md-1">
        <a href="#" id="agregar" class="btn btn-verde btn-sm">
            <i class="fa fa-plus"></i> Agregar
        </a>
    </div>
</div>
<div class="row fila">
    <div class="col-md-1">
        <label>Mes:</label>
    </div>
    <div class="col-md-3">
        <g:select name="mes" id="mes" from="${meses}" optionKey="key" optionValue="value" class="form-control input-sm"/>
    </div>
    <div class="col-md-1">
        <label>Inicio:</label>
    </div>
    <div class="col-md-2">
        <elm:datepicker name="inicio"   class="form-control input-sm" value="${new java.util.Date().format('dd-MM-yyyy')}"/>
    </div>
    <div class="col-md-1">
        <label>Fin:</label>
    </div>
    <div class="col-md-2">
        <elm:datepicker name="fin" class="form-control input-sm"/>
    </div>
</div>
<div class="row fila">
    <div class="col-md-11">
        <table class="table table-darkblue table-sm table-bordered">
            <thead>
            <tr>
                <th>Rubro</th>
                <th>Tipo</th>
                <th style="width: 30px">Mes</th>
                <th>Valor</th>
                <th>Inicio</th>
                <th>Fin</th>
                <th style="width: 40px"></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${rubros}" status="i" var="r">
                <tr data-id="${r.id}" class="r-${r.id}">
                    <td>${r.descripcion}</td>
                    <td style="text-align: center">${r.signo==1?'Ingreso':'Egreso'}</td>
                    <td style="text-align: center">${meses[""+r.mes]}</td>
                    <td style="text-align: right">${g.formatNumber(number: r.valor,type: 'currency',currencySymbol: '' ) }</td>
                    <td style="text-align: center">${r.inicio?.format("dd-MM-yyyy")}</td>
                    <td style="text-align: center">${r.fin?.format("dd-MM-yyyy")}</td>
                    <td style="text-align: center">
                        <a href="#" class="btn btn-danger btn-xs borrar" iden="${r.id}" title="Borrar"><i class="fa fa-trash"></i></a>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
    <script>
        $(".chk").bootstrapSwitch({
            size:'mini',
            onText:"+",
            offText:"-",
            offColor:"primary"
        });
        $("#agregar").click(function(){
            var valor=$("#valor").val()
            var desc=$("#rubro").val()
            var signo = -1
            if( $("#signo").bootstrapSwitch("state"))
                signo=1
            var msg=""
            if(isNaN(valor)){
                msg="El valor debe ser un número positivo mayor a cero"
                valor=0
            }else{
                valor=valor*1
                if(valor<0.001)
                    msg="El valor debe ser un número positivo mayor a cero"
            }
            if(desc==""){
                msg+="Ingrese una descripción"
            }
            if(msg!="")
                bootbox.alert(msg)
            else{
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'rubros', action:'addRubroFijoEmpleado_ajax')}",
                    data: {
                        empleado:"${empleado.id}",
                        rubro:desc,
                        valor:valor,
                        mes:$("#mes").val(),
                        signo:signo,
                        inicio:$("#inicio_input").val(),
                        fin:$("#fin_input").val()
                    },
                    success: function (msg) {
                        closeLoader()
                        $("#detalle").html(msg)
                    } //success
                }); //ajax
            }


        })
        $(".borrar").click(function(){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rubros', action:'borrarFijosRubroEmpleado_ajax')}",
                data: {
                    id:$(this).attr("iden")
                },
                success: function (msg) {
                    closeLoader()
                    $("#detalle").html(msg)
                } //success
            }); //ajax
        })
    </script>
</div>