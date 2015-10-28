<%@ page import="contable.nomina.TipoPrestamo" %>



<div class="fieldcontain ${hasErrors(bean: tipoPrestamoInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoPrestamo.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${tipoPrestamoInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoPrestamoInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoPrestamo.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="100" required="" class="form-control  required" value="${tipoPrestamoInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoPrestamoInstance, field: 'diasDeGracia', 'error')} ">
	<label for="diasDeGracia">
		<g:message code="tipoPrestamo.diasDeGracia.label" default="Dias De Gracia" />
		
	</label>
	<g:textField name="diasDeGracia" value="${tipoPrestamoInstance.diasDeGracia}" class="digits form-control "/>
</div>

