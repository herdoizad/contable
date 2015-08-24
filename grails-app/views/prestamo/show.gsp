
<%@ page import="contable.nomina.Prestamo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'prestamo.label', default: 'Prestamo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-prestamo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-prestamo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list prestamo">
			
				<g:if test="${prestamoInstance?.empleado}">
				<li class="fieldcontain">
					<span id="empleado-label" class="property-label"><g:message code="prestamo.empleado.label" default="Empleado" /></span>
					
						<span class="property-value" aria-labelledby="empleado-label"><g:link controller="empleado" action="show" id="${prestamoInstance?.empleado?.id}">${prestamoInstance?.empleado?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${prestamoInstance?.fin}">
				<li class="fieldcontain">
					<span id="fin-label" class="property-label"><g:message code="prestamo.fin.label" default="Fin" /></span>
					
						<span class="property-value" aria-labelledby="fin-label"><g:formatDate date="${prestamoInstance?.fin}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${prestamoInstance?.inicio}">
				<li class="fieldcontain">
					<span id="inicio-label" class="property-label"><g:message code="prestamo.inicio.label" default="Inicio" /></span>
					
						<span class="property-value" aria-labelledby="inicio-label"><g:formatDate date="${prestamoInstance?.inicio}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${prestamoInstance?.interes}">
				<li class="fieldcontain">
					<span id="interes-label" class="property-label"><g:message code="prestamo.interes.label" default="Interes" /></span>
					
						<span class="property-value" aria-labelledby="interes-label"><g:fieldValue bean="${prestamoInstance}" field="interes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${prestamoInstance?.monto}">
				<li class="fieldcontain">
					<span id="monto-label" class="property-label"><g:message code="prestamo.monto.label" default="Monto" /></span>
					
						<span class="property-value" aria-labelledby="monto-label"><g:fieldValue bean="${prestamoInstance}" field="monto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${prestamoInstance?.plazo}">
				<li class="fieldcontain">
					<span id="plazo-label" class="property-label"><g:message code="prestamo.plazo.label" default="Plazo" /></span>
					
						<span class="property-value" aria-labelledby="plazo-label"><g:fieldValue bean="${prestamoInstance}" field="plazo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${prestamoInstance?.valorCuota}">
				<li class="fieldcontain">
					<span id="valorCuota-label" class="property-label"><g:message code="prestamo.valorCuota.label" default="Valor Cuota" /></span>
					
						<span class="property-value" aria-labelledby="valorCuota-label"><g:fieldValue bean="${prestamoInstance}" field="valorCuota"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:prestamoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${prestamoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
