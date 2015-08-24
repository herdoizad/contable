<%@ page import="contable.nomina.Relacion" %>



<div class="fieldcontain ${hasErrors(bean: relacionInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="relacion.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${relacionInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: relacionInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="relacion.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="100" required="" class="form-control  required" value="${relacionInstance?.descripcion}"/>
</div>

