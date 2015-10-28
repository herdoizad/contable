
<%@ page import="contable.nomina.TipoContrato" %>

<g:if test="${!tipoContratoInstance}">
    <elm:notFound elem="TipoContrato" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoContratoInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoContratoInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoContratoInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoContratoInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoContratoInstance?.procedimiento}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Procedimiento
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoContratoInstance}" field="procedimiento"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>