<%@ page import="contable.core.SriTipoComprobante" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!sriTipoComprobanteInstance}">
    <elm:notFound elem="SriTipoComprobante" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmSriTipoComprobante" id="${sriTipoComprobanteInstance?.id}"
            role="form" controller="sriTipoComprobante" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-6">
            <g:textField name="codigo" maxlength="2" required="" class="form-control  required unique noEspacios" value="${sriTipoComprobanteInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
            <g:textField name="descripcion" maxlength="60" required="" class="form-control  required" value="${sriTipoComprobanteInstance?.descripcion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Usuario" claseField="col-sm-6">
            <g:textField name="usuario" maxlength="16" required="" class="form-control  required noEspacios" value="${sriTipoComprobanteInstance?.usuario}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Compras" claseField="col-sm-2">
            <g:textField name="compras" value="${sriTipoComprobanteInstance.compras}" class="digits form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Importaciones" claseField="col-sm-2">
            <g:textField name="importaciones" value="${sriTipoComprobanteInstance.importaciones}" class="digits form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Ventas" claseField="col-sm-2">
            <g:textField name="ventas" value="${sriTipoComprobanteInstance.ventas}" class="digits form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Crea" claseField="col-sm-4">
            <elm:datepicker name="crea"  class="datepicker form-control  required" value="${sriTipoComprobanteInstance?.crea}" />
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmSriTipoComprobante").validate({
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
                        url: "${createLink(controller:'sriTipoComprobante', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${sriTipoComprobanteInstance?.id}"
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
                submitFormSriTipoComprobante();
                return false;
            }
            return true;
        });
    </script>

</g:else>