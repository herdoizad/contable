<%@ page import="contable.nomina.Prestamo" %>



<div class="fieldcontain ${hasErrors(bean: prestamoInstance, field: 'empleado', 'error')} required">
	<label for="empleado">
		<g:message code="prestamo.empleado.label" default="Empleado" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empleado" name="empleado.id" from="${contable.nomina.Empleado.list()}" optionKey="id" required="" value="${prestamoInstance?.empleado?.id}" class="many-to-one form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: prestamoInstance, field: 'fin', 'error')} required">
	<label for="fin">
		<g:message code="prestamo.fin.label" default="Fin" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="fin"  class="datepicker form-control  required" value="${prestamoInstance?.fin}" />
</div>

<div class="fieldcontain ${hasErrors(bean: prestamoInstance, field: 'inicio', 'error')} required">
	<label for="inicio">
		<g:message code="prestamo.inicio.label" default="Inicio" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="inicio"  class="datepicker form-control  required" value="${prestamoInstance?.inicio}" />
</div>

<div class="fieldcontain ${hasErrors(bean: prestamoInstance, field: 'interes', 'error')} required">
	<label for="interes">
		<g:message code="prestamo.interes.label" default="Interes" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="interes" value="${fieldValue(bean: prestamoInstance, field: 'interes')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: prestamoInstance, field: 'monto', 'error')} required">
	<label for="monto">
		<g:message code="prestamo.monto.label" default="Monto" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="monto" value="${fieldValue(bean: prestamoInstance, field: 'monto')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: prestamoInstance, field: 'plazo', 'error')} required">
	<label for="plazo">
		<g:message code="prestamo.plazo.label" default="Plazo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="plazo" value="${prestamoInstance.plazo}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: prestamoInstance, field: 'valorCuota', 'error')} required">
	<label for="valorCuota">
		<g:message code="prestamo.valorCuota.label" default="Valor Cuota" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="valorCuota" value="${fieldValue(bean: prestamoInstance, field: 'valorCuota')}" class="number form-control   required" required=""/>
</div>

