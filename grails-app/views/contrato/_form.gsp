<%@ page import="contable.nomina.Contrato" %>



<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'numero', 'error')} required">
	<label for="numero">
		<g:message code="contrato.numero.label" default="Numero" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numero" maxlength="30" required="" class="form-control  required" value="${contratoInstance?.numero}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'fin', 'error')} ">
	<label for="fin">
		<g:message code="contrato.fin.label" default="Fin" />
		
	</label>
	<elm:datepicker name="fin"  class="datepicker form-control " value="${contratoInstance?.fin}" />
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'path', 'error')} ">
	<label for="path">
		<g:message code="contrato.path.label" default="Path" />
		
	</label>
	<g:textField name="path" maxlength="150" class="form-control " value="${contratoInstance?.path}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'empleado', 'error')} required">
	<label for="empleado">
		<g:message code="contrato.empleado.label" default="Empleado" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empleado" name="empleado.id" from="${contable.nomina.Empleado.list()}" optionKey="id" required="" value="${contratoInstance?.empleado?.id}" class="many-to-one form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'inicio', 'error')} required">
	<label for="inicio">
		<g:message code="contrato.inicio.label" default="Inicio" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="inicio"  class="datepicker form-control  required" value="${contratoInstance?.inicio}" />
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'sueldo', 'error')} required">
	<label for="sueldo">
		<g:message code="contrato.sueldo.label" default="Sueldo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="sueldo" value="${fieldValue(bean: contratoInstance, field: 'sueldo')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: contratoInstance, field: 'tipo', 'error')} required">
	<label for="tipo">
		<g:message code="contrato.tipo.label" default="Tipo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipo" name="tipo.id" from="${contable.nomina.TipoContrato.list()}" optionKey="id" required="" value="${contratoInstance?.tipo?.id}" class="many-to-one form-control "/>
</div>

