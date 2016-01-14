<table class="table table-darkblue table-bordered table-hover table-striped table-sm">
    <thead>
    <tr>
        <th>Empresa</th>
        <th>Mes</th>
        <th>Tipo</th>
        <th>Número</th>
        <th>Fecha</th>
        <th>Concepto</th>
        <th></th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${comps}" var="c">
        <tr>
            <td>${c.empresa.codigo}</td>
            <td>${c.mes}</td>
            <td>${c.getTipoString()}</td>
            <td class="buscar">${g.formatNumber(number:  c.numero,maxFractionDigits: 0)}</td>
            <td class="buscar" style="text-align: center">${c.fecha.format("dd-MM-yyyy")}</td>
            <td class="buscar">${c.concepto}</td>
            <td style="text-align: center">
                <a href="#" class="btn btn-info btn-xsm ver ${mes}-${g.formatNumber(number:  c.numero,maxFractionDigits: 0)}" title="Ver" mes="${c.mes}" empresa="${c.empresa.codigo}" tipo="${c.tipo}" proc="${c.tipoProcesamiento}" numero="${c.numero}">
                    <i class="fa fa-search"></i>
                </a>
            </td>
            <td style="text-align: center">
                <!--Controla NULL en estado-->
                <g:if test="${mesObj?.estado!='C' && editable!='N'}">
                    <g:if test="${c.tipo==3}">
                        <g:if test="${c.tipoProcesamiento!=4}">
                            <a href="${g.createLink(controller: 'comprobantes',action: 'nuevo',params: [mes:c.mes,tipo:c.tipo,numero:c.numero])}" class="btn btn-info btn-xsm editar ${mes}-${g.formatNumber(number:  c.numero,maxFractionDigits: 0)}" title="Editar" mes="${c.mes}" empresa="${c.empresa.codigo}" tipo="${c.tipo}" numero="${c.numero}">
                                <i class="fa fa-pencil"></i>
                            </a>
                        </g:if>
                    </g:if>
                    <g:if test="${c.tipo==1}">
                        <a href="${g.createLink(controller: 'comprobantes',action: 'nuevoIngreso',params: [mes:c.mes,tipo:c.tipo,numero:c.numero])}" class="btn btn-info btn-xsm editar ${mes}-${g.formatNumber(number:  c.numero,maxFractionDigits: 0)}" title="Editar" mes="${c.mes}" empresa="${c.empresa.codigo}" tipo="${c.tipo}" numero="${c.numero}">
                            <i class="fa fa-pencil"></i>
                        </a>
                    </g:if>

                </g:if>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
<script type="text/javascript">

    function verComp(mes,numero){
        var btn = $("."+mes+"-"+numero)
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'comprobantes', action:'getDetalle_ajax')}",
            data: {
                mes: btn.attr("mes"),
                tipo:btn.attr("tipo"),
                empresa:btn.attr("empresa"),
                numero:btn.attr("numero")
            },
            success: function (msg) {
                closeLoader()

                var b = bootbox.dialog({
                    id: "dlgDetalles",
                    message: msg,

                    buttons: {
                        anular:{
                            label:"Anular",
                            className: "btn-danger btn-sm",
                            callback: function () {
                                var c =  bootbox.confirm("Está seguro?. Si decide continuar los movientos contables del comprobante serán actualizados a 0",function(result){
                                    if(result){
                                        openLoader()
                                        $.ajax({
                                            type: "POST",
                                            url: "${createLink(controller:'comprobantes', action:'anular_ajax')}",
                                            data: {
                                                mes: $("#mes").val(),
                                                tipo:$("#tipo").val(),
                                                empresa:$("#empresa").val(),
                                                numero:$("#numero").val()
                                            },
                                            success: function (msg) {
                                                closeLoader()
                                                if(msg=="ok"){
                                                    var d =  bootbox.alert("Comprobante anulado")
                                                    b.modal("hide")
                                                    $("#contenedor").append(d)
                                                }else{
                                                    var d = bootbox.alert("Error al anular el comprobante")
                                                    b.modal("hide")
                                                    $("#contenedor").append(d)
                                                }
                                            } //success
                                        }); //ajax
                                    }
                                })
                                $("#contenedor").append(c)
                                return false;
                            }

                        },
                        imprimir:{
                            label:"Imprimir",
                            className: "btn-info btn-sm",
                            callback: function () {
                                openLoader()
                                location.href="${g.createLink(controller: 'reportesComprobantes',action:'imprimeComprobante')}?empresa="+$("#empresa").val()+"&mes="+$("#mes").val()+"&numero="+$("#numero").val()+"&tipo="+$("#tipo").val()
                                closeLoader()
                            }
                        },
                        cerrar: {
                            label: "Cerrar",
                            className: "btn-default btn-sm",
                            callback: function () {

                            }
                        }

                    } //buttons
                }); //dialog
                $("#contenedor").append(b)

            } //success
        }); //ajax
    }


    $(".ver").click(function(){
        if($(this).attr("tipo")=="2" || $(this).attr("proc")=="4"){
            location.href="${g.createLink(controller: 'comprobantes',action: 'showEgreso')}/?mes="+$(this).attr("mes")+"&tipo="+$(this).attr("tipo")+"&numero="+$(this).attr("numero")
        }else{
            openLoader()
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'comprobantes', action:'getDetalle_ajax')}",
                data: {
                    mes: $(this).attr("mes"),
                    tipo:$(this).attr("tipo"),
                    empresa:$(this).attr("empresa"),
                    numero:$(this).attr("numero")
                },
                success: function (msg) {
                    closeLoader()

                    var b = bootbox.dialog({
                        id: "dlgDetalles",
                        message: msg,

                        buttons: {
                            <g:if test="${mesObj?.estado!='C'}">
                            anular:{
                                label:"Anular",
                                className: "btn-danger btn-sm",
                                callback: function () {
                                    var c =  bootbox.confirm("Está seguro?. Si decide continuar los movientos contables del comprobante serán actualizados a 0",function(result){
                                        if(result){
                                            openLoader()
                                            $.ajax({
                                                type: "POST",
                                                url: "${createLink(controller:'comprobantes', action:'anular_ajax')}",
                                                data: {
                                                    mes: $("#mes").val(),
                                                    tipo:$("#tipo").val(),
                                                    empresa:$("#empresa").val(),
                                                    numero:$("#numero").val()
                                                },
                                                success: function (msg) {
                                                    closeLoader()
                                                    if(msg=="ok"){
                                                        var d =  bootbox.alert("Comprobante anulado")
                                                        b.modal("hide")
                                                        $("#contenedor").append(d)
                                                    }else{
                                                        var d = bootbox.alert("Error al anular el comprobante")
                                                        b.modal("hide")
                                                        $("#contenedor").append(d)
                                                    }
                                                } //success
                                            }); //ajax
                                        }
                                    })
                                    $("#contenedor").append(c)
                                    closeLoader()
                                    return false;
                                }

                            },
                            </g:if>
                            imprimir:{
                                label:"Imprimir",
                                className: "btn-info btn-sm",
                                callback: function () {
                                    openLoader()
                                    location.href="${g.createLink(controller: 'reportesComprobantes',action:'imprimeComprobante')}?empresa="+$("#empresa").val()+"&mes="+$("#mes").val()+"&numero="+$("#numero").val()+"&tipo="+$("#tipo").val()
                                    closeLoader()
                                }
                            },
                            cerrar: {
                                label: "Cerrar",
                                className: "btn-default btn-sm",
                                callback: function () {
                                    b.remove()
                                }
                            }

                        } //buttons
                    }); //dialog
                    $("#contenedor").append(b)

                } //success
            }); //ajax
        }

        return false
    })

    <g:if test="${numero && numero!=''}">
    verComp('${mes}',${numero})
    </g:if>

    $(".editar").click(function(){
        var boton = $(this)
        bootbox.confirm("Está seguro?. Al editar un comprobante se enviará un correo electronico  a auditoría con los cambios realizados.",function(result){
            if(result){
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'comprobantes', action:'enviarCorreo_ajax')}",
                    data: {
                        mes: boton.attr("mes"),
                        tipo: boton.attr("tipo"),
                        empresa: boton.attr("empresa"),
                        numero: boton.attr("numero")
                    },
                    success: function (msg) {
                        closeLoader()
                        location.href=boton.attr("href")
                    }
                });
            }
        })
        return false
    })

</script>