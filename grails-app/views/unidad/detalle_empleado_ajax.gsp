<div style="position: absolute;width: 200px;top: -50px;right: 0px">
    <g:if test="${empleado.foto}">
        <img src="${g.resource(file: empleado.foto)}" width="200px"/>
    </g:if>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Nombre</label>
    </div>
    <div class="col-md-9">
        ${empleado.nombre}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Apellido</label>
    </div>
    <div class="col-md-9">
        ${empleado.apellido}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Cédula</label>
    </div>
    <div class="col-md-9">
        ${empleado.cedula}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>F. Nacimiento</label>
    </div>
    <div class="col-md-9">
        ${empleado.fechaNacimiento?.format("dd-MM-yyyy")}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Estado civil</label>
    </div>
    <div class="col-md-9">
        ${empleado.estadoCivil.descripcion}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Email</label>
    </div>
    <div class="col-md-9">
        ${empleado.email}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Teléfono</label>
    </div>
    <div class="col-md-9">
        ${empleado.telefono}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Ingreso</label>
    </div>
    <div class="col-md-9">
        ${empleado.registro?.format("dd-MM-yyyy")}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Cargo</label>
    </div>
    <div class="col-md-9">
        ${empleado.cargo}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Hoja de vida</label>
    </div>
    <div class="col-md-9">
        <g:if test="${empleado.path}">
            <a href="#" data-file="${empleado.path}"
               data-ref="Capacitación"
               data-codigo=""
               data-tipo="Capacitación"
               target="_blank" class="btn btn-info ver-doc btn-sm" title="${empleado.path}" >
                <i class="fa fa-search"></i> Ver
            </a>
        </g:if>
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Sueldo</label>
    </div>
    <div class="col-md-9">
        <g:formatNumber number="${sueldo?.sueldo}" type="currency"/>
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Sistama de facturación</label>
    </div>
    <div class="col-md-1">
        <g:if test="${empleado.sistemaDeFacturacion=='S'}">
            Sí
        </g:if>
        <g:else>
            No
        </g:else>
    </div>
    <div class="col-md-2">
        <a href="#" class="btn btn-info btn-sm" iden="${empleado.id}" id="cambiar">
            <i class="fa fa-refresh"></i> Cambiar
        </a>
    </div>
</div>
<div class="row fila">
    <div class="col-md-2">
        <g:link controller="rubros" action="rubrosEmpleado" id="${empleado.id}" class="btn btn-verde btn-sm" style="width: 100%">
            <i class="fa fa-list"></i> Rubros
        </g:link>
    </div>
    <div class="col-md-2">
        <g:link controller="horasExtra" action="index" params="${['empleado':empleado.id]}" class="btn btn-verde btn-sm">
            <i class="fa fa-clock-o"></i> Horas extra
        </g:link>
    </div>
    <div class="col-md-2">
        <g:link controller="rol" action="index" params="${['empleado':empleado.id]}" class="btn btn-verde btn-sm">
            <i class="fa fa-print"></i> Rol de pagos
        </g:link>
    </div>
    <div class="col-md-2">
        <g:link controller="prestamo" action="index" params="${['empleado':empleado.id]}" class="btn btn-verde btn-sm">
            <i class="fa fa-money"></i> Prestamos
        </g:link>
    </div>
    <div class="col-md-3">
        <g:link controller="previsionGastos" action="index" params="${['empleado':empleado.id]}" class="btn btn-verde btn-sm">
            <i class="fa fa-usd"></i> Impuesto a la renta
        </g:link>
    </div>
</div>
<script>

    $(".ver-doc").click(function(){
        showPdf($(this))
        return false
    })
    $("#cambiar").click(function(){
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'unidad', action:'cambiarFac_ajax')}",
            data: {
                id: "${empleado.id}"
            },
            success: function (msg) {
                $("#detalle").html(msg)
            }});
        return false
    })

</script>