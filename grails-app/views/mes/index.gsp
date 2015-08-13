
<%@ page import="contable.core.Mes" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mes.label', default: 'Mes')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-mes" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-mes" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="estado" title="${message(code: 'mes.estado.label', default: 'Estado')}" />
					
						<g:sortableColumn property="periodoSri" title="${message(code: 'mes.periodoSri.label', default: 'Periodo Sri')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'mes.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="codigo" title="${message(code: 'mes.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="creacion" title="${message(code: 'mes.creacion.label', default: 'Creacion')}" />
					
						<th><g:message code="mes.empresa.label" default="Empresa" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${mesInstanceList}" status="i" var="mesInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${mesInstance.id}">${fieldValue(bean: mesInstance, field: "estado")}</g:link></td>
					
						<td>${fieldValue(bean: mesInstance, field: "periodoSri")}</td>
					
						<td>${fieldValue(bean: mesInstance, field: "descripcion")}</td>
					
						<td>${fieldValue(bean: mesInstance, field: "codigo")}</td>
					
						<td><g:formatDate date="${mesInstance.creacion}" /></td>
					
						<td>${fieldValue(bean: mesInstance, field: "empresa")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${mesInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
