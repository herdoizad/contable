<%@ page import="contable.nomina.Unidad" %>



<div class="fieldcontain ${hasErrors(bean: unidadInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="unidad.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" maxlength="100" required="" class="form-control  required" value="${unidadInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: unidadInstance, field: 'jefe', 'error')} ">
	<label for="jefe">
		<g:message code="unidad.jefe.label" default="Jefe" />
		
	</label>
	<g:select id="jefe" name="jefe.id" from="${contable.nomina.Empleado.list()}" optionKey="id" value="${unidadInstance?.jefe?.id}" class="many-to-one form-control " noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: unidadInstance, field: 'padre', 'error')} ">
	<label for="padre">
		<g:message code="unidad.padre.label" default="Padre" />
		
	</label>
	<g:select id="padre" name="padre.id" from="${contable.nomina.Unidad.list()}" optionKey="id" value="${unidadInstance?.padre?.id}" class="many-to-one form-control " noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: unidadInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="unidad.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="5" required="" class="form-control  required unique noEspacios" value="${unidadInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: unidadInstance, field: 'lugar', 'error')} ">
	<label for="lugar">
		<g:message code="unidad.lugar.label" default="Lugar" />
		
	</label>
	<g:textField name="lugar" maxlength="30" class="form-control " value="${unidadInstance?.lugar}"/>
</div>

