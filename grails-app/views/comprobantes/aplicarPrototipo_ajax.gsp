<g:each in="${dets}"  var="c">
    <tr class="tr-info" debe="${c.signo>0?c.valor:0}" haber="${c.signo<0?c.valor:0}">
        <td style='text-align: center'  class="secuencial"></td>
        <td class="cuenta ${c.cuenta.numero}">${c.cuenta?.numero}</td>
        <td>
            <input type='text' class='desc allCaps form-control input-sm' disabled maxlength='35' value='${c.descripcion}'>
        </td>
        <td class="num debe" debe="${c.signo>0?c.valor:0}">
            <input type='text' style="text-align: right" class='debe num-p allCaps form-control input-sm number'
                   value='${g.formatNumber(number:c.signo>0?c.valor:0 ,maxFractionDigits:"2", minFractionDigits:"2")}'>

        </td>
        <td class="num haber" haber="${c.signo<0?c.valor:0}">
            <input type='text' style="text-align: right" class='haber num-p allCaps form-control input-sm number'
                   value='${g.formatNumber(number:c.signo<0?c.valor:0 ,maxFractionDigits:"2", minFractionDigits:"2")}'>
        </td>
        <td style="text-align: center"><a href='#' class='btn btn-danger btn-sm borrar'><i class='fa fa-trash'></i></a></td>
    </tr>
</g:each>

<script>
    $(".borrar").click(function(){
        $(this).parent().parent().remove()
        calcularTotales()
    })
    $(".num-p").blur(function(){
        if($(this).hasClass("debe"))
            $(this).parent().parent().attr("debe",$(this).val())
        else
            $(this).parent().parent().attr("haber",$(this).val())
        calcularTotales()
    })
</script>