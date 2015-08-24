<%@ page import="contable.nomina.Asistencia" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!asistenciaInstance}">
    <elm:notFound elem="Asistencia" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmAsistencia" id="${asistenciaInstance?.id}"
            role="form" controller="asistencia" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Empleado" claseField="col-sm-6">
            <g:select id="empleado" name="empleado.id" from="${contable.nomina.Empleado.list()}" optionKey="id" required="" value="${asistenciaInstance?.empleado?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Horas" claseField="col-sm-2">
            <g:textField name="horas" value="${fieldValue(bean: asistenciaInstance, field: 'horas')}" class="number form-control   required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Mes" claseField="col-sm-6">
            <g:select id="mes" name="mes.id" from="${contable.nomina.MesNomina.list()}" optionKey="id" required="" value="${asistenciaInstance?.mes?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmAsistencia").validate({
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
                submitFormAsistencia();
                return false;
            }
            return true;
        });
    </script>

</g:else>