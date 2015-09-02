
<%@ page import="contable.nomina.Prestamo" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Prestamos</title>
    </head>
    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

    <div class="row fila">
        <div class="col-md-11">
            <div class="panel-completo" style="margin-left: 10px">
                <div class="row">
                    <div class="col-md-8 titulo-panel">
                        ${empleado?'Prestamos del empleado: '+empleado:'Prestamos'}

                    </div>
                    <div class="col-md-4 titulo-panel" style="margin-top: -11px;text-align: right">

                            <a href="#" class="btn btn-verde btnCrear btn-sm">
                                <i class="fa fa-file-o"></i> Crear
                            </a>

                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-12">

        <table class="table table-condensed table-bordered table-striped table-hover">
            <thead>
                <tr>
                    
                    <th>Empleado</th>
                    
                    <g:sortableColumn property="fin" title="Fin" />
                    <g:sortableColumn property="inicio" title="Inicio" />
                    <g:sortableColumn property="monto" title="Monto" />
                    <g:sortableColumn property="plazo" title="Plazo" />
                    <g:sortableColumn property="plazo" title="Cuota" />

                </tr>
            </thead>
            <tbody>
                <g:if test="${prestamoInstanceCount > 0}">
                    <g:each in="${prestamoInstanceList}" status="i" var="prestamoInstance">
                        <tr data-id="${prestamoInstance.id}">
                            <td>${prestamoInstance.empleado}</td>
                            <td style="text-align: center"><g:formatDate date="${prestamoInstance.inicio}" format="dd-MM-yyyy" /></td>
                            <td style="text-align: center"><g:formatDate date="${prestamoInstance.fin}" format="dd-MM-yyyy" /></td>
                            <td style="text-align: right"><g:formatNumber number="${prestamoInstance.monto}" type="currency" currencySymbol=""/></td>
                            <td style="text-align: right"><g:fieldValue bean="${prestamoInstance}" field="plazo"/></td>
                            <td style="text-align: right"><g:formatNumber number="${prestamoInstance.valorCuota}" type="currency" currencySymbol=""/></td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr class="danger">
                        <td class="text-center" colspan="7">
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

        <elm:pagination total="${prestamoInstanceCount}" params="${params}"/>
</div>
     </div>
           </div>
                 </div>
                       </div>


        <script type="text/javascript">
            var id = null;
            function submitFormPrestamo() {
                var $form = $("#frmPrestamo");
                var $btn = $("#dlgCreateEditPrestamo").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando Prestamo");
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
            function deletePrestamo(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Prestamo seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando Prestamo");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'prestamo', action:'delete_ajax')}',
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
            function createEditPrestamo(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? { id: id ,empleado:${empleado?.id}} : {empleado:${empleado?.id}};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'prestamo', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgCreateEditPrestamo",
                            title   : title + " Prestamo",
                            
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
                                        return submitFormPrestamo();
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

            function verPrestamo(id) {
            $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'prestamo', action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver Prestamo",
                            
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
                    createEditPrestamo();
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
                                verPrestamo(id);
                            }
                        },
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                createEditPrestamo(id);
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                deletePrestamo(id);
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
