<%@ page import="contable.core.Banco" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!bancoInstance}">
    <elm:notFound elem="Banco" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmBanco" id="${bancoInstance?.codigo}"
            role="form" controller="banco" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-7">
            <g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${bancoInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-7">
            <g:textField name="descripcion" maxlength="30" required="" class="form-control  required" value="${bancoInstance?.descripcion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Numero" claseField="col-sm-7">
            <g:textField name="numero" maxlength="20" required="" class="form-control  required" value="${bancoInstance?.numero}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Tipo" claseField="col-sm-7">
            <g:textField name="tipo" maxlength="1" required="" class="form-control  required" value="${bancoInstance?.tipo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Saldo" claseField="col-sm-3">
            <g:textField name="saldo" value="${fieldValue(bean: bancoInstance, field: 'saldo')}" class="number form-control  "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Fecha" claseField="col-sm-5">
            <elm:datepicker name="fecha"  class="datepicker form-control " value="${bancoInstance?.fecha}" />
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Creacion" claseField="col-sm-5">
            <elm:datepicker name="creacion"  class="datepicker form-control " value="${bancoInstance?.creacion}" />
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cuenta" claseField="col-sm-7">
            <g:select id="cuenta" name="cuenta.id" from="${cuentas}" optionKey="numero" required="" value="${bancoInstance?.cuenta?.numero}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Empresa" claseField="col-sm-7">
            <g:select id="empresa" name="empresa.id" from="${contable.core.Empresa.list()}" optionKey="codigo"  optionValue="descripcion" required="" value="${bancoInstance?.empresa?.codigo}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Ultimo Cheque" claseField="col-sm-3">
            <g:textField name="ultimoCheque" value="${bancoInstance.ultimoCheque}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmBanco").validate({
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
                        url: "${createLink(controller:'banco', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${bancoInstance?.codigo}"
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
                submitFormBanco();
                return false;
            }
            return true;
        });
    </script>

</g:else>