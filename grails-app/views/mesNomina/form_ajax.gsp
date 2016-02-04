<%@ page import="contable.nomina.MesNomina" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!mesNominaInstance}">
    <elm:notFound elem="MesNomina" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmMesNomina" id="${mesNominaInstance?.id}"
            role="form" controller="mesNomina" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
            <g:textField name="descripcion" maxlength="40" required="" class="form-control  required" value="${mesNominaInstance?.descripcion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-2">
            <g:textField name="codigo" value="${mesNominaInstance.codigo}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Dias Laborables" claseField="col-sm-2">
            <g:textField name="diasLaborables" value="${mesNominaInstance.diasLaborables}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>

        <elm:fieldRapido claseLabel="col-sm-2" label="Estado" claseField="col-sm-6">
            <g:textField name="estado" maxlength="1" required="" class="form-control  required" value="${mesNominaInstance?.estado}"/>
        </elm:fieldRapido>

    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmMesNomina").validate({
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
            
            , rules          : {
                
                codigo: {
                    remote: {
                        url: "${createLink(controller:'mesNomina', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${mesNominaInstance?.id}"
                        }
                    }
                }
                
            },
            messages : {
                
                codigo: {
                    remote: "Ya existe Codigo"
                }
                
            }
            
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormMesNomina();
                return false;
            }
            return true;
        });
    </script>

</g:else>