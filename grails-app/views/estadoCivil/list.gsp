
<%@ page import="contable.nomina.EstadoCivil" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de EstadoCivil</title>
</head>
<body>

<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

<div class="row fila">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-8 titulo-panel">
                    Estado civil
                </div>
                <div class="col-md-4 titulo-panel" style="margin-top: -11px">
                    <div class="col-md-4">
                        <a href="#" class="btn btn-verde btnCrear btn-sm">
                            <i class="fa fa-file-o"></i> Crear
                        </a>
                    </div>
                    <div class="btn-group pull-right col-md-8">
                        <div class="input-group">
                            <input type="text" class="form-control input-sm input-search" placeholder="Buscar" value="${params.search}">
                            <span class="input-group-btn">
                                <g:link controller="estadoCivil" action="list" class="btn btn-default btn-search btn-sm">
                                    <i class="fa fa-search"></i>&nbsp;
                                </g:link>
                            </span>
                        </div><!-- /input-group -->
                    </div>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <table class="table table-condensed table-bordered table-striped table-hover">
                        <thead>
                        <tr>

                            <g:sortableColumn property="codigo" title="Codigo" />

                            <g:sortableColumn property="descripcion" title="Descripcion" />

                        </tr>
                        </thead>
                        <tbody>
                        <g:if test="${estadoCivilInstanceCount > 0}">
                            <g:each in="${estadoCivilInstanceList}" status="i" var="estadoCivilInstance">
                                <tr data-id="${estadoCivilInstance.id}">

                                    <td>${estadoCivilInstance.codigo}</td>

                                    <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${estadoCivilInstance}" field="descripcion"/></elm:textoBusqueda></td>

                                </tr>
                            </g:each>
                        </g:if>
                        <g:else>
                            <tr class="danger">
                                <td class="text-center" colspan="2">
                                    <g:if test="${params.search && params.search!= ''}">
                                        No se encontraron resultados para su búsqueda
                                    </g:if>
                                    <g:else>
                                        No se encontraron registros que mostrar
                                    </g:else>
                                </td>
                            </tr>
                        </g:else>
                        </tbody>
                    </table>

                    <elm:pagination total="${estadoCivilInstanceCount}" params="${params}"/>
                </div>
            </div>
        </div>
    </div>
</div>





<script type="text/javascript">
    var id = null;
    function submitFormEstadoCivil() {
        var $form = $("#frmEstadoCivil");
        var $btn = $("#dlgCreateEditEstadoCivil").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando EstadoCivil");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    setTimeout(function() {
                        if (parts[0] == "SUCCESS") {
                            location.reload(true);
                        } else {
                            spinner.replaceWith($btn);
                            closeLoader();
                            return false;
                        }
                    }, 1000);
                },
                error: function() {
                    log("Ha ocurrido un error interno", "Error");
                    closeLoader();
                }
            });
        } else {
            return false;
        } //else
    }
    function deleteEstadoCivil(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
            "¿Está seguro que desea eliminar el EstadoCivil seleccionado? Esta acción no se puede deshacer.</p>",
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
                        openLoader("Eliminando EstadoCivil");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'estadoCivil', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    setTimeout(function() {
                                        location.reload(true);
                                    }, 1000);
                                } else {
                                    closeLoader();
                                }
                            },
                            error: function() {
                                log("Ha ocurrido un error interno", "Error");
                                closeLoader();
                            }
                        });
                    }
                }
            }
        });
    }
    function createEditEstadoCivil(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'estadoCivil', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditEstadoCivil",
                    title   : title + " EstadoCivil",

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
                                return submitFormEstadoCivil();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function verEstadoCivil(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'estadoCivil', action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver EstadoCivil",

                    message : msg,
                    buttons : {
                        ok : {
                            label     : "Aceptar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    }

    $(function () {

        $(".btnCrear").click(function() {
            createEditEstadoCivil();
            return false;
        });

        $("tbody>tr").contextMenu({
            items  : {
                header   : {
                    label  : "Acciones",
                    header : true
                },
                ver      : {
                    label  : "Ver",
                    icon   : "fa fa-search",
                    action : function ($element) {
                        var id = $element.data("id");
                        verEstadoCivil(id);
                    }
                },
                editar   : {
                    label  : "Editar",
                    icon   : "fa fa-pencil",
                    action : function ($element) {
                        var id = $element.data("id");
                        createEditEstadoCivil(id);
                    }
                },
                eliminar : {
                    label            : "Eliminar",
                    icon             : "fa fa-trash-o",
                    separator_before : true,
                    action           : function ($element) {
                        var id = $element.data("id");
                        deleteEstadoCivil(id);
                    }
                }
            },
            onShow : function ($element) {
                $element.addClass("success");
            },
            onHide : function ($element) {
                $(".success").removeClass("success");
            }
        });
    });
</script>

</body>
</html>
