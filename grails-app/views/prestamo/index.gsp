
<%@ page import="contable.nomina.Prestamo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'prestamo.label', default: 'Prestamo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-prestamo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-prestamo" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="prestamo.empleado.label" default="Empleado" /></th>
					
						<g:sortableColumn property="fin" title="${message(code: 'prestamo.fin.label', default: 'Fin')}" />
					
						<g:sortableColumn property="inicio" title="${message(code: 'prestamo.inicio.label', default: 'Inicio')}" />
					
						<g:sortableColumn property="interes" title="${message(code: 'prestamo.interes.label', default: 'Interes')}" />
					
						<g:sortableColumn property="monto" title="${message(code: 'prestamo.monto.label', default: 'Monto')}" />
					
						<g:sortableColumn property="plazo" title="${message(code: 'prestamo.plazo.label', default: 'Plazo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${prestamoInstanceList}" status="i" var="prestamoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${prestamoInstance.id}">${fieldValue(bean: prestamoInstance, field: "empleado")}</g:link></td>
					
						<td><g:formatDate date="${prestamoInstance.fin}" /></td>
					
						<td><g:formatDate date="${prestamoInstance.inicio}" /></td>
					
						<td>${fieldValue(bean: prestamoInstance, field: "interes")}</td>
					
						<td>${fieldValue(bean: prestamoInstance, field: "monto")}</td>
					
						<td>${fieldValue(bean: prestamoInstance, field: "plazo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${prestamoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
