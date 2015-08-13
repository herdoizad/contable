
<%@ page import="contable.core.BancoOcp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bancoOcp.label', default: 'BancoOcp')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-bancoOcp" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-bancoOcp" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="codigo" title="${message(code: 'bancoOcp.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'bancoOcp.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="creacion" title="${message(code: 'bancoOcp.creacion.label', default: 'Creacion')}" />
					
						<g:sortableColumn property="usuario" title="${message(code: 'bancoOcp.usuario.label', default: 'Usuario')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${bancoOcpInstanceList}" status="i" var="bancoOcpInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${bancoOcpInstance.id}">${fieldValue(bean: bancoOcpInstance, field: "codigo")}</g:link></td>
					
						<td>${fieldValue(bean: bancoOcpInstance, field: "descripcion")}</td>
					
						<td><g:formatDate date="${bancoOcpInstance.creacion}" /></td>
					
						<td>${fieldValue(bean: bancoOcpInstance, field: "usuario")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${bancoOcpInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
