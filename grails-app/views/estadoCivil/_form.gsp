<%@ page import="contable.nomina.EstadoCivil" %>



<div class="fieldcontain ${hasErrors(bean: estadoCivilInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="estadoCivil.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${estadoCivilInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estadoCivilInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="estadoCivil.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="100" required="" class="form-control  required" value="${estadoCivilInstance?.descripcion}"/>
</div>

