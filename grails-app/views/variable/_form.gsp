<%@ page import="contable.nomina.Variable" %>



<div class="fieldcontain ${hasErrors(bean: variableInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="variable.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" maxlength="100" required="" class="form-control  required" value="${variableInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: variableInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="variable.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="20" required="" class="form-control  required unique noEspacios" value="${variableInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: variableInstance, field: 'sql', 'error')} ">
	<label for="sql">
		<g:message code="variable.sql.label" default="Sql" />
		
	</label>
	<g:textField name="sql" class="form-control " value="${variableInstance?.sql}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: variableInstance, field: 'valor', 'error')} ">
	<label for="valor">
		<g:message code="variable.valor.label" default="Valor" />
		
	</label>
	<g:textField name="valor" value="${fieldValue(bean: variableInstance, field: 'valor')}" class="number form-control  "/>
</div>

