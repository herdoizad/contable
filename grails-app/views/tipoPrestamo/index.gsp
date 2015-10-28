
<%@ page import="contable.nomina.TipoPrestamo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tipoPrestamo.label', default: 'TipoPrestamo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tipoPrestamo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-tipoPrestamo" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="codigo" title="${message(code: 'tipoPrestamo.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'tipoPrestamo.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="diasDeGracia" title="${message(code: 'tipoPrestamo.diasDeGracia.label', default: 'Dias De Gracia')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${tipoPrestamoInstanceList}" status="i" var="tipoPrestamoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${tipoPrestamoInstance.id}">${fieldValue(bean: tipoPrestamoInstance, field: "codigo")}</g:link></td>
					
						<td>${fieldValue(bean: tipoPrestamoInstance, field: "descripcion")}</td>
					
						<td>${fieldValue(bean: tipoPrestamoInstance, field: "diasDeGracia")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${tipoPrestamoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
