<%@ page import="contable.nomina.Prestamo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!prestamoInstance}">
    <elm:notFound elem="Prestamo" genero="o" />
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmPrestamo" id="${prestamoInstance?.id}"
                role="form" controller="prestamo" action="save_ajax" method="POST">


            <elm:fieldRapido claseLabel="col-sm-2" label="Empleado" claseField="col-sm-6">
                <g:if test="${empleado}">
                    <input type="hidden" name="empleado.id" value="${empleado.id}">
                    <input type="text" value="${empleado}" class="form-control " disabled>
                </g:if>
                <g:else>
                    <g:select id="empleado" name="empleado.id" from="${contable.nomina.Empleado.findAllByEstado('A')}" optionKey="id" required="" value="${prestamoInstance?.empleado?.id}" class="many-to-one form-control "/>
                </g:else>

            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Inicio" claseField="col-sm-4">
                <elm:datepicker name="inicio"  class="datepicker form-control  required" value="${prestamoInstance?.inicio}" />
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Fin" claseField="col-sm-4">
                <elm:datepicker name="fin"  class="datepicker form-control  required" value="${prestamoInstance?.fin}" />
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Interes" claseField="col-sm-2">
                <g:textField name="interes" value="${fieldValue(bean: prestamoInstance, field: 'interes')}" class="number form-control   required" required=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Monto" claseField="col-sm-3">
                <g:textField name="monto" value="${fieldValue(bean: prestamoInstance, field: 'monto')}" class="monto  number form-control   required" required="" style="text-align: right"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Plazo" claseField="col-sm-3">
                <g:textField name="plazo" value="${prestamoInstance.plazo}" class="monto digits form-control  required" required="" style="text-align: right"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Valor Cuota" claseField="col-sm-3">
                <g:textField name="valorCuota" id="cuota" value="${fieldValue(bean: prestamoInstance, field: 'valorCuota')}" class="number form-control   required" required="" style="text-align: right"/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmPrestamo").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            }

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormPrestamo();
                return false;
            }
            return true;
        });
        $(".monto").blur(function(){
            var cuaota = -1
            var monto = $("#monto").val()*1
            if(isNaN(monto)) {
                cuaota = 0
            }
            var plazo = $("#plazo").val()*1
            if(isNaN(plazo)) {
                cuaota = 0
            }
            if(cuaota!=0)
                cuaota=monto/plazo
            if(cuaota<100000)
                $("#cuota").val(cuaota.toFixed(2))

        })
    </script>

</g:else>