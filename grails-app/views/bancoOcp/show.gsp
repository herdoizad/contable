
<%@ page import="contable.core.BancoOcp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bancoOcp.label', default: 'BancoOcp')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-bancoOcp" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-bancoOcp" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list bancoOcp">
			
				<g:if test="${bancoOcpInstance?.codigo}">
				<li class="fieldcontain">
					<span id="codigo-label" class="property-label"><g:message code="bancoOcp.codigo.label" default="Codigo" /></span>
					
						<span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${bancoOcpInstance}" field="codigo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoOcpInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="bancoOcp.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${bancoOcpInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoOcpInstance?.creacion}">
				<li class="fieldcontain">
					<span id="creacion-label" class="property-label"><g:message code="bancoOcp.creacion.label" default="Creacion" /></span>
					
						<span class="property-value" aria-labelledby="creacion-label"><g:formatDate date="${bancoOcpInstance?.creacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoOcpInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="bancoOcp.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:fieldValue bean="${bancoOcpInstance}" field="usuario"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:bancoOcpInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${bancoOcpInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
