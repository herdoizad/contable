
<%@ page import="contable.nomina.DetalleRol" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'detalleRol.label', default: 'DetalleRol')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-detalleRol" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-detalleRol" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list detalleRol">
			
				<g:if test="${detalleRolInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="detalleRol.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${detalleRolInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${detalleRolInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="detalleRol.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:fieldValue bean="${detalleRolInstance}" field="usuario"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${detalleRolInstance?.modificacion}">
				<li class="fieldcontain">
					<span id="modificacion-label" class="property-label"><g:message code="detalleRol.modificacion.label" default="Modificacion" /></span>
					
						<span class="property-value" aria-labelledby="modificacion-label"><g:formatDate date="${detalleRolInstance?.modificacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${detalleRolInstance?.registro}">
				<li class="fieldcontain">
					<span id="registro-label" class="property-label"><g:message code="detalleRol.registro.label" default="Registro" /></span>
					
						<span class="property-value" aria-labelledby="registro-label"><g:formatDate date="${detalleRolInstance?.registro}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${detalleRolInstance?.rol}">
				<li class="fieldcontain">
					<span id="rol-label" class="property-label"><g:message code="detalleRol.rol.label" default="Rol" /></span>
					
						<span class="property-value" aria-labelledby="rol-label"><g:link controller="rol" action="show" id="${detalleRolInstance?.rol?.id}">${detalleRolInstance?.rol?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${detalleRolInstance?.signo}">
				<li class="fieldcontain">
					<span id="signo-label" class="property-label"><g:message code="detalleRol.signo.label" default="Signo" /></span>
					
						<span class="property-value" aria-labelledby="signo-label"><g:fieldValue bean="${detalleRolInstance}" field="signo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${detalleRolInstance?.valor}">
				<li class="fieldcontain">
					<span id="valor-label" class="property-label"><g:message code="detalleRol.valor.label" default="Valor" /></span>
					
						<span class="property-value" aria-labelledby="valor-label"><g:fieldValue bean="${detalleRolInstance}" field="valor"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:detalleRolInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${detalleRolInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
