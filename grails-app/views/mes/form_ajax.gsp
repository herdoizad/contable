<%@ page import="contable.core.Mes" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!mesInstance}">
    <elm:notFound elem="Mes" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmMes" id="${mesInstance?.id}"
            role="form" controller="mes" action="save_ajax" method="POST">

        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-2">
            <g:textField name="codigo" value="${mesInstance.codigo}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        <elm:fieldRapido claseLabel="col-sm-2" label="Estado" claseField="col-sm-6">
            <g:textField name="estado" maxlength="1" required="" class="form-control  required" value="${mesInstance?.estado}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Periodo Sri" claseField="col-sm-6">
            <g:textField name="periodoSri" maxlength="5" class="form-control " value="${mesInstance?.periodoSri}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
            <g:textField name="descripcion" maxlength="50" class="form-control " value="${mesInstance?.descripcion}"/>
        </elm:fieldRapido>

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Empresa" claseField="col-sm-6">
            <g:select id="empresa" name="empresa.id" from="${contable.core.Empresa.list()}" optionKey="codigo" optionValue="descripcion" required="" value="${mesInstance?.empresa?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>

        <elm:fieldRapido claseLabel="col-sm-2" label="Inicio" claseField="col-sm-4">
            <elm:datepicker name="inicio"  class="datepicker form-control  required" value="${mesInstance?.inicio}" />
        </elm:fieldRapido>

        <elm:fieldRapido claseLabel="col-sm-2" label="Fin" claseField="col-sm-4">
            <elm:datepicker name="fin"  class="datepicker form-control  required" value="${mesInstance?.fin}" />
        </elm:fieldRapido>
        


        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmMes").validate({
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
                        url: "${createLink(controller:'mes', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${mesInstance?.id}"
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
                submitFormMes();
                return false;
            }
            return true;
        });
    </script>

</g:else>