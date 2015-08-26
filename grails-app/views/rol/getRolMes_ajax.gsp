<imp:js src="${resource(dir: 'js', file: 'funciones.js')}"/>
<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>
<g:if test="${roles.size()==0}">
    <div class="row fila">
        <div class="col-md-4">
            <label>No existen roles de pagos para el periodo seleccionado</label>
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-verde" id="generar"><i class="fa fa-copy"></i> Generar rol de pagos</a>
        </div>
    </div>
</g:if>

<g:each in="${roles}" var="r">
    <div class="panel panel-default" >
        <div class="panel-heading " style="font-size: 10px;line-height: 10px;padding: 5px">${r?.empleado}</div>
        <div class="panel-body" style="padding-bottom: 0px">
            <table class="table table-sm table-darkblue" style="margin-bottom: 0px">
                <thead>
                <tr>
                    <th>Rubro</th>
                    <th>Tipo</th>
                    <th style="width: 150px">Valor</th>
                    <th style="width: 40px"></th>
                    <th style="width: 40px"></th>
                </tr>
                </thead>
                <tbody>
                <g:set var="total" value="${0}"></g:set>
                <g:each in="${contable.nomina.DetalleRol.findAllByRol(r,[sort:'signo'])}" var="d">
                    <tr>
                        <g:set var="total" value="${total+(d.signo*d.valor)}"></g:set>
                        <td>
                            <g:if test="${r.estado=='N'}">
                                <input type="text" class="form-control input-sm  desc-${d.id}"  maxlength="150" value="${d.descripcion}" id="desc_${d.id}">
                            </g:if>
                            <g:else>
                                ${d.descripcion}
                            </g:else>

                        </td>
                        <td style="text-align: center">
                            ${d.signo==1?'Ingreso':'Egreso'}
                        </td>
                        <td style="text-align: right">
                            <g:if test="${r.estado=='N'}">
                                <input type="text" style="text-align: right" signo="${d.signo}"  value="${d.valor}"
                                       class="form-control input-sm number valor-${d.id} dt-${r.id}" rol="${r.id}" id="valor_${r.id}">
                            </g:if>
                            <g:else>
                                <g:formatNumber number="${d.valor}" type="currency" currencySymbol="" />
                            </g:else>
                        </td>
                        <td style="text-align: center">
                            <g:if test="${r.estado=='N'}">
                                <a href="#" class="btn btn-info btn-xs guardar" title="Guardar" iden="${d.id}" >
                                    <i class="fa fa-save"></i>
                                </a>
                            </g:if>
                        </td>
                        <td style="text-align: center">
                            <g:if test="${r.estado=='N'}">
                                <a href="#" class="btn btn-danger btn-xs borrar" title="Borrar" iden="${d.id}">
                                    <i class="fa fa-trash"></i>
                                </a>
                            </g:if>
                        </td>
                    </tr>
                </g:each>
                <tr>
                    <td colspan="2" style="text-align: right">
                        <label>Total a recibir</label>
                    </td>
                    <td style="text-align: right;font-weight: bold"  class="total-${r.id}">
                        <g:formatNumber number="${total}" type="currency" currencySymbol="" />
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</g:each>
<script>
    function  calculaTotales(id){
        var total = 0
        $(".dt-"+id).each(function(){
            total+=$(this).val()*1*$(this).attr("signo")*1
        })
        $(".total-"+id).html(number_format(total,2,".",","))

    }
    $("#generar").click(function(){
        bootbox.confirm("Está seguro?",function(result){
            if(result){
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'rol', action:'generarRol_ajax')}",
                    data: "mes=${mes.id}&empleado=${emp}",
                    success: function (msg) {
                        closeLoader()
                        $("#detalle").html(msg)
                    } //success
                }); //ajax
            }
        })

    });
    $(".panel-heading").css({cursor:"pointer"}).click(function(){
        $(this).parent().find(".panel-body").toggle()
    })
    $(".guardar").click(function(){
        var id = $(this).attr("iden")
        var rol = $(".valor-"+id).attr("rol")
        var valor = $(".valor-"+id).val()
        var desc = $(".desc-"+id).val()
        var msg =""
        if(desc==""){
            msg="Ingrese la descripción del rubro"
        }
        if(isNaN(valor)){
            msg="Ingrese un valor valido<br\>"
        }else{
            valor=valor*1
            if(valor<=0)
                msg="El valor debe ser un número positivo<br\>"
        }
        if(msg==""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rol', action:'updateRubro_ajax')}",
                data: "id="+id+"&valor="+valor+"&desc="+desc,
                success: function (msg) {
                    closeLoader()
                    calculaTotales(rol)
                    log("Datos guardados","success")
                } //success
            }); //ajax
        }else{
            bootbox.alert(msg)
        }
        return false
    })
    $(".borrar").click(function(){
        var btn = $(this)
        var id = $(this).attr("iden")
        var rol = $(".valor-"+id).attr("rol")
        bootbox.confirm("Está seguro?",function(result){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rol', action:'deleteRubro_ajax')}",
                data: "id="+id,
                success: function (msg) {
                    btn.parent().parent().remove()
                    closeLoader()
                    calculaTotales(rol)
                    log("Datos borrados","danger")
                } //success
            }); //ajax
        })
    })
</script>