<table class="table table-bordered table-striped table-darkblue table-hover table-condensed">
    <thead>
    <tr>
        <th>#</th>
        <th>Cuenta</th>
        <th>Descripción</th>
        <th>Tipo</th>
        <th>Valor</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${detalle}" var="d">
        <tr>
            <td>${d.secuencial}</td>
            <td>${d.cuenta.numero}</td>
            <td>${d.descripcion}</td>
            <td style="text-align: center">${d.signo==1?'Debe':'Haber'}</td>
            <td style="text-align: right">${d.valor}</td>
            <td style="text-align: center;width: 40px">
                <a href="#" class="borrar btn btn-sm btn-danger" iden="${d.codigo}" sec="${d.secuencial}">
                    <i class="fa fa-trash"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
<script>
    $(".borrar").click(function(){
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'prototipo', action:'borraCuenta_ajax')}",
            data: {
                id:$(this).attr("iden"),
                secuencial:$(this).attr("sec")
            },
            success: function (msg) {
                closeLoader()
                $("#row-detalle").show()
                $("#detalle").html(msg)

            } //success
        }); //ajax
    })
</script>