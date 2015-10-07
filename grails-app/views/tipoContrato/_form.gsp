<%@ page import="contable.nomina.TipoContrato" %>



<div class="fieldcontain ${hasErrors(bean: tipoContratoInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoContrato.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${tipoContratoInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoContratoInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoContrato.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="100" required="" class="form-control  required" value="${tipoContratoInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoContratoInstance, field: 'procedimiento', 'error')} ">
	<label for="procedimiento">
		<g:message code="tipoContrato.procedimiento.label" default="Procedimiento" />
		
	</label>
	<g:textField name="procedimiento" maxlength="100" class="form-control " value="${tipoContratoInstance?.procedimiento}"/>
</div>

