<div class="row fila">
    <div class="col-md-1">
        <label>Rubro:</label>
    </div>
    <div class="col-md-3">
        <g:select name="rubros" id="rubros" from="${contable.nomina.Rubro.list([sort: 'nombre'])}" optionKey="id" optionValue="nombre" class="form-control input-sm"/>
    </div>

    <div class="col-md-1">
        <a href="#" id="agregar" class="btn btn-verde btn-sm">
            <i class="fa fa-plus"></i> Agregar
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
                <th style="width: 40px"></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${rubros}" status="i" var="r">
                <tr data-id="${r.id}" class="r-${r.rubro.id}">
                    <td>${r.rubro.nombre}</td>
                    <td style="text-align: center">${r.rubro.signo==1?'Ingreso':'Egreso'}</td>
                    <td style="text-align: center">
                        <a href="#" class="btn btn-danger btn-xs borrar" iden="${r.id}" title="Borrar"><i class="fa fa-trash"></i></a>
                    </td>
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
            bootbox.alert("El rubro seleccionado ya esta asignado al contrato")
        else{
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rubros', action:'addRubroContrato_ajax')}",
                data: {
                    tipo:"${tipo.id}",
                    rubro:$("#rubros").val(),
                    descuenta:descuenta
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
            url: "${createLink(controller:'rubros', action:'borrarRubroContrato_ajax')}",
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