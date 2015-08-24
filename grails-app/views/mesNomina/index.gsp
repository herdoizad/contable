
<%@ page import="contable.nomina.MesNomina" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mesNomina.label', default: 'MesNomina')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-mesNomina" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-mesNomina" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="descripcion" title="${message(code: 'mesNomina.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="codigo" title="${message(code: 'mesNomina.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="diasLaborables" title="${message(code: 'mesNomina.diasLaborables.label', default: 'Dias Laborables')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${mesNominaInstanceList}" status="i" var="mesNominaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${mesNominaInstance.id}">${fieldValue(bean: mesNominaInstance, field: "descripcion")}</g:link></td>
					
						<td>${fieldValue(bean: mesNominaInstance, field: "codigo")}</td>
					
						<td>${fieldValue(bean: mesNominaInstance, field: "diasLaborables")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${mesNominaInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
