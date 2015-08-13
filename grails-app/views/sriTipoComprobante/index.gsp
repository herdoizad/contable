
<%@ page import="contable.core.SriTipoComprobante" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sriTipoComprobante.label', default: 'SriTipoComprobante')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-sriTipoComprobante" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-sriTipoComprobante" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="codigo" title="${message(code: 'sriTipoComprobante.codigo.label', default: 'Codigo')}" />
					
						<g:sortableColumn property="descripcion" title="${message(code: 'sriTipoComprobante.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="usuario" title="${message(code: 'sriTipoComprobante.usuario.label', default: 'Usuario')}" />
					
						<g:sortableColumn property="compras" title="${message(code: 'sriTipoComprobante.compras.label', default: 'Compras')}" />
					
						<g:sortableColumn property="importaciones" title="${message(code: 'sriTipoComprobante.importaciones.label', default: 'Importaciones')}" />
					
						<g:sortableColumn property="ventas" title="${message(code: 'sriTipoComprobante.ventas.label', default: 'Ventas')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sriTipoComprobanteInstanceList}" status="i" var="sriTipoComprobanteInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sriTipoComprobanteInstance.id}">${fieldValue(bean: sriTipoComprobanteInstance, field: "codigo")}</g:link></td>
					
						<td>${fieldValue(bean: sriTipoComprobanteInstance, field: "descripcion")}</td>
					
						<td>${fieldValue(bean: sriTipoComprobanteInstance, field: "usuario")}</td>
					
						<td>${fieldValue(bean: sriTipoComprobanteInstance, field: "compras")}</td>
					
						<td>${fieldValue(bean: sriTipoComprobanteInstance, field: "importaciones")}</td>
					
						<td>${fieldValue(bean: sriTipoComprobanteInstance, field: "ventas")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sriTipoComprobanteInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
