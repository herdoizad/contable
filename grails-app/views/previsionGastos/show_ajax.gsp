
<%@ page import="contable.nomina.PrevisionGastos" %>

<g:if test="${!previsionGastosInstance}">
    <elm:notFound elem="PrevisionGastos" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${previsionGastosInstance?.anio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Anio
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${previsionGastosInstance}" field="anio"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${previsionGastosInstance?.empleado}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Empleado
                </div>
                
                <div class="col-sm-4">
                    ${previsionGastosInstance?.empleado?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${previsionGastosInstance?.totalAlimentacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Total Alimentacion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${previsionGastosInstance}" field="totalAlimentacion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${previsionGastosInstance?.totalEducacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Total Educacion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${previsionGastosInstance}" field="totalEducacion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${previsionGastosInstance?.totalSalud}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Total Salud
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${previsionGastosInstance}" field="totalSalud"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${previsionGastosInstance?.totalVestimenta}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Total Vestimenta
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${previsionGastosInstance}" field="totalVestimenta"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${previsionGastosInstance?.totalVivienda}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Total Vivienda
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${previsionGastosInstance}" field="totalVivienda"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>