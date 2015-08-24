
<%@ page import="contable.nomina.Contrato" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'contrato.label', default: 'Contrato')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-contrato" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-contrato" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list contrato">
			
				<g:if test="${contratoInstance?.numero}">
				<li class="fieldcontain">
					<span id="numero-label" class="property-label"><g:message code="contrato.numero.label" default="Numero" /></span>
					
						<span class="property-value" aria-labelledby="numero-label"><g:fieldValue bean="${contratoInstance}" field="numero"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.fin}">
				<li class="fieldcontain">
					<span id="fin-label" class="property-label"><g:message code="contrato.fin.label" default="Fin" /></span>
					
						<span class="property-value" aria-labelledby="fin-label"><g:formatDate date="${contratoInstance?.fin}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.path}">
				<li class="fieldcontain">
					<span id="path-label" class="property-label"><g:message code="contrato.path.label" default="Path" /></span>
					
						<span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${contratoInstance}" field="path"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.empleado}">
				<li class="fieldcontain">
					<span id="empleado-label" class="property-label"><g:message code="contrato.empleado.label" default="Empleado" /></span>
					
						<span class="property-value" aria-labelledby="empleado-label"><g:link controller="empleado" action="show" id="${contratoInstance?.empleado?.id}">${contratoInstance?.empleado?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.inicio}">
				<li class="fieldcontain">
					<span id="inicio-label" class="property-label"><g:message code="contrato.inicio.label" default="Inicio" /></span>
					
						<span class="property-value" aria-labelledby="inicio-label"><g:formatDate date="${contratoInstance?.inicio}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.sueldo}">
				<li class="fieldcontain">
					<span id="sueldo-label" class="property-label"><g:message code="contrato.sueldo.label" default="Sueldo" /></span>
					
						<span class="property-value" aria-labelledby="sueldo-label"><g:fieldValue bean="${contratoInstance}" field="sueldo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contratoInstance?.tipo}">
				<li class="fieldcontain">
					<span id="tipo-label" class="property-label"><g:message code="contrato.tipo.label" default="Tipo" /></span>
					
						<span class="property-value" aria-labelledby="tipo-label"><g:link controller="tipoContrato" action="show" id="${contratoInstance?.tipo?.id}">${contratoInstance?.tipo?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:contratoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${contratoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
