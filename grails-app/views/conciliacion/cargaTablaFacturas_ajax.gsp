<div class="col-md-12" >
    <table class="table table-condensed table-hover table-darkblue table-sm table-bordered">
        <thead>
        <tr>
            <th>Número</th>
            <th>Cliente</th>
            <th>Fecha venta</th>
            <th>Valor</th>
            <th></th>
            <th></th>
            <th>Estado</th>
            <th>Acreditación</th>
            <th>Opción</th>
            <th>Banco</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${datos}" var="f">
            <tr class="${f['ESTADO_CONCILIACION']=='-1'?'conciliado':''}">
                <td>${f["NUMERO_FACTURA"]}</td>
                <td>${f["CODIGO_CLIENTE"]}</td>
                <td style="text-align: center">${f["FECHA_VENTA"].format("dd-MM-yyyy")}</td>
                <td style="text-align: right"><g:formatNumber number="${f['PAGO_FACTURA']}" type="currency" currencySymbol=""/></td>
                <td style="text-align: center">
                    <g:if test="${f['CODIGO_CONDICION']=='2'}">
                        <span style="color: red">Anulado</span>
                    </g:if>
                </td>
                <td style="text-align: center">
                    <g:if test="${f['ESTADO_CONCILIACION']!='-1' && f['CODIGO_CONDICION']!='2'}">
                        <a href="#" class="btn btn-verde btn-xsm nuevo" iden="${f['NUMERO_FACTURA']}">
                            <i class="fa fa-check"></i>
                        </a>
                    </g:if>
                </td>
                <g:if test="${datosCon[f['NUMERO_FACTURA']]}">
                    <td style="text-align: center">
                        ${datosCon[f["NUMERO_FACTURA"]]["ESTADO_CONCILIACION"]=='-1'?'Activo':''}
                    </td>
                %{--<td style="text-align: center">${datosCon[f["NUMERO_FACTURA"]]["FECHA_ACREDITACION"]?.format("dd-MM-yyyy")}</td>--}%
                    <td style="text-align: center;width: 120px !important;" >
                        <elm:datepicker name="fecha" id="fecha_${f['NUMERO_FACTURA']}" class="form-control input-sm"
                                        value="${datosCon[f['NUMERO_FACTURA']]['FECHA_ACREDITACION']}"/>

                    </td>
                    <td style="text-align: center">${datosCon[f["NUMERO_FACTURA"]]["OPCION_CONCILIACION"]?"BANCOS":""}</td>
                %{--<td style="text-align: center">${datosCon[f["NUMERO_FACTURA"]]["CONCILIA_BANCO"]}</td>--}%
                    <td style="text-align: center;width: 160px !important;">
                        <g:select name="banco" from="${bancos}"  id="banco_${f['NUMERO_FACTURA']}" optionKey="conciliaBanco"  value="${datosCon[f['NUMERO_FACTURA']]['CONCILIA_BANCO']}"
                                  optionValue="descripcion" class="form-control input-sm"/>
                    </td>
                    <td style="text-align: center">
                        <a href="#" iden="${f['NUMERO_FACTURA']}" title="Guardar" class="guardar btn btn-verde btn-sm">
                            <i class="fa fa-save"></i>
                        </a>
                    </td>
                </g:if>
                <g:else>
                    <td colspan="5"></td>
                </g:else>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<script>
    $(".nuevo").click(function(){
        var id = $(this).attr("iden")
        openLoader("");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'conciliaForm_ajax')}",
            data    : {
                numero:id,
                fechaLista:$("#facturas_input").val()
            },
            success : function (msg) {
                closeLoader()

                var b = bootbox.dialog({
                    id      : "dlgCreateEditBanco",
                    title   : "Conciliar",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                openLoader()
                                $.ajax({
                                    type    : "POST",
                                    url     : "${g.createLink(action: 'saveConciliaForm_ajax')}",
                                    data    : $(".frm").serialize(),
                                    success : function (msg) {
                                        closeLoader()
                                        $("#tabla-facturas").html("")
                                        $("#tabla-facturas").html(msg)
                                    },
                                    error: function() {
                                        log("Ha ocurrido un error interno", "Error");
                                        closeLoader();
                                    }
                                });
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");
                closeLoader();
            }
        });
        return false
    })

    $(".guardar").click(function(){
        var id = $(this).attr("iden")
        var fecha = $("#fecha_"+id).val()
        var banco = $("#banco_"+id).val()
        openLoader("");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'saveConcilia_ajax')}",
            data    : {
                numero:id,
                fecha:fecha,
                banco:banco,
                fechaLista:$("#facturas_input").val()
            },
            success : function (msg) {
                closeLoader()
                $("#tabla-facturas").html(msg)
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");
                closeLoader();
            }
        });
        return false
    });
</script>