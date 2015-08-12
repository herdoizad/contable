<%@ page import="contable.core.Cuenta" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!cuentaInstance}">
    <elm:notFound elem="Cuenta" genero="o" />
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal frm-cuenta" name="frmCuenta" id="${cuentaInstance?.numero}"
                role="form" controller="cuentas" action="save_ajax" method="POST">
            <input type="hidden" name="prefijo" id="prefijo" value="${padre?.numero?.trim()}">
            <g:if test="${padre}">
                <elm:fieldRapido claseLabel="col-sm-2" label="Nivel" claseField="col-sm-3">
                    <input type="hidden" name="nivel" value="${padre.nivel+1}">
                    <g:textField name="nivelLabel" value="${padre.nivel+1}"  disabled="" class="digits nivel input-sm form-control  required " required=""/>
                </elm:fieldRapido>
            </g:if>
            <g:else>
                <elm:fieldRapido claseLabel="col-sm-2" label="Nivel" claseField="col-sm-3">
                    <g:textField name="nivel" value="${cuentaInstance.nivel}" class="digits  nivel input-sm form-control  required" required=""/>
                </elm:fieldRapido>
            </g:else>
            <g:if test="${!cuentaInstance.numero}">
                <elm:fieldRapido claseLabel="col-sm-2" label="Padre" claseField="col-sm-7">
                    <input type="hidden" name="padre" value="${cuentaInstance?.padre}">
                    <g:textField name="padreLABEL" maxlength="15" class="form-control input-sm " disabled="" value="${cuentaInstance?.padre}" />
                </elm:fieldRapido>
                <elm:fieldRapido claseLabel="col-sm-2" label="Número" claseField="col-sm-7">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">${cuentaInstance.padre}</span>
                        <g:textField name="numero" id="numero" maxlength="${limites[padre?.nivel+1]}" required=""  class="form-control   input-sm" value=""/>
                    </div>
                </elm:fieldRapido>
            </g:if>
            <g:else>
                <elm:fieldRapido claseLabel="col-sm-2" label="Padre" claseField="col-sm-7">
                    <g:textField name="padre" maxlength="15" class="form-control  input-sm disabled " value="${cuentaInstance?.padre}" disabled=""/>
                </elm:fieldRapido>
                <elm:fieldRapido claseLabel="col-sm-2" label="Numero" claseField="col-sm-7">
                    <g:textField name="numeroLABEL"  id="numero" maxlength="15" required=""  class="form-control   input-sm disabled" disabled="" value="${cuentaInstance?.numero}"/>
                </elm:fieldRapido>
            </g:else>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-7">
                <g:textField name="descripcion" maxlength="60" required="" class="form-control  input-sm required" value="${cuentaInstance?.descripcion?.trim()}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Clase" claseField="col-sm-7">
                <g:select name="clase" from="${clases}" required="" optionKey="key" optionValue="value"
                          class="form-control   input-sm required" value="${cuentaInstance?.clase}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Movimiento" claseField="col-sm-3">
                Si <input type="radio" name="agrupa" value="1" ${cuentaInstance?.agrupa==1?'checked':''} > No <input type="radio" name="agrupa" value="2" ${cuentaInstance?.agrupa!=1?'checked':''}>
            </elm:fieldRapido>


            <input type="hidden" name="usuario" value="${session.usuario.login}">






        </g:form>
    </div>

    <script type="text/javascript">
        var limites=[1,1,1,2,3,4,5]
        var validator = $("#frmCuenta").validate({
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

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormCuenta();
                return false;
            }
            return true;
        });
        $("#numero").blur(function(){
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'cuentas', action:'verificaNumero_ajax')}",
                data: {
                    id: $("#prefijo").val()+$("#numero").val()
                },
                success: function (msg) {
                    if(msg!="ok") {
                        $("#numero").val("")
                        bootbox.alert("El número de cuenta ingresado ya existe, por favor cambielo.")
                    }

                } //success
            }); //ajax
        })
        $(".nivel").blur(function(){
            $("#numero").attr("maxlength",limites[$(".nivel").val()*1]);
        })
    </script>

</g:else>