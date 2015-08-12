<%@ page import="contable.core.Banco" %>



<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="banco.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${bancoInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="banco.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="30" required="" class="form-control  required" value="${bancoInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'numero', 'error')} required">
	<label for="numero">
		<g:message code="banco.numero.label" default="Numero" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numero" maxlength="20" required="" class="form-control  required" value="${bancoInstance?.numero}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'tipo', 'error')} required">
	<label for="tipo">
		<g:message code="banco.tipo.label" default="Tipo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="tipo" maxlength="1" required="" class="form-control  required" value="${bancoInstance?.tipo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'saldo', 'error')} ">
	<label for="saldo">
		<g:message code="banco.saldo.label" default="Saldo" />
		
	</label>
	<g:textField name="saldo" value="${fieldValue(bean: bancoInstance, field: 'saldo')}" class="number form-control  "/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'fecha', 'error')} ">
	<label for="fecha">
		<g:message code="banco.fecha.label" default="Fecha" />
		
	</label>
	<elm:datepicker name="fecha"  class="datepicker form-control " value="${bancoInstance?.fecha}" />
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'creacion', 'error')} ">
	<label for="creacion">
		<g:message code="banco.creacion.label" default="Creacion" />
		
	</label>
	<elm:datepicker name="creacion"  class="datepicker form-control " value="${bancoInstance?.creacion}" />
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'usuario', 'error')} ">
	<label for="usuario">
		<g:message code="banco.usuario.label" default="Usuario" />
		
	</label>
	<g:textField name="usuario" maxlength="20" class="form-control  noEspacios" value="${bancoInstance?.usuario}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'cuenta', 'error')} required">
	<label for="cuenta">
		<g:message code="banco.cuenta.label" default="Cuenta" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cuenta" name="cuenta.id" from="${contable.core.Cuenta.list()}" optionKey="id" required="" value="${bancoInstance?.cuenta?.id}" class="many-to-one form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'empresa', 'error')} required">
	<label for="empresa">
		<g:message code="banco.empresa.label" default="Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empresa" name="empresa.id" from="${contable.core.Empresa.list()}" optionKey="id" required="" value="${bancoInstance?.empresa?.id}" class="many-to-one form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'ultimoCheque', 'error')} required">
	<label for="ultimoCheque">
		<g:message code="banco.ultimoCheque.label" default="Ultimo Cheque" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="ultimoCheque" value="${bancoInstance.ultimoCheque}" class="digits form-control  required" required=""/>
</div>

