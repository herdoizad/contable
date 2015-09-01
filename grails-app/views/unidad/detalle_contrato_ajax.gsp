<div class="row fila">
    <div class="col-md-3">
        <label>Número</label>
    </div>
    <div class="col-md-9">
        ${con.numero}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Tipo</label>
    </div>
    <div class="col-md-9">
        ${con.tipo.descripcion}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Inicio</label>
    </div>
    <div class="col-md-9">
        ${con.inicio?.format("dd-MM-yyyy")}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Fin</label>
    </div>
    <div class="col-md-9">
        ${con.fin?.format("dd-MM-yyyy")}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Archivo</label>
    </div>
    <div class="col-md-9">

            <a href="#" data-file="${con.path}"
               data-ref="Capacitación"
               data-codigo=""
               data-tipo="Capacitación"
               target="_blank" class="btn btn-info ver-doc btn-sm" title="${con.path}" >
                <i class="fa fa-search"></i> Ver
            </a>

    </div>
</div>
<script>

    $(".ver-doc").click(function(){
        showPdf($(this))
        return false
    })

</script>