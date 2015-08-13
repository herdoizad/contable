<%@ page import="contable.core.Cliente" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!clienteInstance}">
    <elm:notFound elem="Cliente" genero="o" />
</g:if>
<g:else>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmCliente" id="${clienteInstance?.codigo}"
            role="form" controller="cliente" action="save_ajax" method="POST">
        <div class="row fila" >
            <div class="col-md-2 text-right">
                <label>Código</label>
            </div>
            <div class="col-md-2">
                <g:textField name="codigo" maxlength="8" required="" class="form-control input-sm required unique noEspacios" value="${clienteInstance?.codigo}"/>
            </div>
            <div class="col-md-1 text-right">
                <label>Ruc</label>
            </div>
            <div class="col-md-2">
                <g:textField name="ruc" maxlength="13" required="" class="form-control  input-sm  required number digits" value="${clienteInstance?.ruc}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2 text-right">
                <label>Nombre</label>
            </div>
            <div class="col-md-4">
                <g:textField name="nombre" maxlength="50" class="form-control input-sm  " value="${clienteInstance?.nombre?.trim()}"/>
            </div>
            <div class="col-md-1 text-right">
                <label>Ciudad</label>
            </div>
            <div class="col-md-2">
                <g:textField name="ciudad" maxlength="20" class="form-control  input-sm " value="${clienteInstance?.ciudad?.trim()}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2 text-right">
                <label>Representante</label>
            </div>
            <div class="col-md-4">
                <g:textField name="cp" maxlength="50" class="form-control  input-sm " value="${clienteInstance?.cp?.trim()}"/>
            </div>
            <div class="col-md-1 text-right">
                <label>Contacto</label>
            </div>
            <div class="col-md-4">
                <g:textField name="contacto" maxlength="50" class="form-control  input-sm " value="${clienteInstance?.contacto?.trim()}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2 text-right">
                <label>Direccion</label>
            </div>
            <div class="col-md-9">
                <g:textField name="direccion" maxlength="50" class="form-control input-sm  " value="${clienteInstance?.direccion?.trim()}"/>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2 text-right">
                <label>Teléfono</label>
            </div>
            <div class="col-md-2">
                <g:textField name="telefono" maxlength="10" class="number digits form-control input-sm  " value="${clienteInstance?.telefono?.trim()}"/>
            </div>
            <div class="col-md-1 text-right">
                <label>Email</label>
            </div>
            <div class="col-md-4">
                <div class="input-group"><span class="input-group-addon"><i class="fa fa-envelope"></i></span><g:field type="email" name="email" maxlength="90" class="form-control  input-sm  unique noEspacios" value="${clienteInstance?.email}"/></div>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-2 text-right">
                <label>Observaciones</label>
            </div>
            <div class="col-md-9">
                <g:textArea name="observacion" cols="40" rows="5" maxlength="255" class="form-control  input-sm " value="${clienteInstance?.observacion}"/>
            </div>
        </div>

        <div class="row fila">
            <div class="col-md-2 text-right">
                <label>Banco</label>
            </div>
            <div class="col-md-2">
               <g:select name="bancoOcp" from="${contable.core.BancoOcp.list()}" optionKey="codigo" optionValue="descripcion" class="form-control  input-sm "  value="${clienteInstance?.banco?.codigo}" noSelection="['':'Seleccione']"></g:select>
            </div>
            <div class="col-md-2 text-right">
                <label>Tipo de cuenta</label>
            </div>
            <div class="col-md-2">
                <g:select name="tipoCuenta" from="${tipos}" class="form-control  input-sm "
                          optionValue="value" optionKey="key" value="${clienteInstance?.tipoCuenta}"></g:select>
            </div>
            <div class="col-md-1 text-right">
                <label>Cuenta</label>
            </div>
            <div class="col-md-2">
                <g:textField name="numeroCuenta" maxlength="20" class="number digits form-control  input-sm " value="${clienteInstance?.numeroCuenta}"/>
            </div>
        </div>


        <div class="row fila">
            <div class="col-md-2 text-right">
                <label>Proveedor</label>
            </div>
            <div class="col-md-2">
               <g:select name="proveedor" from="${combo}" optionKey="key" optionValue="value" class="form-control input-sm"/>
            </div>
            <div class="col-md-1 text-right">
                <label>Cliente</label>
            </div>
            <div class="col-md-2">
                <g:select name="cliente" from="${combo}" optionKey="key" optionValue="value" class="form-control input-sm"/>
            </div>
            <div class="col-md-2 text-right">
                <label>Contibuyente Especial</label>
            </div>
            <div class="col-md-2">
                <g:select name="contibuyenteEspecial" from="${combo}" optionKey="key" optionValue="value" class="form-control input-sm"/>
            </div>
        </div>







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