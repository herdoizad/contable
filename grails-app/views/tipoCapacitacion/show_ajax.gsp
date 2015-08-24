
<%@ page import="contable.nomina.TipoCapacitacion" %>

<g:if test="${!tipoCapacitacionInstance}">
    <elm:notFound elem="TipoCapacitacion" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoCapacitacionInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoCapacitacionInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoCapacitacionInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoCapacitacionInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>