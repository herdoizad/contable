<g:if test="${pagos.size()>0}">
    <table class="table table-bordered table-drakblue table-hover">
        <thead>
        <tr>
            <th>Empleado</th>
            <th>Tipo</th>
            <th>Monto</th>
            <th>Plazo</th>
            <th>Cuota</th>
            <th>Fecha de pago</th>
            <th>Taza</th>
            <th>Interes</th>
            <th>Pago</th>
            <th>Capital</th>
            <th>Saldo</th>
            <th></th>
            <th></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${pagos}" var="p">
            <tr>
                <td>${p.prestamo.empleado}</td>
                <td>${p.prestamo.tipo.descripcion}</td>
                <td style="text-align: right"> <g:formatNumber number="${p.prestamo.monto}" type="currency" currencySymbol="\$"/></td>
                <td style="text-align: right">${p.prestamo.plazo}</td>
                <td style="text-align: right"> <g:formatNumber number="${p.prestamo.valorCuota}" type="currency" currencySymbol="\$"/></td>
                <td style="text-align: center">${p.fechaDePago.format("dd-MM-yyyy")}</td>
                <td style="text-align: right">${p.taza}%</td>
                <td style="text-align: right">
                    <g:formatNumber number="${p.interes}" type="currency" currencySymbol="\$"/>
                </td>
                <td style="text-align: center;">
                    <g:if test="${p.estado!='A'}">
                        <input type="text" style="text-align: right;width: 80px"
                               class="form-control  input-sm pago number" id="cuota_${p.id}"
                               value="${p.cuota}" interes="${p.interes}"  iden="${p.id}" >
                    </g:if>
                    <g:else>
                        <g:formatNumber number="${p.cuota}" type="currency" currencySymbol="\$"/>
                    </g:else>
                </td>
                <td style="text-align: right;" id="capital_${p.id}">
                    <g:formatNumber number="${p.capital}" type="currency" currencySymbol=""/>
                </td>
                <td style="text-align: right" saldo="${p.saldo}" cuotaO="${p.cuota}" id="saldo_${p.id}">
                    <g:formatNumber number="${p.saldo}" type="currency" currencySymbol=""/>
                </td>
                <g:if test="${p.estado!='A'}">
                    <td style="text-align: center;width: 40px">
                        <a href="#" class="btn btn-info btn-sm guadar" iden="${p.id}" title="guardar" interes="${p.interes}">
                            <i class="fa fa-save"></i>
                        </a>
                    </td>
                    <td style="text-align: center;width: 40px">
                        <a href="#" class="btn btn-verde btn-sm aprobar"  iden="${p.id}"  title="aprobar" mes="${p.mes.id}" interes="${p.interes}">
                            <i class="fa fa-check"></i>
                        </a>
                    </td>
                    <td style="text-align: center;width: 40px">
                        <a href="#" class="btn btn-danger btn-sm borrar"  mes="${p.mes.id}" iden="${p.id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                </g:if>
                <g:else>
                    <td colspan="3" style="text-align: center">
                        Aprobado
                    </td>
                </g:else>
            </tr>
        </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    No hay pagos generado para el mes de ${mes.descripcion}.
    <a href="#" id="generar" style="margin-right: 15px" class="btn btn-verde btn-sm"><i class="fa fa-cog"></i> Generar</a>
</g:else>
<script type="text/javascript">
    $("#generar").click(function(){

        openLoader()
        var div = $($("#activo").val())
        $(".tab-pane").html("")
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'pagosPrestamos', action:'generarPagos_ajax')}",
            data: "mes=${mes.id}",
            success: function (msg) {
                closeLoader()
                div.html(msg)
            } //success
        }); //ajax
    })

    $(".pago").blur(function(){
        var min = $(this).attr("interes")*1
        var valor = $(this).val()
        var saldo = $("#saldo_"+$(this).attr("iden"))
        if(isNaN(valor))
            valor=0
        else
            valor=valor*1
        if(valor<min){
            bootbox.alert("El valor del pago no puede ser menor a "+min)
        }else{
            $("#capital_"+$(this).attr("iden")).html(number_format(valor-min,2,".",""))
            saldo.html(number_format(saldo.attr("saldo")*1-(valor-saldo.attr("cuotaO")*1),2,".",""))
            saldo.attr("saldo",saldo.attr("saldo")*1-(valor-saldo.attr("cuotaO")*1))
            saldo.attr("cuotaO",valor)
        }
    });

    $(".guadar").click(function(){
        var valor = $("#cuota_"+$(this).attr("iden")).val()
        var saldo = $("#saldo_"+$(this).attr("iden")).attr("saldo")
        var min = $(this).attr("interes")*1
        var msg =""
        var id=$(this).attr("iden")
        if(isNaN(valor))
            msg+="El valor de la cuota debe ser un número positivo<br/>"
        else
            valor=valor*1
        if(valor<0.01)
            msg+="El valor de la cuota debe ser un número positivo mayor a cero<br/>"
        if(valor<min)
            msg+="El valor del pago no puede ser menor a "+min+" <br/>"
        if(msg==""){
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'pagosPrestamos', action:'guardar_ajax')}",
                data:{
                    cuota:valor,
                    saldo:saldo,
                    id:id
                },
                success: function (msg) {
                    closeLoader()
                } //success
            }); //ajax
        }else{
            bootbox.alert(msg)
        }

    })
    $(".borrar").click(function(){
        var div = $($("#activo").val())
        var id = $(this).attr("iden")
        var mes = $(this).attr("mes")
        bootbox.confirm("Está seguro?",function(result){

            if(result){
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'pagosPrestamos', action:'borrar_ajax')}",
                    data:{
                        id:id,
                        mes:mes
                    },
                    success: function (msg) {
                        closeLoader()
                        div.html(msg)
                    } //success
                }); //ajax
            }
        })

    })
    $(".aprobar").click(function(){
        var valor = $("#cuota_"+$(this).attr("iden")).val()
        var saldo = $("#saldo_"+$(this).attr("iden")).attr("saldo")
        var min = $(this).attr("interes")*1
        var msg =""
        var mes = $(this).attr("mes")
        var id=$(this).attr("iden")
        if(isNaN(valor))
            msg+="El valor de la cuota debe ser un número positivo<br/>"
        else
            valor=valor*1
        if(valor<0.01)
            msg+="El valor de la cuota debe ser un número positivo mayor a cero<br/>"
        if(valor<min)
            msg+="El valor del pago no puede ser menor a "+min+" <br/>"
        if(msg==""){
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'pagosPrestamos', action:'guardar_ajax')}",
                data:{
                    cuota:valor,
                    saldo:saldo,
                    id:id,
                    aprobar:1
                },
                success: function (msg) {
                    closeLoader()
                    if(msg=="ok"){
                        var div = $($("#activo").val())
                        $(".tab-pane").html("")
                        openLoader()
                        $.ajax({
                            type: "POST",
                            url: "${createLink(controller:'pagosPrestamos', action:'getPagosMes_ajax')}",
                            data: "mes="+mes,
                            success: function (msg) {
                                closeLoader()
                                div.html(msg)
                            } //success
                        }); //ajax
                    }else{
                        bootbox.alert(msg)
                    }
                } //success
            }); //ajax
        }else{
            bootbox.alert(msg)
        }

    })
</script>