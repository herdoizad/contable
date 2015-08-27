<imp:js src="${resource(dir: 'js', file: 'funciones.js')}"/>
<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>
<g:if test="${roles.size()==0}">
    <div class="row fila">
        <div class="col-md-4">
            <label>No existen roles de pagos para el periodo seleccionado</label>
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-verde btn-sm" id="generar"><i class="fa fa-copy"></i> Generar rol de pagos</a>
        </div>
    </div>
</g:if>
<g:else>
    <div  class="row" style="margin-bottom: 10px;margin-top: -10px">
        <div class="col-md-1">
            <a href="#" class="btn btn-success btn-sm " id="aprobar" empleado="${emp}" mes="${mes.id}">
                <i class="fa fa-check"></i> Aprobar
            </a>
        </div>
        <div class="col-md-1">
            <a href="#" class="btn btn-default btn-sm " id="mail" empleado="${emp}" mes="${mes.id}">
                <i class="fa fa-envelope"></i> Enivar
            </a>
        </div>
        <div class="col-md-1">
            <a href="${g.createLink(action: 'reporte',controller: 'reporteRol',id: mes.id)}" class="btn btn-default btn-sm " id="reporte" empleado="${emp}" mes="${mes.id}">
                <i class="fa fa-print"></i> Imprimir
            </a>
        </div>
    </div>
</g:else>

<g:each in="${roles}" var="r">
    <div class="panel ${r.estado!='A'?'panel-default':'panel-success'}" style="position: relative">
        <i class="fa fa-print print"  style="position: absolute;top: 5px;right: 5px;color: #ffffff;cursor: pointer" rol="${r.id}"></i>
        <div class="panel-heading " style="font-size: 10px;line-height: 10px;padding: 5px">
            ${r?.empleado}

        </div>
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
                <g:if test="${r.estado=='N'}">
                    <tr>
                        <td>
                            <input type="text" class="form-control input-sm  n-desc-${r.id}"  maxlength="150" placeholder="Descripción">
                        </td>
                        <td style="width: 90px">
                            <g:select name="tipo" from="${tipos}" class="form-control input-sm n-tipo-${r.id}" optionValue="value" optionKey="key"/>
                        </td>
                        <td>
                            <input type="text" style="text-align: right" class="form-control input-sm  number n-valor-${r.id}"  maxlength="150" placeholder="Valor">
                        </td>
                        <td style="text-align: center">
                            <a href="#" class="btn btn-info btn-xs nuevo " title="Agregar" iden="${r.id}" >
                                <i class="fa fa-plus"></i>
                            </a>
                        </td>
                        <td></td>
                    </tr>
                </g:if>
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

    $(".print").click(function(){
      location.href="${g.createLink(controller: 'reporteRol',action: 'reporteRol')}/"+$(this).attr("rol")
    })
    $("#generar").click(function(){
        var div = $($("#activo").val())
        bootbox.confirm("Está seguro?",function(result){
            if(result){
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'rol', action:'generarRol_ajax')}",
                    data: "mes=${mes.id}&empleado=${emp}",
                    success: function (msg) {
                        closeLoader()
                        div.html(msg)
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
            msg+="Ingrese la descripción del rubro<br/>"
        }
        if(isNaN(valor)){
            msg+="Ingrese un valor valido<br/>"
        }else{
            valor=valor*1
            if(valor<=0)
                msg+="El valor debe ser un número positivo<br/>"
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
    $(".nuevo").click(function(){
        var div = $($("#activo").val())
        var id = $(this).attr("iden")
        var valor = $(".n-valor-"+id).val()
        var desc = $(".n-desc-"+id).val()
        var tipo = $(".n-tipo-"+id).val()
        var msg =""
        if(desc==""){
            msg+="Ingrese la descripción del rubro<br/>"
        }
        if(isNaN(valor)){
            msg+="Ingrese un valor valido<br/>"
        }else{
            valor=valor*1
            if(valor<=0)
                msg+="El valor debe ser un número positivo<br/>"
        }
        if(msg==""){
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'rol', action:'addRubro_ajax')}",
                data: "id="+id+"&valor="+valor+"&desc="+desc+"&tipo="+tipo,
                success: function (msg) {
                    closeLoader()
                    div.html(msg)
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

    $("#aprobar").click(function(){
        var btn =$(this)
        var div = $($("#activo").val())
        bootbox.confirm("Está seguro? está acción no puede revertirse",function(result){
            if(result){
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'rol', action:'aprobarRoles_ajax')}",
                    data: "mes="+btn.attr("mes")+"&empleado="+btn.attr("empleado"),
                    success: function (msg) {
                        closeLoader()
                        div.html(msg)
                    } //success
                }); //ajax
            }
        })

    })
    $("#mail").click(function(){
        var btn =$(this)
        bootbox.confirm("Está seguro?",function(result){
            if(result){
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'rol', action:'enviarEmails_ajax')}",
                    data: "mes="+btn.attr("mes")+"&empleado="+btn.attr("empleado"),
                    success: function (msg) {
                        closeLoader()
                        log("Email enviados","success")
                    } //success
                }); //ajax
            }
        })
        return false

    })
</script>