
<%@ page import="contable.nomina.DetalleRol" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'detalleRol.label', default: 'DetalleRol')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-detalleRol" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-detalleRol" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="descripcion" title="${message(code: 'detalleRol.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="usuario" title="${message(code: 'detalleRol.usuario.label', default: 'Usuario')}" />
					
						<g:sortableColumn property="modificacion" title="${message(code: 'detalleRol.modificacion.label', default: 'Modificacion')}" />
					
						<g:sortableColumn property="registro" title="${message(code: 'detalleRol.registro.label', default: 'Registro')}" />
					
						<th><g:message code="detalleRol.rol.label" default="Rol" /></th>
					
						<g:sortableColumn property="signo" title="${message(code: 'detalleRol.signo.label', default: 'Signo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${detalleRolInstanceList}" status="i" var="detalleRolInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${detalleRolInstance.id}">${fieldValue(bean: detalleRolInstance, field: "descripcion")}</g:link></td>
					
						<td>${fieldValue(bean: detalleRolInstance, field: "usuario")}</td>
					
						<td><g:formatDate date="${detalleRolInstance.modificacion}" /></td>
					
						<td><g:formatDate date="${detalleRolInstance.registro}" /></td>
					
						<td>${fieldValue(bean: detalleRolInstance, field: "rol")}</td>
					
						<td>${fieldValue(bean: detalleRolInstance, field: "signo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${detalleRolInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
