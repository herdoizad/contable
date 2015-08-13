<%@ page import="contable.core.BancoOcp" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!bancoOcpInstance}">
    <elm:notFound elem="BancoOcp" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmBancoOcp" id="${bancoOcpInstance?.id}"
            role="form" controller="bancoOcp" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-6">
            <g:textField name="codigo" maxlength="3" required="" class="form-control  required unique noEspacios" value="${bancoOcpInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
            <g:textField name="descripcion" maxlength="60" required="" class="form-control  required" value="${bancoOcpInstance?.descripcion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Creacion" claseField="col-sm-4">
            <elm:datepicker name="creacion"  class="datepicker form-control " value="${bancoOcpInstance?.creacion}" />
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Usuario" claseField="col-sm-6">
            <g:textField name="usuario" maxlength="20" class="form-control  noEspacios" value="${bancoOcpInstance?.usuario}"/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmBancoOcp").validate({
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
                        url: "${createLink(controller:'bancoOcp', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${bancoOcpInstance?.id}"
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
                submitFormBancoOcp();
                return false;
            }
            return true;
        });
    </script>

</g:else>