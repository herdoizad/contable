<%@ page import="contable.nomina.Asistencia" %>



<div class="fieldcontain ${hasErrors(bean: asistenciaInstance, field: 'empleado', 'error')} required">
	<label for="empleado">
		<g:message code="asistencia.empleado.label" default="Empleado" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empleado" name="empleado.id" from="${contable.nomina.Empleado.list()}" optionKey="id" required="" value="${asistenciaInstance?.empleado?.id}" class="many-to-one form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: asistenciaInstance, field: 'horas', 'error')} required">
	<label for="horas">
		<g:message code="asistencia.horas.label" default="Horas" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="horas" value="${fieldValue(bean: asistenciaInstance, field: 'horas')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: asistenciaInstance, field: 'mes', 'error')} required">
	<label for="mes">
		<g:message code="asistencia.mes.label" default="Mes" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="mes" name="mes.id" from="${contable.nomina.MesNomina.list()}" optionKey="id" required="" value="${asistenciaInstance?.mes?.id}" class="many-to-one form-control "/>
</div>

