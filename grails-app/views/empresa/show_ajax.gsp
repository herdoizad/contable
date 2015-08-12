
<%@ page import="contable.core.Empresa" %>

<g:if test="${!empresaInstance}">
    <elm:notFound elem="Empresa" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${empresaInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.direccion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Direccion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="direccion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.telefono}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Telefono
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="telefono"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.fax}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fax
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="fax"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.casilla}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Casilla
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="casilla"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.secuencialFactura}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Secuencial Factura
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="secuencialFactura"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.secuencialComprobante}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Secuencial Comprobante
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="secuencialComprobante"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.secuencialIngreso}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Secuencial Ingreso
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="secuencialIngreso"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.secuencialEgreso}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Secuencial Egreso
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="secuencialEgreso"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.secuencialDiario}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Secuencial Diario
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="secuencialDiario"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.porcentajeIva}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Porcentaje Iva
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="porcentajeIva"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.representante}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Representante
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="representante"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.contador}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Contador
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="contador"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.ruc}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Ruc
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="ruc"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.email}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Email
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="email"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.moneda}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Moneda
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="moneda"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.anio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Anio
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="anio"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.comodin}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Comodin
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="comodin"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.principal}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Principal
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="principal"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.cedulaContador}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cedula Contador
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="cedulaContador"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.cedulaRepresentante}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cedula Representante
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="cedulaRepresentante"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.tipoRepresentante}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipo Representante
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="tipoRepresentante"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.numeroCopias}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Numero Copias
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="numeroCopias"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${empresaInstance?.secucialTransporte}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Secucial Transporte
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${empresaInstance}" field="secucialTransporte"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>