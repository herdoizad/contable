
<%@ page import="contable.core.Nivel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'nivel.label', default: 'Nivel')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-nivel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-nivel" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list nivel">
			
				<g:if test="${nivelInstance?.codigo}">
				<li class="fieldcontain">
					<span id="codigo-label" class="property-label"><g:message code="nivel.codigo.label" default="Codigo" /></span>
					
						<span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${nivelInstance}" field="codigo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivelDesc1}">
				<li class="fieldcontain">
					<span id="nivelDesc1-label" class="property-label"><g:message code="nivel.nivelDesc1.label" default="Nivel Desc1" /></span>
					
						<span class="property-value" aria-labelledby="nivelDesc1-label"><g:fieldValue bean="${nivelInstance}" field="nivelDesc1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivelDesc2}">
				<li class="fieldcontain">
					<span id="nivelDesc2-label" class="property-label"><g:message code="nivel.nivelDesc2.label" default="Nivel Desc2" /></span>
					
						<span class="property-value" aria-labelledby="nivelDesc2-label"><g:fieldValue bean="${nivelInstance}" field="nivelDesc2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivelDesc3}">
				<li class="fieldcontain">
					<span id="nivelDesc3-label" class="property-label"><g:message code="nivel.nivelDesc3.label" default="Nivel Desc3" /></span>
					
						<span class="property-value" aria-labelledby="nivelDesc3-label"><g:fieldValue bean="${nivelInstance}" field="nivelDesc3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivelDesc4}">
				<li class="fieldcontain">
					<span id="nivelDesc4-label" class="property-label"><g:message code="nivel.nivelDesc4.label" default="Nivel Desc4" /></span>
					
						<span class="property-value" aria-labelledby="nivelDesc4-label"><g:fieldValue bean="${nivelInstance}" field="nivelDesc4"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivelDesc5}">
				<li class="fieldcontain">
					<span id="nivelDesc5-label" class="property-label"><g:message code="nivel.nivelDesc5.label" default="Nivel Desc5" /></span>
					
						<span class="property-value" aria-labelledby="nivelDesc5-label"><g:fieldValue bean="${nivelInstance}" field="nivelDesc5"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivel5}">
				<li class="fieldcontain">
					<span id="nivel5-label" class="property-label"><g:message code="nivel.nivel5.label" default="Nivel5" /></span>
					
						<span class="property-value" aria-labelledby="nivel5-label"><g:fieldValue bean="${nivelInstance}" field="nivel5"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivelDesc6}">
				<li class="fieldcontain">
					<span id="nivelDesc6-label" class="property-label"><g:message code="nivel.nivelDesc6.label" default="Nivel Desc6" /></span>
					
						<span class="property-value" aria-labelledby="nivelDesc6-label"><g:fieldValue bean="${nivelInstance}" field="nivelDesc6"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="nivel.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:fieldValue bean="${nivelInstance}" field="usuario"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.creacion}">
				<li class="fieldcontain">
					<span id="creacion-label" class="property-label"><g:message code="nivel.creacion.label" default="Creacion" /></span>
					
						<span class="property-value" aria-labelledby="creacion-label"><g:formatDate date="${nivelInstance?.creacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivel1}">
				<li class="fieldcontain">
					<span id="nivel1-label" class="property-label"><g:message code="nivel.nivel1.label" default="Nivel1" /></span>
					
						<span class="property-value" aria-labelledby="nivel1-label"><g:fieldValue bean="${nivelInstance}" field="nivel1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivel2}">
				<li class="fieldcontain">
					<span id="nivel2-label" class="property-label"><g:message code="nivel.nivel2.label" default="Nivel2" /></span>
					
						<span class="property-value" aria-labelledby="nivel2-label"><g:fieldValue bean="${nivelInstance}" field="nivel2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivel3}">
				<li class="fieldcontain">
					<span id="nivel3-label" class="property-label"><g:message code="nivel.nivel3.label" default="Nivel3" /></span>
					
						<span class="property-value" aria-labelledby="nivel3-label"><g:fieldValue bean="${nivelInstance}" field="nivel3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivel4}">
				<li class="fieldcontain">
					<span id="nivel4-label" class="property-label"><g:message code="nivel.nivel4.label" default="Nivel4" /></span>
					
						<span class="property-value" aria-labelledby="nivel4-label"><g:fieldValue bean="${nivelInstance}" field="nivel4"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nivelInstance?.nivel6}">
				<li class="fieldcontain">
					<span id="nivel6-label" class="property-label"><g:message code="nivel.nivel6.label" default="Nivel6" /></span>
					
						<span class="property-value" aria-labelledby="nivel6-label"><g:fieldValue bean="${nivelInstance}" field="nivel6"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:nivelInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${nivelInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
