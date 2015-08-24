
<%@ page import="contable.nomina.Variable" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'variable.label', default: 'Variable')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-variable" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-variable" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nombre" title="${message(code: 'variable.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="codigo" title="${message(code: 'variable.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="sql" title="${message(code: 'variable.sql.label', default: 'Sql')}" />
					
						<g:sortableColumn property="valor" title="${message(code: 'variable.valor.label', default: 'Valor')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${variableInstanceList}" status="i" var="variableInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${variableInstance.id}">${fieldValue(bean: variableInstance, field: "nombre")}</g:link></td>
					
						<td>${fieldValue(bean: variableInstance, field: "codigo")}</td>
					
						<td>${fieldValue(bean: variableInstance, field: "sql")}</td>
					
						<td>${fieldValue(bean: variableInstance, field: "valor")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${variableInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
