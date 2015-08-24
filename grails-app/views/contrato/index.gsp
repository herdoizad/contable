
<%@ page import="contable.nomina.Contrato" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'contrato.label', default: 'Contrato')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-contrato" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-contrato" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="numero" title="${message(code: 'contrato.numero.label', default: 'Numero')}" />
					
						<g:sortableColumn property="fin" title="${message(code: 'contrato.fin.label', default: 'Fin')}" />
					
						<g:sortableColumn property="path" title="${message(code: 'contrato.path.label', default: 'Path')}" />
					
						<th><g:message code="contrato.empleado.label" default="Empleado" /></th>
					
						<g:sortableColumn property="inicio" title="${message(code: 'contrato.inicio.label', default: 'Inicio')}" />
					
						<g:sortableColumn property="sueldo" title="${message(code: 'contrato.sueldo.label', default: 'Sueldo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${contratoInstanceList}" status="i" var="contratoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${contratoInstance.id}">${fieldValue(bean: contratoInstance, field: "numero")}</g:link></td>
					
						<td><g:formatDate date="${contratoInstance.fin}" /></td>
					
						<td>${fieldValue(bean: contratoInstance, field: "path")}</td>
					
						<td>${fieldValue(bean: contratoInstance, field: "empleado")}</td>
					
						<td><g:formatDate date="${contratoInstance.inicio}" /></td>
					
						<td>${fieldValue(bean: contratoInstance, field: "sueldo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${contratoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
