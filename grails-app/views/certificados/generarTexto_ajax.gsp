<g:form action="imprimeCertificado" class="frm">
    <input type="hidden" name="id" value="${empleado.id}">
    <textarea id="texto" name="text" class="form-control input-sm" style="height: 400px;overflow: auto;text-align: justify">
Quito, ${new java.util.Date().format("dd-MM-yyyy")}

Petróleos y servicios

Certifica

Que ${empleado.sexo=="M"?"el señor":"la señora"} ${empleado}, identificado con cédula de identidad N° ${empleado.cedula},ha laborado en nuestra empresa como ${empleado.cargo}, durante el periodo comprendido desde el ${empleado.registro.format('dd-MM-yyyy')} hasta ${sueldo.fin?sueldo.fin.format('dd-MM-yyyy'):' la actualidad'}, con un sueldo de ${g.formatNumber(number:  sueldo.sueldo,type: 'currency')} dólares americanos.


    </textarea>
</g:form>
<div class="row fila">
    <div class="col-md-1">
        <a href="#" class="btn btn-verde input-sm" id="print">
            <i class="fa fa-print"></i> Imprimir
        </a>
    </div>
</div>
<script>
    $("#print").click(function(){
        $(".frm").submit()
    });

</script>