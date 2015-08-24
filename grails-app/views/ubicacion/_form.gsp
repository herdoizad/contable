<%@ page import="contable.nomina.Ubicacion" %>



<div class="fieldcontain ${hasErrors(bean: ubicacionInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="ubicacion.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" required="" class="form-control  required unique noEspacios" value="${ubicacionInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: ubicacionInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="ubicacion.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" class="form-control  required" value="${ubicacionInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: ubicacionInstance, field: 'padre', 'error')} required">
	<label for="padre">
		<g:message code="ubicacion.padre.label" default="Padre" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="padre" name="padre.id" from="${contable.nomina.Ubicacion.list()}" optionKey="id" required="" value="${ubicacionInstance?.padre?.id}" class="many-to-one form-control "/>
</div>

