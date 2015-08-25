<%@ page contentType="text/html;charset=UTF-8" %>
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
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row">
<div class="col-md-12">
<div class="panel-completo" style="margin-left: 10px">
<div class="row">
    <div class="col-md-12 titulo-panel">
        Cargas familiares
    </div>
</div>
<div class="row fila">
<div class="col-md-12">
<div class="panel-body" style="padding:0px">
<div class="header-flow">
    <g:link controller="empleado" action="nuevoEmpleado" id="${empleado.id}">
        <div class="header-flow-item before">
            <span class="badge before">1</span> Datos personales
            <span class="arrow"></span>
        </div>
    </g:link>
    <g:if test="${empleado?.id}">
        <g:link controller="empleado" action="capacitacion" id="${empleado.id}">
            <div class="header-flow-item before">
                <span class="badge before">2</span>
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
        <g:link controller="empleado" action="cargas"  id="${empleado.id}">
            <div class="header-flow-item active">
                <span class="badge active">3</span>
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
        <g:link controller="empleado" action="contratos" id="${empleado.id}">
            <div class="header-flow-item ">
                <span class="badge ">4</span>
                Contratos
                <span class="arrow"></span>
            </div>
        </g:link>
    </g:if>
    <g:else>
        <div class="header-flow-item disabled">
            <span class="badge disabled">3</span>
            Contratos
            <span class="arrow"></span>
        </div>
    </g:else>
</div>
<div class="flow-body">
    <g:each in="${cargas}" var="c">
        <div class="panel panel-info" style="border-color:#2F4050 ">
            <div class="panel-heading " style="background:  #2F4050;color: #ffffff">${c.nombre+" "+c.apellido}</div>
            <div class="panel-body">
                <g:form action="saveCar_ajax" class="frmCar-${c.id}"  >
                    <input type="hidden" name="id" value="${c.id}">
                    <input type="hidden" name="empleado.id" value="${empleado.id}">
                    <div class="row">
                        <div class="col-md-1">
                            <label>Nombres</label>
                        </div>
                        <div class="col-md-3">
                            <input type="text" name="nombre"  value="${c.nombre}" maxlength="60"  class="required form-control input-sm allCaps">
                        </div>
                        <div class="col-md-1">
                            <label>Apellidos</label>
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="apellido" value="${c.apellido}" maxlength="60" class="required form-control input-sm allCaps">
                        </div>
                        <div class="col-md-1">
                            <label>Género</label>
                        </div>
                        <div class="col-md-2">
                            <g:select name="sexo" from="${['M':'Masculino','F':'Femenino']}" value="${c.sexo}"
                                      optionKey="key" optionValue="value"   class="required form-control input-sm"></g:select>
                        </div>
                    </div>
                    <div class="row fila">
                        <div class="col-md-1">
                            <label>Cédula</label>
                        </div>
                        <div class="col-md-2">
                            <input type="text" name="cedula" value="${c.cedula}"  maxlength="10"  class=" form-control input-sm allCaps">
                        </div>
                        <div class="col-md-1">
                            <label>F. Nacimiento</label>
                        </div>
                        <div class="col-md-2">
                            <elm:datepicker name="fechaNacimiento" id="fec_nac_${c.id}"  value="${c.fechaNacimiento?.format("dd-MM-yyyy")}" class="required form-control input-sm" />
                        </div>

                        <div class="col-md-1">
                            <label>Relacion</label>
                        </div>
                        <div class="col-md-2">
                            <g:select name="relacion.id" from="${contable.nomina.Relacion.list()}" value="${c.relacion?.id}"
                                      optionKey="id" optionValue="descripcion" class="required form-control input-sm"></g:select>
                        </div>
                        <div class="col-md-1">
                            <label>Fin</label>
                        </div>
                        <div class="col-md-2">
                            <elm:datepicker name="fin" id="fin_${c.id}" value="${c.fin?.format("dd-MM-yyyy")}"  class=" form-control input-sm" />
                        </div>
                    </div>
                    <div class="row fila">
                        <div class="col-md-1">
                            <label>Teléfono</label>
                        </div>
                        <div class="col-md-2">
                            <input type="text"  maxlength="10" value="${c.telefono}"  name="telefono" class="required form-control input-sm allCaps">
                        </div>
                        <div class="col-md-1">
                            <label>Dirección</label>
                        </div>
                        <div class="col-md-4">
                            <input type="text"  maxlength="150" value="${c.direccion}" name="direccion" class="required form-control input-sm allCaps">
                        </div>

                        <div class="col-md-1">
                            <label>E-mail</label>
                        </div>
                        <div class="col-md-3">
                            <input type="text" value="${c.email}"  maxlength="60"  name="email" class=" form-control input-sm allCaps">
                        </div>
                    </div>
                    <div class="row fila">
                        <div class="col-md-1 ">
                            <a href="#" class="btn btn-verde btn-sm save-car"  iden="${c.id}">
                                <i class="fa fa-save"></i> Guardar
                            </a>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </g:each>
    <div class="panel panel-info" style="border-color:#2F4050 ">
        <div class="panel-heading " style="background:  #2F4050;color: #ffffff">Registrar nueva carga familiar</div>
        <div class="panel-body">

            <g:form action="saveCar_ajax" class="frmCar"  >
                <input type="hidden" name="empleado.id" value="${empleado.id}">
                <div class="row">
                    <div class="col-md-1">
                        <label>Nombres</label>
                    </div>
                    <div class="col-md-3">
                        <input type="text" name="nombre"  maxlength="60"  class="required form-control input-sm allCaps">
                    </div>
                    <div class="col-md-1">
                        <label>Apellidos</label>
                    </div>
                    <div class="col-md-4">
                        <input type="text" name="apellido"  maxlength="60" class="required form-control input-sm allCaps">
                    </div>
                    <div class="col-md-1">
                        <label>Género</label>
                    </div>
                    <div class="col-md-2">
                        <g:select name="sexo" from="${['M':'Masculino','F':'Femenino']}"
                                  optionKey="key" optionValue="value"   class="required form-control input-sm"></g:select>
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-1">
                        <label>Cédula</label>
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="cedula"  maxlength="10"  class=" form-control input-sm allCaps">
                    </div>
                    <div class="col-md-1">
                        <label>F. Nacimiento</label>
                    </div>
                    <div class="col-md-2">
                        <elm:datepicker name="fechaNacimiento"   class="required form-control input-sm" />
                    </div>

                    <div class="col-md-1">
                        <label>Relacion</label>
                    </div>
                    <div class="col-md-2">
                        <g:select name="relacion.id" from="${contable.nomina.Relacion.list()}"
                                  optionKey="id" optionValue="descripcion" class="required form-control input-sm"></g:select>
                    </div>
                    <div class="col-md-1">
                        <label>Fin</label>
                    </div>
                    <div class="col-md-2">
                        <elm:datepicker name="fin"   class=" form-control input-sm" />
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-1">
                        <label>Teléfono</label>
                    </div>
                    <div class="col-md-2">
                        <input type="text"  maxlength="10"  name="telefono" class="required form-control input-sm allCaps">
                    </div>
                    <div class="col-md-1">
                        <label>Dirección</label>
                    </div>
                    <div class="col-md-4">
                        <input type="text"  maxlength="150"  name="direccion" class="required form-control input-sm allCaps">
                    </div>

                    <div class="col-md-1">
                        <label>E-mail</label>
                    </div>
                    <div class="col-md-3">
                        <input type="text"   maxlength="60"  name="email" class=" form-control input-sm allCaps">
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-1 ">
                        <a href="#" class="btn btn-verde btn-sm" id="save-car">
                            <i class="fa fa-save"></i> Guardar
                        </a>
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
</div>
</div>
<script>
    $("#save-car").click(function(){
        $(".frmCar").submit()
    })
    $(".save-car").click(function(){
        $(".frmCar-"+$(this).attr("iden")).submit()
    })
</script>
</body>
</html>