<%@ page import="contable.core.Empresa" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!empresaInstance}">
    <elm:notFound elem="Empresa" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmEmpresa" id="${empresaInstance?.codigo}"
            role="form" controller="empresa" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-7">
            <g:textField name="codigo" maxlength="2" required="" class="form-control  required unique noEspacios" value="${empresaInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-7">
            <g:textField name="descripcion" maxlength="50" required="" class="form-control  required" value="${empresaInstance?.descripcion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Direccion" claseField="col-sm-7">
            <g:textField name="direccion" maxlength="50" required="" class="form-control  required" value="${empresaInstance?.direccion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Telefono" claseField="col-sm-7">
            <g:textField name="telefono" maxlength="15" required="" class="form-control  required" value="${empresaInstance?.telefono}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Fax" claseField="col-sm-7">
            <g:textField name="fax" maxlength="15" required="" class="form-control  required" value="${empresaInstance?.fax}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Casilla" claseField="col-sm-7">
            <g:textField name="casilla" maxlength="15" required="" class="form-control  required" value="${empresaInstance?.casilla}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Secuencial Factura" claseField="col-sm-3">
            <g:textField name="secuencialFactura" value="${empresaInstance.secuencialFactura}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Secuencial Comprobante" claseField="col-sm-3">
            <g:textField name="secuencialComprobante" value="${empresaInstance.secuencialComprobante}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Secuencial Ingreso" claseField="col-sm-3">
            <g:textField name="secuencialIngreso" value="${empresaInstance.secuencialIngreso}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Secuencial Egreso" claseField="col-sm-3">
            <g:textField name="secuencialEgreso" value="${empresaInstance.secuencialEgreso}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Secuencial Diario" claseField="col-sm-3">
            <g:textField name="secuencialDiario" value="${empresaInstance.secuencialDiario}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Porcentaje Iva" claseField="col-sm-3">
            <g:textField name="porcentajeIva" value="${fieldValue(bean: empresaInstance, field: 'porcentajeIva')}" class="number form-control   required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Representante" claseField="col-sm-7">
            <g:textField name="representante" maxlength="50" required="" class="form-control  required" value="${empresaInstance?.representante}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Contador" claseField="col-sm-7">
            <g:textField name="contador" maxlength="50" required="" class="form-control  required" value="${empresaInstance?.contador}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Ruc" claseField="col-sm-7">
            <g:textField name="ruc" maxlength="13" required="" class="form-control  required" value="${empresaInstance?.ruc}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Email" claseField="col-sm-7">
            <div class="input-group"><span class="input-group-addon"><i class="fa fa-envelope"></i></span><g:field type="email" name="email" maxlength="30" required="" class="form-control  required unique noEspacios" value="${empresaInstance?.email}"/></div>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Moneda" claseField="col-sm-7">
            <g:textField name="moneda" maxlength="3" required="" class="form-control  required" value="${empresaInstance?.moneda}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Anio" claseField="col-sm-3">
            <g:textField name="anio" value="${empresaInstance.anio}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Comodin" claseField="col-sm-7">
            <g:textField name="comodin" maxlength="1" class="form-control " value="${empresaInstance?.comodin}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Principal" claseField="col-sm-7">
            <g:textField name="principal" maxlength="1" class="form-control " value="${empresaInstance?.principal}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cedula Contador" claseField="col-sm-7">
            <g:textField name="cedulaContador" maxlength="13" class="form-control " value="${empresaInstance?.cedulaContador}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cedula Representante" claseField="col-sm-7">
            <g:textField name="cedulaRepresentante" maxlength="13" class="form-control " value="${empresaInstance?.cedulaRepresentante}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Tipo Representante" claseField="col-sm-7">
            <g:textField name="tipoRepresentante" maxlength="1" class="form-control " value="${empresaInstance?.tipoRepresentante}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Numero Copias" claseField="col-sm-3">
            <g:textField name="numeroCopias" value="${empresaInstance.numeroCopias}" class="digits form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Secucial Transporte" claseField="col-sm-3">
            <g:textField name="secucialTransporte" value="${empresaInstance.secucialTransporte}" class="digits form-control "/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmEmpresa").validate({
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
                        url: "${createLink(controller:'empresa', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${empresaInstance?.codigo}"
                        }
                    }
                },
                
                email: {
                    remote: {
                        url: "${createLink(controller:'empresa', action: 'validar_unique_email_ajax')}",
                        type: "post",
                        data: {
                            id: "${empresaInstance?.codigo}"
                        }
                    }
                }
                
            },
            messages : {
                
                codigo: {
                    remote: "Ya existe Codigo"
                },
                
                email: {
                    remote: "Ya existe Email"
                }
                
            }
            
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormEmpresa();
                return false;
            }
            return true;
        });
    </script>

</g:else>