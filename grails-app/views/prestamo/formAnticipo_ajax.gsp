<g:form class="frm" action="saveAnticipo_ajax">
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
            <g:textField name="monto" id="monto" value="${(sueldo?.sueldo*0.35).toDouble().round(2)}" max="${(sueldo?.sueldo*0.35).toDouble().round(2)}" min="0" class="monto  number form-control   required" required="" style="text-align: right"/>
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
        var msg =""
        if(isNaN(valor)){
            msg+="El monto debe ser un número<br\>"
        }else{
            if(valor>$("#monto").attr("max")*1){
                msg+="El monto del anticipo no puede superar el 35% de la remuneración del empleado"
            }
        }
        if(msg==""){
            $(".frm").submit()
        }else{
            bootbox.alert(msg)
        }

    })
</script>