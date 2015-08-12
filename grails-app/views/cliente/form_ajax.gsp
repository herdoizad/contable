<%@ page import="contable.core.Cliente" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!clienteInstance}">
    <elm:notFound elem="Cliente" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmCliente" id="${clienteInstance?.codigo}"
            role="form" controller="cliente" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-7">
            <g:textField name="codigo" maxlength="8" required="" class="form-control  required unique noEspacios" value="${clienteInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cp" claseField="col-sm-7">
            <g:textField name="cp" maxlength="100" required="" class="form-control  required" value="${clienteInstance?.cp}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Auxiliar" claseField="col-sm-7">
            <g:textField name="auxiliar" maxlength="15" class="form-control " value="${clienteInstance?.auxiliar}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Auxiliar2" claseField="col-sm-7">
            <g:textField name="auxiliar2" maxlength="15" class="form-control " value="${clienteInstance?.auxiliar2}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-7">
            <g:textField name="nombre" maxlength="50" class="form-control " value="${clienteInstance?.nombre}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Ruc" claseField="col-sm-7">
            <g:textField name="ruc" maxlength="13" class="form-control " value="${clienteInstance?.ruc}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Ciudad" claseField="col-sm-7">
            <g:textField name="ciudad" maxlength="20" class="form-control " value="${clienteInstance?.ciudad}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Direccion" claseField="col-sm-7">
            <g:textField name="direccion" maxlength="50" class="form-control " value="${clienteInstance?.direccion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Telefono" claseField="col-sm-7">
            <g:textField name="telefono" maxlength="10" class="form-control " value="${clienteInstance?.telefono}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Fax" claseField="col-sm-7">
            <g:textField name="fax" maxlength="10" class="form-control " value="${clienteInstance?.fax}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Contacto" claseField="col-sm-7">
            <g:textField name="contacto" maxlength="50" class="form-control " value="${clienteInstance?.contacto}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Observacion" claseField="col-sm-7">
            <g:textArea name="observacion" cols="40" rows="5" maxlength="255" class="form-control " value="${clienteInstance?.observacion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo Lista" claseField="col-sm-7">
            <g:textField name="codigoLista" maxlength="4" class="form-control  unique noEspacios" value="${clienteInstance?.codigoLista}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Tipo" claseField="col-sm-3">
            <g:textField name="tipo" value="${clienteInstance.tipo}" class="digits form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Email" claseField="col-sm-7">
            <div class="input-group"><span class="input-group-addon"><i class="fa fa-envelope"></i></span><g:field type="email" name="email" maxlength="90" class="form-control  unique noEspacios" value="${clienteInstance?.email}"/></div>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cuenta Por Cobrar" claseField="col-sm-7">
            <g:textField name="cuentaPorCobrar" maxlength="15" class="form-control " value="${clienteInstance?.cuentaPorCobrar}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cuenta Por Pagar" claseField="col-sm-7">
            <g:textField name="cuentaPorPagar" maxlength="15" class="form-control " value="${clienteInstance?.cuentaPorPagar}"/>
        </elm:fieldRapido>

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Proveedor" claseField="col-sm-7">
            <g:textField name="proveedor" maxlength="1" class="form-control " value="${clienteInstance?.proveedor}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cliente" claseField="col-sm-7">
            <g:textField name="cliente" maxlength="1" class="form-control " value="${clienteInstance?.cliente}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo Vendedor" claseField="col-sm-3">
            <g:textField name="codigoVendedor" value="${clienteInstance.codigoVendedor}" class="digits form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Acepta Mora" claseField="col-sm-7">
            <g:textField name="aceptaMora" maxlength="1" class="form-control " value="${clienteInstance?.aceptaMora}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cuenta Anticipos" claseField="col-sm-7">
            <g:textField name="cuentaAnticipos" maxlength="15" class="form-control " value="${clienteInstance?.cuentaAnticipos}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Contibuyente Especial" claseField="col-sm-7">
            <g:textField name="contibuyenteEspecial" maxlength="1" class="form-control " value="${clienteInstance?.contibuyenteEspecial}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cuenta Prestamos" claseField="col-sm-7">
            <g:textField name="cuentaPrestamos" maxlength="15" class="form-control " value="${clienteInstance?.cuentaPrestamos}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Retiene Fuente" claseField="col-sm-7">
            <g:textField name="retieneFuente" maxlength="1" class="form-control " value="${clienteInstance?.retieneFuente}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Banco" claseField="col-sm-7">
            <g:textField name="banco" maxlength="3" class="form-control " value="${clienteInstance?.banco}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Tipo Cuenta" claseField="col-sm-7">
            <g:textField name="tipoCuenta" maxlength="3" class="form-control " value="${clienteInstance?.tipoCuenta}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Numero Cuenta" claseField="col-sm-7">
            <g:textField name="numeroCuenta" maxlength="20" class="form-control " value="${clienteInstance?.numeroCuenta}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Tipoid" claseField="col-sm-7">
            <g:textField name="tipoid" maxlength="2" class="form-control " value="${clienteInstance?.tipoid}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Creacion" claseField="col-sm-5">
            <elm:datepicker name="creacion"  class="datepicker form-control  required" value="${clienteInstance?.creacion}" />
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Empresa" claseField="col-sm-7">
            <g:select id="empresa" name="empresa.id" from="${contable.core.Empresa.list()}" optionKey="codigo" optionValue="descripcion" required="" value="${clienteInstance?.empresa?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmCliente").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            }
            
            , rules          : {
                
                codigo: {
                    remote: {
                        url: "${createLink(controller:'cliente', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${clienteInstance?.codigo}"
                        }
                    }
                },
                
                codigoLista: {
                    remote: {
                        url: "${createLink(controller:'cliente', action: 'validar_unique_codigoLista_ajax')}",
                        type: "post",
                        data: {
                            id: "${clienteInstance?.codigo}"
                        }
                    }
                },
                
                email: {
                    remote: {
                        url: "${createLink(controller:'cliente', action: 'validar_unique_email_ajax')}",
                        type: "post",
                        data: {
                            id: "${clienteInstance?.codigo}"
                        }
                    }
                },
                
                codigoVendedor: {
                    remote: {
                        url: "${createLink(controller:'cliente', action: 'validar_unique_codigoVendedor_ajax')}",
                        type: "post",
                        data: {
                            id: "${clienteInstance?.codigo}"
                        }
                    }
                }
                
            },
            messages : {
                
                codigo: {
                    remote: "Ya existe Codigo"
                },
                
                codigoLista: {
                    remote: "Ya existe Codigo Lista"
                },
                
                email: {
                    remote: "Ya existe Email"
                },
                
                codigoVendedor: {
                    remote: "Ya existe Codigo Vendedor"
                }
                
            }
            
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormCliente();
                return false;
            }
            return true;
        });
    </script>

</g:else>