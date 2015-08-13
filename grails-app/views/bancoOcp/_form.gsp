<%@ page import="contable.core.BancoOcp" %>



<div class="fieldcontain ${hasErrors(bean: bancoOcpInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="bancoOcp.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="3" required="" class="form-control  required unique noEspacios" value="${bancoOcpInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoOcpInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="bancoOcp.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="60" required="" class="form-control  required" value="${bancoOcpInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoOcpInstance, field: 'creacion', 'error')} ">
	<label for="creacion">
		<g:message code="bancoOcp.creacion.label" default="Creacion" />
		
	</label>
	<elm:datepicker name="creacion"  class="datepicker form-control " value="${bancoOcpInstance?.creacion}" />
</div>

<div class="fieldcontain ${hasErrors(bean: bancoOcpInstance, field: 'usuario', 'error')} ">
	<label for="usuario">
		<g:message code="bancoOcp.usuario.label" default="Usuario" />
		
	</label>
	<g:textField name="usuario" maxlength="20" class="form-control  noEspacios" value="${bancoOcpInstance?.usuario}"/>
</div>

