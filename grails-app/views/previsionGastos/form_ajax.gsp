<%@ page import="contable.nomina.PrevisionGastos" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!previsionGastosInstance}">
    <elm:notFound elem="PrevisionGastos" genero="o" />
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmPrevisionGastos" id="${previsionGastosInstance?.id}"
                role="form" controller="previsionGastos" action="save_ajax" method="POST">


           %{--<elm:fieldRapido claseLabel="col-sm-2" label="Anio" claseField="col-sm-2">
                <g:textField name="anio" value="${previsionGastosInstance.anio?prestamoInstance.anio:new Date().format('yyyy')}" class="digits form-control  required" required=""/>
            </elm:fieldRapido>
--}%
            <elm:fieldRapido claseLabel="col-sm-2" label="Empleado" claseField="col-sm-6">
                <g:if test="${empleado}">
                    <input type="hidden" name="empleado.id" value="${empleado.id}">
                    <input type="text" value="${empleado}" class="form-control " disabled>
                </g:if>
                <g:else>
                    <g:select id="empleado" name="empleado.id" from="${contable.nomina.Empleado.findAllByEstado('A')}" optionKey="id" required="" value="${prestamoInstance?.empleado?.id}" class="many-to-one form-control "/>
                </g:else>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Total Vivienda" claseField="col-sm-3">
                <g:textField name="totalVivienda" style="text-align:right"  value="${fieldValue(bean: previsionGastosInstance, field: 'totalVivienda')}" class="number form-control   required" required=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Total Educacion" claseField="col-sm-3">
                <g:textField name="totalEducacion" style="text-align:right"  value="${fieldValue(bean: previsionGastosInstance, field: 'totalEducacion')}" class="number form-control   required" required=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Total Salud" claseField="col-sm-3">
                <g:textField name="totalSalud" style="text-align:right"  value="${fieldValue(bean: previsionGastosInstance, field: 'totalSalud')}" class="number form-control   required" required=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Total Vestimenta" claseField="col-sm-3">
                <g:textField name="totalVestimenta"  style="text-align:right" value="${fieldValue(bean: previsionGastosInstance, field: 'totalVestimenta')}" class="number form-control   required" required=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Total Alimentacion" claseField="col-sm-3">
                <g:textField name="totalAlimentacion" style="text-align:right" value="${fieldValue(bean: previsionGastosInstance, field: 'totalAlimentacion')}" class="number form-control   required" required=""/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmPrevisionGastos").validate({
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
                submitFormPrevisionGastos();
                return false;
            }
            return true;
        });
    </script>

</g:else>