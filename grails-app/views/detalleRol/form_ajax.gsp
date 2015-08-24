<%@ page import="contable.nomina.DetalleRol" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!detalleRolInstance}">
    <elm:notFound elem="DetalleRol" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmDetalleRol" id="${detalleRolInstance?.id}"
            role="form" controller="detalleRol" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
            <g:textField name="descripcion" maxlength="150" required="" class="form-control  required" value="${detalleRolInstance?.descripcion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Usuario" claseField="col-sm-6">
            <g:textField name="usuario" maxlength="15" required="" class="form-control  required noEspacios" value="${detalleRolInstance?.usuario}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Modificacion" claseField="col-sm-4">
            <elm:datepicker name="modificacion"  class="datepicker form-control " value="${detalleRolInstance?.modificacion}" />
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Registro" claseField="col-sm-4">
            <elm:datepicker name="registro"  class="datepicker form-control  required" value="${detalleRolInstance?.registro}" />
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Rol" claseField="col-sm-6">
            <g:select id="rol" name="rol.id" from="${contable.nomina.Rol.list()}" optionKey="id" required="" value="${detalleRolInstance?.rol?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Signo" claseField="col-sm-2">
            <g:textField name="signo" value="${detalleRolInstance.signo}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Valor" claseField="col-sm-2">
            <g:textField name="valor" value="${fieldValue(bean: detalleRolInstance, field: 'valor')}" class="number form-control   required" required=""/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmDetalleRol").validate({
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
                submitFormDetalleRol();
                return false;
            }
            return true;
        });
    </script>

</g:else>