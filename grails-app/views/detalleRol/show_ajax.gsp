
<%@ page import="contable.nomina.DetalleRol" %>

<g:if test="${!detalleRolInstance}">
    <elm:notFound elem="DetalleRol" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${detalleRolInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${detalleRolInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${detalleRolInstance?.usuario}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Usuario
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${detalleRolInstance}" field="usuario"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${detalleRolInstance?.modificacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Modificacion
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${detalleRolInstance?.modificacion}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${detalleRolInstance?.registro}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Registro
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${detalleRolInstance?.registro}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${detalleRolInstance?.rol}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Rol
                </div>
                
                <div class="col-sm-4">
                    ${detalleRolInstance?.rol?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${detalleRolInstance?.signo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Signo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${detalleRolInstance}" field="signo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${detalleRolInstance?.valor}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Valor
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${detalleRolInstance}" field="valor"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>