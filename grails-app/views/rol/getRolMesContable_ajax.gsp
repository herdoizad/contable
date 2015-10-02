<imp:js src="${resource(dir: 'js', file: 'funciones.js')}"/>
<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>
<g:if test="${roles.size()==0}">
    <div class="row fila">
        <div class="col-md-4">
            <label>No existen roles de pagos para el periodo seleccionado</label>
        </div>
    </div>
</g:if>
<g:else>
    <g:if test="${roles[0].estado!='C'}">
        <div  class="row" style="margin-bottom: 10px;margin-top: -10px">
            <div class="col-md-1">
                <a href="#" class="btn btn-success btn-sm " id="aprobar"  mes="${mes.id}">
                    <i class="fa fa-check"></i> Aprobar
                </a>
            </div>
        </div>
    </g:if>
</g:else>
<table class="table table-darkblue table-bordered table-hover table-condensed table-sm">
    <thead>
    <tr>
        <th>Mes</th>
        <th>Estado</th>
        <th>Empleado</th>
        <th>Ingresos</th>
        <th>Egresos</th>
        <th>Total a recibir</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:set var="ti" value="${0}"/>
    <g:set var="te" value="${0}"/>
    <g:each in="${roles}" var="r">
        <g:set var="ti" value="${ti+r.totalIngresos}"/>
        <g:set var="te" value="${te+r.totalEgresos}"/>
        <tr>
            <td>${r.mes.descripcion}</td>
            <td>${r.estado=='A'?'Pendiente':'Aprobado'}</td>
            <td>${r.empleado}</td>
            <td style="text-align: right"><g:formatNumber number="${r.totalIngresos}" type="currency" currencySymbol="\$"/></td>
            <td style="text-align: right"><g:formatNumber number="${r.totalEgresos}" type="currency" currencySymbol="\$"/></td>
            <td style="text-align: right"><g:formatNumber number="${r.totalIngresos-r.totalEgresos}" type="currency" currencySymbol="\$"/></td>
            <td style="text-align: center">
                <a href="#" class="btn-xsm btn-info btn ver" rol="${r.id}"> <i class="fa fa-list"></i></a>
            </td>
        </tr>
    </g:each>
    </tbody>
    <tfoot>
    <tr>
        <td style="text-align: right;font-weight: bold" colspan="2">Total</td>
        <td style="text-align: right;font-weight: bold"><g:formatNumber number="${ti}" type="currency" currencySymbol="\$"/></td>
        <td style="text-align: right;font-weight: bold"><g:formatNumber number="${te}" type="currency" currencySymbol="\$"/></td>
        <td style="text-align: right;font-weight: bold"><g:formatNumber number="${ti-te}" type="currency" currencySymbol="\$"/></td>
    </tr>
    </tfoot>
</table>

<script>
    $(".ver").click(function(){
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'rol', action:'detalleRol_ajax')}",
            data: "rol="+$(this).attr("rol"),
            success: function (msg) {
                closeLoader()
                var b = bootbox.dialog({
                    id      : "dlgDetalle",
                    title   : "Datalle del rol",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cerrar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    $("#aprobar").click(function(){
        var btn =$(this)
        var div = $($("#activo").val())
        bootbox.confirm("Está seguro? está acción no puede revertirse",function(result){
            if(result){
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'rol', action:'aprobarContable_ajax')}",
                    data: "mes="+btn.attr("mes"),
                    success: function (msg) {
                        closeLoader()
                        div.html(msg)
                    } //success
                }); //ajax
            }
        })

    })
</script>