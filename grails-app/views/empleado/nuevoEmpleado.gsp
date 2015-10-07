<%@ page import="contable.seguridad.Usuario" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Empleados</title>
    <link href="${g.resource(dir: 'css/custom/', file: 'dashboard.css')}" rel="stylesheet" type="text/css">
    <style>
    label{
        font-size: 10px;
    }
    </style>
    <imp:js src="${resource(dir: 'js/plugins/bootstrap-combobox/js', file: 'bootstrap-combobox.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-combobox/css', file: 'bootstrap-combobox.css')}"/>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
<div class="col-md-12">
<div class="panel-completo" style="margin-left: 10px">
<div class="row">
    <div class="col-md-12 titulo-panel">
        Registro de empleados
    </div>
</div>
<div class="row fila">
<div class="col-md-12">
<div class="panel-body" style="padding:0px">
<div class="header-flow">
    <div class="header-flow-item active">
        <span class="badge active">1</span> Datos personales
        <span class="arrow"></span>
    </div>
    <g:if test="${empleado?.id}">
        <g:link controller="empleado" action="capacitacion" id="${empleado.id}">
            <div class="header-flow-item ">
                <span class="badge ">2</span>
                Instrucción
                <span class="arrow"></span>
            </div>
        </g:link>
    </g:if>
    <g:else>
        <div class="header-flow-item disabled">
            <span class="badge disabled">2</span>
            Instrucción
            <span class="arrow"></span>
        </div>
    </g:else>
    <g:if test="${empleado?.id}">
        <g:link controller="empleado" action="cargas" id="${empleado.id}">
            <div class="header-flow-item ">
                <span class="badge ">3</span>
                Cargas familiares
                <span class="arrow"></span>
            </div>
        </g:link>
    </g:if>
    <g:else>
        <div class="header-flow-item disabled">
            <span class="badge disabled">3</span>
            Cargas familiares
            <span class="arrow"></span>
        </div>
    </g:else>
    <g:if test="${empleado?.id}">
        <g:link controller="empleado" action="contratos" id="${empleado?.id}">
            <div class="header-flow-item ">
                <span class="badge ">4</span>
                Contratos
                <span class="arrow"></span>
            </div>
        </g:link>
    </g:if>
    <g:else>
        <div class="header-flow-item disabled">
            <span class="badge disabled">4</span>
            Contratos
            <span class="arrow"></span>
        </div>
    </g:else>
</div>
<div class="flow-body">
    <g:form action="saveEmpleado_ajax" controller="empleado" class="frmEmpleado" >
        <input type="hidden" name="id" id="iden" value="${empleado?.id}">
        <div class="row">
            <div class="col-md-1">
                <label>Nombres</label>
            </div>
            <div class="col-md-3">
                <input type="text" name="nombre"  maxlength="60" value="${empleado?.nombre}" class="required form-control input-sm allCaps">
            </div>
            <div class="col-md-1">
                <label>Apellidos</label>
            </div>
            <div class="col-md-4">
                <input type="text" name="apellido"  maxlength="60" value="${empleado?.apellido}" class="required form-control input-sm allCaps">
            </div>
            <div class="col-md-1">
                <label>Género</label>
            </div>
            <div class="col-md-2">
                <g:select name="sexo" from="${['M':'Masculino','F':'Femenino']}"
                          optionKey="key" optionValue="value"  value="${empleado?.sexo}" class="required form-control input-sm"></g:select>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-1">
                <label>Cédula</label>
            </div>
            <div class="col-md-2">
                <input type="text" name="cedula" id="cedula" maxlength="10" value="${empleado?.cedula}" class="required form-control input-sm allCaps">
            </div>
            <div class="col-md-1">
                <label>F. Nacimiento</label>
            </div>
            <div class="col-md-2">
                <elm:datepicker name="fechaNacimiento"  value="${(empleado.id)?empleado?.fechaNacimiento?.format("dd-MM-yyyy"):'01-01-1980'}" class="required form-control input-sm" />
            </div>
            <div class="col-md-1">
                <label>Nacionalidad</label>
            </div>
            <div class="col-md-2">
                <input type="text"   maxlength="40" name="nacionalidad"  value="${empleado?.nacionalidad}" class="required form-control input-sm allCaps">
            </div>
            <div class="col-md-1">
                <label>Estado civil</label>
            </div>
            <div class="col-md-2">
                <g:select name="estadoCivil.id" from="${contable.nomina.EstadoCivil.list()}"  value="${empleado?.estadoCivil?.id}"
                          optionKey="id" optionValue="descripcion" class="required form-control input-sm"></g:select>
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-1">
                <label>Dirección</label>
            </div>
            <div class="col-md-5">
                <input type="text"  maxlength="150" value="${empleado?.direccion}" name="direccion" class="required form-control input-sm allCaps">
            </div>
            <div class="col-md-1">
                <label>Número</label>
            </div>
            <div class="col-md-1">
                <input type="text"  maxlength="20" value="${empleado?.numero}" name="numero" class=" form-control input-sm allCaps">
            </div>
            <div class="col-md-1">
                <label>Calle secundaria</label>
            </div>
            <div class="col-md-3">
                <input type="text"  maxlength="75" value="${empleado?.calleSecundaria}" name="calleSecundaria" class=" form-control input-sm allCaps">
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-1">
                <label>Teléfono</label>
            </div>
            <div class="col-md-2">
                <input type="text"  maxlength="10" value="${empleado?.telefono}" name="telefono" class="required form-control input-sm allCaps">
            </div>

            <div class="col-md-1">
                <label>E-mail</label>
            </div>
            <div class="col-md-3">
                <input type="text"   maxlength="60" value="${empleado?.email}" name="email" class="required form-control input-sm allCaps">
            </div>
            <div class="col-md-1">
                <label>Código sectorial</label>
            </div>
            <div class="col-md-3">
                <input type="text" name="codigoSectorial"  maxlength="20" value="${empleado?.codigoSectorial}" class="form-control input-sm allCaps">
            </div>
        </div>
        <div class="row fila">
            <div class="col-md-1">
                <label>Unidad</label>
            </div>
            <div class="col-md-2">
                <g:select name="unidad.id" from="${contable.nomina.Unidad.list()}"  value="${empleado?.unidad?.id}"
                          optionKey="id" optionValue="nombre" class="required form-control input-sm"></g:select>
            </div>
            <div class="col-md-1">
                <label>Cargo</label>
            </div>
            <div class="col-md-3">
                <input type="text" name="cargo" maxlength="50"  value="${empleado?.cargo}" class="required form-control input-sm allCaps">
            </div>
            <div class="col-md-1" style="text-align: right">
                <label>Lugar de trabajo</label>
            </div>
            <div class="col-md-2">
                <input type="text" maxlength="50" name="ciudadTrabajo"  value="${empleado?.ciudadTrabajo}" class="form-control input-sm allCaps">
            </div>
            <div class="col-md-1" >
                <label>Tipo de sangre</label>
            </div>
            <div class="col-md-1">
                <input type="text" name="tipoSangre" maxlength="4"  value="${empleado?.tipoSangre}" class="form-control input-sm allCaps">
            </div>

        </div>
        <div class="row fila" style="border-top: 1px solid #000000">
        </div>
        <div class="row fila">
            <div class="col-md-1">
                <label>Banco</label>
            </div>
            <div class="col-md-2">
                <input type="text" name="banco"  maxlength="50" value="${empleado?.banco}" class="form-control input-sm allCaps">
            </div>
            <div class="col-md-1">
                <label>Tipo de cuenta</label>
            </div>
            <div class="col-md-1">
                <g:select name="tipoCuenta" from="${['A':'A','C':'C']}"
                          optionValue="value" optionKey="key" class="form-control input-sm allCaps"  value="${empleado?.tipoCuenta}"
                />
            </div>
            <div class="col-md-1">
                <label>Cuenta</label>
            </div>
            <div class="col-md-2">
                <input type="text" maxlength="20" name="cuenta"  value="${empleado?.cuenta}" class="form-control input-sm number digits">
            </div>
            <div class="col-md-1">
                <label>Cuenta contable</label>
            </div>
            <div class="col-md-3">
                <g:select name="cuentaContable.id" from="${contable.core.Cuenta.findAllByNivel(5)}" optionKey="numero"
                          class="form-control input-sm select" noSelection="['':'']"   value="${empleado?.cuentaContable?.getNumeroPad()}"
                />
            </div>
        </div>
        <div class="row fila" style="border-top: 1px solid #000000">
        </div>
        <div class="row fila">
            <input type="hidden" name="sueldoId" value="${sueldo?.id}">
            <div class="col-md-1">
                <label>Sueldo</label>
            </div>
            <div class="col-md-2">
                <input type="text" name="sueldo" class="form-control input-sm number" style="text-align: right" value="${sueldo?.sueldo}">
            </div>
            <div class="col-md-1">
                <label>Inicio:</label>
            </div>
            <div class="col-md-2">
                <elm:datepicker name="sueldoInicio"  value="${sueldo?.inicio?.format('dd-MM-yyyy')}" class="form-control input-sm"/>
            </div>
            <div class="col-md-1">
                <label>Fin:</label>
            </div>
            <div class="col-md-2">
                <elm:datepicker name="sueldoFin"  value="${sueldo?.fin?.format('dd-MM-yyyy')}" class="form-control input-sm"/>
            </div>
            <g:if test="${empleado.id}">
                <div class="col-md-1">
                    <a href="#" id="verHist" class="btn btn-info btn-sm">
                        <i class="fa fa-list"></i> Ver historial
                    </a>
                </div>
            </g:if>
        </div>
        <div class="row fila" style="border-top: 1px solid #000000">
        </div>
        <div class="row fila">
            <div class="col-md-1">
                <label>Usuario</label>
            </div>
            <div class="col-md-3">
                <g:select name="usuario" id="usuario" class="form-control input-sm" noSelection="['':'Seleccione']"
                          from="${Usuario.findAllByEstado('A',[sort: 'nombre'])}" value="${empleado?.usuario}"
                          optionKey="login" optionValue="nombre" style="font-weight:normal"/>
            </div>
        </div>
        <div class="row fila" style="margin-top: 20px">
            <div class="col-md-1">
                <a href="#" id="guardar" class="btn btn-verde"><i class="fa fa-save"></i> Guardar</a>
            </div>
        </div>
    </g:form>
</div>
</div>

</div>
</div>
</div>
</div>
</div>
<script>

    function check_cedula( valor ){
        var cedula = valor
        array = cedula.split( "" );
        num = array.length;
        if ( num == 10 )
        {
            total = 0;
            digito = (array[9]*1);
            for( i=0; i < (num-1); i++ )
            {
                mult = 0;
                if ( ( i%2 ) != 0 ) {
                    total = total + ( array[i] * 1 );
                }
                else
                {
                    mult = array[i] * 2;
                    if ( mult > 9 )
                        total = total + ( mult - 9 );
                    else
                        total = total + mult;
                }
            }
            decena = total / 10;
            decena = Math.floor( decena );
            decena = ( decena + 1 ) * 10;
            final = ( decena - total );
            if ( ( final == 10 && digito == 0 ) || ( final == digito ) ) {

                return true;
            }
            else
            {

                return false;
            }
        }
        else
        {
            return false;
        }
    }

    var validator = $(".frmEmpleado").validate({
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



        },
        messages : {


        }

    });
    $('.select').combobox();
    $("#guardar").click(function(){
        var $form = $(".frmEmpleado");
        var $btn = $(this);
        if(check_cedula($("#cedula").val())){
            if ($form.valid()) {
                $btn.replaceWith(spinner);
                $form.submit()
            }
        }else{
            bootbox.alert("Ingrese una cédula valida")
        }

    })
    $("#verHist").click(function(){
        openLoader()
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'empleado', action:'sueldos_ajax')}",
            data    : "id=${empleado.id}",
            success : function (msg) {
                closeLoader()
                var b = bootbox.dialog({
                    id      : "dlgSueldo",
                    title   : "Historial de sueldos",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cerrar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }

                    } //buttons
                }); //dialog

            } //success
        }); //ajax
        return false
    })
</script>
</body>
</html>