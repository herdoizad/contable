
<%@ page import="contable.core.Banco" %>

<g:if test="${!bancoInstance}">
    <elm:notFound elem="Banco" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${bancoInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.numero}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Numero
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoInstance}" field="numero"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.tipo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoInstance}" field="tipo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.saldo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Saldo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoInstance}" field="saldo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.fecha}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fecha
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${bancoInstance?.fecha}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.creacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Creacion
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${bancoInstance?.creacion}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.usuario}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Usuario
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoInstance}" field="usuario"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.cuenta}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cuenta
                </div>
                
                <div class="col-sm-4">
                    ${bancoInstance?.cuenta?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.empresa}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Empresa
                </div>
                
                <div class="col-sm-4">
                    ${bancoInstance?.empresa?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoInstance?.ultimoCheque}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Ultimo Cheque
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoInstance}" field="ultimoCheque"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>