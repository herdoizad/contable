<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Plan de cuentas</title>
</head>
<body>

<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-9 titulo-panel">
                    Plan de cuentas
                </div>
                <div class="btn-group pull-right col-md-3 titulo-panel" style="margin-top: -11px">
                    <div class="input-group">
                        <input type="text" class="form-control input-search input-sm" placeholder="Buscar" value="${params.search}">
                        <span class="input-group-btn">
                            <g:link controller="cuentas" action="list" class="btn btn-sm btn-default btn-search">
                                <i class="fa fa-search"></i>&nbsp;
                            </g:link>
                        </span>
                    </div><!-- /input-group -->
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">

                    <table class="table table-condensed table-bordered table-striped table-hover">
                        <thead>
                        <tr>
                            <g:sortableColumn property="numero" title="Número" />
                            <g:sortableColumn property="descripcion" title="Descripción" />
                            <th style="width: 40px">Nivel</th>
                            <th>Tipo</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:if test="${count > 0}">
                            <g:each in="${lista}" status="i" var="cuenta">
                                <tr data-id="${cuenta.numero}">
                                    <td>${cuenta.numero}</td>
                                    <td>
                                        <elm:textoBusqueda busca="${params.search}">
                                            ${cuenta.descripcion}
                                        </elm:textoBusqueda>
                                    </td>
                                    <td style="text-align: center">
                                        ${cuenta.nivel}
                                    </td>
                                    <td style="text-align: center">
                                        <g:if test="${cuenta.clase=='1'}">
                                            Activo
                                        </g:if>
                                        <g:if test="${cuenta.clase=='2'}">
                                            Pasivo
                                        </g:if>
                                        <g:if test="${cuenta.clase=='3'}">
                                            Patrimonio
                                        </g:if>
                                        <g:if test="${cuenta.clase=='4'}">
                                            Ingresos
                                        </g:if>
                                        <g:if test="${cuenta.clase=='5'}">
                                            Gastos
                                        </g:if>
                                        <g:if test="${cuenta.clase=='6' || cuenta.clase=='7'}">
                                            De orden
                                        </g:if>
                                    </td>

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

                    <elm:pagination total="${count}" params="${params}"/>
                </div>
            </div>
        </div>
    </div>
</div>






<script type="text/javascript">
    var id = null;
    function submitFormEntidad() {
        var $form = $("#frmEntidad");
        var $btn = $("#dlgCreateEditEntidad").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando Entidad");
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
    function deleteEntidad(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                    "¿Está seguro que desea eliminar la Entidad seleccionada? Esta acción no se puede deshacer.</p>",
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
                        openLoader("Eliminando Entidad");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'entidad', action:'delete_ajax')}',
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
    function createEditEntidad(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'entidad', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditEntidad",
                    title   : title + " Entidad",

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
                                return submitFormEntidad();
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

    function verEntidad(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'entidad', action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver Entidad",

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
            createEditEntidad();
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
                        verEntidad(id);
                    }
                },
                editar   : {
                    label  : "Editar",
                    icon   : "fa fa-pencil",
                    action : function ($element) {
                        var id = $element.data("id");
                        createEditEntidad(id);
                    }
                },
                eliminar : {
                    label            : "Eliminar",
                    icon             : "fa fa-trash-o",
                    separator_before : true,
                    action           : function ($element) {
                        var id = $element.data("id");
                        deleteEntidad(id);
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
