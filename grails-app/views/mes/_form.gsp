<%@ page import="contable.core.Mes" %>



<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'estado', 'error')} required">
	<label for="estado">
		<g:message code="mes.estado.label" default="Estado" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="estado" maxlength="1" required="" class="form-control  required" value="${mesInstance?.estado}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'periodoSri', 'error')} ">
	<label for="periodoSri">
		<g:message code="mes.periodoSri.label" default="Periodo Sri" />
		
	</label>
	<g:textField name="periodoSri" maxlength="5" class="form-control " value="${mesInstance?.periodoSri}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="mes.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="50" class="form-control " value="${mesInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="mes.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" value="${mesInstance.codigo}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'creacion', 'error')} required">
	<label for="creacion">
		<g:message code="mes.creacion.label" default="Creacion" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="creacion"  class="datepicker form-control  required" value="${mesInstance?.creacion}" />
</div>

<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'empresa', 'error')} required">
	<label for="empresa">
		<g:message code="mes.empresa.label" default="Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empresa" name="empresa.id" from="${contable.core.Empresa.list()}" optionKey="id" optionValue="descripcion" required="" value="${mesInstance?.empresa?.id}" class="many-to-one form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'fin', 'error')} required">
	<label for="fin">
		<g:message code="mes.fin.label" default="Fin" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="fin"  class="datepicker form-control  required" value="${mesInstance?.fin}" />
</div>

<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'inicio', 'error')} required">
	<label for="inicio">
		<g:message code="mes.inicio.label" default="Inicio" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="inicio"  class="datepicker form-control  required" value="${mesInstance?.inicio}" />
</div>

<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'usuario', 'error')} required">
	<label for="usuario">
		<g:message code="mes.usuario.label" default="Usuario" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="usuario" required="" class="form-control  required noEspacios" value="${mesInstance?.usuario}"/>
</div>

