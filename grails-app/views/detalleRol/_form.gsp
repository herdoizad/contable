<%@ page import="contable.nomina.DetalleRol" %>



<div class="fieldcontain ${hasErrors(bean: detalleRolInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="detalleRol.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="150" required="" class="form-control  required" value="${detalleRolInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: detalleRolInstance, field: 'usuario', 'error')} required">
	<label for="usuario">
		<g:message code="detalleRol.usuario.label" default="Usuario" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="usuario" maxlength="15" required="" class="form-control  required noEspacios" value="${detalleRolInstance?.usuario}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: detalleRolInstance, field: 'modificacion', 'error')} ">
	<label for="modificacion">
		<g:message code="detalleRol.modificacion.label" default="Modificacion" />
		
	</label>
	<elm:datepicker name="modificacion"  class="datepicker form-control " value="${detalleRolInstance?.modificacion}" />
</div>

<div class="fieldcontain ${hasErrors(bean: detalleRolInstance, field: 'registro', 'error')} required">
	<label for="registro">
		<g:message code="detalleRol.registro.label" default="Registro" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="registro"  class="datepicker form-control  required" value="${detalleRolInstance?.registro}" />
</div>

<div class="fieldcontain ${hasErrors(bean: detalleRolInstance, field: 'rol', 'error')} required">
	<label for="rol">
		<g:message code="detalleRol.rol.label" default="Rol" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="rol" name="rol.id" from="${contable.nomina.Rol.list()}" optionKey="id" required="" value="${detalleRolInstance?.rol?.id}" class="many-to-one form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: detalleRolInstance, field: 'signo', 'error')} required">
	<label for="signo">
		<g:message code="detalleRol.signo.label" default="Signo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="signo" value="${detalleRolInstance.signo}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: detalleRolInstance, field: 'valor', 'error')} required">
	<label for="valor">
		<g:message code="detalleRol.valor.label" default="Valor" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="valor" value="${fieldValue(bean: detalleRolInstance, field: 'valor')}" class="number form-control   required" required=""/>
</div>

