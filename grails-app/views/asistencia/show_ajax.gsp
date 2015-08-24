
<%@ page import="contable.nomina.Asistencia" %>

<g:if test="${!asistenciaInstance}">
    <elm:notFound elem="Asistencia" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${asistenciaInstance?.empleado}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Empleado
                </div>
                
                <div class="col-sm-4">
                    ${asistenciaInstance?.empleado?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.horas}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Horas
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${asistenciaInstance}" field="horas"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.mes}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Mes
                </div>
                
                <div class="col-sm-4">
                    ${asistenciaInstance?.mes?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>