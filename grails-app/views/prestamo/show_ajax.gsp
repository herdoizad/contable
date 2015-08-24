
<%@ page import="contable.nomina.Prestamo" %>

<g:if test="${!prestamoInstance}">
    <elm:notFound elem="Prestamo" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${prestamoInstance?.empleado}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Empleado
                </div>
                
                <div class="col-sm-4">
                    ${prestamoInstance?.empleado?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${prestamoInstance?.fin}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fin
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${prestamoInstance?.fin}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${prestamoInstance?.inicio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Inicio
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${prestamoInstance?.inicio}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${prestamoInstance?.interes}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Interes
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${prestamoInstance}" field="interes"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${prestamoInstance?.monto}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Monto
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${prestamoInstance}" field="monto"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${prestamoInstance?.plazo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Plazo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${prestamoInstance}" field="plazo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${prestamoInstance?.valorCuota}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Valor Cuota
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${prestamoInstance}" field="valorCuota"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>