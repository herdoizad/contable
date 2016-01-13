
<%@ page import="contable.nomina.PrevisionGastos" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'previsionGastos.label', default: 'PrevisionGastos')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-previsionGastos" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-previsionGastos" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list previsionGastos">
			
				<g:if test="${previsionGastosInstance?.anio}">
				<li class="fieldcontain">
					<span id="anio-label" class="property-label"><g:message code="previsionGastos.anio.label" default="Anio" /></span>
					
						<span class="property-value" aria-labelledby="anio-label"><g:fieldValue bean="${previsionGastosInstance}" field="anio"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${previsionGastosInstance?.empleado}">
				<li class="fieldcontain">
					<span id="empleado-label" class="property-label"><g:message code="previsionGastos.empleado.label" default="Empleado" /></span>
					
						<span class="property-value" aria-labelledby="empleado-label"><g:link controller="empleado" action="show" id="${previsionGastosInstance?.empleado?.id}">${previsionGastosInstance?.empleado?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${previsionGastosInstance?.totalVivienda}">
				<li class="fieldcontain">
					<span id="totalVivienda-label" class="property-label"><g:message code="previsionGastos.totalVivienda.label" default="Total Vivienda" /></span>
					
						<span class="property-value" aria-labelledby="totalVivienda-label"><g:fieldValue bean="${previsionGastosInstance}" field="totalVivienda"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${previsionGastosInstance?.totalEducacion}">
				<li class="fieldcontain">
					<span id="totalEducacion-label" class="property-label"><g:message code="previsionGastos.totalEducacion.label" default="Total Educacion" /></span>
					
						<span class="property-value" aria-labelledby="totalEducacion-label"><g:fieldValue bean="${previsionGastosInstance}" field="totalEducacion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${previsionGastosInstance?.totalSalud}">
				<li class="fieldcontain">
					<span id="totalSalud-label" class="property-label"><g:message code="previsionGastos.totalSalud.label" default="Total Salud" /></span>
					
						<span class="property-value" aria-labelledby="totalSalud-label"><g:fieldValue bean="${previsionGastosInstance}" field="totalSalud"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${previsionGastosInstance?.totalVestimenta}">
				<li class="fieldcontain">
					<span id="totalVestimenta-label" class="property-label"><g:message code="previsionGastos.totalVestimenta.label" default="Total Vestimenta" /></span>
					
						<span class="property-value" aria-labelledby="totalVestimenta-label"><g:fieldValue bean="${previsionGastosInstance}" field="totalVestimenta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${previsionGastosInstance?.totalAlimentacion}">
				<li class="fieldcontain">
					<span id="totalAlimentacion" class="property-label"><g:message code="previsionGastos.totalAlimentacion.label" default="Total Alimentacion" /></span>
					
						<span class="property-value" aria-labelledby="totalAlimentacion-label"><g:fieldValue bean="${previsionGastosInstance}" field="totalAlimentacion"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:previsionGastosInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${previsionGastosInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
