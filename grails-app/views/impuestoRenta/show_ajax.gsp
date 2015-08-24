
<%@ page import="contable.nomina.ImpuestoRenta" %>

<g:if test="${!impuestoRentaInstance}">
    <elm:notFound elem="ImpuestoRenta" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${impuestoRentaInstance?.anio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Anio
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${impuestoRentaInstance}" field="anio"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${impuestoRentaInstance?.base}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Base
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${impuestoRentaInstance}" field="base"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${impuestoRentaInstance?.desde}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Desde
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${impuestoRentaInstance}" field="desde"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${impuestoRentaInstance?.hasta}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Hasta
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${impuestoRentaInstance}" field="hasta"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${impuestoRentaInstance?.impuesto}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Impuesto
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${impuestoRentaInstance}" field="impuesto"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>