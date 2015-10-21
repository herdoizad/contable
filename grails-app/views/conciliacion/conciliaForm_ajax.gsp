<g:form action="saveConciliaForm_ajax" class="frm">
    <div class="row fila">
        <div class="col-md-2">
            <label>Factura</label>
        </div>
        <div class="col-md-4">
            <input type="hidden" name="numero" value="${fact}">
            <input type="hidden" name="fechaLista" value="${fechaLista}">
            <input type="text" disabled value="${fact}" class="form-control input-sm">
        </div>
    </div>
    <div class="row fila">
        <div class="col-md-2">
            <label>Acreditación</label>
        </div>
        <div class="col-md-4">
            <elm:datepicker name="fechaNuevo" value="${new java.util.Date()}" class="form-control input-sm"/>
        </div>
    </div>
    <div class="row fila">
        <div class="col-md-2">
            <label>Banco</label>
        </div>
        <div class="col-md-4">
            <g:select name="banco" from="${bancos}"  id="banco_nuevo" optionKey="conciliaBanco"
                      optionValue="descripcion" class="form-control input-sm"/>
        </div>
    </div>
</g:form>