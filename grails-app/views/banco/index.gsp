
<%@ page import="contable.core.Banco" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'banco.label', default: 'Banco')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-banco" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-banco" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="codigo" title="${message(code: 'banco.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'banco.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="numero" title="${message(code: 'banco.numero.label', default: 'Numero')}" />
					
						<g:sortableColumn property="tipo" title="${message(code: 'banco.tipo.label', default: 'Tipo')}" />
					
						<g:sortableColumn property="saldo" title="${message(code: 'banco.saldo.label', default: 'Saldo')}" />
					
						<g:sortableColumn property="fecha" title="${message(code: 'banco.fecha.label', default: 'Fecha')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${bancoInstanceList}" status="i" var="bancoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${bancoInstance.codigo}">${fieldValue(bean: bancoInstance, field: "codigo")}</g:link></td>
					
						<td>${fieldValue(bean: bancoInstance, field: "descripcion")}</td>
					
						<td>${fieldValue(bean: bancoInstance, field: "numero")}</td>
					
						<td>${fieldValue(bean: bancoInstance, field: "tipo")}</td>
					
						<td>${fieldValue(bean: bancoInstance, field: "saldo")}</td>
					
						<td><g:formatDate date="${bancoInstance.fecha}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${bancoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
