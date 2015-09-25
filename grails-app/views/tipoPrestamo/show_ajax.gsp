
<%@ page import="contable.nomina.TipoPrestamo" %>

<g:if test="${!tipoPrestamoInstance}">
    <elm:notFound elem="TipoPrestamo" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoPrestamoInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoPrestamoInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoPrestamoInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoPrestamoInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>