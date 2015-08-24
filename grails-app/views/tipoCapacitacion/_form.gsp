<%@ page import="contable.nomina.TipoCapacitacion" %>



<div class="fieldcontain ${hasErrors(bean: tipoCapacitacionInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoCapacitacion.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${tipoCapacitacionInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoCapacitacionInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoCapacitacion.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="100" required="" class="form-control  required" value="${tipoCapacitacionInstance?.descripcion}"/>
</div>

