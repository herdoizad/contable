<%@ page import="contable.nomina.PrevisionGastos" %>



<div class="fieldcontain ${hasErrors(bean: previsionGastosInstance, field: 'anio', 'error')} required">
	<label for="anio">
		<g:message code="previsionGastos.anio.label" default="Anio" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="anio" value="${previsionGastosInstance.anio}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: previsionGastosInstance, field: 'empleado', 'error')} required">
	<label for="empleado">
		<g:message code="previsionGastos.empleado.label" default="Empleado" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empleado" name="empleado.id" from="${contable.nomina.Empleado.list()}" optionKey="id" required="" value="${previsionGastosInstance?.empleado?.id}" class="many-to-one form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: previsionGastosInstance, field: 'totalAlimentacion', 'error')} required">
	<label for="totalAlimentacion">
		<g:message code="previsionGastos.totalAlimentacion.label" default="Total Alimentacion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalAlimentacion" value="${fieldValue(bean: previsionGastosInstance, field: 'totalAlimentacion')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: previsionGastosInstance, field: 'totalEducacion', 'error')} required">
	<label for="totalEducacion">
		<g:message code="previsionGastos.totalEducacion.label" default="Total Educacion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalEducacion" value="${fieldValue(bean: previsionGastosInstance, field: 'totalEducacion')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: previsionGastosInstance, field: 'totalSalud', 'error')} required">
	<label for="totalSalud">
		<g:message code="previsionGastos.totalSalud.label" default="Total Salud" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalSalud" value="${fieldValue(bean: previsionGastosInstance, field: 'totalSalud')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: previsionGastosInstance, field: 'totalVestimenta', 'error')} required">
	<label for="totalVestimenta">
		<g:message code="previsionGastos.totalVestimenta.label" default="Total Vestimenta" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalVestimenta" value="${fieldValue(bean: previsionGastosInstance, field: 'totalVestimenta')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: previsionGastosInstance, field: 'totalVivienda', 'error')} required">
	<label for="totalVivienda">
		<g:message code="previsionGastos.totalVivienda.label" default="Total Vivienda" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalVivienda" value="${fieldValue(bean: previsionGastosInstance, field: 'totalVivienda')}" class="number form-control   required" required=""/>
</div>

