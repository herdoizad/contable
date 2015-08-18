
<%@ page import="contable.core.Nivel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'nivel.label', default: 'Nivel')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-nivel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-nivel" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="codigo" title="${message(code: 'nivel.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="nivelDesc1" title="${message(code: 'nivel.nivelDesc1.label', default: 'Nivel Desc1')}" />
					
						<g:sortableColumn property="nivelDesc2" title="${message(code: 'nivel.nivelDesc2.label', default: 'Nivel Desc2')}" />
					
						<g:sortableColumn property="nivelDesc3" title="${message(code: 'nivel.nivelDesc3.label', default: 'Nivel Desc3')}" />
					
						<g:sortableColumn property="nivelDesc4" title="${message(code: 'nivel.nivelDesc4.label', default: 'Nivel Desc4')}" />
					
						<g:sortableColumn property="nivelDesc5" title="${message(code: 'nivel.nivelDesc5.label', default: 'Nivel Desc5')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${nivelInstanceList}" status="i" var="nivelInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${nivelInstance.id}">${fieldValue(bean: nivelInstance, field: "codigo")}</g:link></td>
					
						<td>${fieldValue(bean: nivelInstance, field: "nivelDesc1")}</td>
					
						<td>${fieldValue(bean: nivelInstance, field: "nivelDesc2")}</td>
					
						<td>${fieldValue(bean: nivelInstance, field: "nivelDesc3")}</td>
					
						<td>${fieldValue(bean: nivelInstance, field: "nivelDesc4")}</td>
					
						<td>${fieldValue(bean: nivelInstance, field: "nivelDesc5")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${nivelInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
