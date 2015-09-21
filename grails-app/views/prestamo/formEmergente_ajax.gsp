<g:form class="frm" action="saveEmergente_ajax">
    <div class="row fila">
        <div class="col-md-1">
            <label>Empleado</label>
        </div>
        <div class="col-md-3">
            <input type="text" class="form-control input-sm" value="${empleado}" disabled>
        </div>
        <div class="col-md-2">
            <label>Tipo de prestamo</label>
        </div>
        <div class="col-md-3">
            <input type="text" class="form-control input-sm" value="${tipo}" disabled>
        </div>
        <div class="col-md-1">
            <label>Remuneración</label>
        </div>
        <div class="col-md-2">
            <input type="text" class="form-control input-sm" value="${sueldo.sueldo}" style="text-align: right" disabled>
        </div>
    </div>
    <div class="row fila">
        <div class="col-md-1">
            <label>Monto:</label>
        </div>
        <div class="col-md-3">
            <g:textField name="monto" id="monto" value="${sueldo?.sueldo}" max="${sueldo.sueldo}" min="0" class="monto  number form-control   required" required="" style="text-align: right"/>
        </div>
        <div class="col-md-1">
            <label>Plazo:</label>
        </div>
        <div class="col-md-2">
            <div class="input-group">
                <g:textField name="plazo" id="plazo" value="4" max="4" class="monto digits form-control  required" required="" style="text-align: right" aria-describedby="basic-addon2"/>
                <span class="input-group-addon" id="basic-addon2">Meses</span>
            </div>

        </div>

        <div class="col-md-2">
            <a href="#" class="btn btn-verde btn-sm" id="guardar">
                <i class="fa fa-send"></i> Enivar solicitud
            </a>
        </div>
    </div>
</g:form>
<script>
    $("#guardar").click(function(){
        var valor = $("#monto").val()*1
        var plazo = $("#plazo").val()*1
        var msg =""
        if(isNaN(valor)){
            msg+="El monto debe ser un número<br/>"
        }else{
            if(valor>$("#monto").attr("max")*1){
                msg+="El monto del anticipo no puede superar la remuneración del empleado<br/>"
            }
        }
        if(isNaN(plazo)){
            msg+="El plazo debe ser un número<br\>"
        }else{
            if(plazo>$("#plazo").attr("max")*1){
                msg+="El plazo no puede ser mayor a cuatro meses<br/>"
            }
        }
        if(msg==""){
            $(".frm").submit()
        }else{
            bootbox.alert(msg)
        }

    })
</script>