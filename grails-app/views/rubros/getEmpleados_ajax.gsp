<div class="row">
    <div class="col-md-3">
        <label>Mes</label>
    </div>
    <div class="col-md-8">
        <g:select name="mes"  id="mes" from="${meses}" class="form-control input-sm" optionKey="id" optionValue="codigo"/>
    </div>
</div>
<div class="row fila" style="height: 450px;overflow-y: auto">
    <div class="col-md-12">
        <table class="table table-darkblue table-bordered table-sm">
            <thead>
            <tr>
                <th>Empleado</th>
                <th style="width:40px;"></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${emps}" var="e">
                <tr>
                    <td>${e.nombre} ${e.apellido}</td>
                    <td style="text-align: center">
                        <a href="#" class="test btn btn-xs btn-info" emp="${e.id}">
                            <i class="fa fa-check"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
<script>
    $(".test").click(function(){
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'rubros', action:'test_ajax')}",
            data: {
                formula:$("#formula").val(),
                mes:$("#mes").val(),
                empleado:$(this).attr("emp")
            },
            success: function (msg) {
                closeLoader()
                $("#dlgEmpleados").modal("hide")
                bootbox.alert({
                    id: "dlgTest",
                    title: "Resultado",
                    message: msg
                });
            },
            error:function (msg) {
                closeLoader()
                $("#dlgEmpleados").modal("hide")
                bootbox.alert({
                    id: "dlgTest",
                    title: "Error",
                    message: "Error al ejecutar la fórmula."
                });
            }

        }); //ajax
    })
</script>