
<%@ page import="contable.nomina.Unidad" %>

<g:if test="${!unidadInstance}">
    <elm:notFound elem="Unidad" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${unidadInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${unidadInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${unidadInstance?.jefe}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Jefe
                </div>
                
                <div class="col-sm-4">
                    ${unidadInstance?.jefe?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${unidadInstance?.padre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Padre
                </div>
                
                <div class="col-sm-4">
                    ${unidadInstance?.padre?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${unidadInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${unidadInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${unidadInstance?.lugar}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Lugar
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${unidadInstance}" field="lugar"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>