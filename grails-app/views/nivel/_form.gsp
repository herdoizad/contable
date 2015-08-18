<%@ page import="contable.core.Nivel" %>



<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="nivel.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="2" required="" class="form-control  required unique noEspacios" value="${nivelInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivelDesc1', 'error')} required">
	<label for="nivelDesc1">
		<g:message code="nivel.nivelDesc1.label" default="Nivel Desc1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivelDesc1" maxlength="15" required="" class="form-control  required" value="${nivelInstance?.nivelDesc1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivelDesc2', 'error')} required">
	<label for="nivelDesc2">
		<g:message code="nivel.nivelDesc2.label" default="Nivel Desc2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivelDesc2" maxlength="15" required="" class="form-control  required" value="${nivelInstance?.nivelDesc2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivelDesc3', 'error')} required">
	<label for="nivelDesc3">
		<g:message code="nivel.nivelDesc3.label" default="Nivel Desc3" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivelDesc3" maxlength="15" required="" class="form-control  required" value="${nivelInstance?.nivelDesc3}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivelDesc4', 'error')} required">
	<label for="nivelDesc4">
		<g:message code="nivel.nivelDesc4.label" default="Nivel Desc4" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivelDesc4" maxlength="15" required="" class="form-control  required" value="${nivelInstance?.nivelDesc4}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivelDesc5', 'error')} ">
	<label for="nivelDesc5">
		<g:message code="nivel.nivelDesc5.label" default="Nivel Desc5" />
		
	</label>
	<g:textField name="nivelDesc5" maxlength="15" class="form-control " value="${nivelInstance?.nivelDesc5}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivel5', 'error')} ">
	<label for="nivel5">
		<g:message code="nivel.nivel5.label" default="Nivel5" />
		
	</label>
	<g:textField name="nivel5" value="${nivelInstance.nivel5}" class="digits form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivelDesc6', 'error')} ">
	<label for="nivelDesc6">
		<g:message code="nivel.nivelDesc6.label" default="Nivel Desc6" />
		
	</label>
	<g:textField name="nivelDesc6" maxlength="15" class="form-control " value="${nivelInstance?.nivelDesc6}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'usuario', 'error')} required">
	<label for="usuario">
		<g:message code="nivel.usuario.label" default="Usuario" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="usuario" maxlength="16" required="" class="form-control  required noEspacios" value="${nivelInstance?.usuario}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'creacion', 'error')} required">
	<label for="creacion">
		<g:message code="nivel.creacion.label" default="Creacion" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="creacion"  class="datepicker form-control  required" value="${nivelInstance?.creacion}" />
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivel1', 'error')} required">
	<label for="nivel1">
		<g:message code="nivel.nivel1.label" default="Nivel1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivel1" value="${nivelInstance.nivel1}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivel2', 'error')} required">
	<label for="nivel2">
		<g:message code="nivel.nivel2.label" default="Nivel2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivel2" value="${nivelInstance.nivel2}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivel3', 'error')} required">
	<label for="nivel3">
		<g:message code="nivel.nivel3.label" default="Nivel3" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivel3" value="${nivelInstance.nivel3}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivel4', 'error')} required">
	<label for="nivel4">
		<g:message code="nivel.nivel4.label" default="Nivel4" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivel4" value="${nivelInstance.nivel4}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'nivel6', 'error')} required">
	<label for="nivel6">
		<g:message code="nivel.nivel6.label" default="Nivel6" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nivel6" value="${nivelInstance.nivel6}" class="digits form-control  required" required=""/>
</div>

