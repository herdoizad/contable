
<%@ page import="contable.core.Empresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-empresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-empresa" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="codigo" title="${message(code: 'empresa.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'empresa.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="direccion" title="${message(code: 'empresa.direccion.label', default: 'Direccion')}" />
					
						<g:sortableColumn property="telefono" title="${message(code: 'empresa.telefono.label', default: 'Telefono')}" />
					
						<g:sortableColumn property="fax" title="${message(code: 'empresa.fax.label', default: 'Fax')}" />
					
						<g:sortableColumn property="casilla" title="${message(code: 'empresa.casilla.label', default: 'Casilla')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${empresaInstanceList}" status="i" var="empresaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${empresaInstance.id}">${fieldValue(bean: empresaInstance, field: "codigo")}</g:link></td>
					
						<td>${fieldValue(bean: empresaInstance, field: "descripcion")}</td>
					
						<td>${fieldValue(bean: empresaInstance, field: "direccion")}</td>
					
						<td>${fieldValue(bean: empresaInstance, field: "telefono")}</td>
					
						<td>${fieldValue(bean: empresaInstance, field: "fax")}</td>
					
						<td>${fieldValue(bean: empresaInstance, field: "casilla")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${empresaInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
