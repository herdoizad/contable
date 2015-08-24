<%@ page import="contable.nomina.ImpuestoRenta" %>



<div class="fieldcontain ${hasErrors(bean: impuestoRentaInstance, field: 'anio', 'error')} required">
	<label for="anio">
		<g:message code="impuestoRenta.anio.label" default="Anio" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="anio" value="${impuestoRentaInstance.anio}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: impuestoRentaInstance, field: 'base', 'error')} required">
	<label for="base">
		<g:message code="impuestoRenta.base.label" default="Base" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="base" value="${fieldValue(bean: impuestoRentaInstance, field: 'base')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: impuestoRentaInstance, field: 'desde', 'error')} required">
	<label for="desde">
		<g:message code="impuestoRenta.desde.label" default="Desde" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="desde" value="${fieldValue(bean: impuestoRentaInstance, field: 'desde')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: impuestoRentaInstance, field: 'hasta', 'error')} required">
	<label for="hasta">
		<g:message code="impuestoRenta.hasta.label" default="Hasta" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="hasta" value="${fieldValue(bean: impuestoRentaInstance, field: 'hasta')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: impuestoRentaInstance, field: 'impuesto', 'error')} required">
	<label for="impuesto">
		<g:message code="impuestoRenta.impuesto.label" default="Impuesto" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="impuesto" value="${fieldValue(bean: impuestoRentaInstance, field: 'impuesto')}" class="number form-control   required" required=""/>
</div>

