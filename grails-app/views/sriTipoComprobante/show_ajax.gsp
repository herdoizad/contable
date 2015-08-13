
<%@ page import="contable.core.SriTipoComprobante" %>

<g:if test="${!sriTipoComprobanteInstance}">
    <elm:notFound elem="SriTipoComprobante" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${sriTipoComprobanteInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sriTipoComprobanteInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sriTipoComprobanteInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sriTipoComprobanteInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sriTipoComprobanteInstance?.usuario}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Usuario
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sriTipoComprobanteInstance}" field="usuario"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sriTipoComprobanteInstance?.compras}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Compras
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sriTipoComprobanteInstance}" field="compras"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sriTipoComprobanteInstance?.importaciones}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Importaciones
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sriTipoComprobanteInstance}" field="importaciones"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sriTipoComprobanteInstance?.ventas}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Ventas
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sriTipoComprobanteInstance}" field="ventas"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sriTipoComprobanteInstance?.crea}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Crea
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${sriTipoComprobanteInstance?.crea}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>