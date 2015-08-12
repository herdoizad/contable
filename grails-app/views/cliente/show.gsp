
<%@ page import="contable.core.Cliente" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cliente" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cliente" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list cliente">
			
				<g:if test="${clienteInstance?.codigo}">
				<li class="fieldcontain">
					<span id="codigo-label" class="property-label"><g:message code="cliente.codigo.label" default="Codigo" /></span>
					
						<span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${clienteInstance}" field="codigo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.cp}">
				<li class="fieldcontain">
					<span id="cp-label" class="property-label"><g:message code="cliente.cp.label" default="Cp" /></span>
					
						<span class="property-value" aria-labelledby="cp-label"><g:fieldValue bean="${clienteInstance}" field="cp"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.auxiliar}">
				<li class="fieldcontain">
					<span id="auxiliar-label" class="property-label"><g:message code="cliente.auxiliar.label" default="Auxiliar" /></span>
					
						<span class="property-value" aria-labelledby="auxiliar-label"><g:fieldValue bean="${clienteInstance}" field="auxiliar"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.auxiliar2}">
				<li class="fieldcontain">
					<span id="auxiliar2-label" class="property-label"><g:message code="cliente.auxiliar2.label" default="Auxiliar2" /></span>
					
						<span class="property-value" aria-labelledby="auxiliar2-label"><g:fieldValue bean="${clienteInstance}" field="auxiliar2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="cliente.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${clienteInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.ruc}">
				<li class="fieldcontain">
					<span id="ruc-label" class="property-label"><g:message code="cliente.ruc.label" default="Ruc" /></span>
					
						<span class="property-value" aria-labelledby="ruc-label"><g:fieldValue bean="${clienteInstance}" field="ruc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.ciudad}">
				<li class="fieldcontain">
					<span id="ciudad-label" class="property-label"><g:message code="cliente.ciudad.label" default="Ciudad" /></span>
					
						<span class="property-value" aria-labelledby="ciudad-label"><g:fieldValue bean="${clienteInstance}" field="ciudad"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.direccion}">
				<li class="fieldcontain">
					<span id="direccion-label" class="property-label"><g:message code="cliente.direccion.label" default="Direccion" /></span>
					
						<span class="property-value" aria-labelledby="direccion-label"><g:fieldValue bean="${clienteInstance}" field="direccion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.telefono}">
				<li class="fieldcontain">
					<span id="telefono-label" class="property-label"><g:message code="cliente.telefono.label" default="Telefono" /></span>
					
						<span class="property-value" aria-labelledby="telefono-label"><g:fieldValue bean="${clienteInstance}" field="telefono"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.fax}">
				<li class="fieldcontain">
					<span id="fax-label" class="property-label"><g:message code="cliente.fax.label" default="Fax" /></span>
					
						<span class="property-value" aria-labelledby="fax-label"><g:fieldValue bean="${clienteInstance}" field="fax"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.contacto}">
				<li class="fieldcontain">
					<span id="contacto-label" class="property-label"><g:message code="cliente.contacto.label" default="Contacto" /></span>
					
						<span class="property-value" aria-labelledby="contacto-label"><g:fieldValue bean="${clienteInstance}" field="contacto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.observacion}">
				<li class="fieldcontain">
					<span id="observacion-label" class="property-label"><g:message code="cliente.observacion.label" default="Observacion" /></span>
					
						<span class="property-value" aria-labelledby="observacion-label"><g:fieldValue bean="${clienteInstance}" field="observacion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.codigoLista}">
				<li class="fieldcontain">
					<span id="codigoLista-label" class="property-label"><g:message code="cliente.codigoLista.label" default="Codigo Lista" /></span>
					
						<span class="property-value" aria-labelledby="codigoLista-label"><g:fieldValue bean="${clienteInstance}" field="codigoLista"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.tipo}">
				<li class="fieldcontain">
					<span id="tipo-label" class="property-label"><g:message code="cliente.tipo.label" default="Tipo" /></span>
					
						<span class="property-value" aria-labelledby="tipo-label"><g:fieldValue bean="${clienteInstance}" field="tipo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="cliente.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${clienteInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.cuentaPorCobrar}">
				<li class="fieldcontain">
					<span id="cuentaPorCobrar-label" class="property-label"><g:message code="cliente.cuentaPorCobrar.label" default="Cuenta Por Cobrar" /></span>
					
						<span class="property-value" aria-labelledby="cuentaPorCobrar-label"><g:fieldValue bean="${clienteInstance}" field="cuentaPorCobrar"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.cuentaPorPagar}">
				<li class="fieldcontain">
					<span id="cuentaPorPagar-label" class="property-label"><g:message code="cliente.cuentaPorPagar.label" default="Cuenta Por Pagar" /></span>
					
						<span class="property-value" aria-labelledby="cuentaPorPagar-label"><g:fieldValue bean="${clienteInstance}" field="cuentaPorPagar"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="cliente.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:fieldValue bean="${clienteInstance}" field="usuario"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.proveedor}">
				<li class="fieldcontain">
					<span id="proveedor-label" class="property-label"><g:message code="cliente.proveedor.label" default="Proveedor" /></span>
					
						<span class="property-value" aria-labelledby="proveedor-label"><g:fieldValue bean="${clienteInstance}" field="proveedor"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.cliente}">
				<li class="fieldcontain">
					<span id="cliente-label" class="property-label"><g:message code="cliente.cliente.label" default="Cliente" /></span>
					
						<span class="property-value" aria-labelledby="cliente-label"><g:fieldValue bean="${clienteInstance}" field="cliente"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.codigoVendedor}">
				<li class="fieldcontain">
					<span id="codigoVendedor-label" class="property-label"><g:message code="cliente.codigoVendedor.label" default="Codigo Vendedor" /></span>
					
						<span class="property-value" aria-labelledby="codigoVendedor-label"><g:fieldValue bean="${clienteInstance}" field="codigoVendedor"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.aceptaMora}">
				<li class="fieldcontain">
					<span id="aceptaMora-label" class="property-label"><g:message code="cliente.aceptaMora.label" default="Acepta Mora" /></span>
					
						<span class="property-value" aria-labelledby="aceptaMora-label"><g:fieldValue bean="${clienteInstance}" field="aceptaMora"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.cuentaAnticipos}">
				<li class="fieldcontain">
					<span id="cuentaAnticipos-label" class="property-label"><g:message code="cliente.cuentaAnticipos.label" default="Cuenta Anticipos" /></span>
					
						<span class="property-value" aria-labelledby="cuentaAnticipos-label"><g:fieldValue bean="${clienteInstance}" field="cuentaAnticipos"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.contibuyenteEspecial}">
				<li class="fieldcontain">
					<span id="contibuyenteEspecial-label" class="property-label"><g:message code="cliente.contibuyenteEspecial.label" default="Contibuyente Especial" /></span>
					
						<span class="property-value" aria-labelledby="contibuyenteEspecial-label"><g:fieldValue bean="${clienteInstance}" field="contibuyenteEspecial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.cuentaPrestamos}">
				<li class="fieldcontain">
					<span id="cuentaPrestamos-label" class="property-label"><g:message code="cliente.cuentaPrestamos.label" default="Cuenta Prestamos" /></span>
					
						<span class="property-value" aria-labelledby="cuentaPrestamos-label"><g:fieldValue bean="${clienteInstance}" field="cuentaPrestamos"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.retieneFuente}">
				<li class="fieldcontain">
					<span id="retieneFuente-label" class="property-label"><g:message code="cliente.retieneFuente.label" default="Retiene Fuente" /></span>
					
						<span class="property-value" aria-labelledby="retieneFuente-label"><g:fieldValue bean="${clienteInstance}" field="retieneFuente"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.banco}">
				<li class="fieldcontain">
					<span id="banco-label" class="property-label"><g:message code="cliente.banco.label" default="Banco" /></span>
					
						<span class="property-value" aria-labelledby="banco-label"><g:fieldValue bean="${clienteInstance}" field="banco"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.tipoCuenta}">
				<li class="fieldcontain">
					<span id="tipoCuenta-label" class="property-label"><g:message code="cliente.tipoCuenta.label" default="Tipo Cuenta" /></span>
					
						<span class="property-value" aria-labelledby="tipoCuenta-label"><g:fieldValue bean="${clienteInstance}" field="tipoCuenta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.numeroCuenta}">
				<li class="fieldcontain">
					<span id="numeroCuenta-label" class="property-label"><g:message code="cliente.numeroCuenta.label" default="Numero Cuenta" /></span>
					
						<span class="property-value" aria-labelledby="numeroCuenta-label"><g:fieldValue bean="${clienteInstance}" field="numeroCuenta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.tipoid}">
				<li class="fieldcontain">
					<span id="tipoid-label" class="property-label"><g:message code="cliente.tipoid.label" default="Tipoid" /></span>
					
						<span class="property-value" aria-labelledby="tipoid-label"><g:fieldValue bean="${clienteInstance}" field="tipoid"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.creacion}">
				<li class="fieldcontain">
					<span id="creacion-label" class="property-label"><g:message code="cliente.creacion.label" default="Creacion" /></span>
					
						<span class="property-value" aria-labelledby="creacion-label"><g:formatDate date="${clienteInstance?.creacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${clienteInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="cliente.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label"><g:link controller="empresa" action="show" id="${clienteInstance?.empresa?.id}">${clienteInstance?.empresa?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:clienteInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${clienteInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
