<%@ page import="contable.nomina.Ubicacion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!ubicacionInstance}">
    <elm:notFound elem="Ubicacion" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmUbicacion" id="${ubicacionInstance?.id}"
            role="form" controller="ubicacion" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-6">
            <g:textField name="codigo" required="" class="form-control  required unique noEspacios" value="${ubicacionInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
            <g:textField name="nombre" required="" class="form-control  required" value="${ubicacionInstance?.nombre}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Padre" claseField="col-sm-6">
            <g:select id="padre" name="padre.id" from="${contable.nomina.Ubicacion.list()}" optionKey="id" required="" value="${ubicacionInstance?.padre?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmUbicacion").validate({
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
                        url: "${createLink(controller:'ubicacion', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${ubicacionInstance?.id}"
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
                submitFormUbicacion();
                return false;
            }
            return true;
        });
    </script>

</g:else>