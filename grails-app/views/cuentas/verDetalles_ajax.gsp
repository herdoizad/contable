<div class="row">
    <div class="col-md-3">
        <label>Numero</label>
    </div>
    <div class="col-md-9">
        ${cuenta.numero}
    </div>
</div>
<div class="row">
    <div class="col-md-3">
        <label>Descripción</label>
    </div>
    <div class="col-md-9">
        ${cuenta.descripcion}
    </div>
</div>
<div class="row">
    <div class="col-md-3">
        <label>Padre</label>
    </div>
    <div class="col-md-9">
        ${cuenta.padre}
    </div>
</div>
<div class="row">
    <div class="col-md-3">
        <label>Clase</label>
    </div>
    <div class="col-md-9">
        ${cuenta.getClaseString()}
    </div>
</div>
<div class="row">
    <div class="col-md-3">
        <label>Movimiento</label>
    </div>
    <div class="col-md-9">
        ${cuenta.agrupa==1?"Si":"No"}
    </div>
</div>
<div class="row">
    <div class="col-md-3">
        <label>Nivel</label>
    </div>
    <div class="col-md-9">
        ${cuenta.nivel}
    </div>
</div>