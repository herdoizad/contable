
<%@ page import="contable.nomina.Ubicacion" %>

<g:if test="${!ubicacionInstance}">
    <elm:notFound elem="Ubicacion" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${ubicacionInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${ubicacionInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${ubicacionInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${ubicacionInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${ubicacionInstance?.padre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Padre
                </div>
                
                <div class="col-sm-4">
                    ${ubicacionInstance?.padre?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>