
<%@ page import="contable.core.Cliente" %>

<g:if test="${!clienteInstance}">
    <elm:notFound elem="Cliente" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${clienteInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.cp}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cp
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="cp"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.auxiliar}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Auxiliar
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="auxiliar"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.auxiliar2}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Auxiliar2
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="auxiliar2"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.ruc}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Ruc
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="ruc"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.ciudad}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Ciudad
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="ciudad"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.direccion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Direccion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="direccion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.telefono}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Telefono
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="telefono"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.fax}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fax
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="fax"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.contacto}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Contacto
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="contacto"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.observacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Observacion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="observacion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.codigoLista}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo Lista
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="codigoLista"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.tipo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="tipo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.email}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Email
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="email"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.cuentaPorCobrar}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cuenta Por Cobrar
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="cuentaPorCobrar"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.cuentaPorPagar}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cuenta Por Pagar
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="cuentaPorPagar"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.usuario}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Usuario
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="usuario"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.proveedor}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Proveedor
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="proveedor"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.cliente}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cliente
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="cliente"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.codigoVendedor}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo Vendedor
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="codigoVendedor"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.aceptaMora}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Acepta Mora
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="aceptaMora"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.cuentaAnticipos}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cuenta Anticipos
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="cuentaAnticipos"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.contibuyenteEspecial}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Contibuyente Especial
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="contibuyenteEspecial"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.cuentaPrestamos}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cuenta Prestamos
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="cuentaPrestamos"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.retieneFuente}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Retiene Fuente
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="retieneFuente"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.banco}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Banco
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="banco"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.tipoCuenta}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipo Cuenta
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="tipoCuenta"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.numeroCuenta}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Numero Cuenta
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="numeroCuenta"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.tipoid}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipoid
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${clienteInstance}" field="tipoid"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.creacion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Creacion
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${clienteInstance?.creacion}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${clienteInstance?.empresa}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Empresa
                </div>
                
                <div class="col-sm-4">
                    ${clienteInstance?.empresa?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>