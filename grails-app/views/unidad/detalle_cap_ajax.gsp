<div class="row fila">
    <div class="col-md-3">
        <label>Título</label>
    </div>
    <div class="col-md-9">
        ${cap.titulo}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Institución</label>
    </div>
    <div class="col-md-9">
        ${cap.institucion}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Tipo</label>
    </div>
    <div class="col-md-9">
        ${cap.tipo.descripcion}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Inicio</label>
    </div>
    <div class="col-md-9">
        ${cap.fin?.format("dd-MM-yyyy")}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Fin</label>
    </div>
    <div class="col-md-9">
        ${cap.fin?.format("dd-MM-yyyy")}
    </div>
</div>
<div class="row fila">
    <div class="col-md-3">
        <label>Archivo</label>
    </div>
    <div class="col-md-9">

            <a href="#" data-file="${cap.path}"
               data-ref="Capacitación"
               data-codigo=""
               data-tipo="Capacitación"
               target="_blank" class="btn btn-info ver-doc btn-sm" title="${cap.path}" >
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