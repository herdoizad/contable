
<%@ page import="contable.nomina.EstadoCivil" %>

<g:if test="${!estadoCivilInstance}">
    <elm:notFound elem="EstadoCivil" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${estadoCivilInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${estadoCivilInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${estadoCivilInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${estadoCivilInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>