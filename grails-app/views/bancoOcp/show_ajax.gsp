
<%@ page import="contable.core.BancoOcp" %>

<g:if test="${!bancoOcpInstance}">
    <elm:notFound elem="BancoOcp" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${bancoOcpInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoOcpInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoOcpInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoOcpInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoOcpInstance?.creacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Creacion
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${bancoOcpInstance?.creacion}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bancoOcpInstance?.usuario}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Usuario
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bancoOcpInstance}" field="usuario"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>