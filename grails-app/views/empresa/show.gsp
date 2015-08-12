
<%@ page import="contable.core.Empresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-empresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-empresa" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list empresa">
			
				<g:if test="${empresaInstance?.codigo}">
				<li class="fieldcontain">
					<span id="codigo-label" class="property-label"><g:message code="empresa.codigo.label" default="Codigo" /></span>
					
						<span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${empresaInstance}" field="codigo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="empresa.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${empresaInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.direccion}">
				<li class="fieldcontain">
					<span id="direccion-label" class="property-label"><g:message code="empresa.direccion.label" default="Direccion" /></span>
					
						<span class="property-value" aria-labelledby="direccion-label"><g:fieldValue bean="${empresaInstance}" field="direccion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.telefono}">
				<li class="fieldcontain">
					<span id="telefono-label" class="property-label"><g:message code="empresa.telefono.label" default="Telefono" /></span>
					
						<span class="property-value" aria-labelledby="telefono-label"><g:fieldValue bean="${empresaInstance}" field="telefono"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.fax}">
				<li class="fieldcontain">
					<span id="fax-label" class="property-label"><g:message code="empresa.fax.label" default="Fax" /></span>
					
						<span class="property-value" aria-labelledby="fax-label"><g:fieldValue bean="${empresaInstance}" field="fax"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.casilla}">
				<li class="fieldcontain">
					<span id="casilla-label" class="property-label"><g:message code="empresa.casilla.label" default="Casilla" /></span>
					
						<span class="property-value" aria-labelledby="casilla-label"><g:fieldValue bean="${empresaInstance}" field="casilla"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.secuencialFactura}">
				<li class="fieldcontain">
					<span id="secuencialFactura-label" class="property-label"><g:message code="empresa.secuencialFactura.label" default="Secuencial Factura" /></span>
					
						<span class="property-value" aria-labelledby="secuencialFactura-label"><g:fieldValue bean="${empresaInstance}" field="secuencialFactura"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.secuencialComprobante}">
				<li class="fieldcontain">
					<span id="secuencialComprobante-label" class="property-label"><g:message code="empresa.secuencialComprobante.label" default="Secuencial Comprobante" /></span>
					
						<span class="property-value" aria-labelledby="secuencialComprobante-label"><g:fieldValue bean="${empresaInstance}" field="secuencialComprobante"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.secuencialIngreso}">
				<li class="fieldcontain">
					<span id="secuencialIngreso-label" class="property-label"><g:message code="empresa.secuencialIngreso.label" default="Secuencial Ingreso" /></span>
					
						<span class="property-value" aria-labelledby="secuencialIngreso-label"><g:fieldValue bean="${empresaInstance}" field="secuencialIngreso"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.secuencialEgreso}">
				<li class="fieldcontain">
					<span id="secuencialEgreso-label" class="property-label"><g:message code="empresa.secuencialEgreso.label" default="Secuencial Egreso" /></span>
					
						<span class="property-value" aria-labelledby="secuencialEgreso-label"><g:fieldValue bean="${empresaInstance}" field="secuencialEgreso"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.secuencialDiario}">
				<li class="fieldcontain">
					<span id="secuencialDiario-label" class="property-label"><g:message code="empresa.secuencialDiario.label" default="Secuencial Diario" /></span>
					
						<span class="property-value" aria-labelledby="secuencialDiario-label"><g:fieldValue bean="${empresaInstance}" field="secuencialDiario"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.porcentajeIva}">
				<li class="fieldcontain">
					<span id="porcentajeIva-label" class="property-label"><g:message code="empresa.porcentajeIva.label" default="Porcentaje Iva" /></span>
					
						<span class="property-value" aria-labelledby="porcentajeIva-label"><g:fieldValue bean="${empresaInstance}" field="porcentajeIva"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.representante}">
				<li class="fieldcontain">
					<span id="representante-label" class="property-label"><g:message code="empresa.representante.label" default="Representante" /></span>
					
						<span class="property-value" aria-labelledby="representante-label"><g:fieldValue bean="${empresaInstance}" field="representante"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.contador}">
				<li class="fieldcontain">
					<span id="contador-label" class="property-label"><g:message code="empresa.contador.label" default="Contador" /></span>
					
						<span class="property-value" aria-labelledby="contador-label"><g:fieldValue bean="${empresaInstance}" field="contador"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.ruc}">
				<li class="fieldcontain">
					<span id="ruc-label" class="property-label"><g:message code="empresa.ruc.label" default="Ruc" /></span>
					
						<span class="property-value" aria-labelledby="ruc-label"><g:fieldValue bean="${empresaInstance}" field="ruc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="empresa.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${empresaInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.moneda}">
				<li class="fieldcontain">
					<span id="moneda-label" class="property-label"><g:message code="empresa.moneda.label" default="Moneda" /></span>
					
						<span class="property-value" aria-labelledby="moneda-label"><g:fieldValue bean="${empresaInstance}" field="moneda"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.anio}">
				<li class="fieldcontain">
					<span id="anio-label" class="property-label"><g:message code="empresa.anio.label" default="Anio" /></span>
					
						<span class="property-value" aria-labelledby="anio-label"><g:fieldValue bean="${empresaInstance}" field="anio"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.comodin}">
				<li class="fieldcontain">
					<span id="comodin-label" class="property-label"><g:message code="empresa.comodin.label" default="Comodin" /></span>
					
						<span class="property-value" aria-labelledby="comodin-label"><g:fieldValue bean="${empresaInstance}" field="comodin"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.principal}">
				<li class="fieldcontain">
					<span id="principal-label" class="property-label"><g:message code="empresa.principal.label" default="Principal" /></span>
					
						<span class="property-value" aria-labelledby="principal-label"><g:fieldValue bean="${empresaInstance}" field="principal"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.cedulaContador}">
				<li class="fieldcontain">
					<span id="cedulaContador-label" class="property-label"><g:message code="empresa.cedulaContador.label" default="Cedula Contador" /></span>
					
						<span class="property-value" aria-labelledby="cedulaContador-label"><g:fieldValue bean="${empresaInstance}" field="cedulaContador"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.cedulaRepresentante}">
				<li class="fieldcontain">
					<span id="cedulaRepresentante-label" class="property-label"><g:message code="empresa.cedulaRepresentante.label" default="Cedula Representante" /></span>
					
						<span class="property-value" aria-labelledby="cedulaRepresentante-label"><g:fieldValue bean="${empresaInstance}" field="cedulaRepresentante"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.tipoRepresentante}">
				<li class="fieldcontain">
					<span id="tipoRepresentante-label" class="property-label"><g:message code="empresa.tipoRepresentante.label" default="Tipo Representante" /></span>
					
						<span class="property-value" aria-labelledby="tipoRepresentante-label"><g:fieldValue bean="${empresaInstance}" field="tipoRepresentante"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.numeroCopias}">
				<li class="fieldcontain">
					<span id="numeroCopias-label" class="property-label"><g:message code="empresa.numeroCopias.label" default="Numero Copias" /></span>
					
						<span class="property-value" aria-labelledby="numeroCopias-label"><g:fieldValue bean="${empresaInstance}" field="numeroCopias"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.secucialTransporte}">
				<li class="fieldcontain">
					<span id="secucialTransporte-label" class="property-label"><g:message code="empresa.secucialTransporte.label" default="Secucial Transporte" /></span>
					
						<span class="property-value" aria-labelledby="secucialTransporte-label"><g:fieldValue bean="${empresaInstance}" field="secucialTransporte"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:empresaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${empresaInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
