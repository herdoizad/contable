<%@ page import="contable.seguridad.Usuario" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Estructura del Menú y Procesos</title>

    <style type="text/css">
    .orden, .icono {
        cursor : pointer;
    }
    </style>

</head>

<body>
<div class="row">
    <div class="col-md-12">
        <div class="panel-completo" style="">
            <div class="row">
                <div class="col-md-8 titulo-panel">
                    Configuración del menú
                </div>
                <div class="col-md-2 titulo-panel">
                        Seleccione el perfil
                </div>
                <div class="col-md-2 titulo-panel" style="margin-top: -11px">
                    <g:select name="usuario" id="usuario" class="form-control input-sm" from="${Usuario.findAllByEstado('A',[sort: 'nombre'])}"
                              optionKey="login" optionValue="nombre" style="font-weight:normal"/>
                </div>
            </div>
            <div class="row fila">
                <ul class="nav nav-pills corner-all" style="border: solid 1px #cccccc; margin-bottom: 10px;text-align: center">
                    <g:each in="${modulos}" var="modulo">
                        <li role="presentation">
                            <a href="#" class="mdlo" id="${modulo.id}">
                                <g:if test="${modulo.icono}">
                                    <i class="${modulo.icono}"></i>
                                </g:if>
                                ${modulo.nombre}
                            </a>
                        </li>
                    </g:each>
                </ul>

                <div class="well" id="acciones">
                </div>

                <div class="btn-toolbar">
                    <div class="btn-group">
                        <a href="#" id="btnCargarAcc" class="btn btn-sm btn-warning">
                            <i class="fa fa-paper-plane-o"></i> Cargar acciones
                        </a>
                    </div>
                    <div class="btn-group">
                        <a href="${g.createLink(controller: 'sistema',action: 'list')}" target="_blank" id="btnCrearSistema" class="btn btn-sm btn-success">
                            <i class="icon-grails-alt"></i> Administrar Sistemas
                        </a>
                        <a href="#" id="btnCrearModulo" class="btn btn-sm btn-success">
                            <i class="fa fa-file-o"></i> Crear módulo
                        </a>
                        <a href="#" id="btnEditarModulo" class="btn btn-sm btn-success">
                            <i class="fa fa-pencil"></i> Editar módulo
                        </a>
                        <a href="#" id="btnBorrarModulo" class="btn btn-sm btn-success">
                            <i class="fa fa-trash-o"></i> Eliminar módulo
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<script type="text/javascript">

    function reload() {
        var id = $(".active").find(".mdlo").attr("id");
        var usuario = $("#usuario").val();
        $("#acciones").html(spinner);
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'acciones', action:'acciones_ajax')}",
            data    : {
                id   : id,
                usuario : usuario
            },
            success : function (msg) {
                $("#acciones").html(msg);
            }
        });
    }

    /* **************************************** MODULO ******************************************************** */
    function submitFormModulo() {
        var $form = $("#frmModulo");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando Módulo");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    setTimeout(function () {
                        if (parts[0] == "SUCCESS") {
                            location.reload(true);
                        } else {
                            spinner.replaceWith($btn);
                            return false;
                        }
                    }, 1000);
                }
            });
        } else {
            return false;
        } //else
    }
    function deleteModulo(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                    "¿Está seguro que desea eliminar el Módulo seleccionado (<strong>" + $.trim($(".active").find(".mdlo").text()) + "</strong>)? " +
                    "Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash-o'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        openLoader("Eliminando Módulo");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'modulo', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 1000);
                                } else {
                                    closeLoader();
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function createEditModulo(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        openLoader();
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'modulo', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                closeLoader();
                var b = bootbox.dialog({
                    id    : "dlgCreateEdit",
                    title : title + " Módulo",

                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormModulo();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control input-sm").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit
    /* **************************************** MODULO ******************************************************** */

    $(function () {
        $(".mdlo").click(function () {
            $(".active").removeClass("active");
            $(this).parent().addClass("active");
            reload();
            return false;
        }).first().click();

        $("#usuario").change(function () {
            reload();
        });

        $("#btnCrearPerfil").click(function () {
            createEditPerfil();
            return false;
        });
        $("#btnEditarPerfil").click(function () {
            createEditPerfil($("#usuario").val());
            return false;
        });
        $("#btnBorrarPerfil").click(function () {
            deletePerfil($("#usuario").val());
            return false;
        });

        $("#btnCrearModulo").click(function () {
            createEditModulo();
            return false;
        });
        $("#btnEditarModulo").click(function () {
            createEditModulo($(".active").find(".mdlo").attr("id"));
            return false;
        });
        $("#btnBorrarModulo").click(function () {
            deleteModulo($(".active").find(".mdlo").attr("id"));
            return false;
        });

        $("#btnCargarAcc").click(function () {
            bootbox.confirm("¿Está seguro de querer cargar las acciones desde Grails?", function (result) {
                if (result) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'acciones', action:'cargarAcciones_ajax')}",
                        success : function (msg) {
                            closeLoader();
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            $(".mdlo").first().click();
                        }
                    });
                }
            });
        });
    });
</script>

</body>
</html>