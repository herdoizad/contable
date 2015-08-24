
<%@ page import="contable.nomina.PrevisionGastos" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'previsionGastos.label', default: 'PrevisionGastos')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-previsionGastos" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-previsionGastos" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="anio" title="${message(code: 'previsionGastos.anio.label', default: 'Anio')}" />
					
						<th><g:message code="previsionGastos.empleado.label" default="Empleado" /></th>
					
						<g:sortableColumn property="totalAlimentacion" title="${message(code: 'previsionGastos.totalAlimentacion.label', default: 'Total Alimentacion')}" />
					
						<g:sortableColumn property="totalEducacion" title="${message(code: 'previsionGastos.totalEducacion.label', default: 'Total Educacion')}" />
					
						<g:sortableColumn property="totalSalud" title="${message(code: 'previsionGastos.totalSalud.label', default: 'Total Salud')}" />
					
						<g:sortableColumn property="totalVestimenta" title="${message(code: 'previsionGastos.totalVestimenta.label', default: 'Total Vestimenta')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${previsionGastosInstanceList}" status="i" var="previsionGastosInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${previsionGastosInstance.id}">${fieldValue(bean: previsionGastosInstance, field: "anio")}</g:link></td>
					
						<td>${fieldValue(bean: previsionGastosInstance, field: "empleado")}</td>
					
						<td>${fieldValue(bean: previsionGastosInstance, field: "totalAlimentacion")}</td>
					
						<td>${fieldValue(bean: previsionGastosInstance, field: "totalEducacion")}</td>
					
						<td>${fieldValue(bean: previsionGastosInstance, field: "totalSalud")}</td>
					
						<td>${fieldValue(bean: previsionGastosInstance, field: "totalVestimenta")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${previsionGastosInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
