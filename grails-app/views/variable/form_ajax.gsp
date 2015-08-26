<%@ page import="contable.nomina.Variable" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!variableInstance}">
    <elm:notFound elem="Variable" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmVariable" id="${variableInstance?.id}"
            role="form" controller="variable" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-10">
            <g:textField name="nombre" maxlength="100" required="" class="form-control  required" value="${variableInstance?.nombre}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-6">
            <g:textField name="codigo" maxlength="20" required="" class="form-control  required unique noEspacios" value="${variableInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Sql" claseField="col-sm-10">
            <textarea name="sql" class="form-control " style="height: 200px">${variableInstance?.sql}</textarea>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Valor" claseField="col-sm-3">
            <g:textField name="valor" value="${fieldValue(bean: variableInstance, field: 'valor')}" class="number form-control  "/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmVariable").validate({
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
                        url: "${createLink(controller:'variable', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${variableInstance?.id}"
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
                submitFormVariable();
                return false;
            }
            return true;
        });
    </script>

</g:else>