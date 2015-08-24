
<%@ page import="contable.nomina.Asistencia" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'asistencia.label', default: 'Asistencia')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-asistencia" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-asistencia" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list asistencia">
			
				<g:if test="${asistenciaInstance?.empleado}">
				<li class="fieldcontain">
					<span id="empleado-label" class="property-label"><g:message code="asistencia.empleado.label" default="Empleado" /></span>
					
						<span class="property-value" aria-labelledby="empleado-label"><g:link controller="empleado" action="show" id="${asistenciaInstance?.empleado?.id}">${asistenciaInstance?.empleado?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${asistenciaInstance?.horas}">
				<li class="fieldcontain">
					<span id="horas-label" class="property-label"><g:message code="asistencia.horas.label" default="Horas" /></span>
					
						<span class="property-value" aria-labelledby="horas-label"><g:fieldValue bean="${asistenciaInstance}" field="horas"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${asistenciaInstance?.mes}">
				<li class="fieldcontain">
					<span id="mes-label" class="property-label"><g:message code="asistencia.mes.label" default="Mes" /></span>
					
						<span class="property-value" aria-labelledby="mes-label"><g:link controller="mesNomina" action="show" id="${asistenciaInstance?.mes?.id}">${asistenciaInstance?.mes?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:asistenciaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${asistenciaInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
