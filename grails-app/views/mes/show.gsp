
<%@ page import="contable.core.Mes" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mes.label', default: 'Mes')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-mes" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-mes" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list mes">
			
				<g:if test="${mesInstance?.estado}">
				<li class="fieldcontain">
					<span id="estado-label" class="property-label"><g:message code="mes.estado.label" default="Estado" /></span>
					
						<span class="property-value" aria-labelledby="estado-label"><g:fieldValue bean="${mesInstance}" field="estado"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mesInstance?.periodoSri}">
				<li class="fieldcontain">
					<span id="periodoSri-label" class="property-label"><g:message code="mes.periodoSri.label" default="Periodo Sri" /></span>
					
						<span class="property-value" aria-labelledby="periodoSri-label"><g:fieldValue bean="${mesInstance}" field="periodoSri"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mesInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="mes.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${mesInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mesInstance?.codigo}">
				<li class="fieldcontain">
					<span id="codigo-label" class="property-label"><g:message code="mes.codigo.label" default="Codigo" /></span>
					
						<span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${mesInstance}" field="codigo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mesInstance?.creacion}">
				<li class="fieldcontain">
					<span id="creacion-label" class="property-label"><g:message code="mes.creacion.label" default="Creacion" /></span>
					
						<span class="property-value" aria-labelledby="creacion-label"><g:formatDate date="${mesInstance?.creacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mesInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="mes.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label"><g:link controller="empresa" action="show" id="${mesInstance?.empresa?.id}">${mesInstance?.empresa?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${mesInstance?.fin}">
				<li class="fieldcontain">
					<span id="fin-label" class="property-label"><g:message code="mes.fin.label" default="Fin" /></span>
					
						<span class="property-value" aria-labelledby="fin-label"><g:formatDate date="${mesInstance?.fin}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mesInstance?.inicio}">
				<li class="fieldcontain">
					<span id="inicio-label" class="property-label"><g:message code="mes.inicio.label" default="Inicio" /></span>
					
						<span class="property-value" aria-labelledby="inicio-label"><g:formatDate date="${mesInstance?.inicio}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mesInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="mes.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:fieldValue bean="${mesInstance}" field="usuario"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:mesInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${mesInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
