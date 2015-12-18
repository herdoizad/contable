<table class="table table-condensed table-striped">
    <tbody>
    <g:each in="${empleados}" var="e">
        <tr class="tr-info">
            <td>${e.apellido} ${e.nombre}</td>
            <td style="width: 150px">
                <input type="text" empleado="${e.id}" value="${datos[e]}" style="text-align: right" class="val form-control input-sm number" >
            </td>
        </tr>
    </g:each>
    </tbody>
    <tfoot>
    <tr>
        <td><label>Total</label></td>
        <td id="total" style="text-align: right;font-weight: bold"></td>
    </tr>

    </tfoot>
</table>
<div class="row fila">
    <div class="col-md-1">
        <a href="#" id="guardar" class="btn btn-verde btn-sm">
            <i class="fa fa-save"></i> Guardar
        </a>
    </div>
</div>
<script>
    $(".val").blur(function(){
        var total = 0
        $(".val").each(function(){
            var valor = $(this).val()
            if(isNaN(valor)) {
                valor = 0
                $(this).val("0")
            }
            total+=valor*1
        })
        $("#total").html(number_format(total,2,".",""))
    })
    $("#guardar").click(function(){
        bootbox.confirm("Está seguro?",function(result){
            if(result){
                var rubro = $("#rubro").val()
                var msg =""
                var total = $("#total").html()
                if(isNaN(total))
                    msg="Ingrese valores para el rubro"
                var tipo = $("#tipo").val()
                if(msg==""){
                    var data =""
                    $(".val").each(function(){
                        var valor = $(this).val()
                        if(!isNaN(valor) && valor!="") {
                            data+=$(this).attr("empleado")+";"+$(this).val()+"W"
                        }
                    })
                    $("#data").val(data)
                    $(".frm").submit()
                }else{
                    bootbox.alert(msg)
                }
            }
        })

    });
    $(".val").blur();
</script>