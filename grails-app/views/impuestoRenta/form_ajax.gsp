<%@ page import="contable.nomina.ImpuestoRenta" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!impuestoRentaInstance}">
    <elm:notFound elem="ImpuestoRenta" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmImpuestoRenta" id="${impuestoRentaInstance?.id}"
            role="form" controller="impuestoRenta" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Anio" claseField="col-sm-2">
            <g:textField name="anio" value="${impuestoRentaInstance.anio}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Base" claseField="col-sm-2">
            <g:textField name="base" value="${fieldValue(bean: impuestoRentaInstance, field: 'base')}" class="number form-control   required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Desde" claseField="col-sm-2">
            <g:textField name="desde" value="${fieldValue(bean: impuestoRentaInstance, field: 'desde')}" class="number form-control   required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Hasta" claseField="col-sm-2">
            <g:textField name="hasta" value="${fieldValue(bean: impuestoRentaInstance, field: 'hasta')}" class="number form-control   required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Impuesto" claseField="col-sm-2">
            <g:textField name="impuesto" value="${fieldValue(bean: impuestoRentaInstance, field: 'impuesto')}" class="number form-control   required" required=""/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmImpuestoRenta").validate({
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
                submitFormImpuestoRenta();
                return false;
            }
            return true;
        });
    </script>

</g:else>