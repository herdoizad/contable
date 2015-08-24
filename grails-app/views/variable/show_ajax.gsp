
<%@ page import="contable.nomina.Variable" %>

<g:if test="${!variableInstance}">
    <elm:notFound elem="Variable" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${variableInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${variableInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${variableInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${variableInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${variableInstance?.sql}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Sql
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${variableInstance}" field="sql"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${variableInstance?.valor}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Valor
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${variableInstance}" field="valor"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>