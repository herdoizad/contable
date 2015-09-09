<g:each in="${cuentas}"  var="c">
    <tr class="tr-info" debe="0.00" haber="${c.value}">
        <td style='text-align: center'  class="secuencial"></td>
        <td class="cuenta ${c.key.numero}">${c.key?.numero}</td>
        <td>
            <input type='text' class='desc allCaps form-control input-sm' disabled maxlength='35' value='${c.key.descripcion.trim()}'>
         </td>
        <td class="num debe" debe="0.00">0.00</td>
        <td class="num haber" haber="${c.value}"><g:formatNumber number="${c.value}" maxFractionDigits="2" minFractionDigits="2"/></td>
        <td style="text-align: center"><a href='#' class='btn btn-danger btn-sm borrar'><i class='fa fa-trash'></i></a></td>
    </tr>
</g:each>

<script>
    $(".borrar").click(function(){
        $(this).parent().parent().remove()
        calcularTotales()
    })
</script>