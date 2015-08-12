<%@ page import="contable.core.Empresa" %>



<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="empresa.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="2" required="" class="form-control  required unique noEspacios" value="${empresaInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="empresa.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="50" required="" class="form-control  required" value="${empresaInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} required">
	<label for="direccion">
		<g:message code="empresa.direccion.label" default="Direccion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="direccion" maxlength="50" required="" class="form-control  required" value="${empresaInstance?.direccion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'telefono', 'error')} required">
	<label for="telefono">
		<g:message code="empresa.telefono.label" default="Telefono" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="telefono" maxlength="15" required="" class="form-control  required" value="${empresaInstance?.telefono}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'fax', 'error')} required">
	<label for="fax">
		<g:message code="empresa.fax.label" default="Fax" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fax" maxlength="15" required="" class="form-control  required" value="${empresaInstance?.fax}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'casilla', 'error')} required">
	<label for="casilla">
		<g:message code="empresa.casilla.label" default="Casilla" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="casilla" maxlength="15" required="" class="form-control  required" value="${empresaInstance?.casilla}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'secuencialFactura', 'error')} required">
	<label for="secuencialFactura">
		<g:message code="empresa.secuencialFactura.label" default="Secuencial Factura" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="secuencialFactura" value="${empresaInstance.secuencialFactura}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'secuencialComprobante', 'error')} required">
	<label for="secuencialComprobante">
		<g:message code="empresa.secuencialComprobante.label" default="Secuencial Comprobante" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="secuencialComprobante" value="${empresaInstance.secuencialComprobante}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'secuencialIngreso', 'error')} required">
	<label for="secuencialIngreso">
		<g:message code="empresa.secuencialIngreso.label" default="Secuencial Ingreso" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="secuencialIngreso" value="${empresaInstance.secuencialIngreso}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'secuencialEgreso', 'error')} required">
	<label for="secuencialEgreso">
		<g:message code="empresa.secuencialEgreso.label" default="Secuencial Egreso" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="secuencialEgreso" value="${empresaInstance.secuencialEgreso}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'secuencialDiario', 'error')} required">
	<label for="secuencialDiario">
		<g:message code="empresa.secuencialDiario.label" default="Secuencial Diario" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="secuencialDiario" value="${empresaInstance.secuencialDiario}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'porcentajeIva', 'error')} required">
	<label for="porcentajeIva">
		<g:message code="empresa.porcentajeIva.label" default="Porcentaje Iva" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="porcentajeIva" value="${fieldValue(bean: empresaInstance, field: 'porcentajeIva')}" class="number form-control   required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'representante', 'error')} required">
	<label for="representante">
		<g:message code="empresa.representante.label" default="Representante" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="representante" maxlength="50" required="" class="form-control  required" value="${empresaInstance?.representante}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'contador', 'error')} required">
	<label for="contador">
		<g:message code="empresa.contador.label" default="Contador" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="contador" maxlength="50" required="" class="form-control  required" value="${empresaInstance?.contador}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'ruc', 'error')} required">
	<label for="ruc">
		<g:message code="empresa.ruc.label" default="Ruc" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="ruc" maxlength="13" required="" class="form-control  required" value="${empresaInstance?.ruc}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="empresa.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<div class="input-group"><span class="input-group-addon"><i class="fa fa-envelope"></i></span><g:field type="email" name="email" maxlength="30" required="" class="form-control  required unique noEspacios" value="${empresaInstance?.email}"/></div>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'moneda', 'error')} required">
	<label for="moneda">
		<g:message code="empresa.moneda.label" default="Moneda" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="moneda" maxlength="3" required="" class="form-control  required" value="${empresaInstance?.moneda}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'anio', 'error')} required">
	<label for="anio">
		<g:message code="empresa.anio.label" default="Anio" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="anio" value="${empresaInstance.anio}" class="digits form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'comodin', 'error')} ">
	<label for="comodin">
		<g:message code="empresa.comodin.label" default="Comodin" />
		
	</label>
	<g:textField name="comodin" maxlength="1" class="form-control " value="${empresaInstance?.comodin}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'principal', 'error')} ">
	<label for="principal">
		<g:message code="empresa.principal.label" default="Principal" />
		
	</label>
	<g:textField name="principal" maxlength="1" class="form-control " value="${empresaInstance?.principal}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'cedulaContador', 'error')} ">
	<label for="cedulaContador">
		<g:message code="empresa.cedulaContador.label" default="Cedula Contador" />
		
	</label>
	<g:textField name="cedulaContador" maxlength="13" class="form-control " value="${empresaInstance?.cedulaContador}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'cedulaRepresentante', 'error')} ">
	<label for="cedulaRepresentante">
		<g:message code="empresa.cedulaRepresentante.label" default="Cedula Representante" />
		
	</label>
	<g:textField name="cedulaRepresentante" maxlength="13" class="form-control " value="${empresaInstance?.cedulaRepresentante}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'tipoRepresentante', 'error')} ">
	<label for="tipoRepresentante">
		<g:message code="empresa.tipoRepresentante.label" default="Tipo Representante" />
		
	</label>
	<g:textField name="tipoRepresentante" maxlength="1" class="form-control " value="${empresaInstance?.tipoRepresentante}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'numeroCopias', 'error')} ">
	<label for="numeroCopias">
		<g:message code="empresa.numeroCopias.label" default="Numero Copias" />
		
	</label>
	<g:textField name="numeroCopias" value="${empresaInstance.numeroCopias}" class="digits form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'secucialTransporte', 'error')} ">
	<label for="secucialTransporte">
		<g:message code="empresa.secucialTransporte.label" default="Secucial Transporte" />
		
	</label>
	<g:textField name="secucialTransporte" value="${empresaInstance.secucialTransporte}" class="digits form-control "/>
</div>

