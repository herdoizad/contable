<div class="row fila">
    <div class="col-md-3">
        <label>Nombre</label>
    </div>
    <div class="col-md-9">
        ${carga.nombre}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Apellido</label>
    </div>
    <div class="col-md-9">
        ${carga.apellido}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Cédula</label>
    </div>
    <div class="col-md-9">
        ${carga.cedula}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Relación</label>
    </div>
    <div class="col-md-9">
        ${carga.relacion.descripcion}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Email</label>
    </div>
    <div class="col-md-9">
        ${carga.email}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Teléfono</label>
    </div>
    <div class="col-md-9">
        ${carga.telefono}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>F. Nacimiento</label>
    </div>
    <div class="col-md-9">
        ${carga.fechaNacimiento?.format("dd-MM-yyyy")}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Fin</label>
    </div>
    <div class="col-md-9">
        ${carga.fin?.format("dd-MM-yyyy")}
    </div>
</div>