<div class="row fila">
    <div class="col-md-1">
        <label>Rubro:</label>
    </div>
    <div class="col-md-3">
        <g:select name="rubros" id="rubros" from="${contable.nomina.Rubro.list([sort: 'nombre'])}" optionKey="id" optionValue="nombre" class="form-control input-sm"/>
    </div>
    <div class="col-md-1">
        <label>Descuenta:</label>
    </div>
    <div class="col-md-1">
        <input type="checkbox" class="chk" id="signo" name="signo_chk" value="1" checked>
    </div>
    <div class="col-md-1">
        <label>Mes:</label>
    </div>
    <div class="col-md-2">
        <g:select name="mes" id="mes" from="${meses}" optionKey="key" optionValue="value" class="form-control input-sm"/>
    </div>
    <div class="col-md-1">
        <a href="#" id="agregar" class="btn btn-verde btn-sm">
            <i class="fa fa-plus"></i> Agregar
        </a>
    </div>
</div>
<div class="row fila">
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
    <div class="col-md-1">
        <label>Aplicar plantilla:</label>
    </div>
    <div class="col-md-4">
       <g:select name="plantilla" id="tipo" from="${contable.nomina.TipoContrato.list([sort: 'descripcion'])}"
       class="form-control input-sm" optionValue="descripcion" optionKey="id" noSelection="['':'']"
       />
    </div>
    <div class="col-md-1">
      <a href="#" class="btn btn-verde btn-sm" id="aplicar">
          <i class="fa fa-adjust"></i> Aplicar
      </a>
    </div>
</div>
<div class="row fila">
    <div class="col-md-11">
        <table class="table table-darkblue table-sm table-bordered">
            <thead>
            <tr>
                <th>Rubro</th>
                <th>Tipo</th>
                <th style="width: 50px">Descuenta</th>
                <th style="width: 30px">Mes</th>
                <th>Inicio</th>
                <th>Fin</th>
                <th style="width: 40px"></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${rubros}" status="i" var="r">
                <tr data-id="${r.id}" class="r-${r.rubro.id}">
                    <td>${r.rubro.nombre}</td>
                    <td style="text-align: center">${r.rubro.signo==1?'Ingreso':'Egreso'}</td>
                    <td style="text-align: center">${r.descontable=="S"?'Si':'No'}</td>
                    <td style="text-align: center">${meses[""+r.mes]}</td>
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

</div>
<div class="row fila">
    <div class="col-md-11">
        <table class="table table-darkblue table-sm table-bordered">
            <thead>
            <tr>
                <th colspan="6">Rubros fijos</th>
            </tr>
            <tr>
                <th>Rubro</th>
                <th>Tipo</th>
                <th style="width: 30px">Mes</th>
                <th>Valor</th>
                <th>Inicio</th>
                <th>Fin</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${fijos}" status="i" var="r">
                <tr data-id="${r.id}" class="r-${r.id}">
                    <td>${r.descripcion}</td>
                    <td style="text-align: center">${r.signo==1?'Ingreso':'Egreso'}</td>
                    <td style="text-align: center">${meses[""+r.mes]}</td>
                    <td style="text-align: right">${g.formatNumber(number: r.valor,type: 'currency',currencySymbol: '' ) }</td>
                    <td style="text-align: center">${r.inicio?.format("dd-MM-yyyy")}</td>
                    <td style="text-align: center">${r.fin?.format("dd-MM-yyyy")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
<script>
    $(".chk").bootstrapSwitch({
        size:'mini',
        onText:"Si",
        offText:"No",
        offColor:"primary"
    });
    $("#agregar").click(function(){
        var descuenta = "S"
        if(!$("#signo").bootstrapSwitch("state"))
            descuenta="N"
        var cant = $(".r-"+$("#rubros").val()).size()
        if(cant>0)
            bootbox.alert("El rubro seleccionado ya esta asignado al empleado")
        else{
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rubros', action:'addRubroEmpleado_ajax')}",
                data: {
                    empleado:"${empleado.id}",
                    rubro:$("#rubros").val(),
                    descuenta:descuenta,
                    mes:$("#mes").val(),
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
            url: "${createLink(controller:'rubros', action:'borrarRubroEmpleado_ajax')}",
            data: {
                id:$(this).attr("iden")
            },
            success: function (msg) {
                closeLoader()
                $("#detalle").html(msg)
            } //success
        }); //ajax
    })
    $("#aplicar").click(function(){
        if($("#tipo").val()!=""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rubros', action:'aplicarPLantilla_ajax')}",
                data: {
                    empleado:"${empleado?.id}",
                    tipo:$("#tipo").val()
                },
                success: function (msg) {
                    closeLoader()
                    $("#detalle").html(msg)
                } //success
            }); //ajax
        }

    })
</script>