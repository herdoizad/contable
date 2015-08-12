<%@ page import="contable.core.Cliente" %>



<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="cliente.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="8" required="" class="form-control  required unique noEspacios" value="${clienteInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'cp', 'error')} required">
	<label for="cp">
		<g:message code="cliente.cp.label" default="Cp" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cp" maxlength="100" required="" class="form-control  required" value="${clienteInstance?.cp}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'auxiliar', 'error')} ">
	<label for="auxiliar">
		<g:message code="cliente.auxiliar.label" default="Auxiliar" />
		
	</label>
	<g:textField name="auxiliar" maxlength="15" class="form-control " value="${clienteInstance?.auxiliar}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'auxiliar2', 'error')} ">
	<label for="auxiliar2">
		<g:message code="cliente.auxiliar2.label" default="Auxiliar2" />
		
	</label>
	<g:textField name="auxiliar2" maxlength="15" class="form-control " value="${clienteInstance?.auxiliar2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'nombre', 'error')} ">
	<label for="nombre">
		<g:message code="cliente.nombre.label" default="Nombre" />
		
	</label>
	<g:textField name="nombre" maxlength="50" class="form-control " value="${clienteInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'ruc', 'error')} ">
	<label for="ruc">
		<g:message code="cliente.ruc.label" default="Ruc" />
		
	</label>
	<g:textField name="ruc" maxlength="13" class="form-control " value="${clienteInstance?.ruc}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'ciudad', 'error')} ">
	<label for="ciudad">
		<g:message code="cliente.ciudad.label" default="Ciudad" />
		
	</label>
	<g:textField name="ciudad" maxlength="20" class="form-control " value="${clienteInstance?.ciudad}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'direccion', 'error')} ">
	<label for="direccion">
		<g:message code="cliente.direccion.label" default="Direccion" />
		
	</label>
	<g:textField name="direccion" maxlength="50" class="form-control " value="${clienteInstance?.direccion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'telefono', 'error')} ">
	<label for="telefono">
		<g:message code="cliente.telefono.label" default="Telefono" />
		
	</label>
	<g:textField name="telefono" maxlength="10" class="form-control " value="${clienteInstance?.telefono}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'fax', 'error')} ">
	<label for="fax">
		<g:message code="cliente.fax.label" default="Fax" />
		
	</label>
	<g:textField name="fax" maxlength="10" class="form-control " value="${clienteInstance?.fax}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'contacto', 'error')} ">
	<label for="contacto">
		<g:message code="cliente.contacto.label" default="Contacto" />
		
	</label>
	<g:textField name="contacto" maxlength="50" class="form-control " value="${clienteInstance?.contacto}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'observacion', 'error')} ">
	<label for="observacion">
		<g:message code="cliente.observacion.label" default="Observacion" />
		
	</label>
	<g:textArea name="observacion" cols="40" rows="5" maxlength="255" class="form-control " value="${clienteInstance?.observacion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'codigoLista', 'error')} ">
	<label for="codigoLista">
		<g:message code="cliente.codigoLista.label" default="Codigo Lista" />
		
	</label>
	<g:textField name="codigoLista" maxlength="4" class="form-control  unique noEspacios" value="${clienteInstance?.codigoLista}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'tipo', 'error')} ">
	<label for="tipo">
		<g:message code="cliente.tipo.label" default="Tipo" />
		
	</label>
	<g:textField name="tipo" value="${clienteInstance.tipo}" class="digits form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="cliente.email.label" default="Email" />
		
	</label>
	<div class="input-group"><span class="input-group-addon"><i class="fa fa-envelope"></i></span><g:field type="email" name="email" maxlength="90" class="form-control  unique noEspacios" value="${clienteInstance?.email}"/></div>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'cuentaPorCobrar', 'error')} ">
	<label for="cuentaPorCobrar">
		<g:message code="cliente.cuentaPorCobrar.label" default="Cuenta Por Cobrar" />
		
	</label>
	<g:textField name="cuentaPorCobrar" maxlength="15" class="form-control " value="${clienteInstance?.cuentaPorCobrar}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'cuentaPorPagar', 'error')} ">
	<label for="cuentaPorPagar">
		<g:message code="cliente.cuentaPorPagar.label" default="Cuenta Por Pagar" />
		
	</label>
	<g:textField name="cuentaPorPagar" maxlength="15" class="form-control " value="${clienteInstance?.cuentaPorPagar}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'usuario', 'error')} required">
	<label for="usuario">
		<g:message code="cliente.usuario.label" default="Usuario" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="usuario" maxlength="16" required="" class="form-control  required noEspacios" value="${clienteInstance?.usuario}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'proveedor', 'error')} ">
	<label for="proveedor">
		<g:message code="cliente.proveedor.label" default="Proveedor" />
		
	</label>
	<g:textField name="proveedor" maxlength="1" class="form-control " value="${clienteInstance?.proveedor}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'cliente', 'error')} ">
	<label for="cliente">
		<g:message code="cliente.cliente.label" default="Cliente" />
		
	</label>
	<g:textField name="cliente" maxlength="1" class="form-control " value="${clienteInstance?.cliente}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'codigoVendedor', 'error')} ">
	<label for="codigoVendedor">
		<g:message code="cliente.codigoVendedor.label" default="Codigo Vendedor" />
		
	</label>
	<g:textField name="codigoVendedor" value="${clienteInstance.codigoVendedor}" class="digits form-control "/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'aceptaMora', 'error')} ">
	<label for="aceptaMora">
		<g:message code="cliente.aceptaMora.label" default="Acepta Mora" />
		
	</label>
	<g:textField name="aceptaMora" maxlength="1" class="form-control " value="${clienteInstance?.aceptaMora}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'cuentaAnticipos', 'error')} ">
	<label for="cuentaAnticipos">
		<g:message code="cliente.cuentaAnticipos.label" default="Cuenta Anticipos" />
		
	</label>
	<g:textField name="cuentaAnticipos" maxlength="15" class="form-control " value="${clienteInstance?.cuentaAnticipos}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'contibuyenteEspecial', 'error')} ">
	<label for="contibuyenteEspecial">
		<g:message code="cliente.contibuyenteEspecial.label" default="Contibuyente Especial" />
		
	</label>
	<g:textField name="contibuyenteEspecial" maxlength="1" class="form-control " value="${clienteInstance?.contibuyenteEspecial}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'cuentaPrestamos', 'error')} ">
	<label for="cuentaPrestamos">
		<g:message code="cliente.cuentaPrestamos.label" default="Cuenta Prestamos" />
		
	</label>
	<g:textField name="cuentaPrestamos" maxlength="15" class="form-control " value="${clienteInstance?.cuentaPrestamos}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'retieneFuente', 'error')} ">
	<label for="retieneFuente">
		<g:message code="cliente.retieneFuente.label" default="Retiene Fuente" />
		
	</label>
	<g:textField name="retieneFuente" maxlength="1" class="form-control " value="${clienteInstance?.retieneFuente}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'banco', 'error')} ">
	<label for="banco">
		<g:message code="cliente.banco.label" default="Banco" />
		
	</label>
	<g:textField name="banco" maxlength="3" class="form-control " value="${clienteInstance?.banco}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'tipoCuenta', 'error')} ">
	<label for="tipoCuenta">
		<g:message code="cliente.tipoCuenta.label" default="Tipo Cuenta" />
		
	</label>
	<g:textField name="tipoCuenta" maxlength="3" class="form-control " value="${clienteInstance?.tipoCuenta}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'numeroCuenta', 'error')} ">
	<label for="numeroCuenta">
		<g:message code="cliente.numeroCuenta.label" default="Numero Cuenta" />
		
	</label>
	<g:textField name="numeroCuenta" maxlength="20" class="form-control " value="${clienteInstance?.numeroCuenta}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'tipoid', 'error')} ">
	<label for="tipoid">
		<g:message code="cliente.tipoid.label" default="Tipoid" />
		
	</label>
	<g:textField name="tipoid" maxlength="2" class="form-control " value="${clienteInstance?.tipoid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'creacion', 'error')} required">
	<label for="creacion">
		<g:message code="cliente.creacion.label" default="Creacion" />
		<span class="required-indicator">*</span>
	</label>
	<elm:datepicker name="creacion"  class="datepicker form-control  required" value="${clienteInstance?.creacion}" />
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'empresa', 'error')} required">
	<label for="empresa">
		<g:message code="cliente.empresa.label" default="Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empresa" name="empresa.id" from="${contable.core.Empresa.list()}" optionKey="id" required="" value="${clienteInstance?.empresa?.id}" class="many-to-one form-control "/>
</div>

