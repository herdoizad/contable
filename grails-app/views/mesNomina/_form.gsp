<%@ page import="contable.nomina.MesNomina" %>



<div class="fieldcontain ${hasErrors(bean: mesNominaInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="mesNomina.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="40" required="" class="form-control  required" value="${mesNominaInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mesNominaInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="mesNomina.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" value="${mesNominaInstance.codigo}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: mesNominaInstance, field: 'diasLaborables', 'error')} required">
	<label for="diasLaborables">
		<g:message code="mesNomina.diasLaborables.label" default="Dias Laborables" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="diasLaborables" value="${mesNominaInstance.diasLaborables}" class="digits form-control  required" required=""/>
</div>

