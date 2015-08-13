
<%@ page import="contable.core.SriTipoComprobante" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sriTipoComprobante.label', default: 'SriTipoComprobante')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-sriTipoComprobante" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-sriTipoComprobante" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list sriTipoComprobante">
			
				<g:if test="${sriTipoComprobanteInstance?.codigo}">
				<li class="fieldcontain">
					<span id="codigo-label" class="property-label"><g:message code="sriTipoComprobante.codigo.label" default="Codigo" /></span>
					
						<span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${sriTipoComprobanteInstance}" field="codigo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sriTipoComprobanteInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="sriTipoComprobante.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${sriTipoComprobanteInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sriTipoComprobanteInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="sriTipoComprobante.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:fieldValue bean="${sriTipoComprobanteInstance}" field="usuario"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sriTipoComprobanteInstance?.compras}">
				<li class="fieldcontain">
					<span id="compras-label" class="property-label"><g:message code="sriTipoComprobante.compras.label" default="Compras" /></span>
					
						<span class="property-value" aria-labelledby="compras-label"><g:fieldValue bean="${sriTipoComprobanteInstance}" field="compras"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sriTipoComprobanteInstance?.importaciones}">
				<li class="fieldcontain">
					<span id="importaciones-label" class="property-label"><g:message code="sriTipoComprobante.importaciones.label" default="Importaciones" /></span>
					
						<span class="property-value" aria-labelledby="importaciones-label"><g:fieldValue bean="${sriTipoComprobanteInstance}" field="importaciones"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sriTipoComprobanteInstance?.ventas}">
				<li class="fieldcontain">
					<span id="ventas-label" class="property-label"><g:message code="sriTipoComprobante.ventas.label" default="Ventas" /></span>
					
						<span class="property-value" aria-labelledby="ventas-label"><g:fieldValue bean="${sriTipoComprobanteInstance}" field="ventas"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sriTipoComprobanteInstance?.crea}">
				<li class="fieldcontain">
					<span id="crea-label" class="property-label"><g:message code="sriTipoComprobante.crea.label" default="Crea" /></span>
					
						<span class="property-value" aria-labelledby="crea-label"><g:formatDate date="${sriTipoComprobanteInstance?.crea}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:sriTipoComprobanteInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${sriTipoComprobanteInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
