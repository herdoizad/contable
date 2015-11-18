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
<div class="row">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Contratos
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
                                    <div class="header-flow-item before">
                                        <span class="badge before">3</span>
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
                                    <div class="header-flow-item active">
                                        <span class="badge active">4</span>
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

                            <g:each in="${contratos}" var="c">
                                <div class="panel panel-info" style="border-color:#2F4050 ">
                                    <div class="panel-heading " style="background:  #2F4050;color: #ffffff">${c.numero}</div>
                                    <div class="panel-body">
                                        <g:form action="saveCon_ajax" class="frm frmCon-${c.id}" enctype="multipart/form-data" >
                                            <input type="hidden" name="empleado.id" value="${empleado.id}">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <div class="row">
                                                <div class="col-md-1">
                                                    <label>Tipo</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <g:select name="tipo.id"  value="${c.tipo?.id}" from="${contable.nomina.TipoContrato.list()}"
                                                              optionKey="id" optionValue="descripcion" class="form-control input-sm"
                                                    />
                                                </div>
                                                <div class="col-md-1">
                                                    <label>Número</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="text" name="numero" value="${c.numero}" class="form-control input-sm number required ">
                                                </div>
                                            </div>
                                            <div class="row fila">
                                                <div class="col-md-1">
                                                    <label>Inicio:</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <elm:datepicker name="inicio" id="inicio_${c.id}" value="${c.inicio?.format('dd-MM-yyyy')}" class="form-control input-sm"/>
                                                </div>
                                                <div class="col-md-1">
                                                    <label>Fin:</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <elm:datepicker name="fin" id="fin_${c.id}" value="${c.fin?.format('dd-MM-yyyy')}" class="form-control input-sm"/>
                                                </div>
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
                                                    <a href="#" iden="${c.id}" class="btn btn-sm btn-verde btn-save"><i class="fa fa-save"></i> Guardar</a>
                                                </div>
                                            </div>
                                        </g:form>
                                    </div>
                                </div>
                            </g:each>

                            <div class="panel panel-info" style="border-color:#2F4050 ">
                                <div class="panel-heading " style="background:  #2F4050;color: #ffffff">Registrar contrato</div>
                                <div class="panel-body">
                                    <g:form action="saveCon_ajax" class="frmCon" enctype="multipart/form-data" >
                                        <input type="hidden" name="empleado.id" value="${empleado.id}"></inpu>
                                        <div class="row">
                                            <div class="col-md-1">
                                                <label>Tipo</label>
                                            </div>
                                            <div class="col-md-2">
                                                <g:select name="tipo.id" from="${contable.nomina.TipoContrato.list()}"
                                                          optionKey="id" optionValue="descripcion" class="form-control input-sm"
                                                />
                                            </div>
                                            <div class="col-md-1">
                                                <label>Número</label>
                                            </div>
                                            <div class="col-md-2">
                                                <input type="text" name="numero" class="form-control input-sm number required ">
                                            </div>
                                        </div>
                                        <div class="row fila">
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


    var validator = $(".frmCon").validate({
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
    var validator = $(".frm").validate({
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

    $(".ver-doc").click(function(){
        showPdf($(this))
        return false
    })
    $(".pdf-handler").click(function(){
        $(".pdf-viewer").hide("slide",{direction:'right'})
        $("#data").hide()
    })
    $("#btn-save-nuevo").click(function(){
        var inicio =$("#inicio_input").val()
        var fin = $("#fin_input").val()
        var dateParts
        if(inicio!="") {
            dateParts = inicio.split("-");
            inicio = new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);
        }
        if(fin!="") {
            dateParts = fin.split("-");
            fin = new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);
        }
        var msg =""
        if(inicio=="" && fin!=""){
            msg+="Ingrese una fecha de inicio <br/>"
        }
        if(fin!="" && inicio!=""){
            if(inicio>fin)
                msg+="La fecha fin debe ser mayor a la de inicio<br/>"
        }
        if(msg=="") {
            $(".frmCon").submit()
        }else{
            bootbox.alert(msg)
        }
        return false

    })
    $(".btn-save").click(function(){
        $(".frmCon-"+$(this).attr("iden")).submit()
    })
</script>
</body>
</html>