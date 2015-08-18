
<%@ page import="contable.core.Nivel" %>

<g:if test="${!nivelInstance}">
    <elm:notFound elem="Nivel" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${nivelInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivelDesc1}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel Desc1
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivelDesc1"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivelDesc2}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel Desc2
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivelDesc2"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivelDesc3}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel Desc3
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivelDesc3"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivelDesc4}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel Desc4
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivelDesc4"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivelDesc5}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel Desc5
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivelDesc5"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivel5}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel5
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivel5"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivelDesc6}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel Desc6
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivelDesc6"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.usuario}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Usuario
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="usuario"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.creacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Creacion
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${nivelInstance?.creacion}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivel1}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel1
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivel1"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivel2}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel2
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivel2"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivel3}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel3
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivel3"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivel4}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel4
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivel4"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${nivelInstance?.nivel6}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nivel6
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${nivelInstance}" field="nivel6"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>