
<%@ page import="contable.core.Banco" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'banco.label', default: 'Banco')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-banco" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-banco" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list banco">
			
				<g:if test="${bancoInstance?.codigo}">
				<li class="fieldcontain">
					<span id="codigo-label" class="property-label"><g:message code="banco.codigo.label" default="Codigo" /></span>
					
						<span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${bancoInstance}" field="codigo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="banco.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${bancoInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.numero}">
				<li class="fieldcontain">
					<span id="numero-label" class="property-label"><g:message code="banco.numero.label" default="Numero" /></span>
					
						<span class="property-value" aria-labelledby="numero-label"><g:fieldValue bean="${bancoInstance}" field="numero"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.tipo}">
				<li class="fieldcontain">
					<span id="tipo-label" class="property-label"><g:message code="banco.tipo.label" default="Tipo" /></span>
					
						<span class="property-value" aria-labelledby="tipo-label"><g:fieldValue bean="${bancoInstance}" field="tipo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.saldo}">
				<li class="fieldcontain">
					<span id="saldo-label" class="property-label"><g:message code="banco.saldo.label" default="Saldo" /></span>
					
						<span class="property-value" aria-labelledby="saldo-label"><g:fieldValue bean="${bancoInstance}" field="saldo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.fecha}">
				<li class="fieldcontain">
					<span id="fecha-label" class="property-label"><g:message code="banco.fecha.label" default="Fecha" /></span>
					
						<span class="property-value" aria-labelledby="fecha-label"><g:formatDate date="${bancoInstance?.fecha}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.creacion}">
				<li class="fieldcontain">
					<span id="creacion-label" class="property-label"><g:message code="banco.creacion.label" default="Creacion" /></span>
					
						<span class="property-value" aria-labelledby="creacion-label"><g:formatDate date="${bancoInstance?.creacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="banco.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:fieldValue bean="${bancoInstance}" field="usuario"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.cuenta}">
				<li class="fieldcontain">
					<span id="cuenta-label" class="property-label"><g:message code="banco.cuenta.label" default="Cuenta" /></span>
					
						<span class="property-value" aria-labelledby="cuenta-label"><g:link controller="cuenta" action="show" id="${bancoInstance?.cuenta?.id}">${bancoInstance?.cuenta?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="banco.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label"><g:link controller="empresa" action="show" id="${bancoInstance?.empresa?.id}">${bancoInstance?.empresa?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${bancoInstance?.ultimoCheque}">
				<li class="fieldcontain">
					<span id="ultimoCheque-label" class="property-label"><g:message code="banco.ultimoCheque.label" default="Ultimo Cheque" /></span>
					
						<span class="property-value" aria-labelledby="ultimoCheque-label"><g:fieldValue bean="${bancoInstance}" field="ultimoCheque"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:bancoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${bancoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
