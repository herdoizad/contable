
<%@ page import="contable.nomina.TipoContrato" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tipoContrato.label', default: 'TipoContrato')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tipoContrato" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-tipoContrato" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="codigo" title="${message(code: 'tipoContrato.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'tipoContrato.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="procedimiento" title="${message(code: 'tipoContrato.procedimiento.label', default: 'Procedimiento')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${tipoContratoInstanceList}" status="i" var="tipoContratoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${tipoContratoInstance.id}">${fieldValue(bean: tipoContratoInstance, field: "codigo")}</g:link></td>
					
						<td>${fieldValue(bean: tipoContratoInstance, field: "descripcion")}</td>
					
						<td>${fieldValue(bean: tipoContratoInstance, field: "procedimiento")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${tipoContratoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
