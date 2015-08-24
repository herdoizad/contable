
<%@ page import="contable.nomina.ImpuestoRenta" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'impuestoRenta.label', default: 'ImpuestoRenta')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-impuestoRenta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-impuestoRenta" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list impuestoRenta">
			
				<g:if test="${impuestoRentaInstance?.anio}">
				<li class="fieldcontain">
					<span id="anio-label" class="property-label"><g:message code="impuestoRenta.anio.label" default="Anio" /></span>
					
						<span class="property-value" aria-labelledby="anio-label"><g:fieldValue bean="${impuestoRentaInstance}" field="anio"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${impuestoRentaInstance?.base}">
				<li class="fieldcontain">
					<span id="base-label" class="property-label"><g:message code="impuestoRenta.base.label" default="Base" /></span>
					
						<span class="property-value" aria-labelledby="base-label"><g:fieldValue bean="${impuestoRentaInstance}" field="base"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${impuestoRentaInstance?.desde}">
				<li class="fieldcontain">
					<span id="desde-label" class="property-label"><g:message code="impuestoRenta.desde.label" default="Desde" /></span>
					
						<span class="property-value" aria-labelledby="desde-label"><g:fieldValue bean="${impuestoRentaInstance}" field="desde"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${impuestoRentaInstance?.hasta}">
				<li class="fieldcontain">
					<span id="hasta-label" class="property-label"><g:message code="impuestoRenta.hasta.label" default="Hasta" /></span>
					
						<span class="property-value" aria-labelledby="hasta-label"><g:fieldValue bean="${impuestoRentaInstance}" field="hasta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${impuestoRentaInstance?.impuesto}">
				<li class="fieldcontain">
					<span id="impuesto-label" class="property-label"><g:message code="impuestoRenta.impuesto.label" default="Impuesto" /></span>
					
						<span class="property-value" aria-labelledby="impuesto-label"><g:fieldValue bean="${impuestoRentaInstance}" field="impuesto"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:impuestoRentaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${impuestoRentaInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
