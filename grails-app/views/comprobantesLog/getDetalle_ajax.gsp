<table class="table table-sm table-bordered table-hover">
    <thead>
    <tr>
        <th colspan="8"></th>
        <th colspan="2">Valor</th>
        <th></th>
    </tr>
    <tr>
        <th>#</th>
        <th>Fecha</th>
        <th>Usuario</th>
        <th>Operación</th>
        <th>Mes</th>
        <th>Tipo</th>
        <th>Número</th>
        <th>Cuenta</th>
        <th>Editado</th>
        <th>Nuevo</th>
        <th></th>
    </tr>
    </thead>
    <tb>
        <g:each in="${datos}" var="d" status="i">
            <tr class="row-info">
                <td style="text-align: center;width: 40px">${i+1}</td>
                <td style="width: 150px ;text-align: center">${d['fecha'].format("dd-MM-yyyy HH:mm:ss")}</td>
                <td style="width: 150px ;text-align: center">${d['usuario']}</td>
                <td style="text-align: center">${d['operacion']=='U'?'Edición':'Eliminación'}</td>
                <td style="text-align: center" >${d['mes']}</td>
                <td  style="text-align: center">${tipos[d['tipo']]}</td>
                <td  style="text-align: right">${d['numero']}</td>
                <td  style="text-align: right">${d['cuenta']}</td>
                <td style="text-align: right"><g:formatNumber number="${d['valorO']}" type="currency" currencySymbol=""/></td>
                <td style="text-align: right"><g:formatNumber number="${d['valorN']}" type="currency" currencySymbol=""/></td>
                <td style="width: 30px;text-align: center">
                    <a href="#" class="btn btn-xs btn-verde ver" numero="${d['numero']}" tipo="${d['tipo']}" mes="${d['mes']}">
                        <i class="fa fa-search"></i>
                    </a>
                </td>
            </tr>
        </g:each>
    </tb>
</table>
<script>
    $(".ver").click(function(){
//        openLoader()
        $(".row-info").removeClass("hg")
        $(this).parent().parent().addClass("hg")
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'comprobantes', action:'getDetalle_ajax')}",
            data: {
                mes: $(this).attr("mes"),
                tipo:$(this).attr("tipo"),
                empresa:'PS',
                numero:$(this).attr("numero")
            },
            success: function (msg) {
//                closeLoader()
                $("#info").html(msg)
            } //success
        }); //ajax
        return false
    })
</script>