<%@ page import="contable.core.SriTipoComprobante" %>



<div class="fieldcontain ${hasErrors(bean: sriTipoComprobanteInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="sriTipoComprobante.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="2" required="" class="form-control  required unique noEspacios" value="${sriTipoComprobanteInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sriTipoComprobanteInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="sriTipoComprobante.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="60" required="" class="form-control  required" value="${sriTipoComprobanteInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sriTipoComprobanteInstance, field: 'usuario', 'error')} required">
	<label for="usuario">
		<g:message code="sriTipoComprobante.usuario.label" default="Usuario" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="usuario" maxlength="16" required="" class="form-control  required noEspacios" value="${sriTipoComprobanteInstance?.usuario}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sriTipoComprobanteInstance, field: 'compras', 'error')} ">
	<label for="compras">
		<g:message code="sriTipoComprobante.compras.label" default="Compras" />
		
	</label>
	<g:textField name="compras" value="${sriTipoComprobanteInstance.compras}" class="digits form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: sriTipoComprobanteInstance, field: 'importaciones', 'error')} ">
	<label for="importaciones">
		<g:message code="sriTipoComprobante.importaciones.label" default="Importaciones" />
		
	</label>
	<g:textField name="importaciones" value="${sriTipoComprobanteInstance.importaciones}" class="digits form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: sriTipoComprobanteInstance, field: 'ventas', 'error')} ">
	<label for="ventas">
		<g:message code="sriTipoComprobante.ventas.label" default="Ventas" />
		
	</label>
	<g:textField name="ventas" value="${sriTipoComprobanteInstance.ventas}" class="digits form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: sriTipoComprobanteInstance, field: 'crea', 'error')} required">
	<label for="crea">
		<g:message code="sriTipoComprobante.crea.label" default="Crea" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="crea"  class="datepicker form-control  required" value="${sriTipoComprobanteInstance?.crea}" />
</div>

