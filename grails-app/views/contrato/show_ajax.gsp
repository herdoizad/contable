
<%@ page import="contable.nomina.Contrato" %>

<g:if test="${!contratoInstance}">
    <elm:notFound elem="Contrato" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${contratoInstance?.numero}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Numero
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${contratoInstance}" field="numero"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${contratoInstance?.fin}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fin
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${contratoInstance?.fin}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${contratoInstance?.path}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Path
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${contratoInstance}" field="path"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${contratoInstance?.empleado}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Empleado
                </div>
                
                <div class="col-sm-4">
                    ${contratoInstance?.empleado?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${contratoInstance?.inicio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Inicio
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${contratoInstance?.inicio}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${contratoInstance?.sueldo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Sueldo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${contratoInstance}" field="sueldo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${contratoInstance?.tipo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipo
                </div>
                
                <div class="col-sm-4">
                    ${contratoInstance?.tipo?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>