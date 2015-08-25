<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Empleados</title>
    <link href="${g.resource(dir: 'css/custom/', file: 'dashboard.css')}" rel="stylesheet" type="text/css">
    <link href="${g.resource(dir: 'css/custom/', file: 'pdfViewer.css')}" rel="stylesheet" type="text/css">
    <imp:js src="${resource(dir: 'js/plugins/pdfObject', file: 'pdfobject.min.js')}"/>
    <style>
    label{
        font-size: 10px;
    }
    </style>
</head>
<body>
<div class="pdf-viewer" style="width: 46%">
    <div class="pdf-content" >
        <div class="pdf-container" id="doc"></div>
        <div class="pdf-handler" >
            <i class="fa fa-arrow-right"></i>
        </div>
        <div class="pdf-header" id="data">
            N. Referencia: <span id="referencia-pdf" class="data"></span>
            Código: <span id="codigo" class="data"></span>
            Tipo: <span id="tipo" class="data"></span>



        </div>
        <div id="msgNoPDF">
            <p>No tiene configurado el plugin de lectura de PDF en este navegador.</p>

            <p>
                Puede
                <a class="text-info" target="_blank" style="color: white" href="http://get.adobe.com/es/reader/">
                    <u>descargar Adobe Reader aquí</u>
                </a>
            </p>
        </div>
    </div>
</div>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row" style="padding-bottom: 200px">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Intrucción formal
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
                                    <div class="header-flow-item active">
                                        <span class="badge active">2</span>
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
                            <div class="row fila">
                                <g:form action="subirArchivo_ajax" class="frmHoja" enctype="multipart/form-data" >
                                    <input type="hidden" name="id" value="${empleado.id}">
                                    <div class="col-md-12">
                                        <div class="panel panel-info">
                                            <div class="panel-heading">Hoja de vida</div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-md-1">
                                                        <label> Archivo PDF</label>
                                                    </div>
                                                    <g:if test="${empleado.path}">
                                                        <div class="col-md-1">
                                                            <a href="#" data-file="${empleado.path}"
                                                               data-ref="Hoja de vida"
                                                               data-codigo=""
                                                               data-tipo="Hoja de vida"
                                                               target="_blank" class="btn btn-info ver-doc btn-sm" title="${empleado.path}" >
                                                                <i class="fa fa-search"></i> Ver
                                                            </a>
                                                        </div>
                                                    </g:if>
                                                    <div class="col-md-3">
                                                        <input type="file" placeholder="Seleccione un archivo" name="hojaDeVida" class="form-control input-sm">
                                                    </div>
                                                    <div class="col-md-1">
                                                        <a href="#" id="subir-hoja" class="btn btn-sm btn-success"><i class="fa fa-upload"></i> Subir</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </g:form>
                            </div>
                            <g:each in="${caps}" var="c">
                                <div class="panel panel-info" style="border-color:#2F4050 ">
                                    <div class="panel-heading " style="background:  #2F4050;color: #ffffff">${c.titulo}</div>
                                    <div class="panel-body">
                                        <g:form action="saveCap_ajax" class="frmCap-${c.id}" enctype="multipart/form-data" >
                                            <input type="hidden" name="empleado.id" value="${empleado.id}">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <div class="row fila">
                                                <div class="col-md-1">
                                                    <label>Descripción:</label>
                                                </div>
                                                <div class="col-md-5">
                                                    <input type="text" name="titulo" value="${c.titulo}" class="form-control input-sm required" maxlength="150">
                                                </div>
                                                <div class="col-md-1">
                                                    <label>Institución:</label>
                                                </div>
                                                <div class="col-md-5">
                                                    <input type="text" name="institucion" value="${c.institucion}" class="form-control input-sm required" maxlength="150">
                                                </div>
                                            </div>
                                            <div class="row fila">
                                                <div class="col-md-1">
                                                    <label>Tipo:</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <g:select name="tipo.id" from="${contable.nomina.TipoCapacitacion.list()}" value="${c.tipo?.id}"
                                                              class="form-control input-sm required" optionKey="id" optionValue="descripcion"
                                                    />
                                                </div>
                                                <div class="col-md-1">
                                                    <label>Duracción:</label>
                                                </div>
                                                <div class="col-md-1">
                                                    <input type="number" name="horas"  class="form-control input-sm number digits " min="0" value="${c.horas}">
                                                </div>
                                                <div class="col-md-1">
                                                    <label>Inicio:</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <elm:datepicker name="inicio" id="inicio-${c.id}"  value="${c.inicio?.format("dd-MM-yyyy")}" class="form-control input-sm"/>
                                                </div>
                                                <div class="col-md-1">
                                                    <label>Fin:</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <elm:datepicker name="fin" id="fin-${c.id}"  value="${c.fin?.format("dd-MM-yyyy")}" class="form-control input-sm"/>
                                                </div>
                                            </div>
                                            <div class="row fila">
                                                <div class="col-md-1">
                                                    <label>Archivo PDF</label>
                                                </div>
                                                <g:if test="${c.path}">
                                                    <div class="col-md-1">
                                                        <a href="#" data-file="${c.path}"
                                                           data-ref="Capacitación"
                                                           data-codigo=""
                                                           data-tipo="Capacitación"
                                                           target="_blank" class="btn btn-info ver-doc btn-sm" title="${c.path}" >
                                                            <i class="fa fa-search"></i> Ver
                                                        </a>
                                                    </div>
                                                </g:if>
                                                <div class="col-md-3">
                                                    <input type="file" placeholder="Seleccione un archivo" name="archivo" class="form-control input-sm">
                                                </div>
                                                <div class="col-md-1">
                                                    <a href="#"  class="btn btn-sm btn-verde save-cap" iden="${c.id}"><i class="fa fa-save"></i> Guardar</a>
                                                </div>
                                            </div>
                                        </g:form>
                                    </div>
                                </div>
                            </g:each>
                            <div class="panel panel-info" style="border-color:#2F4050 ">
                                <div class="panel-heading " style="background:  #2F4050;color: #ffffff">Registrar instrucción</div>
                                <div class="panel-body">
                                    <g:form action="saveCap_ajax" class="frmCap" enctype="multipart/form-data" >
                                        <input type="hidden" name="empleado.id" value="${empleado.id}">
                                        <div class="row fila">
                                            <div class="col-md-1">
                                                <label>Descripción:</label>
                                            </div>
                                            <div class="col-md-5">
                                                <input type="text" name="titulo" class="form-control input-sm required" maxlength="150">
                                            </div>
                                            <div class="col-md-1">
                                                <label>Institución:</label>
                                            </div>
                                            <div class="col-md-5">
                                                <input type="text" name="institucion" class="form-control input-sm required" maxlength="150">
                                            </div>
                                        </div>
                                        <div class="row fila">
                                            <div class="col-md-1">
                                                <label>Tipo:</label>
                                            </div>
                                            <div class="col-md-3">
                                                <g:select name="tipo.id" from="${contable.nomina.TipoCapacitacion.list()}"
                                                          class="form-control input-sm required" optionKey="id" optionValue="descripcion"
                                                />
                                            </div>
                                            <div class="col-md-1">
                                                <label>Duracción:</label>
                                            </div>
                                            <div class="col-md-1">
                                                <input type="number" name="horas" class="form-control input-sm number digits " min="0" value="0">
                                            </div>
                                            <div class="col-md-1">
                                                <label>Inicio:</label>
                                            </div>
                                            <div class="col-md-2">
                                                <elm:datepicker name="inicio" class="form-control input-sm"/>
                                            </div>
                                            <div class="col-md-1">
                                                <label>Fin:</label>
                                            </div>
                                            <div class="col-md-2">
                                                <elm:datepicker name="fin" class="form-control input-sm"/>
                                            </div>
                                        </div>
                                        <div class="row fila">
                                            <div class="col-md-1">
                                                <label>Archivo PDF</label>
                                            </div>
                                            <div class="col-md-3">
                                                <input type="file" placeholder="Seleccione un archivo" name="archivo" class="form-control input-sm">
                                            </div>
                                            <div class="col-md-1">
                                                <a href="#" id="btn-save-nuevo" class="btn btn-sm btn-verde"><i class="fa fa-save"></i> Guardar</a>
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
    function showPdf(div){
        $("#msgNoPDF").show();
        $("#doc").html("")
        var pathFile = div.data("file")
        $("#referencia-pdf").html(div.data("ref"))
        $("#codigo").html(div.data("codigo"))
        $("#tipo").html(div.data("tipo"))
        var path = "${resource()}/" + pathFile;
        var myPDF = new PDFObject({
            url           : path,
            pdfOpenParams : {
                navpanes: 1,
                statusbar: 0,
                view: "FitW"
            }
        }).embed("doc");
        $(".pdf-viewer").show("slide",{direction:'right'})
        $("#data").show()
    }
    $("#subir-hoja").click(function(){
        $(".frmHoja").submit()
    })
    $(".ver-doc").click(function(){
        showPdf($(this))
        return false
    })
    $(".pdf-handler").click(function(){
        $(".pdf-viewer").hide("slide",{direction:'right'})
        $("#data").hide()
    })
    $("#btn-save-nuevo").click(function(){
        $(".frmCap").submit()
    })
    $(".save-cap").click(function(){

        $(".frmCap-"+$(this).attr("iden")).submit()
    })
</script>
</body>
</html>