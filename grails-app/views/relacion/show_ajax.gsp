
<%@ page import="contable.nomina.Relacion" %>

<g:if test="${!relacionInstance}">
    <elm:notFound elem="Relacion" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${relacionInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${relacionInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${relacionInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${relacionInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>