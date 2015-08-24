
<%@ page import="contable.nomina.Unidad" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'unidad.label', default: 'Unidad')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-unidad" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-unidad" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list unidad">
			
				<g:if test="${unidadInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="unidad.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${unidadInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${unidadInstance?.jefe}">
				<li class="fieldcontain">
					<span id="jefe-label" class="property-label"><g:message code="unidad.jefe.label" default="Jefe" /></span>
					
						<span class="property-value" aria-labelledby="jefe-label"><g:link controller="empleado" action="show" id="${unidadInstance?.jefe?.id}">${unidadInstance?.jefe?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${unidadInstance?.padre}">
				<li class="fieldcontain">
					<span id="padre-label" class="property-label"><g:message code="unidad.padre.label" default="Padre" /></span>
					
						<span class="property-value" aria-labelledby="padre-label"><g:link controller="unidad" action="show" id="${unidadInstance?.padre?.id}">${unidadInstance?.padre?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${unidadInstance?.codigo}">
				<li class="fieldcontain">
					<span id="codigo-label" class="property-label"><g:message code="unidad.codigo.label" default="Codigo" /></span>
					
						<span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${unidadInstance}" field="codigo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${unidadInstance?.lugar}">
				<li class="fieldcontain">
					<span id="lugar-label" class="property-label"><g:message code="unidad.lugar.label" default="Lugar" /></span>
					
						<span class="property-value" aria-labelledby="lugar-label"><g:fieldValue bean="${unidadInstance}" field="lugar"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:unidadInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${unidadInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
