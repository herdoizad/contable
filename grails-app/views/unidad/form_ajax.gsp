<%@ page import="contable.nomina.Unidad" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!unidadInstance}">
    <elm:notFound elem="Unidad" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmUnidad" id="${unidadInstance?.id}"
            role="form" controller="unidad" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-10">
            <g:textField name="nombre" maxlength="100" required="" class="form-control  required" value="${unidadInstance?.nombre}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Jefe" claseField="col-sm-6">
            <g:select id="jefe" name="jefe.id" from="${contable.nomina.Empleado.findAllByEstado('A',[sort: 'apellido'])}" optionKey="id" value="${unidadInstance?.jefe?.id}" class="many-to-one form-control " noSelection="['null': '']"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Padre" claseField="col-sm-6">
            <g:if test="${padre}">
                <input type="hidden" name="padre.id" value="${padre.id}">
                <input type="text" class="form-control" value="${padre.nombre}" disabled>
            </g:if>
            <g:else>
                <g:select id="padre" name="padre.id" from="${contable.nomina.Unidad.list([sort: 'nombre'])}"  optionValue="nombre" optionKey="id" value="${unidadInstance?.padre?.id}" class="many-to-one form-control " noSelection="['null': '']"/>
            </g:else>

        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-2">
            <g:textField name="codigo" maxlength="5" required="" class="form-control  required unique noEspacios" value="${unidadInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Lugar" claseField="col-sm-6">
            <g:textField name="lugar" maxlength="30" class="form-control " value="${unidadInstance?.lugar}"/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmUnidad").validate({
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
                        url: "${createLink(controller:'unidad', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${unidadInstance?.id}"
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
                submitFormUnidad();
                return false;
            }
            return true;
        });

    </script>

</g:else>